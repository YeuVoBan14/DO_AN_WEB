<!-- #include file="../connect.asp" -->
<%
Dim email_ql, password_ql
email_ql = Request.Form("email_ql")
password_ql = Request.Form("password_ql")
If (NOT isnull(email_ql) AND NOT isnull(password_ql) AND TRIM(email_ql)<>"" AND TRIM(password_ql)<>"" ) Then
    ' true
    Dim sql
    sql = "select * from QUANLY where email_ql= ? and password_ql= ?"
    Dim cmdPrep
    set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType=1
    cmdPrep.Prepared=true
    cmdPrep.CommandText = sql
    cmdPrep.Parameters(0)=email_ql
    cmdPrep.Parameters(1)=password_ql
    Dim result
    set result = cmdPrep.execute()
    'kiem tra ket qua result o day
    If not result.EOF Then
        ' dang nhap thanh cong
        Session("email_ql")=result("email_ql")
        Session("ten_ql")=result("ten_ql")
        Session("Success")="Login Successfully"
        Response.redirect("product.asp")
    Else
        ' dang nhap ko thanh cong
        Session("Error") = "Wrong email or password_ql"
    End if
    result.Close()
    connDB.Close()
Else
    ' false
    Session("Error")="Please input email and password_ql."
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
                ten_ql = Result("ten_ql")
                email_ql = Result("email_ql")
                password_ql = Result("password_ql")
                sdt_ql = Result("sdt_ql")
            End If

   
            Result.Close()
        End If
    Else
        maquanly = Request.QueryString("maquanly")
        ten_ql = Request.form("ten_ql")
        email_ql = Request.form("email_ql")
        password_ql = Request.form("password_ql")
        sdt_ql = Request.form("sdt_ql")

        if (isnull (maquanly) OR trim(maquanly) = "") then maquanly=0 end if

        if (cint(maquanly)=0) then
            if (NOT isnull(ten_ql) and ten_ql <>"" and NOT isnull(email_ql) and email_ql <>"" and NOT isnull(password_ql) and password_ql <>"" and NOT isnull(sdt_ql) and sdt_ql <>"" ) then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO QUANLY(ten_ql,email_ql,password_ql,sdt_ql) VALUES(?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("ten_ql",202,1,255,ten_ql)
                cmdPrep.parameters.Append cmdPrep.createParameter("email_ql",202,1,255,email_ql)
                cmdPrep.parameters.Append cmdPrep.createParameter("password_ql",202,1,255,password_ql)
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
    <link rel="stylesheet" href="../style/loginadmin.css">
  </head>
  <body>

    <!--form area start-->
    <div class="form">
      <!--login form start-->
      <form class="login-form" action="" method="post">
        <i class="fas fa-user-circle"></i>
        <input class="user-input" type="text" name="email_ql" id="email_ql" placeholder="Username" required>
        <input class="user-input" type="password" name="password_ql" id="password_ql" placeholder="Password" required>
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
        <input class="user-input" type="text" name="ten_ql" id='ten_ql' placeholder="Username" required value="<%=ten_ql%>">
        <input class="user-input" type="email" name="email_ql" id='email_ql' placeholder="Email Address" required value="<%=email_ql%>">
        <input class="user-input" type="text" name="password_ql" id='password_ql' placeholder="Password" required value="<%=password_ql%>">
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