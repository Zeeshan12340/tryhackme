only ssh and port 80 open, no access to config.php, /assets
different font files available, flag.jpg, no interesting dirs, no subdomains

interesting cookie, 'id' changing it's value impacts the number shown in the website
some type of hashing function used, if reversed, possible to inject code executed on server

rabbit hole on hashing, id parameter is vuln to sqli,

database:`webapp`;table:`queue`;column:`queueNum`,user:`web@localhost`,dir:`/var/lib/mysql`
