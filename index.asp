<!--#include file="connect.asp"-->
<%
    Dim sqlString, rs
    sqlString = "Select * from SANPHAM"
    connDB.Open()
    set rs = connDB.execute(sqlString)    
%> 
<%
' code to calculate the current page number
currentPage = Request.QueryString("page")
if currentPage = "" then currentPage = 1

' code to retrieve the products for the current page
pageSize = 4
startRow = (currentPage - 1) * pageSize
sqlString = "SELECT * FROM SANPHAM ORDER BY ma_sp OFFSET " & startRow & " ROWS FETCH NEXT " & pageSize & " ROWS ONLY"
set rs = connDB.execute(sqlString)
%>
<%
' ham lam tron so nguyen
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function

    function checkPage(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function
' trang hien tai
    page = Request.QueryString("page")
    limit = 4

    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    strSQL = "SELECT COUNT(ma_sp) AS count FROM SANPHAM"
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing
' lay ve tong so trang
    pages = Ceil(totalRows/limit)
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <title>Index</title>
    <style>
      *{
          padding: 0;
          margin: 0;
          box-sizing: border-box;
          font-family: 'Poppins', sans-serif;
          text-decoration: none;
      }
      body{
        align-items: center;
        justify-content: center;
        background: #ACC8E5;
        min-height: 150vh;
      }
      .title{
          text-align: center;
          padding-top: 80px;
          font-size: 35px;
          font-weight: 700;
          color: #fff;
        }
        @media (max-width: 420px) {
          .title{
            font-size: 20px;
          }
        }
      header{
        list-style: none;
        box-sizing: border-box;
        position: fixed;
        z-index: 3;
        width: 100%;
      }
      nav{
        background: #0082e6;
        height: 80px;
        width: 100%;
      }
      nav ul{
        float: right;
        margin-right: 20px;
        text-decoration: none;
      }
      nav ul li{
        display: inline-block;
        line-height: 80px;
        margin: 0 5px;
      }
      nav ul li a{
        color: white;
        font-size: 17px;
        padding: 7px 13px;
        border-radius: 3px;
        text-transform: uppercase;
        font-weight: 600;
        border-radius: 20px;
      }
      .user-icon{
        padding: 10px 12px;
      }
      .logout-icon{
        padding: 12px 12px;
        border-radius: 50px;
      }
      .welcome-mess{
        color: #fff;
        font-size: 16px;
        font-weight: 600;
      }
      a.active,a:hover{
        background: white;
        color: #1b9bff;
        transition: .5s;
      }
      .checkbtn{
        font-size: 30px;
        color: white;
        float: right;
        line-height: 80px;
        margin-right: 40px;
        cursor: pointer;
        display: none;
      }
      #check{
        display: none;
      }
      @media (max-width: 952px){
        nav ul li a{
          font-size: 16px;
        }
      }
      @media (max-width: 858px){
        .checkbtn{
          display: block;
        }
        ul{
          z-index: 3;
          position: fixed;
          width: 100%;
          height: 100vh;
          background: #2c3e50;
          top: 80px;
          left: -100%;
          text-align: center;
          transition: all .5s;
        }
        nav ul li{
          display: block;
          margin: 50px 0;
          line-height: 30px;
        }
        nav ul li a{
          font-size: 20px;
        }
        a:hover{
          background: none;
          color: #0082e6;
        }
        #check:checked ~ ul{
          left: 0;
        }
      }

      /* style for search box */
      .search-box{
        display: inline-block;
        margin-top: 10px;
        margin-left: 10px;
        position: relative;
        height: 60px;
        width: 60px;
        border-radius: 50%;
        box-shadow: 5px 5px 30px rgba(0,0,0,.2);
        transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
      }
      .search-box.active{
        width: 350px;
      }
      .search-box input{
        width: 100%;
        height: 100%;
        border: none;
        border-radius: 50px;
        background: #fff;
        outline: none;
        padding: 0 60px 0 20px;
        font-size: 18px;
        opacity: 0;
        transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
      }
      .search-box input.active{
        opacity: 1;
      }
      .search-box input::placeholder{
        color: #a6a6a6;
      }
      .search-box .search-icon{
        position: absolute;
        right: 0px;
        top: 50%;
        transform: translateY(-50%);
        height: 60px;
        width: 60px;
        background: #fff;
        border-radius: 50%;
        text-align: center;
        line-height: 60px;
        font-size: 22px;
        color: #0082e6;
        cursor: pointer;
        z-index: 1;
        transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
      }
      .search-box .search-icon.active{
        right: 5px;
        height: 50px;
        line-height: 50px;
        width: 50px;
        font-size: 20px;
        background: #0082e6;
        color: #fff;
        transform: translateY(-50%) rotate(360deg);
      }
      .search-box .cancel-icon{
        position: absolute;
        right: 20px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 25px;
        color: #fff;
        cursor: pointer;
        transition: all 0.5s 0.2s cubic-bezier(0.68, -0.55, 0.265, 1.55);
      }
      .search-box .cancel-icon.active{
        right: -40px;
        transform: translateY(-50%) rotate(360deg);
      }
      .search-box .search-data{
        text-align: center;
        padding-top: 7px;
        color: #fff;
        font-size: 18px;
        word-wrap: break-word;
      }
      .search-box .search-data.active{
        display: none;
      }

      /* slider */
      .slidermain{
        width: 100%;
        /* min-height: 100vh; */
        padding-top: 50px;
      }
      .img-slider{
        position: relative;
        width: 800px;
        height: 500px;
        border: 6px solid #0082e6 ;
        border-radius: 37px;
        background: black;
        margin: 0px auto 0 auto;
        overflow: hidden;
      }

      .img-slider .slide{
        z-index: 1;
        position: absolute;
        width: 100%;
        clip-path: circle(0% at 0 50%);
      }

      .img-slider .slide.active{
        clip-path: circle(150% at 0 50%);
        transition: 2s;
        transition-property: clip-path;
      }

      .img-slider .slide img{
        z-index: 1;
        width: 100%;
        border-radius: 30px;
      }

      .img-slider .slide .info{
        position: absolute;
        top: 0;
        padding: 15px 30px;
      }

      .img-slider .slide .info h2{
        color: #fff;
        font-size: 45px;
        text-transform: uppercase;
        font-weight: 800;
        letter-spacing: 2px;
      }

      .img-slider .slide .info p{
        color: #fff;
        background: rgba(0, 0, 0, 0.1);
        font-size: 16px;
        width: 60%;
        padding: 10px;
        border-radius: 4px;
      }

      .img-slider .navigation{
        z-index: 2;
        position: absolute;
        display: flex;
        bottom: 30px;
        left: 50%;
        transform: translateX(-50%);
      }

      .img-slider .navigation .btn{
        background: rgba(255, 255, 255, 0.5);
        width: 12px;
        height: 12px;
        margin: 10px;
        border-radius: 50%;
        cursor: pointer;
      }

      .img-slider .navigation .btn.active{
        background: #2696E9;
        box-shadow: 0 0 2px rgba(0, 0, 0, 0.5);
      }

      @media (max-width: 820px){
        .img-slider{
          width: 600px;
          height: 375px;
        }

        .img-slider .slide .info{
          padding: 10px 25px;
        }

        .img-slider .slide .info h2{
          font-size: 35px;
        }

        .img-slider .slide .info p{
          width: 70%;
          font-size: 15px;
        }

        .img-slider .navigation{
          bottom: 25px;
        }

        .img-slider .navigation .btn{
          width: 10px;
          height: 10px;
          margin: 8px;
        }
      }

      @media (max-width: 620px){
        .img-slider{
          width: 400px;
          height: 250px;
        }

        .img-slider .slide .info{
          padding: 10px 20px;
        }

        .img-slider .slide .info h2{
          font-size: 30px;
        }

        .img-slider .slide .info p{
          width: 80%;
          font-size: 13px;
        }

        .img-slider .navigation{
          bottom: 15px;
        }

        .img-slider .navigation .btn{
          width: 8px;
          height: 8px;
          margin: 6px;
        }
      }

      @media (max-width: 420px){
        .img-slider{
          width: 320px;
          height: 200px;
        }

        .img-slider .slide .info{
          padding: 5px 10px;
        }

        .img-slider .slide .info h2{
          font-size: 25px;
        }

        .img-slider .slide .info p{
          width: 90%;
          font-size: 11px;
        }

        .img-slider .navigation{
          bottom: 10px;
        }
      }

      /* products */
      .productmain {
        display: flex;
        flex-wrap: nowrap;
        overflow-x: auto;
      }

      .productcard {
        flex: 0 0 auto;
        display: block;
        width: 25%;
        padding: 10px;
        box-sizing: border-box;
      }
      .productcard .card{
        width: 100%;
        background: #ecf0f1;
        border: 3px solid #0082e6 ;
        border-radius: 10px;
        overflow: hidden;
      }
      .productcard .card .productimg{
        position: relative;
        width: 100%;
        height: 310px;
        overflow: hidden;
      }
      .productcard .card .productimg img{
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: 1s ease-in-out;
        transform-origin: right;
      }
      .productcard .card:hover .productimg img{
        transform: scale(1.5);
      }
      .productaction{
        position: absolute;
        top: 10px;
        right: 10px;
      }
      .productaction li{
        position: relative;
        list-style: none;
        width: 40px;
        height: 40px;
        background: #fff;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 4px;
        cursor: pointer;
        transition: transform 0.5s;
        transform: translateX(60px);
      }
      .productaction li button{
        background: none;
        border: none;
      }
      .productaction li button a{
        background: none;
        border: none;
        color: black;
      }
      .productaction li button i{
        font-size: 16px;
      }
      .productaction li:nth-child(2){
        transition-delay: 0.15s;
      }
      .productaction li:nth-child(3){
        transition-delay: 0.3s;
      }
      .productcard .card:hover .productaction li{
        transform: translateX(0px);
      }
      .productaction li:hover{
        background: #ff2020;
        color: #fff;
        transition: 0.3s ease-in-out;
      }
      .productaction li span {
        position: absolute;
        right: 50px;
        top: 50%;
        transform: translateY(-50%);
        white-space: nowrap;
        padding: 4px 6px;
        background: #fff;
        color: #333;
        font-weight: 500;
        font-size: 13px;
        border-radius: 4px;
        pointer-events: none;
        opacity: 0;
        transition: 0.5s;
      }
      .productaction li span a{
        color: black;
        font-size: 15px;
      }
      .productaction li:hover span{
        opacity: 1;
      }
      .productcontent{
        padding: 10px;
      }
      .productbrand{
        size: 10px;
        color: #333;
      }
      .productcontent h3{
        color: #3498db;
        text-transform: uppercase;
      }
      .productprice{
        display: flex;
        align-content: space-between;
        float: right;
        font-size: 20px;
        margin: 10px;
        color: #ff2020;
        font-weight: 700;
      }
      @media (max-width: 700px){
        .productcard .card{
          width: 25%; 
          padding: 10px; 
          float:left;
          height: 300px;
      }
      }



      /* style for footer */
      footer{
        height: fit-content;
        width: 100%;
        display: flex;
        background: #0082e6;
        color: white;
        margin-top: 50px;
      }
      .footer_about{
        width: 40%;
        padding: 10px 10px;
        justify-content: center;
        align-items: center;
      }
      .contactform{
        width: 100%;
        height: 300px;
        padding: 40px;
        background: #fff;
        border-radius: 20px;
        margin-top: 0;
      }
      .contactform h2{
        font-size: 20px;
        color: #333;
        text-align: center;
        font-weight: 500;
      }
      .contactform .inputbox{
        position: relative;
        width: 100%;
        margin-top: 5px;
      }
      .contactform .inputbox input,
      .contactform .inputbox textarea{
        width: 100%;
        padding: 2px 0;
        font-size: 13px;
        margin: 10px 0;
        border: none;
        border-bottom: 2px solid #333;
        outline: none;
        resize: none;
      }
      .contactform .inputbox textarea{
        height: 50px;
      }
      .contactform .inputbox span{
        position: absolute;
        left: 0;
        padding: 5px 0;
        font-size: 13px;
        margin: 10px 0;
        pointer-events: none;
        transition: 0.5s;
        color: #666;
      }
      .contactform .inputbox input:focus ~ span,
      .contactform .inputbox input:valid ~ span,
      .contactform .inputbox textarea:focus ~ span,
      .contactform .inputbox textarea:valid ~ span{
        color: #e91e63;
        font-size: 12px;
        transform: translateY(-20px);
      }
      .contactform .inputbox input[type="submit"]{
        width: 80px;
        background: #0082e6;
        color: #fff;
        border: none;
        cursor: pointer;
        padding: 10px;
        font-size: 14px;
        border-radius: 5px;
      }
      @media (max-width: 700px){
        .contactform{
          padding: 15px
          !important
        }
        .contactform h2{
          font-size: 15px;
        }
        .contactform .inputbox span{
          font-size: 10px;
        }
        .contactform .inputbox input[type="submit"]{
          width: 60px;
          font-size: 10px;
        }
      }
      @media (max-width: 560px) {
        .contactform{
          padding: 10px;
        }
        .contactform h2{
          font-size: 10px
          !important
        }
        .contactform .inputbox span{
          font-size: 6px;
        }
        .contactform .inputbox input[type="submit"]{
          width: 40px;
          padding: 7px;
          font-size: 6px;
          margin-top: 0 ;
        }
      }
      .footer_social{
        width: 30%;
        padding: 10px 10px;
        text-align: center;
      }
      .footer_social h2{
        margin-top: 30px;
      }
      .footer_social a{
        background: none;
      }
      .footer_social a i{
        font-size: 25px;
        color: white;
        margin: 10px 10px;
      }
      .footer_social a i:hover{
        font-size: 35px;
        transition: 0.5s ease-in-out;
      }
      .footer_map{
        width: 40%;
        padding: 30px 10px;
        text-align: center;
      }
      .footer_map .map{
        border: 3px solid white;
        border-radius: 10px;
        width: 90%;
        height: 153px;
        overflow: hidden;
        margin: 0 auto;
      }
      .footer_map .map iframe{
        width: 450px;
        height: 150px;
        border-radius: 10px;
      }
      @media (max-width: 560px) {
        .footer_about h2{
          font-size: 20px;
        }
        .footer_about p{
          font-size: 15px;
        }
        .footer_social h2,
        .footer_map h2{
          font-size: 20px;
        }
        .footer_social a i{
          font-size: 15px;
          margin: 5px;
        }
        .footer_social a i:hover{
          font-size: 20px;
          transition: 0.5s ease-in-out;
        }
      }
      /*style for pagination*/
      .page_main{
        margin: 0 auto  ;
        display: flex;
        width: 25%;
        height: 10px;
        height: 60px;
        border: 5px solid #0082e6;
        border-radius: 40px;
        background: #3498db;
        justify-content: center;
        align-items: center;
        overflow: hidden;
      }
      .page_item{
        list-style: none;
        display: inline-block;
        padding: 0 5px;
      }
      .page_link{
        color: white;
        border: 2px soild blue;
        font-size: 20px;
        padding: 7px 13px;
        border-radius: 50px;
        font-weight: bold;
      }
      /* style for modal */

      *{
        box-sizing: border-box;
      }
      body{
        min-height: 150vh;
      }
      .modal-container{
        width: 100%;
        height: 150vh;
        position: fixed;
        background: rgba(0, 0, 0, 0.5);
        top: 0;
        left: 0;
        opacity: 0;
        pointer-events: none;
        transition: all 0.5s ease-in-out;
        z-index: 4;
      }
      .modal-show{
        opacity: 1
        !important;
        pointer-events: all
        !important
      }
      .modal{
        position: relative;
        background: #fff;
        max-width: 500px;
        left: 50%;
        transform: translateX(-50%);
        top: 0;
        transition: all 0.5s ease-in-out;
        border: 5px solid #0082e6;
        border-radius: 30px;
      }
      .modal-container.modal-show .modal{
        top: 100px;
      }
      #modal-header{
        display: flex;
        justify-content: space-between;
        padding: 10px 20px;
        align-items: center;
        border-bottom: 1px solid #ccc;
      }
      #modal-header h2{
        margin: 0 auto;
      }
      .btn-modal-close{
        background: none;
        border: none;
        font-size: 18px;
        cursor: pointer;
      }
      #modal-body{
        padding: 15px 20px;
        display: flex;
      }
      #modal-body img{
        width: 200px ;
        height: 200px ;
        border-radius: 20px;
      }
      #modal-body ul{
        margin-left: 20px;
      }
      #modal-body ul li{
        display: flex;
        margin-top: 5px;
      }
      #modal-body ul li span{
        font-size: 20px;
        font-weight: 700;
        color: #0082e6;  
      }
      #modal-body ul li p{
        margin: 0 10px;
        font-size: 20px;
      }
      #modal-body ul li button{
        position: relative;
        justify-content: center;
        align-items: center;
        margin: 10px auto;
        width: 100px;
        height: 35px;
        border: none;
        background: #0082e6;
        color: white;
        font-size: 13px;
        border-radius: 5px;
        text-transform: capitalize;
        cursor: pointer;
      }
      #modal-body ul li button a{
        background: none;
        transition: 0.2s ease-in-out;
      }
      #modal-body ul li button a:hover{
        color: white;
        font-size: 14px;
      }
    </style>
</head>
<body>
    <header>
      <nav>
        <div class="search-box">
          <input type="text" placeholder="Type to search..">
          
          <div class="search-icon">
            <i class="fas fa-search"></i>
          </div>
          <div class="cancel-icon">
            <i class="fas fa-times"></i>
          </div>
          <div class="search-data">
          </div>
      </div>
      <input type="checkbox" id="check">
      <label for="check" class="checkbtn">
        <i class="fas fa-bars"></i>
      </label>
        <ul>
          <li><a href="#home" target="_self">Home</a></li>
          <li><a href="shoppingcart.asp">My Cart</a></li>
          <li><a href="#product" target="_self">Products</a></li>
          <li><a href="#contact" target="_self">Contact</a></li>
          <li><%
                    If (NOT isnull(Session("email_kh"))) AND (TRIM(Session("email_kh"))<>"") Then
                %>
                    <a href="logout.asp" class="logout-icon"><style class="fa fa-sign-out"></style></a>
                    <span class="welcome-mess">Welcome <%=Session("email_kh")%>!</span>
                <%                        
                    Else
                %>                
                        <a href="login.asp" class="user-icon"><i class="fa-solid fa-user"></i></a>
                <%
                    End If
                %></li>
        </ul>
      </nav>
      <section></section>
    </header>

    <!-- slider -->
    <div class="title" id="home">
      <h1>News</h1>
    </div>
    <div class="slidermain">
    <div class="img-slider">
      <div class="slide active">
        <img src="slidepic/watch1.jpg" alt="">
        <div class="info">
          <h2>Rolex</h2>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
        </div>
      </div>
      <div class="slide">
        <img src="slidepic/watch2.jpg" alt="">
        <div class="info">
          <h2>Omega</h2>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
        </div>
      </div>
      <div class="slide">
        <img src="slidepic/watch3.jpg" alt="">
        <div class="info">
          <h2>Patek Philipe</h2>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
        </div>
      </div>
      <div class="slide">
        <img src="slidepic/watch4.jpg" alt="">
        <div class="info">
          <h2>Our Collection</h2>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
        </div>
      </div>
      <div class="slide">
        <img src="slidepic/watch5.jpg" alt="">
        <div class="info">
          <h2>Citizen</h2>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
        </div>
      </div>
      <div class="navigation">
        <div class="btn active"></div>
        <div class="btn"></div>
        <div class="btn"></div>
        <div class="btn"></div>
        <div class="btn"></div>
      </div>
    </div>
  </div>

    <!-- products -->
    <div class="title" id="product">
      <h1>Product</h1>
    </div>
    <div class="productmain">
      <%
      ' code to display the product cards for the current page
      counter = 0
      do while not rs.EOF and counter < pageSize
      %>
      <div class="productcard">
        <div class="card">
          <div class="productimg">
            <img src="<%= rs("hinh_anh_sp") %>" alt="<%= rs("ten_sp") %>">
            <ul class="productaction">
              <li>
                <button id="btn-modal-open-<%= counter %>"><i class="fa-solid fa-eye"></i></button>
                <span>View details</span>
              </li> 
              <li>
                <button><a href="addCart.asp?ma_sp=<%= rs("ma_sp")%>"><i class="fa-solid fa-cart-shopping"></i></a></button>
                <span>Add to cart</span>
              </li> 
            </ul>
          </div>
          <div class="productcontent">
            <span class="productbrand"><%= rs("loai") %></span>
            <h3><%= rs("ten_sp") %></h3>    
            <span class="productprice"><%= rs("gia_ban") %></span>
          </div>
        </div>                
      </div>
      <div id="modal-container-<%= counter %>" class="modal-container">
        <div class="modal" id="modal-main-<%= counter %>">
          <div id="modal-header">  
              <h2><%= rs("ten_sp") %></h2>
              <button id="btn-modal-close-<%= counter %>" class="btn-modal-close"><i class="fa-solid fa-xmark"></i></button>
          </div>
          <div id="modal-body">
            <img src="<%= rs("hinh_anh_sp") %>" alt="">
            <ul>
              <li>
                <span>Brand:</span>
                <p><%= rs("loai") %></p>
              </li>
              <li>
                <span>Price:</span>
                <p><%= rs("gia_ban") %></p>
              </li>
              <li>
                <span>Color:</span>
                <p><%= rs("mau_sp") %></p>
              </li>
              <li>
                <span>Quantity in stock:</span>
                <p><%= rs("soluong_ton") %></p>
              </li>
              <li>
                <button><a href="addCart.asp?ma_sp=<%= rs("ma_sp")%>">add to cart</a></button>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <%
        rs.MoveNext
        counter = counter + 1
      loop
      %>
    </div>
    
    
<!-- Pagination links -->
  <div class="page_main">
  <ul class="page_number">
    <% if (pages>1) then 
        for i= 1 to pages
    %>
    <li class="page_item <%=checkPage(Clng(i)=Clng(page),"active")%>"><a class="page_link" href="index.asp?page=<%=i%>"><%=i%></a></li>
    <%
        next
        end if
    %>
  </ul>
</div>
    <footer>
      <div class="footer_about" id="contact">
          <div class="contactform">
            <h2>Send Message</h2>
            <div class="inputbox">
              <input type="text" required="required">
              <span>Your Name:</span>
            </div>
            <div class="inputbox">
              <input type="text" required="required">
              <span>Email:</span>
            </div>
            <div class="inputbox">
              <textarea name="" id="" cols="30" rows="10" required="required"></textarea>
              <span>Type your message:</span>
            </div>
            <div class="inputbox">
              <input type="submit" value="Send">
            </div>
        </div>
      </div>
      <div class="footer_social">
        <h2>Reach us at:</h2>
         <a href="https://www.facebook.com/bach.luong.1044186" target="_blank"><i class="fa-brands fa-facebook"></i></a>
         <a href="#"><i class="fa-brands fa-twitter"></i></a>
         <a href=""><i class="fa-brands fa-instagram"></i></a>
      </div>
      <div class="footer_map">
        <h2>Our location</h2>
        <div class="map">
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.7334696246703!2d105.
          84074577375598!3d21.00331848865479!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ac
          773026b415%3A0x499b8b613889f78a!2zVHLGsOG7nW5nIMSQ4bqhaSBI4buNYyBYw6J5IEThu7FuZyBIw6AgTuG7mWkg
          LSBIVUNF!5e0!3m2!1svi!2s!4v1681804299762!5m2!1svi!2s" 
          style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
      </div>
    </footer>

    <!-- script for search box -->
    <script>
      const searchBox = document.querySelector(".search-box");
      const searchBtn = document.querySelector(".search-icon");
      const cancelBtn = document.querySelector(".cancel-icon");
      const searchInput = document.querySelector("input");
      const searchData = document.querySelector(".search-data");
      searchBtn.onclick =()=>{
        searchBox.classList.add("active");
        searchBtn.classList.add("active");
        searchInput.classList.add("active");
        cancelBtn.classList.add("active");
        searchInput.focus();
        if(searchInput.value != ""){
          var values = searchInput.value;
          searchData.classList.remove("active");
          searchData.innerHTML = "You just typed " + "<span style='font-weight: 500;'>" + values + "</span>";
        }else{
          searchData.textContent = "";
        }
      }
      cancelBtn.onclick =()=>{
        searchBox.classList.remove("active");
        searchBtn.classList.remove("active");
        searchInput.classList.remove("active");
        cancelBtn.classList.remove("active");
        searchData.classList.toggle("active");
        searchInput.value = "";
      }
    </script>

    <!-- script for slider -->
    <script type="text/javascript">
      var slides = document.querySelectorAll('.slide');
      var btns = document.querySelectorAll('.btn');
      let currentSlide = 1;
  
      // Javascript for image slider manual navigation
      var manualNav = function(manual){
        slides.forEach((slide) => {
          slide.classList.remove('active');
  
          btns.forEach((btn) => {
            btn.classList.remove('active');
          });
        });
  
        slides[manual].classList.add('active');
        btns[manual].classList.add('active');
      }
  
      btns.forEach((btn, i) => {
        btn.addEventListener("click", () => {
          manualNav(i);
          currentSlide = i;
        });
      });
  
      // Javascript for image slider autoplay navigation
      var repeat = function(activeClass){
        let active = document.getElementsByClassName('active');
        let i = 1;
  
        var repeater = () => {
          setTimeout(function(){
            [...active].forEach((activeSlide) => {
              activeSlide.classList.remove('active');
            });
  
          slides[i].classList.add('active');
          btns[i].classList.add('active');
          i++;
  
          if(slides.length == i){
            i = 0;
          }
          if(i >= slides.length){
            return;
          }
          repeater();
        }, 10000);
        }
        repeater();
      }
      repeat();
      </script>
    
    
    <!-- script for modal -->
    <script>
      <% rs.MoveFirst %>
      <% counter = 0 %>
      <% do while not rs.EOF and counter < pageSize %>
        const btnOpen<%= counter %> = document.getElementById('btn-modal-open-<%= counter %>');
        const btnClose<%= counter %> = document.getElementById('btn-modal-close-<%= counter %>');
        const modalContainer<%= counter %> = document.getElementById('modal-container-<%= counter %>');
        const modalMain<%= counter %> = document.getElementById('modal-main-<%= counter %>');
      
        btnOpen<%= counter %>.addEventListener('click', () => {
          modalContainer<%= counter %>.classList.add('modal-show');
        });
      
        btnClose<%= counter %>.addEventListener('click', () => {
          modalContainer<%= counter %>.classList.remove('modal-show');
        });
        modalContainer<%= counter %>.addEventListener('click', (e)=>{
        if(!modalMain<%= counter %>.contains(e.target)){
          btnClose<%= counter %>.click();
        }
        });
        <% rs.MoveNext %>
        <% counter = counter + 1 %>
      <% loop %>
    </script>


</body>
</html>