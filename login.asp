<!-- #include file="connect.asp" -->
<%
    If (Request.ServerVariables("REQUEST_METHOD") = "post") THEN        
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
                mk_kh = Result("mk_kh")
                email_kh = Result("email_kh")
                diachi_kh= Result("diachi_kh")
            End If

   
            Result.Close()
        End If
    Else
        ma_kh = Request.QueryString("ma_kh")
        ten_kh = Request.form("ten_kh")
        tuoi_kh = Request.form("tuoi_kh")
        gioi_tinh = Request.form("gioi_tinh")
        sdt_kh = Request.form("sdt_kh")
        mk_kh = Request.form("mk_kh")
        email_kh = Request.form("email_kh")
        diachi_kh= Request.form("diachi_kh")

        if (isnull (ma_kh) OR trim(ma_kh) = "") then ma_kh=0 end if

        if (cint(ma_kh)=0) then
            if (NOT isnull(ten_kh) and ten_kh <>"" and NOT isnull(tuoi_kh) and tuoi_kh <>"" and NOT isnull(gioi_tinh) and gioi_tinh <>"" and NOT isnull(sdt_kh) and sdt_kh <>"" and NOT isnull(mk_kh) and mk_kh <>"" and NOT isnull(email_kh) and email_kh <>"" and NOT isnull(diachi_kh) and diachi_kh <>"" ) then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO KHACHHANG(ten_kh,tuoi_kh,gioi_tinh,sdt_kh,mk_kh,email_kh,diachi_kh) VALUES(?,?,?,?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("ten_kh",202,1,255,ten_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("tuoi_kh",202,1,255,tuoi_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("gioi_tinh",202,1,255,gioi_tinh)
                cmdPrep.parameters.Append cmdPrep.createParameter("sdt_kh",202,1,255,sdt_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("mk_kh",202,1,255,mk_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("email_kh",202,1,255,email_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("diachi_kh",202,1,255,diachi_kh)

                cmdPrep.execute               
                
                If Err.Number = 0 Then 
                
                    Session("Success") = "Đăng ký thành công"                    
                    Response.redirect("login.asp")  
                Else  
                    handleError(Err.Description)
                End If
                On Error GoTo 0
            else
                Session("Error") = "Đăng ký thất bại"                
            end if
        end if
    End If    
%>
<div class="error">
<%
If Request.Form("submit") <> "" Then
    Dim username
    username = Request.Form("username")
    Dim password
    password = Request.Form("password")
    
    Dim conn
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open "Provider=SQLOLEDB;Data Source=YEUVOBAN\SQLEXPRESS;Initial Catalog=DO_AN_WEB;User ID=sa;Password=1234;"
    Dim rs
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open "SELECT * FROM QUANLY WHERE email_ql = '" & username & "' AND password = '" & password & "'", conn
    If rs.EOF Then
        'Response.Write(Session("Error"))
        Response.Write("<p>Invalid input. Try again</p>")
    Else
        Session("authenticated") = True
        Response.Redirect "index.asp"
    End If
    rs.Close
    Set rs = Nothing
    conn.Close
    Set conn = Nothing
End If
%>
</div>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <title>login</title>
    <style>
        *{
            margin: 0px;
            padding: 0px;
            font-family: 'poppins',sans-serif;
        }
        .error{
            position: fixed;
            text-align: center;
            top: 85px;
            line-height: 45px;
            font-family: 'Courier New', Courier, monospace ;
            width: 100%;
            font-size: 20px;
            font-weight: bold;
            color: #ff0000;
        }
        section{
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            width: 100%;
            background: url('background3.jpg')no-repeat;
            background-position: center;
            background-size: cover;
        }
        .form-box{
            position: relative;
            width: 400px;
            height: 450px;
            background-color: transparent;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 40px;
            border: 2px solid white;
            box-shadow: 4px 4px 4px rgba(164, 219, 222, 0.5);
            background-color:rgba(237, 243, 244, 0.2)
        }
        h2{
            font-size: 2em;
            color: #fff;
            text-align: center;
        }
        .inputboxlogin{
            position: relative;
            margin: 30px 0;
            width: 310px;
            border-bottom: 2px solid #fff;
        }
        .inputboxlogin label{
            position: absolute;
            top: 50%;
            left: 5px;
            transform: translateY(-50%);
            color: #fff;
            font-size: 1em;
            pointer-events: none;
            transition: .5s;
        }
        input:focus ~ label,
        input:valid ~ label{
            top:-5px;
        }
        .inputboxlogin input{
            width: 100%;
            height: 50px;
            background: transparent;
            border: none;
            outline: none;
            font-size: 1em;
            padding: 0 35px 0 5px;
            color: #fff;
        }
        .inputboxlogin ion-icon{
            position: absolute;
            top: 20px;
            right: 8px;
            color: #fff;
            display: flex;
            justify-content: center;
            font-size: 20px;
        }
        button{
            width: 100%;
            height: 40px;
            border-radius: 40px;
            background: #fff;
            border: none;
            outline: none;
            cursor: pointer;
            font-size: 1em;
            font-weight: 600;
            margin-top: 20px;
        }
        /* #btn-modal-open{
            background: #ccc;
            outline: none;
            border: none;
            margin-top: 10px;
            font-size: 15px;
            padding: 5px 10px;
            border-radius: 7px;
            font-weight: 500;
            cursor: pointer;
        } */
        #modal-container{
            width: 100%;
            height: 150vh;
            position: fixed;
            background: rgba(0, 0, 0, 0.5);
            top: 0;
            left: 0;
            opacity: 0;
            pointer-events: none;
            transition: all 0.5s ease-in-out;
            }
        .modal-show{
            opacity: 1
            !important;
            pointer-events: all
            !important
            }
        .modal{
            position: relative;
            background: #1d2b3a;
            max-width: 600px;
            left: 50%;
            transform: translateX(-50%);
            top: 0;
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
            width: 500px;
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
        .inputbox:nth-child(2){
            width: 100px;
            margin-right: 10px;
            display: inline-block;
            }
        .inputbox:nth-child(3){
            width: 385px;
            display: inline-block;
            }
        .inputbox span{
            position: absolute;
            left: 0;
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
        .session{
            width: 300px;
            height: 80px;
            font-size: 30px;
            background: rgba(209, 231, 221, 0.5);
            color: rgb(26, 89, 60);
            border-radius: 10px;
            position: fixed;
            align-items: center;
            top: 10px;
            right: 10px;
            opacity: 1;
            transition: opacity 1s ease-in-out;   
        }
        .session p{
            margin: auto;
            line-height: 80px;
            text-align: center;
            font-weight: bolder;
        }
    </style>
</head>
<body>
    <section>
        <div class="session" id="success-message" style="display: none;">
            <p>Success</p>
        </div>
        <div class="form-box">
            <div class="form-value">
                <form method="post" action="login.asp">
                    <h2>Login</h2>
                    <div class="inputboxlogin">
                        <ion-icon name="mail-outline"></ion-icon>
                        <input type="text" name="username" required id="username">
                        <label for="username">Email</label>
                    </div>
                    <div class="inputboxlogin">
                        <ion-icon name="lock-closed-outline"></ion-icon>
                        <input type="password" name="password" required id="password">
                        <label for="password">Password</label>
                    </div>
                    <button type="submit" name="submit" value="Login">Log in</button>
                </form>
                <button id="btn-modal-open">Sign Up</button>
                <button onclick="handleButtonClick()">Click Me</button>
            </div>
        </div>
    </section>
    <div id="modal-container" >
        <div class="modal" id="modal-main">
          <div id="modal-header">  
              <h3>Sign In</h3>
              <button id="btn-modal-close"><i class="fa-solid fa-xmark"></i></button>
          </div>
          <div id="modal-body">
            <form method="post">
              <div class="inputbox">
                <input type="text" id="ten_kh" name="ten_kh" value="<%=ten_kh%>" required>
                <span>Name</span>
              </div>
              <div class="inputbox">
                <input type="number" id="tuoi_kh" name="tuoi_kh" value="<%=tuoi_kh%>" required>
                <span>Age</span>
              </div>
              <div class="inputbox">
                <input type="text" id="sdt_kh" name="sdt_kh" value="<%=sdt_kh%>" required>
                <span>Phone</span>
              </div>
              <div class="inputbox">
                <input type="text" id="gioi_tinh" name="gioi_tinh" value="<%=gioi_tinh%>" required>
                <span>Gender</span>
              </div>
              <div class="inputbox">
                <input type="email" id="email_kh" name="email_kh" value="<%=email_kh%>" required>
                <span>Email</span>
              </div>
              <div class="inputbox">
                <input type="text" id="mk_kh" name="mk_kh" value="<%=mk_kh%>" required>
                <span>Password</span>
              </div>
              <div class="inputbox">
                <input type="text" class="form-control" id="diachi_kh" name="diachi_kh" value="<%=diachi_kh%>" required>
                <span>Address</span>
              </div>
              <button type="submit" class="btn-submit">
              <%
                        if (ma_kh=0) then
                            Response.write("Sign up")
                        end if
                    %>
              </button>
            </form>
          </div>
        </div>
      </div>
    
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script>
      const btn_open = document.getElementById('btn-modal-open');
      const btn_close = document.getElementById('btn-modal-close');
      const modal_container = document.getElementById('modal-container');
      const modal_main = document.getElementById('modal-main');
      btn_open.addEventListener('click' , ()=>{
        modal_container.classList.add('modal-show')
      });
      btn_close.addEventListener('click' , ()=>{
        modal_container.classList.remove('modal-show')
      });
      modal_container.addEventListener('click', (e)=>{
        if(!modal_main.contains(e.target)){
          btn_close.click();
        }
      });
    </script>

    <script>
    function fadeOut() {
      var successMessage = document.getElementById("success-message");
      successMessage.style.opacity = 0;
    }

    function handleButtonClick() {
      var successMessage = document.getElementById("success-message");
      successMessage.style.display = "block"; // Show the success message
      setTimeout(fadeOut, 3000); // Fade out after 3 seconds
    }
    </script>
</body>
</html>