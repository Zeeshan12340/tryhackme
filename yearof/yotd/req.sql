<?xml version="1.0"?>
<!DOCTYPE items [
<!ELEMENT items (item*)>
<!ATTLIST items burpVersion CDATA "">
<!ATTLIST items exportTime CDATA "">
<!ELEMENT item (time, url, host, port, protocol, method, path, extension, request, status, responselength, mimetype, response, comment)>
<!ELEMENT time (#PCDATA)>
<!ELEMENT url (#PCDATA)>
<!ELEMENT host (#PCDATA)>
<!ATTLIST host ip CDATA "">
<!ELEMENT port (#PCDATA)>
<!ELEMENT protocol (#PCDATA)>
<!ELEMENT method (#PCDATA)>
<!ELEMENT path (#PCDATA)>
<!ELEMENT extension (#PCDATA)>
<!ELEMENT request (#PCDATA)>
<!ATTLIST request base64 (true|false) "false">
<!ELEMENT status (#PCDATA)>
<!ELEMENT responselength (#PCDATA)>
<!ELEMENT mimetype (#PCDATA)>
<!ELEMENT response (#PCDATA)>
<!ATTLIST response base64 (true|false) "false">
<!ELEMENT comment (#PCDATA)>
]>
<items burpVersion="2022.3.7" exportTime="Mon May 23 16:14:18 PKT 2022">
  <item>
    <time>Mon May 23 16:13:58 PKT 2022</time>
    <url><![CDATA[http://10.10.208.202/]]></url>
    <host ip="10.10.208.202">10.10.208.202</host>
    <port>80</port>
    <protocol>http</protocol>
    <method><![CDATA[GET]]></method>
    <path><![CDATA[/]]></path>
    <extension>null</extension>
    <request base64="true"><![CDATA[R0VUIC8gSFRUUC8xLjENCkhvc3Q6IDEwLjEwLjIwOC4yMDINClVzZXItQWdlbnQ6IE1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NDsgcnY6OTEuMCkgR2Vja28vMjAxMDAxMDEgRmlyZWZveC85MS4wDQpBY2NlcHQ6IHRleHQvaHRtbCxhcHBsaWNhdGlvbi94aHRtbCt4bWwsYXBwbGljYXRpb24veG1sO3E9MC45LGltYWdlL3dlYnAsKi8qO3E9MC44DQpBY2NlcHQtTGFuZ3VhZ2U6IGVuLVVTLGVuO3E9MC41DQpBY2NlcHQtRW5jb2Rpbmc6IGd6aXAsIGRlZmxhdGUNCkNvbm5lY3Rpb246IGNsb3NlDQpDb29raWU6IGlkPTE2MWQzZWJjYzkzNDczZTQwODM4NDEwZWEyODRlYzNmDQpVcGdyYWRlLUluc2VjdXJlLVJlcXVlc3RzOiAxDQoNCg==]]></request>
    <status></status>
    <responselength></responselength>
    <mimetype></mimetype>
    <response base64="true"></response>
    <comment></comment>
  </item>
</items>
