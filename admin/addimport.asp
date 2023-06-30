<!-- #include file="../connect.asp" -->
<%
    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()                
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.Prepared = True
    cmdPrep.CommandText = "INSERT INTO HOADONNHAP(ngay_nhap) VALUES(GETDATE())"

    cmdPrep.execute  
    Response.redirect("import.asp")                  
%>
