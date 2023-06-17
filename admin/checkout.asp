<!-- #include file="../connect.asp" -->
<%   
    If (isnull(Session("email_kh")) OR TRIM(Session("email_kh")) = "") Then
        Response.redirect("login.asp")
    End If
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN
    mahoadon_ban = Request.QueryString("mahoadon_ban")
    If (isnull(mahoadon_ban) OR trim(mahoadon_ban) = "") then 
            mahoadon_ban=0 
    End if
    If (cint(mahoadon_ban)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM HOADONBAN JOIN CTHOADONBAN ON HOADONBAN.mahoadon_ban = CTHOADONBAN.mahoadon_ban WHERE mahoadon_ban=?"

            cmdPrep.Parameters(0)=mahoadon_ban
            Set Result = cmdPrep.execute

            If not Result.EOF then
                tongtien_ban = Result("tongtien_ban")
                ngay_ban = Result("ngay_ban")
                trang_thai = Result("trang_thai")
                ma_kh = Result("ma_kh")
            End If
            Result.Close()
    End If
    Else
%>