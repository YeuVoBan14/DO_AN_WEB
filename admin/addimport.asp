<!-- #include file="../connect.asp" -->
<%
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        macthoadon_nhap = Request.QueryString("macthoadon_nhap")
        If (isnull(macthoadon_nhap) OR trim(macthoadon_nhap) = "") then 
            macthoadon_nhap=0 
        End if
        If (cint(macthoadon_nhap)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM CTHOADONNHAP WHERE macthoadon_nhap=?"
            
            cmdPrep.Parameters(0)=macthoadon_nhap
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                mahoadon_nhap = Result("mahoadon_nhap")
                ma_nhacc = Result("ma_nhacc")
                ma_sp = Result("ma_sp")
                soluong_nhap = Result("soluong_nhap")
                dongia_nhap = Result("dongia_nhap")
                
            End If

   
            Result.Close()
        End If
    Else
        macthoadon_nhap = Request.QueryString("macthoadon_nhap")
        ma_nhacc = Request.form("ma_nhacc")
        ma_sp = Request.form("ma_sp")
        soluong_nhap = Request.form("soluong_nhap")
        dongia_nhap = Request.form("dongia_nhap")
        

        if (isnull (macthoadon_nhap) OR trim(macthoadon_nhap) = "") then macthoadon_nhap=0 end if

        if (cint(macthoadon_nhap)=0) then
            if (NOT isnull(ten_nhacc) and ten_nhacc <>"" and NOT isnull(sdt_nhacc) and sdt_nhacc <>"" and NOT isnull(email_nhacc) and email_nhacc <>"" and NOT isnull(diachi_nhacc) and diachi_nhacc <>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO NHACUNGCAP(ten_nhacc,sdt_nhacc,email_nhacc,diachi_nhacc) VALUES(?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("ten_nhacc",202,1,255,ten_nhacc)
                cmdPrep.parameters.Append cmdPrep.createParameter("sdt_nhacc",202,1,255,sdt_nhacc)
                cmdPrep.parameters.Append cmdPrep.createParameter("email_nhacc",202,1,255,email_nhacc)
                cmdPrep.parameters.Append cmdPrep.createParameter("diachi_nhacc",202,1,255,diachi_nhacc)

                cmdPrep.execute               
                
                If Err.Number = 0 Then 
                
                    Session("Success") = "New supplier added!"                    
                    Response.redirect("supplier.asp")  
                Else  
                    handleError(Err.Description)
                End If
                On Error GoTo 0
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
        <link rel="stylesheet" href="../style/addedit.css">
        <title>Add/Edit Supplier</title>
    </head>
    <body>
        
        <div id="modal-container" >
        <div class="modal" id="modal-main">
          <div id="modal-header">  
              <h3>Add/Edit Supplier</h3>
              <button id="btn-modal-close"><i class="fa-solid fa-xmark"></i></button>
          </div>
          <div id="modal-body">
            <form method="post">
              <div class="inputbox">
              
                <input type="text" id="ten_nhacc" name="ten_nhacc" required value="<%=ten_nhacc%>">
                <span>Name</span>
              </div>
              <div class="inputbox">
                
                <input type="number" id="sdt_nhacc" name="sdt_nhacc" required value="<%=sdt_nhacc%>">
                <span>Phone</span>
              </div>
              <div class="inputbox">
                
                <input type="text" id="email_nhacc" name="email_nhacc"  required value="<%=email_nhacc%>">
                <span>Email</span>
              </div>
              <div class="inputbox">
                
                <input type="text" id="diachi_nhacc" name="diachi_nhacc" required value="<%=diachi_nhacc%>">
                <span>Address</span>
              </div>
              <button type="submit" class="btn-submit">
              		<%
                        if (macthoadon_nhap=0) then
                            Response.write("Create")
                        else
                            Response.write("Save")
                        end if
                    %>
              </button>
              <button class="btn-submit" style="background: #eb5160;"><a href="supplier.asp" style="text-decoration: none; color: white">Cancel</a></button>

            </form>
          </div>
        </div>
      </div>
    </div>
    </body>
</html>