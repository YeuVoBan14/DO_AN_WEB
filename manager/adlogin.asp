<!-- #include file="connect.asp" -->
<%
Dim email_ql, password
email_ql = Request.Form("email_ql")
password = Request.Form("password")
If (NOT isnull(email_ql) AND NOT isnull(password) AND TRIM(email_ql)<>"" AND TRIM(password)<>"" ) Then
    ' true
    Dim sql
    sql = "select * from QUANLY where email_ql= ? and password= ?"
    Dim cmdPrep
    set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType=1
    cmdPrep.Prepared=true
    cmdPrep.CommandText = sql
    cmdPrep.Parameters(0)=email_ql
    cmdPrep.Parameters(1)=password
    Dim result
    set result = cmdPrep.execute()
    'kiem tra ket qua result o day
    If not result.EOF Then
        ' dang nhap thanh cong
        Session("email_ql")=result("email_ql")
        Session("Success")="Login Successfully"
        Response.redirect("admin.asp")
    Else
        ' dang nhap ko thanh cong
        Session("Error") = "Wrong email or password"
    End if
    result.Close()
    connDB.Close()
Else
    ' false
    Session("Error")="Please input email and password."
End if
%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <title>LOGIN ADMIN</title>
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
            background: url('./img/back.png')no-repeat;
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
                <form method="post" action="adlogin.asp">
                    <h2>Login ADMIN</h2>
                    <div class="inputboxlogin">
                        <ion-icon name="mail-outline"></ion-icon>
                        <input type="text" name="email_ql" required id="email_ql">
                        <label for="email_ql">Email</label>
                    </div>
                    <div class="inputboxlogin">
                        <ion-icon name="lock-closed-outline"></ion-icon>
                        <input type="password" name="password" required id="password">
                        <label for="password">Password</label>
                    </div>
                    <button type="submit" name="submit" value="Login">Log in</button>
                </form>
                
                
            </div>
        </div>
    </section>
    
    
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