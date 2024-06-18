add ip to hosts file, use .com for enumeration

RECON:
	subdomain enumeration nahamstore-2020-dev
	http://nahamstore-2020-dev.nahamstore.thm/api/customers/?customer_id=1
	{"id":1,"name":"Rita Miles","email":"rita.miles969@gmail.com","tel":"816-719-7115","ssn":"366-24-2649"}
	{"id":2,"name":"Jimmy Jones","email":"jd.jones1997@yahoo.com","tel":"501-392-5473","ssn":"521-61-6392"}
	{"id":3,"name":"Charles Cook","email":"maverick1974@hotmail.com","tel":"617-776-8871","ssn":"438-92-2964"}

XSS:

	(filter based on response size) ,,, try raft-medium from seclist 

	sublist3r gives marketing,stock subdomain
	backend dbms appears to be 'IBM DB2'

	error page on marketing subdomain, ?error=

	title tag needs to be escaped for XXS and search for js 

Open-Redirect:
	?r and redirect_url( found accidentally when accessing a logged in form after restarting)
