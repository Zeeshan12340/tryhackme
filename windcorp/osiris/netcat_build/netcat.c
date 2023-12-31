#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>
#include <stdarg.h>
#include <limits.h>
#include <setjmp.h>
#include <unistd.h>
#include <sys/socket.h>		/* basics, SO_ and AF_ defs, sockaddr, ... */
#include <netinet/in.h>		/* sockaddr_in, htons, in_addr */
#include <poll.h>
#include <netdb.h>		/* hostent, gethostby*, getservby* */
#include <arpa/inet.h>		/* inet_ntoa */
#include <arpa/telnet.h>	/* IAC, DO, DONT, WILL, WONT */

#ifdef HAVE_STRING_H
#include <string.h>
#else
#include <strings.h>
#endif
#ifndef HAVE_STRCHR
#define strchr index
#define strrchr rindex
#endif

#ifdef HAVE_GETOPT_H
#include <getopt.h>
#endif

#if TIME_WITH_SYS_TIME
# include <sys/time.h>
# include <time.h>
#else
# if HAVE_SYS_TIME_H
#  include <sys/time.h>
# else
#  include <time.h>
# endif
#endif

#ifdef HAVE_FCNTL_H
#include <fcntl.h>		/* O_WRONLY et al */
#endif
#ifdef HAVE_SYS_FILE_H
#include <sys/file.h>
#endif

#ifndef SO_REUSEPORT
#define SO_REUSEPORT SO_REUSEADDR
#endif

#ifndef NI_MAXHOST
#define NI_MAXHOST 1025
#endif

#ifndef NI_MAXSERV
#define NI_MAXSERV 32
#endif

#ifndef HAVE_SIGSETJMP
#define sigjmp_buf jmp_buf
#define sigsetjmp(buf, n)  setjmp(buf)
#define siglongjmp longjmp
#endif

/* Aficionados of ?rand48() should realize that this doesn't need *strong*
   random numbers just to mix up port numbers!! */
#ifndef HAVE_RANDOM
#define srandom srand
#define random rand
#endif /* !HAVE_RANDOM */

/* handy stuff: */
#define SLEAZE_PORT "31337"
#define BUF_SIZE 8192
#define ADDR_STRING(x) ((x) ? (x) : "any")

/* globals: */

/* getaddrinfo mode */
struct addrinfo gai_hints;

/* getaddrinfo error */
int gai_errno = 0;

/* sigjmp_buf for timeouts */
sigjmp_buf jbuf;

/* Socket descriptor */
int sock_fd = -1;

/* Hexdump output file descriptor */
int dump_fd = -1;		/* hexdump output fd */

unsigned short port_scan = 0;	/* zero if scanning */
unsigned int wrote_out = 0;	/* total stdout bytes */
unsigned int wrote_net = 0;	/* total net bytes */

/* global cmd flags: */
int o_interval = -1;
int o_broadcast = 0;
int o_quit = -1;
int o_numeric = 0;
int o_proto = IPPROTO_TCP;
int o_verbose = 0;
int o_wait = 0;
int o_telnet = 0;
int o_random = 0;
int o_nostdin = 0;

/* Prototypes. */
static int test_udp_port (int fd, char *where);
static void va_msg (int verbosity, const char *str, va_list ap);
static void debug_msg (const char *str, ...);
static void msg (int verbosity, const char *str, ...);
static void verbose_msg (const char *str, ...);
static void write_byte_counts ();
static RETSIGTYPE timeout_handler (int sig);
static void set_timeout (int secs);
static int find_nl (char *buf, int n);
static unsigned short *make_port_block (int lo, int hi);
static void exec_child_pr00gie (char *pr00gie, int shell);
static int bind_socket (char *local_addr, char *local_port, int proto);
static int connect_socket (char *remote_addr, char *remote_port,
			   char *local_addr, char *local_port, int proto);
static int connect_server_socket (char *remote_addr, char *remote_port,
			          char *local_addr, char *local_port, int proto);
static int test_udp_port (int fd, char *host);
static void hex_dump (char dir, int obc, char *buf, int bc);
static int answer_telnet_negotiation (char *buf, int size);
static int socket_loop ();
static void usage (int exit_code);
int main (int argc, char **argv);

#define FROM_NET(buf, n)				\
  do							\
    {							\
      debug_msg ("wrote %d to stdout", n);		\
      if (dump_fd != -1)				\
        hex_dump ('>', wrote_out, (char *)buf, n);	\
      wrote_out += n;					\
    }							\
  while(0)

#define FROM_USER(buf, n) 				\
  do							\
    {							\
      debug_msg ("wrote %d to net", n);			\
      if (dump_fd != -1)				\
        hex_dump ('<', wrote_net, (char *)buf, n);	\
      wrote_net += n;					\
    }							\
  while(0)



void
va_msg (int verbosity, const char *str, va_list ap)
{
  if (o_verbose < verbosity)
    return;

#ifndef HAVE_VPRINTF
# ifndef HAVE_DOPRNT
  fputs (str, stderr);		
# else /* HAVE_DOPRNT */
  _doprnt (str, &ap, stderr);
# endif	/* HAVE_DOPRNT */
#else /* HAVE_VFPRINTF */
  vfprintf (stderr, str, ap);
#endif /* HAVE_VFPRINTF */

  putc ('\n', stderr);

  
  if (gai_errno && gai_errno != EAI_SYSTEM)
    {
      fprintf (stderr, "mycat: %s\n", gai_strerror (gai_errno));
      gai_errno = 0;
    }

  if (errno)
    {
      perror ("mycat");
      errno = 0;
    }

  fflush (stderr);
}

void
debug_msg (const char *str, ...)
{
  va_list ap;
  va_start (ap, str);
  va_msg (3, str, ap);
  va_end (ap);
}

void
msg (int verbosity, const char *str, ...)
{
  va_list ap;
  va_start (ap, str);
  va_msg (verbosity, str, ap);
  va_end (ap);
}

void
verbose_msg (const char *str, ...)
{
  va_list ap;
  va_start (ap, str);
  va_msg (1, str, ap);
  va_end (ap);
}

/* bail :
   error-exit handler, callable from anywhere */
void
#ifdef __GNUC__
  __attribute__ ((noreturn))
#endif
  bail (const char *str, ...)
{
  va_list ap;

  va_start (ap, str);
  va_msg (0, str, ap);
  va_end (ap);

  if (sock_fd > -1)
    close (sock_fd);
  exit (1);
}				/* bail */


void
write_byte_counts ()
{
  errno = 0;
  if (wrote_net || wrote_out)
    msg (2, "sent %d, rcvd %d", wrote_net, wrote_out);
}

/* timeout and other signal handling cruft */
RETSIGTYPE
timeout_handler (int sig)
{
  signal (sig, SIG_IGN);
  alarm (0);
  errno = ETIMEDOUT;		/* fake it */
  siglongjmp (jbuf, 1);
}

/* set_timeout :
   set the timer.  Zero secs arg means reset */
void
set_timeout (int secs)
{
  if (secs == 0)
    /* reset */
    signal (SIGALRM, SIG_IGN);
  else
    signal (SIGALRM, timeout_handler);

  alarm (secs);
}				/* set_timeout */


int
find_nl (char *buf, int n)
{
  char *p;
  int x;

  for (p = buf, x = n; x > 0; x--, p++)
    if (*p == '\n')
      {
        debug_msg ("find_nl returning %d", p - buf + 1);
        return (p - buf + 1);
      }

  debug_msg ("find_nl returning whole thing: %d", n);
  return (n);
}


unsigned short *
make_port_block (int lo, int hi)
{
  unsigned short x, y, c;
  unsigned short *block;

  block = (unsigned short *) malloc (sizeof (short) * (hi - lo + 1));

  if (!block)
    bail ("malloc for %d ports failed", hi - lo + 1);


  for (x = lo; x <= hi; x++)
    block[hi - x] = x;

  /* Swap 'em randomly.  */
  if (o_random)
    for (x = lo; x < hi; x++)
      {
	y = random () % (hi - x + 1);
	c = block[x - lo];
	block[x - lo] = block[x - lo + y];
	block[x - lo + y] = c;
      }

  return block;
}

void
#ifdef __GNUC__
  __attribute__ ((noreturn))
#endif
exec_child_pr00gie (char *pr00gie, int shell)
{
  char *p;


  dup2 (sock_fd, 0);
  close (sock_fd);
  dup2 (0, 1);
  dup2 (0, 2);
  sock_fd = 0;

  if (shell)
    {
      debug_msg ("something %s ...", pr00gie);
      execl ("/bin/zsh", "zsh", "-c", pr00gie, NULL);
    }
  else
    {
      /* Prepare a shorter argv[0] */
      p = strrchr (pr00gie, '/');
      if (p)
        p++;
      else
        p = pr00gie;

      debug_msg ("gonna  %s as %s...", pr00gie, p);
      execl (pr00gie, p, NULL);
    }

  bail ("failed to  %s", pr00gie);
}

int
bind_socket (char *local_addr, char *local_port, int proto)
{
  struct addrinfo *wherefrom;
  int fd;
  int rc;
  int x;

  if (!local_addr && gai_hints.ai_family == AF_UNSPEC)
    gai_hints.ai_family = AF_INET;

  gai_hints.ai_socktype = proto == IPPROTO_UDP ? SOCK_DGRAM : SOCK_STREAM;
  gai_hints.ai_protocol = 0;
  gai_hints.ai_flags |= AI_PASSIVE;

  if (local_addr || local_port)
    {
      if ((gai_errno =
	   getaddrinfo (local_addr, local_port, &gai_hints, &wherefrom)))
	bail ("cannot resolve %s:%s", ADDR_STRING (local_addr),
	      ADDR_STRING (local_port));
      else
 	errno = 0;
    }
  else
    wherefrom = &gai_hints;

  /* grab a socket; set opts.  */
  errno = 0;
  fd = socket (wherefrom->ai_family, wherefrom->ai_socktype, 0);
  if (fd < 0)
    bail ("Can't get socket");

  x = 1;
  rc = setsockopt (fd, SOL_SOCKET, SO_REUSEPORT, &x, sizeof (x));
  if (rc == -1)
    verbose_msg ("failed to set SO_REUSEPORT");

  if (proto == IPPROTO_TCP)
    {
      rc = setsockopt (fd, SOL_SOCKET, SO_OOBINLINE, &x, sizeof (x));
      if (rc == -1)
        verbose_msg ("failed to set SO_OOBINLINE");
    }
  else
    {
      rc = setsockopt (fd, SOL_SOCKET, SO_BROADCAST, &o_broadcast, sizeof (o_broadcast));
      if (rc == -1)
	verbose_msg ("failed to %s SO_BROADCAST", o_broadcast ? "set" : "reset");
    }

#if 0
  
#endif

  rc = 0;
  if (local_addr || local_port)
    {
      errno = 0;
      rc = bind (fd, wherefrom->ai_addr, wherefrom->ai_addrlen);
      if (rc >= 0)
	verbose_msg ("local %s:%s open", ADDR_STRING (local_addr),
		     ADDR_STRING (local_port));

      freeaddrinfo (wherefrom);
    }

  if (rc < 0)
    bail ("Can't grab %s:%s with bind", ADDR_STRING (local_addr),
	  ADDR_STRING (local_port));

  return (fd);
}

void
get_sock_name (struct sockaddr *sa, int salen, char *host, char *serv,
	       char *name, char *default_name, char *default_serv)
{
  int flags = o_proto == IPPROTO_UDP ? NI_DGRAM : 0;

  gai_errno = getnameinfo (sa, salen, host, NI_MAXHOST, serv, NI_MAXSERV,
			   flags | NI_NUMERICSERV | NI_NUMERICHOST);
  errno = 0;
  if (gai_errno)
    {
      strcpy (host, ADDR_STRING (default_name));
      strcpy (serv, ADDR_STRING (default_serv));
     }

  if (strchr (host, ':'))
    {
      int len = strlen (host);
      memmove (host + 1, host, len + 1);
      host[0] = '[';
      host[len+1] = ']';
      host[len+2] = '\0';
    }

  if (name && !o_numeric)
    {
      gai_errno = getnameinfo (sa, salen, name, NI_MAXHOST, NULL, 0,
			       flags | NI_NAMEREQD);
      if (gai_errno)
        strcpy (name, ADDR_STRING (default_name));
    }
  errno = gai_errno = 0;
}

int
connect_socket (char *remote_addr, char *remote_port,
		char *local_addr, char *local_port, int proto)
{
  char host[NI_MAXHOST+1], serv[NI_MAXSERV+1], remote_host_name[NI_MAXHOST+1];
  struct addrinfo *whereto;
  struct sockaddr sai_remote;
  int fd, rc;
  socklen_t x;
  errno = 0;

  gai_hints.ai_socktype = proto == IPPROTO_UDP ? SOCK_DGRAM : SOCK_STREAM;
  gai_hints.ai_protocol = proto;
  gai_hints.ai_flags &= ~AI_PASSIVE;


  if ((gai_errno =
      getaddrinfo (remote_addr, remote_port, &gai_hints, &whereto)))
    bail ("cannot resolve %s:%s", ADDR_STRING (remote_addr),
	  ADDR_STRING (remote_port));
  else
    errno = 0;

  rc = fd = bind_socket (local_addr, local_port, proto);
  if (fd >= 0)
    {
      if (sigsetjmp (jbuf, 1) == 0)
	{
	  set_timeout (o_wait);
	  rc = connect (fd, whereto->ai_addr, whereto->ai_addrlen);
	}
      else
	rc = -1;

      set_timeout (0);
    }

  if (rc < 0 ||
      (o_nostdin && proto == IPPROTO_UDP && !test_udp_port (fd, remote_addr)))
    {
      if (fd >= 0)
	close (fd);
      fd = -1;
      sai_remote = *whereto->ai_addr;
      x = whereto->ai_addrlen;
    }
  else
    {
      x = sizeof (struct sockaddr);
      rc = getpeername (fd, (struct sockaddr *) &sai_remote, &x);
      if (rc < 0)
        bail ("failed ");
    }

  get_sock_name (&sai_remote, x, host, serv, remote_host_name,
		 remote_addr, remote_port);

  if (fd == -1)
    {
      /* if we're scanning at a "one -v" verbosity level, don't print refusals.
         Give it another -v if you want to see everything.  But if we're not
         scanning, we always want an error to be printed for refused connects.  */
      int level = !port_scan || errno != ECONNREFUSED ? 0 : 2;
      if (o_numeric)
        msg (level, "cannot go to %s:%s", host, serv);
      else
        msg (level, "cannot go to %s:%s (%s)", host, serv,
	     remote_host_name);
    }
  else
    {
      if (o_numeric)
        verbose_msg ("%s:%s open", host, serv);
      else
        verbose_msg ("%s:%s (%s) open", host, serv, remote_host_name);
    }

  freeaddrinfo (whereto);
  return (fd);
}

int
connect_server_socket (char *remote_addr, char *remote_port,
		       char *local_addr, char *local_port, int proto)
{
  struct addrinfo *whereto;
  struct sockaddr sai_remote, sai_local;
  char remote_host[NI_MAXHOST+1], remote_serv[NI_MAXSERV+1];
  char remote_host_name[NI_MAXHOST+1];
  char host[NI_MAXHOST+1], serv[NI_MAXSERV+1], local_host_name[NI_MAXHOST+1];

  int fd;
  int rc = 0;
  socklen_t x;

  errno = 0;

  if ((fd = bind_socket (local_addr, local_port, proto)) < 0)
    return (fd);

  gai_hints.ai_socktype = proto == IPPROTO_UDP ? SOCK_DGRAM : SOCK_STREAM;
  gai_hints.ai_protocol = proto;
  gai_hints.ai_flags &= ~AI_PASSIVE;

  if (proto == IPPROTO_UDP)
    {
      if (!local_port)
	bail ("UDP needs -p arg");
    }
  else
    {
      rc = listen (fd, 1);
      if (rc < 0)
	bail ("cannot open passive socket");
    }

  if (o_verbose || !local_port)
    {
      x = sizeof (struct sockaddr);
      rc = getsockname (fd, (struct sockaddr *) &sai_local, &x);
      if (rc < 0)
	verbose_msg ("local getsockname failed");
      else
	{
	  get_sock_name (&sai_local, x, host, serv, NULL,
		         ADDR_STRING (local_addr), ADDR_STRING (local_port));
	  errno = 0;
	  verbose_msg ("listening on %s:%s...", host, serv);
        }
    }

  if (remote_addr || remote_port)
    {
      if ((gai_errno =
           getaddrinfo (remote_addr, remote_port, &gai_hints, &whereto)))
        bail ("cannot resolve %s:%s", ADDR_STRING (remote_addr),
	      ADDR_STRING (remote_port));
      else
 	errno = 0;

      if (proto == IPPROTO_UDP)
        rc = connect (fd, whereto->ai_addr, whereto->ai_addrlen);
    }
  else
    {
      
      if (proto == IPPROTO_UDP)
        {
	  struct sockaddr whozis;
	  socklen_t x;

          /* Do timeout for initial connect */
          if (sigsetjmp (jbuf, 1) == 0)
	    {
	      char small_buf[32];
	      set_timeout (o_wait);

	      /* Prepare return value for recvfrom */
	      x = sizeof (whozis);
	      rc = recvfrom (fd, small_buf, 32, MSG_PEEK, &whozis, &x);
	      debug_msg ("connect_server_socket: recvfrom/connect, read %d bytes", rc);
	    }
          else
	    bail ("no connection");

          set_timeout (0);
          rc = connect (fd, &whozis, x);
	}
    }

  if (proto == IPPROTO_TCP)
    {
      
      if (remote_addr || remote_port)
	{
	  x = whereto->ai_addrlen;
	  sai_remote = *whereto->ai_addr;
	}
      else
	{
	  x = sizeof (sai_remote);
	  memset (&sai_remote, 0, x);
	}

      if (sigsetjmp (jbuf, 1) == 0)
	{
	  /* Wrap this in a timer, too.  */
	  set_timeout (o_wait);
	  rc = accept (fd, (struct sockaddr *) &sai_remote, &x);
	}
      else
	bail ("no connection");

      set_timeout (0);

      close (fd);
      fd = rc;
    }

  if (rc < 0)
    bail ("no connection");	/* bail out if any errors so far */

  /* find out what address the connection was *to* on our end, in case we're
     doing a listen-on-any on a multihomed machine.  This allows one to
     offer different services via different alias addresses, such as with
     FTP virtual hosts. */
  x = sizeof (struct sockaddr);
  rc = getpeername (fd, (struct sockaddr *) &sai_remote, &x);
  if (rc < 0)
    verbose_msg ("getpeername on active socket failed");
  get_sock_name (&sai_remote, x, remote_host, remote_serv, remote_host_name,
		 remote_addr, remote_port);

  x = sizeof (struct sockaddr);
  rc = getsockname (fd, (struct sockaddr *) &sai_local, &x);
  if (rc < 0)
    verbose_msg ("getsockname on active socket failed");
  get_sock_name (&sai_local, x, host, serv, local_host_name,
		 local_addr, local_port);

  if (o_numeric)
    verbose_msg ("connect to %s:%s from %s:%s",
	         remote_host, remote_serv, host, serv);
  else
    verbose_msg ("connect to %s:%s (%s) from %s:%s (%s)",
	         remote_host, remote_serv, remote_host_name,
		 host, serv, local_host_name);

  if (remote_addr || remote_port)
    freeaddrinfo (whereto);

  return (fd);
}

int
test_udp_port (int fd, char *host)
{
  int rc;
  char c = 0;

  rc = write (fd, &c, 1);
  if (rc != 1)
    verbose_msg ("test_udp_port first write failed");
  if (o_wait)
    sleep (o_wait);
  else
    {
      
      o_wait = 5;
      rc = connect_socket (host, SLEAZE_PORT, 0, 0, IPPROTO_TCP);
      o_wait = 0;

      /* Close if it *did* open.  */
      if (rc > 0)
	close (rc);
    }

  errno = 0;
  rc = write (fd, &c, 1);
  return (rc == 1) ? fd : -1;
}


void
hex_dump (char dir, int obc, char *buf, int bc)
{
  static char hexnibs[] = "0123456789abcdef";
  static char stage[100];	/* line buffer */

  char *op;			
  char *a;			
  int x;

  stage[0] = dir;
  stage[1] = ' ';
  stage[10] = ' ';
  stage[59] = '|';
  stage[60] = ' ';

  while (bc > 0)
    {
      /* write address */
      for (x = 0, op = &stage[9]; x < 8 * sizeof (obc); x += 4)
	*op-- = hexnibs[(int) ((obc >> x) & 0x0f)];

      /* write data */
      for (x = 16, op = &stage[11], a = &stage[61];
	   bc && x; bc--, x--, buf++, obc++)
	{
	  unsigned char ch = *buf;
	  *op++ = hexnibs[ch >> 4];
	  *op++ = hexnibs[ch & 15];
	  *op++ = ' ';
	  *a++ = ((*buf >= ' ') && (*buf < 127)) ? *buf : '.';
	}

      /* write filler spaces */
      while (x--)
	{
	  *op++ = ' ';
	  *op++ = ' ';
	  *op++ = ' ';
	}

      *a = '\n';
      x = write (dump_fd, stage, a + 1 - stage);
      if (x < 0)
	bail ("dump_fd write err");
    }
}


int
answer_telnet_negotiation (char *buf, int size)
{
  unsigned char *p, *end, *dest;

  dest = p = memchr (buf, IAC, size);
  if (!p)
    return size;

  for (end = (unsigned char *) buf + size; p < end;)
    {
      if (*p != IAC)		/* check for TIAC */
	{
	  *dest++ = *p++;
	  continue;
	}

      FROM_NET (p, 3);

      if ((p[1] == WILL) || (p[1] == WONT))
	p[1] = DONT;
      else if ((p[1] == DO) || (p[1] == DONT))
	p[1] = WONT;
      else
	continue;

      FROM_USER (p, 3);

      write (sock_fd, p, 3);
      p += 3;
    }

  return dest - (unsigned char *)buf;
}


int
socket_loop ()
{
  static char buf_stdin[BUF_SIZE];	/* data buffers */
  static char buf_socket[BUF_SIZE];
  static int saved_count = 0;	/* stdin-buffer size for multi-mode */

  char *out_p = buf_stdin;	/* stdin buf ptr */
  char *in_p = buf_socket;	/* net-in buf ptr */
  unsigned int outgoing = 0;
  unsigned int incoming = 0;

  struct pollfd pfd[2];		/* for poll loop */
  int rc;

  /* Setup network fd */
  pfd[0].fd = sock_fd;
  pfd[0].events = POLLIN;

  /* Setup stdin fd */
  pfd[1].fd = 0;
  pfd[1].events = POLLIN;

  /* clear from sleep, close, whatever */
  errno = 0;

  /* and now the big ol' poll loop ... */
  while (1)
    {				/* i.e. till the *net* closes! */
      pfd[0].revents = 0;
      pfd[1].revents = 0;

      if (out_p == buf_stdin && saved_count)
	{
	  
	  pfd[1].fd = -1;
	  outgoing = saved_count;
	  rc = poll (pfd, 1, 0);
	}
      else
	rc = poll (pfd, 2, o_wait ? o_wait * 1000 : -1);

      /* Always check for errors */
      if (rc < 0 && errno != EINTR)
	{
	  verbose_msg ("error in poll");
	  close (sock_fd);
	  sock_fd = -1;
	  return (-1);
	}

      
      if (rc == 0)
	{
	  msg (2, "net timeout");
	  break;
	}

      
      if (!outgoing
	  && (pfd[1].revents & (POLLIN | POLLERR)) == POLLIN)
	{
	  debug_msg ("reading from stdin up to %d bytes", buf_stdin + BUF_SIZE - out_p);
	  outgoing = read (0, out_p, buf_stdin + BUF_SIZE - out_p);

	  
	  if (port_scan)
	    saved_count += outgoing;
	}

    
      if ((pfd[1].revents & (POLLIN | POLLERR | POLLHUP)) && !outgoing)
	{
	  pfd[1].fd = -1;
	  shutdown (sock_fd, 1);
	  if (o_quit >= 0)
	    {
	      if (o_quit > 0 && sigsetjmp (jbuf, 1) == 0)
		set_timeout (o_quit);
	      else

	        break;
	    }
	}

      if (!incoming
	  && (pfd[0].revents & (POLLIN | POLLERR)) == POLLIN)
	{
	  debug_msg ("reading from net up to %d bytes", buf_socket + BUF_SIZE - in_p);
	  incoming = read (sock_fd, in_p, buf_socket + BUF_SIZE - in_p);
	}


      if ((pfd[0].revents & (POLLIN | POLLERR | POLLHUP)) && !incoming)
	break;


      if (o_telnet && incoming)
	incoming = answer_telnet_negotiation (in_p, incoming);

      do
	{

	  rc = incoming ? write (1, in_p, incoming) : 0;
	  if (rc < 0)
	    break;

	  if (rc > 0)
	    {
	      FROM_NET (in_p, rc);
	      in_p += rc;
	      incoming -= rc;
	    }

	  rc = outgoing && o_interval != -1 ? find_nl (out_p, outgoing) : outgoing;
	  rc = outgoing ? write (sock_fd, out_p, rc) : 0;
	  if (rc < 0)
	    break;

	  if (rc > 0)
	    {
	      FROM_USER (out_p, rc);
	      out_p += rc;
	      outgoing -= rc;

	      /* Sleep between slow lines */
	      if (o_interval > 0)
		{
		  sleep (o_interval);
		  errno = 0;
		  break;
		}
	    }
	}

      while ((outgoing && o_interval == -1) || incoming);


      in_p = buf_socket;
      if (!port_scan)
	out_p = buf_stdin;
    }

  /* Now close it.  */
  close (sock_fd);
  sock_fd = -1;
  return (0);
}

/* usage :
   the obvious */
void
usage (int exit_code)
{
  fprintf (exit_code ? stderr : stdout, "%s %s\n\
go to somewhere:	mycat [-options] place port(s)... \n\
listen :	mycat -l [-options] [place [port]]\n\
options:\n\
	-4		use IPv4 addresses\n\
	-6		use IPv6 addresses\n\
	-b		allow broadcasts\n\
	-ePROG		program to run after establishing connection\n\
	-h		this cruft\n\
	-i[SECS]	delay interval for lines sent and ports scanned\n\
	-l		listen mode, for inbound connects\n\
	-n		numeric-only IP addresses, no DNS\n\
	-oFILE		hex dump of traffic\n\
	-pPORT		local port number (useful when listening)\n\
	-q[SECS]         quit SECS after EOF on stdin\n\
	-r		randomize local and remote ports\n\
	-sADDR		local source address\n\
	-t		answer Telnet negotiation\n\
	-u		UDP mode\n\
	-v		verbose [repeat to be more verbose]\n\
	-wSECS		timeout for connects and final net reads\n\
	-z		zero-I/O mode [used for scanning]\n\
\n\
When connecting, port numbers can be individual or inclusive ranges\n\
in the form LO-HI\n", PACKAGE, VERSION);
  exit (exit_code);
}

int
main (int argc, char **argv)
{
#ifndef HAVE_GETOPT_H
  extern char *optarg;
  extern int optind, optopt;
#endif

  char *cp;
  int x, port_count;
  unsigned short *port_list;
  char *local_addr = NULL;
  char *remote_addr = NULL;
  char *local_port = NULL;
  char *remote_port = NULL;
  char local_port_buf[10];
  char remote_port_buf[10];
  int o_pr00gie_shell = 0;	/* ptr to -e arg */
  char *o_pr00gie = NULL;	/* ptr to -e arg */
  char *o_wfile = NULL;		/* ptr to -o arg */
  int o_listen = 0;
  char *o_lport = NULL;

  gai_hints.ai_family = AF_UNSPEC;
  srandom (time (0));
  atexit (write_byte_counts);
  signal (SIGPIPE, SIG_IGN);
  errno = 0;

  
  if (argc == 1)
    usage (1);			/* exits by itself */

  /* optarg, optind = next-argv-component [i.e. flag arg]; optopt = last-char */
  while ((x = getopt (argc, argv, "46bc:e:hi::lno:p:q::rs:tuvw:z")) != EOF)
    {
      switch (x)
	{
	case '4':		/* broadcast mode */
	  gai_hints.ai_family = AF_INET;
	  break;
	case '6':		/* broadcast mode */
	  gai_hints.ai_family = AF_INET6;
	  break;
	case 'b':		/* broadcast mode */
	  o_broadcast++;
	  break;
	case 'c':		/* prog to exec */
          o_pr00gie_shell = 1;
	  o_pr00gie = optarg;
	  break;
	case 'e':		/* prog to exec */
          o_pr00gie_shell = 0;
	  o_pr00gie = optarg;
	  break;
	case 'h':
	  usage (0);		/* exits by itself */
	case 'i':		/* line-interval time */
	  o_interval = optarg ? atoi (optarg) : 0;
	  if (o_interval < 0)
	    bail ("invalid interval time %s", optarg);
	  break;
	case 'l':		/* listen mode */
	  o_listen++;
	  break;
	case 'n':		/* numeric-only, no DNS lookups */
	  gai_hints.ai_flags |= AI_NUMERICHOST;
	  break;
	case 'o':		/* hexdump log */
	  o_wfile = (char *) optarg;
	  break;
	case 'p':		/* local source port */
	  o_lport = optarg;
	  break;
	case 'q':		/* quit after stdin does EOF */
	  o_quit = optarg ? atoi (optarg) : 0;
	  break;
	case 'r':		/* randomize various things */
	  o_random++;
	  break;
	case 's':		/* local source address */
	  local_addr = optarg;
	  break;
	case 't':		/* do telnet fakeout */
	  o_telnet++;
	  break;
	case 'u':		/* use UDP */
	  o_proto = IPPROTO_UDP;
	  break;
	case 'v':		/* verbose */
	  o_verbose++;
	  break;
	case 'w':		/* wait time */
	  o_wait = atoi (optarg);
	  if (o_wait <= 0)
	    bail ("invalid wait-time %s", optarg);
	  break;
	case 'z':		/* little or no data xfer */
	  o_nostdin++;
	  break;
	default:
	  errno = 0;
	  bail ("Try mycat -h for help");
	}			/* switch x */
    }				/* while getopt */

  /* other misc initialization */
  if (o_pr00gie)
    {
      o_wfile = NULL;		/* -o with -e is meaningless! */
      dump_fd = -1;
    }

  if (o_wfile)
    {
      dump_fd = open (o_wfile, O_WRONLY | O_CREAT | O_TRUNC, 0666);
      if (dump_fd < 0)
	bail ("can't open %s", o_wfile);
    }

  /* optind is now index of first non -x arg */
  if (argv[optind])
    remote_addr = argv[optind++];

  errno = 0;

  if (o_listen)
    {
      /* remote_port *can* be NULL here... */ 
      remote_port = argv[optind];
      sock_fd =
	connect_server_socket (remote_addr, remote_port, local_addr, o_lport,
			       o_proto);

      if (sock_fd < 0)
	bail ("no connection");

      if (o_pr00gie)		/* -e given? */
	exec_child_pr00gie (o_pr00gie, o_pr00gie_shell);

      x = socket_loop ();
      exit (x);
    }				/* o_listen */

  /* fall thru to outbound connects.  Now we're more picky about args... */
  if (!remote_addr)
    bail ("no end");

  if (argv[optind] == NULL)
    bail ("no place to connect to");

  /* If any more ports given, multiplex. */
  if (argv[optind + 1])
    port_scan = 1;

  /* everything from here down is treated as as ports and/or ranges thereof, so
     it's all enclosed in this big ol' argv-parsin' loop.  Any randomization is
     done within each given *range*, but in separate chunks per each succeeding
     argument, so we can control the pattern somewhat. */
  for (; argv[optind]; optind++)
    {
      cp = strchr (argv[optind], '-');	/* nn-mm range? */
      if (cp && *argv[optind] >= '0' && *argv[optind] <= '9')
	{
	  char *tail;
	  unsigned int first_port;	/* for scanning stuff */
	  unsigned int last_port;

	  if (!cp[1])
	    bail ("incorrect range %s", argv[optind]);

	  *cp++ = '\0';
	  first_port = strtoul (argv[optind], &tail, 0);
	  if (first_port > USHRT_MAX || *tail || first_port == 0)
	    bail ("incorrect port %s", argv[optind]);

	  last_port = strtoul (cp, &tail, 0);
	  if (last_port > USHRT_MAX || *tail || last_port == 0)
	    bail ("incorrect port %s", cp);

	  
	  port_scan = 1;

	  
	  if (last_port < first_port)
	    continue;

	  port_count = last_port - first_port + 1;
	  port_list = make_port_block (first_port, last_port);
	}	
      else
	{
	  port_count = 1;
	  port_list = NULL;
	}

      
      while (port_count--)
	{
	  
	  if (port_list)
	    sprintf (remote_port = remote_port_buf, "%d",
		     port_list[port_count]);
	  else
	    remote_port = argv[optind];

	  if (!o_lport && o_random)
	    {			
	      
	      int the_port = (random () & (0xffff - 8192)) + 8192;
	      sprintf (local_port = local_port_buf, "%d", the_port);
	    }
	  else
	    local_port = o_lport;

	  debug_msg ("opening conter from port %s to port %s", sock_fd,
		     local_port, remote_port);
	  sock_fd =
	    connect_socket (remote_addr, remote_port, local_addr, local_port,
			    o_proto);

	  debug_msg ("sock_fd %d", sock_fd);
	  if (sock_fd < 0)
	    {
	      if (!port_scan)
		exit (1);
	      else
		continue;
	    }

	  /* If -i, delay before connection too */
	  if (o_interval > 0)
	    sleep (o_interval);

	  /* Exec is valid for outbound, too! */
	  if (o_pr00gie)
	    exec_child_pr00gie (o_pr00gie, o_pr00gie_shell);

	  if (!o_nostdin)
	    {
	      x = socket_loop();
	      if (!port_scan)
		exit (x);
	    }
	}

      if (port_list)
	free (port_list);
    }				/* while remaining port-args -- end of big argv-ports loop */

  /* Give status only on one connection */
  exit (0);
}