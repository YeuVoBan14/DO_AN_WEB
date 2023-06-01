<!-- #include file="../connect.asp" -->
<%
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        ma_sp = Request.QueryString("ma_sp")
        If (isnull(ma_sp) OR trim(ma_sp) = "") then 
            ma_sp=0 
        End if
        If (cint(ma_sp)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM SANPHAM WHERE ma_sp=?"
            
            cmdPrep.Parameters(0)=ma_sp
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                ten_sp = Result("ten_sp")
                loai = Result("loai")
                ten_nhacc = Result("ten_nhacc")
                gia_nhap = Result("gia_nhap")
                gia_ban = Result("gia_ban")
                mau_sp = Result("mau_sp")
                soluong_ton = Result("soluong_ton")
                hinh_anh_sp = Result("hinh_anh_sp")
                
            End If

   
            Result.Close()
        End If
    Else
        ma_sp = Request.QueryString("ma_sp")
        ten_sp = Request.form("ten_sp")
        loai = Request.form("loai")
        ten_nhacc = Request.form("ten_nhacc")
        gia_nhap = Request.form("gia_nhap")
        gia_ban = Request.form("gia_ban")
        mau_sp = Request.form("mau_sp")
        soluong_ton = Request.form("soluong_ton")
        hinh_anh_sp = Request.form("hinh_anh_sp")
        

        if (isnull (ma_sp) OR trim(ma_sp) = "") then ma_sp=0 end if

        if (cint(ma_sp)=0) then
            if (NOT isnull(ten_sp) and ten_sp <>"" and NOT isnull(loai) and loai <>"" and NOT isnull(ten_nhacc) and ten_nhacc <>"" and NOT isnull(gia_nhap) and gia_nhap <>"" and NOT isnull(gia_ban) and gia_ban <>"" and NOT isnull(mau_sp) and mau_sp <>"" and NOT isnull(soluong_ton) and soluong_ton <>"" and NOT isnull(hinh_anh_sp) and hinh_anh_sp <>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO SANPHAM(ten_sp,loai,ten_nhacc,gia_nhap,gia_ban,mau_sp,soluong_ton,hinh_anh_sp) VALUES(?,?,?,?,?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("ten_sp",202,1,255,ten_sp)
                cmdPrep.parameters.Append cmdPrep.createParameter("loai",202,1,255,loai)
                cmdPrep.parameters.Append cmdPrep.createParameter("ten_nhacc",202,1,255,ten_nhacc)
                cmdPrep.parameters.Append cmdPrep.createParameter("gia_nhap",202,1,255,gia_nhap)
                cmdPrep.parameters.Append cmdPrep.createParameter("gia_ban",202,1,255,gia_ban)
                cmdPrep.parameters.Append cmdPrep.createParameter("mau_sp",202,1,255,mau_sp)
                cmdPrep.parameters.Append cmdPrep.createParameter("soluong_ton",202,1,255,soluong_ton)
                cmdPrep.parameters.Append cmdPrep.createParameter("hinh_anh_sp",202,1,255,hinh_anh_sp)

                cmdPrep.execute               
                
                If Err.Number = 0 Then 
                
                    Session("Success") = "New employee added!"                    
                    Response.redirect("add_edit_product.asp")  
                Else  
                    handleError(Err.Description)
                End If
                On Error GoTo 0
            else
                Session("Error") = "You have to input enough info"                
            end if
   else
            if (NOT isnull(ten_sp) and ten_sp <>"" and NOT isnull(loai) and loai <>"" and NOT isnull(ten_nhacc) and ten_nhacc <>"" and NOT isnull(gia_nhap) and gia_nhap <>"" and NOT isnull(gia_ban) and gia_ban <>"" and NOT isnull(mau_sp) and mau_sp <>"" and NOT isnull(soluong_ton) and soluong_ton <>"" and NOT isnull(hinh_anh_sp) and hinh_anh_sp <>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE SANPHAM SET ten_sp=?,loai=?,ten_nhacc=?,gia_nhap=?,gia_ban=?,mau_sp=?,soluong_ton=?,hinh_anh_sp=? WHERE ma_sp=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("ten_sp",202,1,255,ten_sp)
                cmdPrep.parameters.Append cmdPrep.createParameter("loai",202,1,255,loai)
                cmdPrep.parameters.Append cmdPrep.createParameter("ten_nhacc",202,1,255,ten_nhacc)
                cmdPrep.parameters.Append cmdPrep.createParameter("gia_nhap",202,1,255,gia_nhap)
                cmdPrep.parameters.Append cmdPrep.createParameter("gia_ban",202,1,255,gia_ban)
                cmdPrep.parameters.Append cmdPrep.createParameter("mau_sp",202,1,255,mau_sp)
                cmdPrep.parameters.Append cmdPrep.createParameter("soluong_ton",202,1,255,soluong_ton)
                cmdPrep.parameters.Append cmdPrep.createParameter("hinh_anh_sp",202,1,255,hinh_anh_sp)
                cmdPrep.parameters.Append cmdPrep.createParameter("ma_sp",3,1, ,ma_sp)

                cmdPrep.execute
                If Err.Number=0 Then
                    Session("Success") = "The employee was edited!"
                    Response.redirect("add_edit_product.asp")
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
            #gia_ban::-webkit-inner-spin-button,
            #gia_ban::-webkit-outer-spin-button,
            #gia_nhap::-webkit-inner-spin-button,
            #gia_nhap::-webkit-outer-spin-button,
            #soluong_ton::-webkit-inner-spin-button,
            #soluong_ton::-webkit-outer-spin-button {
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
            background: linear-gradient(120deg,#2980b9, #8e44ad);
            top: 0;
            left: 0;
            }
            .modal{
            position: relative;
            background: rgba(29, 43, 58, 0.25);
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
              <h3>Add/Edit Product</h3>
              <button id="btn-modal-close"><i class="fa-solid fa-xmark"></i></button>
          </div>
          <div id="modal-body">
            <form method="post">
              <div class="inputbox">
              
                <input type="text" id="ten_sp" name="ten_sp" required value="<%=ten_sp%>">
                <span>Name</span>
              </div>
              <div class="inputbox">
                
                <input type="number" id="gia_ban" name="gia_ban" required value="<%=gia_ban%>">
                <span>Price</span>
              </div>
              <div class="inputbox">
                
                <input type="text" id="loai" name="loai"  required value="<%=loai%>">
                <span>Brand</span>
              </div>
              <div class="inputbox">
                
                <input type="number" id="soluong_ton" name="soluong_ton" required value="<%=soluong_ton%>">
                <span>Quantities</span>
              </div>
              <div class="inputbox">
                
                <input type="text" id="mau_sp" name="mau_sp" required value="<%=mau_sp%>">
                <span>Color</span>
              </div>
              <div class="inputbox">

                <input type="text" id="ten_nhacc" name="ten_nhacc" required value="<%=ten_nhacc%>">
                <span>Suppiler</span>
              </div>
              <div class="inputbox">

                <input type="number"  id="gia_nhap" name="gia_nhap"  required value="<%=gia_nhap%>">
                <span>Import price</span>
              </div>
			  <div class="inputbox">

                <input type="text"  id="hinh_anh_sp" name="hinh_anh_sp"  required value="<%=hinh_anh_sp%>">
                <span>Picture</span>
              </div>
              <button type="submit" class="btn-submit">
              		<%
                        if (ma_sp=0) then
                            Response.write("Create")
                        else
                            Response.write("Save")
                        end if
                    %>
              </button>
              <button class="btn-submit" style="background: #eb5160;"><a href="product.asp" style="text-decoration: none; color: white">Cancel</a></button>

            </form>
          </div>
        </div>
      </div>
    </div>
    </body>
</html>