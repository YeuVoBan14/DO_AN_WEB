<!-- #include file="../connect.asp" -->
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
        Response.redirect("product.asp")
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
<%
    If (Request.ServerVariables("REQUEST_METHOD") = "post") THEN        
        maquanly = Request.QueryString("maquanly")
        If (isnull(maquanly) OR trim(maquanly) = "") then 
            maquanly=0 
        End if
        If (cint(maquanly)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM QUANLY WHERE maquanly=?"
            
            cmdPrep.Parameters(0)=maquanly
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                tenquanly = Result("tenquanly")
                email_ql = Result("email_ql")
                password = Result("password")
                sdt_ql = Result("sdt_ql")
            End If

   
            Result.Close()
        End If
    Else
        maquanly = Request.QueryString("maquanly")
        tenquanly = Request.form("tenquanly")
        email_ql = Request.form("email_ql")
        password = Request.form("password")
        sdt_ql = Request.form("sdt_ql")

        if (isnull (maquanly) OR trim(maquanly) = "") then maquanly=0 end if

        if (cint(maquanly)=0) then
            if (NOT isnull(tenquanly) and tenquanly <>"" and NOT isnull(email_ql) and email_ql <>"" and NOT isnull(password) and password <>"" and NOT isnull(sdt_ql) and sdt_ql <>"" ) then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO QUANLY(tenquanly,email_ql,password,sdt_ql) VALUES(?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("tenquanly",202,1,255,tenquanly)
                cmdPrep.parameters.Append cmdPrep.createParameter("email_ql",202,1,255,email_ql)
                cmdPrep.parameters.Append cmdPrep.createParameter("password",202,1,255,password)
                cmdPrep.parameters.Append cmdPrep.createParameter("sdt_ql",202,1,255,sdt_ql)


                cmdPrep.execute               
                
                If Err.Number = 0 Then 
                
                    Session("Success") = "Đăng ký thành công"                    
                    Response.redirect("loginadmin.asp")  
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
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>Responsive Login Page</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=figtree:400,600&display=swap" rel="stylesheet" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap');

    *{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    text-decoration: none;
    font-family:Figtree, sans-serif;
    }
        .user-input:-webkit-autofill,
        .user-input:-webkit-autofill:hover,
        .user-input:-webkit-autofill:focus,
        .user-input:-webkit-autofill:active {
            transition: background-color 5000s ease-in-out 0s;
            -webkit-text-fill-color: #111 !important;
        }
body{
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: rgb(34,193,195);
background: linear-gradient(48deg, rgba(34,193,195,1) 24%, rgba(253,187,45,1) 100%);
}

.form{
  z-index: 1;
  position: absolute;
  width: 320px;
  text-align: center;
}

.form i{
  z-index: 1;
  color: #ccc;
  font-size: 65px;
  margin-bottom: 30px;
}

.form .signup-form{
  display: none;
}

.form .user-input{
  width: 320px;
  height: 55px;
  margin-bottom: 30px;
  outline: none;
  border: none;
  background: rgba(255, 255, 255, 0.2);
  color: #fff;
  font-size: 18px;
  text-align: center;
  border-radius: 5px;
  transition: 0.5s;
  transition-property: border-left, border-right, box-shadow;
}

.form .user-input:hover, .form .user-input:focus, .form .user-input:active{
  border-left: solid 8px #4285F4;
  border-right: solid 8px #4285F4;
  box-shadow: 0 0 100px rgba(66, 133, 244, 0.8);
}

.form .options-01{
  margin-bottom: 50px;
}

.form .options-01 input{
  width: 15px;
  height: 15px;
  margin-right: 5px;
}

.form .options-01 .remember-me{
  color: #bbb;
  font-size: 14px;
  display: flex;
  align-items: center;
  float: left;
  cursor: pointer;
}

.form .options-01 a{
  color: #888;
  font-size: 14px;
  font-style: italic;
  float: right;
}

.form .btn{
  outline: none;
  border: none;
  width: 320px;
  height: 55px;
  background: #4285F4;
  color: #fff;
  font-size: 18px;
  letter-spacing: 1px;
  border-radius: 5px;
  cursor: pointer;
  transition: 0.5s;
  transition-property: border-left, border-right, box-shadow;
}

.form .btn:hover{
  border-left: solid 8px rgba(255, 255, 255, 0.5);
  border-right: solid 8px rgba(255, 255, 255, 0.5);
  box-shadow: 0 0 100px rgba(66, 133, 244, 0.8);
}

.form .options-02{
  color: #333;
  font-size: 14px;
  margin-top: 30px;
}

.form .options-02 a{
  color: #4285F4;
}

/* Responsive CSS */

@media screen and (max-width: 500px){
  .form{
    width: 95%;
  }

  .form .user-input{
    width: 100%
  }

  .form .btn{
    width: 100%;
  }
}
      
    </style>
  </head>
  <body>

    <!--form area start-->
    <div class="form">
      <!--login form start-->
      <form class="login-form" action="" method="post">
        <i class="fas fa-user-circle"></i>
        <input class="user-input" type="text" name="email_ql" id="email_ql" placeholder="Username" required>
        <input class="user-input" type="password" name="password" id="password" placeholder="Password" required>
        <!-- <div class="options-01">
          <label class="remember-me"><input type="checkbox" name="">Remember me</label>
          <a href="#">Forgot your password?</a>
        </div> -->
        <input class="btn" type="submit" name="" value="LOGIN">
        <div class="options-02">
          <p>Not Registered? <a href="#">Create an Account</a></p>
        </div>
      </form>
      <!--login form end-->
      <!--signup form start-->
      <form class="signup-form" action="" method="post">
        <i class="fas fa-user-plus"></i>
        <input class="user-input" type="text" name="tenquanly" id='tenquanly' placeholder="Username" required value="<%=tenquanly%>">
        <input class="user-input" type="email" name="email_ql" id='email_ql' placeholder="Email Address" required value="<%=email_ql%>">
        <input class="user-input" type="text" name="password" id='password' placeholder="Password" required value="<%=password%>">
        <input class="user-input" type="text" name="sdt_ql" id='sdt_ql' placeholder="Phone" required value="<%=sdt_ql%>">
        <input class="btn" type="submit" name="" value="SIGN UP">
        <div class="options-02">
          <p>Already Registered? <a href="#">Sign In</a></p>
        </div>
      </form>
      <!--signup form end-->
    </div>
    <!--form area end-->

    <script type="text/javascript">
    $('.options-02 a').click(function(){
      $('form').animate({
        height: "toggle", opacity: "toggle"
      }, "slow");
    });
    </script>

  </body>
</html>