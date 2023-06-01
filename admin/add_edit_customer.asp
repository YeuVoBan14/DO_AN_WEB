<!-- #include file="../connect.asp" -->
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
            if (NOT isnull(ten_kh) and ten_kh <>"" and NOT isnull(tuoi_kh) and tuoi_kh <>"" and NOT isnull(gioi_tinh) and gioi_tinh <>"" and NOT isnull(sdt_kh) and sdt_kh <>"" and NOT isnull(email_kh) and email_kh <>"" and NOT isnull(mk_kh) and mk_kh <>"" and NOT isnull(diachi_kh) and diachi_kh <>"" ) then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO KHACHHANG(ten_kh,tuoi_kh,gioi_tinh,sdt_kh,email_kh,mk_kh,diachi_kh) VALUES(?,?,?,?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("ten_kh",202,1,255,ten_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("tuoi_kh",202,1,255,tuoi_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("gioi_tinh",202,1,255,gioi_tinh)
                cmdPrep.parameters.Append cmdPrep.createParameter("sdt_kh",202,1,255,sdt_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("email_kh",202,1,255,email_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("mk_kh",202,1,255,mk_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("diachi_kh",202,1,255,diachi_kh)

                cmdPrep.execute               
                
                If Err.Number = 0 Then 
                
                    Session("Success") = "New employee added!"                    
                    Response.redirect("add_edit_customer.asp")  
                Else  
                    handleError(Err.Description)
                End If
                On Error GoTo 0
            else
                Session("Error") = "You have to input enough info"                
            end if
   else
            if (NOT isnull(ten_kh) and ten_kh <>"" and NOT isnull(tuoi_kh) and tuoi_kh <>"" and NOT isnull(gioi_tinh) and gioi_tinh <>"" and NOT isnull(sdt_kh) and sdt_kh <>"" and NOT isnull(email_kh) and email_kh <>"" and NOT isnull(mk_kh) and mk_kh <>"" and NOT isnull(diachi_kh) and diachi_kh <>"" ) then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE SANPHAM SET ten_kh=?,tuoi_kh=?,gioi_tinh=?,sdt_kh=?,email_kh=?,mk_kh=?,diachi_kh=? WHERE ma_kh=?"
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
                    Response.redirect("add_edit_customer.asp")
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
        <style>
            *{
            margin: 0px;
            padding: 0px;
            font-family: 'poppins',sans-serif;
            }
            #tuoi_kh::-webkit-inner-spin-button,
            #tuoi_kh::-webkit-outer-spin-button,
            #sdt_kh::-webkit-inner-spin-button,
            #sdt_kh::-webkit-outer-spin-button {
                -webkit-appearance: none;
                appearance: none;
                margin: 0;
            }
            input:-webkit-autofill,
                    input:-webkit-autofill:hover,
                    input:-webkit-autofill:focus,
                    input:-webkit-autofill:active {
                        transition: background-color 5000s ease-in-out 0s;
                        -webkit-text-fill-color: #fff !important;
                    }
            #modal-container{
            width: 100%;
            height: 150vh;
            position: fixed;
            background: linear-gradient(120deg,#6CFF95, #1E524E);
            top: 0;
            left: 0;
            }
            .modal{
            position: relative;
            background: rgba(29, 43, 58, 0.8);
            backdrop-filter: blur(15px);
            max-width: 600px;
            left: 50%;
            transform: translateX(-50%);
            top: 50px;
            transition: all 0.5s ease-in-out;
            border: 3px solid #00dfc4;
            border-radius: 30px;
            }
            #modal-container.modal-show .modal{
            top: 20px;
            }
            #modal-header{
            display: flex;
            justify-content: space-between;
            padding: 10px 20px;
            align-items: center;
            border-bottom: 1px solid rgba(0, 223, 196, 0.3);
            }
            #modal-header h3{
            margin: 0 auto;
            color: #fff;
            width: 100%;
            margin-left: 25px;
            font-size: 30px;
            text-align: center;
            }
            #btn-modal-close{
            background: none;
            border: none;
            font-size: 18px;
            cursor: pointer;
            color: #00dfc4;
            width: 30px;
            margin-top: 0;
            }
            #modal-body{
            padding: 15px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            }
            .inputbox{
            position: relative;
            width: 100%;
            margin-top: 20px;  
            }
            .inputbox input{
            width: 100%;
            padding: 10px;
            border: 1px solid rgba(255, 255, 255, 0.25);
            background: #1d2b3a;
            border-radius: 5px;
            outline: none;
            color: #fff;
            font-size: 1em;
            transition: 0.5s;
            }
            .inputbox:nth-child(2),
            .inputbox:nth-child(4),
            .inputbox:nth-child(6)
            {
            width: 48%;
            margin-right: 16px;
            display: inline-block;
            }
            .inputbox:nth-child(3),
            .inputbox:nth-child(5),
            .inputbox:nth-child(7)
            {
            width: 48%;
            display: inline-block;
            }
            .inputbox span{
            position: absolute;
            left: 0;
            top:0;
            padding: 10px;
            pointer-events: none;
            font-size: 1em;
            color: rgba(255, 255, 255, 0.25);
            text-transform: uppercase;
            transition: 0.5s;
            }
            .inputbox input:valid ~ span,
            .inputbox input:focus ~ span{
            color: #00dfc4;
            transform: translateX(10px) translateY(-7px);
            font-size: 0.65em;
            padding: 0 10px;
            background: #1d2b3a;
            border-left: 1px solid #00dfc4;
            border-right: 1px solid #00dfc4;
            letter-spacing: 0.3em;
            }
            .inputbox input:valid,
            .inputbox input:focus{
            border: 1px solid #00dfc4;
            }
            .btn-submit{
            margin-top: 30px;
            background: #00dfc4;
            border: none;
            outline: none;
            color: (255, 255, 255, 0.25);
            width: 80px;
            height: 40px;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            }
        </style>
    </head>
    <body>
        
        <div id="modal-container" >
        <div class="modal" id="modal-main">
          <div id="modal-header">  
              <h3>Add/Edit Customer</h3>
              <button id="btn-modal-close"><i class="fa-solid fa-xmark"></i></button>
          </div>
          <div id="modal-body">
            <form method="post">
              <div class="inputbox">
              
                <input type="text" id="ten_kh" name="ten_kh" required value="<%=ten_kh%>">
                <span>Name</span>
              </div>
              <div class="inputbox">
                
                <input type="number" id="tuoi_kh" name="tuoi_kh" required value="<%=tuoi_kh%>">
                <span>Age</span>
              </div>
              <div class="inputbox">
                
                <input type="text" id="gioi_tinh" name="gioi_tinh"  required value="<%=gioi_tinh%>">
                <span>Gender</span>
              </div>
              <div class="inputbox">
                
                <input type="email" id="email_kh" name="email_kh" required value="<%=email_kh%>">
                <span>Email</span>
              </div>
              <div class="inputbox">
                
                <input type="text" id="sdt_kh" name="sdt_kh" required value="<%=sdt_kh%>">
                <span>Phone</span>
              </div>          
              <div class="inputbox">

                <input type="text" id="mk_kh" name="mk_kh" required value="<%=mk_kh%>">
                <span>Password</span>
              </div>
              <div class="inputbox">

                <input type="text"  id="diachi_kh" name="diachi_kh"  required value="<%=diachi_kh%>">
                <span>Address</span>
              </div>
              <button type="submit" class="btn-submit">
              		<%
                        if (ma_kh=0) then
                            Response.write("Create")
                        else
                            Response.write("Save")
                        end if
                    %>
              </button>
              <button class="btn-submit" style="background: #eb5160;"><a href="customer.asp" style="text-decoration: none; color: white">Cancel</a></button>

            </form>
          </div>
        </div>
      </div>
    </div>
    </body>
</html>