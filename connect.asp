<%
'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=DESKTOP-HJ880S5;Database=DO_AN_WEB;User Id=sa;Password=1234"
connDB.ConnectionString = strConnection

%>