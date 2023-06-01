<!-- #include file="connect.asp" -->
<%
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        ma_kh = Request.QueryString("ma_kh")
        If (isnull(ma_kh) OR trim(ma_kh) = "") then 
            ma_kh=0 
        End if
        If (cint(ma_kh)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM KHACHHANG WHERE ma_kh=?"
            
            cmdPrep.Parameters(0)=ma_kh
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                ten_kh = Result("ten_kh")
                tuoi_kh = Result("tuoi_kh")
                gioi_tinh = Result("gioi_tinh")
                sdt_kh = Result("sdt_kh")
                email_kh = Result("email_kh")
                mk_kh = Result("mk_kh")
                diachi_kh = Result("diachi_kh")
                
            End If

   
            Result.Close()
        End If
    Else
        ma_kh = Request.QueryString("ma_kh")
        ten_kh = Request.form("ten_kh")
        tuoi_kh = Request.form("tuoi_kh")
        gioi_tinh = Request.form("gioi_tinh")
        sdt_kh = Request.form("sdt_kh")
        email_kh = Request.form("email_kh")
        mk_kh = Request.form("mk_kh")
        diachi_kh = Request.form("diachi_kh")

        if (isnull (ma_kh) OR trim(ma_kh) = "") then ma_kh=0 end if

        if (cint(ma_kh)=0) then
            
             
        else
            if (NOT isnull(ten_kh) and ten_kh <>"" and NOT isnull(tuoi_kh) and tuoi_kh <>"" and NOT isnull(gioi_tinh) and gioi_tinh <>"" and NOT isnull(sdt_kh) and sdt_kh <>"" and NOT isnull(email_kh) and email_kh <>"" and NOT isnull(mk_kh) and mk_kh <>"" and NOT isnull(diachi_kh) and diachi_kh <>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE KHACHHANG SET ten_kh=?,tuoi_kh=?,gioi_tinh=?,sdt_kh=?,email_kh=?,mk_kh=?,diachi_kh=? WHERE ma_kh=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("ten_kh",202,1,255,ten_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("tuoi_kh",202,1,255,tuoi_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("gioi_tinh",202,1,255,gioi_tinh)
                cmdPrep.parameters.Append cmdPrep.createParameter("sdt_kh",202,1,255,sdt_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("email_kh",202,1,255,email_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("mk_kh",202,1,255,mk_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("diachi_kh",202,1,255,diachi_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("ma_kh",3,1, ,ma_kh)

                cmdPrep.execute
                If Err.Number=0 Then
                    Session("Success") = "The employee was edited!"
                    Response.redirect("client.asp")
                Else
                    handleError(Err.Description)
                End If
                On Error Goto 0
            else
                Session("Error") = "You have to input enough info"
            end if
        end if
    End If    
%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <title>Edit Product</title>
    </head>
    <body>
        
        <div class="container">
            <form method="post">
                <div class="mb-3">
                    <label for="ten_kh" class="form-label">Tên Khách Hàng</label>
                    <input type="text" class="form-control" id="ten_kh" name="ten_kh" value="<%=ten_kh%>">
                </div>
                <div class="mb-3">
                    <label for="tuoi_kh" class="form-label">Tuổi</label>
                    <input type="text" class="form-control" id="tuoi_kh" name="tuoi_kh" value="<%=tuoi_kh%>">
                </div>
                <div class="mb-3">
                    <label for="gioi_tinh" class="form-label">Giới Tính</label>
                    <input type="text" class="form-control" id="gioi_tinh" name="gioi_tinh" value="<%=gioi_tinh%>">
                </div> 
                <div class="mb-3">
                    <label for="sdt_kh" class="form-label">Số Điện Thoại</label>
                    <input type="text" class="form-control" id="sdt_kh" name="sdt_kh" value="<%=sdt_kh%>">
                </div>
                <div class="mb-3">
                    <label for="email_kh" class="form-label">Email</label>
                    <input type="text" class="form-control" id="email_kh" name="email_kh" value="<%=email_kh%>">
                </div> 
                <div class="mb-3">
                    <label for="mk_kh" class="form-label">Mật Khẩu</label>
                    <input type="text" class="form-control" id="mk_kh" name="mk_kh" value="<%=mk_kh%>">
                </div>
                <div class="mb-3">
                    <label for="diachi_kh" class="form-label">Địa Chỉ</label>
                    <input type="text" class="form-control" id="diachi_kh" name="diachi_kh" value="<%=diachi_kh%>">
                </div> 
                <button type="submit" class="btn btn-primary">
                    <%
                        if (ma_kh=0) then
                            Response.write("Create")
                        else
                            Response.write("Save")
                        end if
                    %>
                </button>
                <a href="client.asp" class="btn btn-info">Cancel</a>           
            </form>
        </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    </body>
</html>