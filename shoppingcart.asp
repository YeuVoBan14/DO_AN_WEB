<!--#include file="connect.asp"-->
<%
'lay ve danh sach product theo id trong my cart
Dim idList, mycarts, totalProduct, subtotal, statusViews, statusButtons, rs
If (NOT IsEmpty(Session("mycarts"))) Then
  statusViews = "d-none"
  statusButtons = "d-block"
' true
	Set mycarts = Session("mycarts")
	idList = ""
	totalProduct=mycarts.Count    
	For Each List In mycarts.Keys
		If (idList="") Then
' true
			idList = List
		Else
			idList = idList & "," & List
		End if                               
	Next
	Dim sqlString
	sqlString = "Select * from SANPHAM where ma_sp IN (" & idList &")"
	connDB.Open()
	set rs = connDB.execute(sqlString)
	calSubtotal(rs)

  Else
    'Session empty
    statusViews = "d-block"
    statusButtons = "d-none"
    totalProduct=0
  End If
  Sub calSubtotal(rs)
' Do Something...
		subtotal = 0
		do while not rs.EOF
			subtotal = subtotal + Clng(mycarts.Item(CStr(rs("ma_sp")))) * CDbl(CStr(rs("gia_ban")))
			rs.MoveNext
		loop
		rs.MoveFirst
	End Sub
  Sub defineItems(v)
    If (v>1) Then
      Response.Write(" Items")
    Else
      Response.Write(" Item")
    End If
  End Sub
%>

<%
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        macthoadon_ban = Request.QueryString("macthoadon_ban")
        If (isnull(macthoadon_ban) OR trim(macthoadon_ban) = "") then 
            macthoadon_ban=0 
        End if
        If (cint(macthoadon_ban)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM CTHOADONBAN WHERE macthoadon_ban=?"
            
            cmdPrep.Parameters(0)=macthoadon_ban
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                ten_sp = Result("ten_sp")
                loai = Result("loai")
                
                
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
                    Response.redirect("product.asp")  
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
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carts</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=figtree:400,600&display=swap" rel="stylesheet" />
    <style>
      *{
        font-family:Figtree, sans-serif;
      }
      body{
        background: #ACC8E5;
      }
      #form1{
        appearance: textfield;
      }
      #form1::-webkit-inner-spin-button,
      #form1::-webkit-outer-spin-button {
        -webkit-appearance: none;
        appearance: none;
        margin: 0;
      }
    </style>
</head>
<body>

<section class="h-100 h-custom" style="background-color: #ACC8E5;">
  <div class="container py-2 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12">
        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
          <div class="card-body p-0">
            <div class="row g-0">
              <div class="col-lg-8">
                <div class="p-5">
                  <div class="d-flex justify-content-between align-items-center mb-5">
                    <h1 class="fw-bold mb-0 text-black">Shopping Cart</h1>
                    <h6 class="mb-0 text-muted"><%= totalProduct %> <%call defineItems(totalProduct) %></h6>
                  </div>
                  <form action="removecart.asp" method=post>
                  <hr class="my-4">
                  <h5 class="mt-3 text-center text-body-secondary <%= statusViews %>">You have no products added in your shopping cart.</h5>
                <%
                If (totalProduct<>0) Then
                do while not rs.EOF
                %>
                  <div class="row mb-4 d-flex justify-content-between align-items-center">
                    <div class="col-md-2 col-lg-2 col-xl-2">
                      <img
                        src="<%= rs("hinh_anh_sp") %>"
                        class="img-fluid rounded-3" alt="Cotton T-shirt">
                    </div>
                    <div class="col-md-3 col-lg-3 col-xl-3">
                      <h6 class="text-muted"><%= rs("ten_sp")%></h6>
                      <h6 class="text-black mb-0" name="mau"><%= rs("mau_sp")%></h6>
                    </div>
                    <div class="col-md-3 col-lg-3 col-xl-2 d-flex">
                      <button class="btn btn-link px-2"
                        onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
                        <i class="fas fa-minus"></i>
                      </button>

                      <input id="form1" min="0" max=<%= rs("soluong_ton") %> name="quantity" value="<%
                                    Dim id
                                    id  = CStr(rs("ma_sp"))
                                    Response.Write(mycarts.Item(id))                                     
                                    %>" type="number"
                        class="form-control form-control-sm"  />

                      <button class="btn btn-link px-2"
                        onclick="this.parentNode.querySelector('input[type=number]').stepUp()">
                        <i class="fas fa-plus"></i>
                      </button>
                    </div>
                    <div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
                      <h6 class="mb-0">$ <%= rs("gia_ban")%></h6>
                    </div>
                    <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                    
                      <a href="removecart.asp?id=<%= rs("ma_sp")%>" class="text-muted"><i class="fas fa-times"></i></a>
                    </div>
                  </div>
                  

                  <hr class="my-4">
                    <%
                    rs.MoveNext
                    loop
                    'phuc vu cho viec update subtotal
                    rs.MoveFirst
                    End If
                    %> 
                
                  <div class="row pt-2" style="width: 40%;">
                    <h6 class="mb-0 col-lg-10 pt-3"><a href="index.asp" class="text-body"><i
                          class="fas fa-long-arrow-alt-left me-2"></i>Back to shop</a></h6>
                          <!-- <input type="submit" name="update" value="Update" class="btn btn-warning btn-block btn-lg text-white col-lg-2 <%= statusButtons %>"
                    data-mdb-ripple-color="dark"/> -->
                  </div>
                  <div class="row" style="width: 50%; float: right; margin-bottom: 10px;">
                    <button type="submit" class="btn btn-success btn-lg"
                      data-mdb-ripple-color="dark">Purchase</button>
                  </div>
                </form>
                </div>
              </div>
              <div class="col-lg-4 bg-secondary-subtle <%= statusButtons %>">
                <div class="p-5">
                  <h3 class="fw-bold mb-5 mt-2 pt-1">Summary</h3>
                  <hr class="my-4">

                  <div class="d-flex justify-content-between mb-4">
                    <h5 class="text-uppercase"><%= totalProduct %> <%call defineItems(totalProduct) %></h5>
                    <h5>$ <%= subtotal%></h5>
                  </div>

                  <hr class="my-4">

                  <div class="d-flex justify-content-between mb-5">
                    <h5 class="text-uppercase">Total price</h5>
                    <h5>$ <%= subtotal %></h5>
                  </div>
                  
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

</body>

</html>
