<!-- #include file="connect.asp" -->
<%

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

    page = Request.QueryString("page")
    limit = 3

    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    strSQL = "SELECT COUNT(ma_kh) AS count FROM KHACHHANG"
    connDB.Open()
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing

    pages = Ceil(totalRows/limit)
    
    Dim range
    If (pages<=5) Then
        range = pages
    Else
        range = 5
    End if
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
  <title>Client</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- JQVMap -->
  <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
  <!-- summernote -->
  <link rel="stylesheet" href="plugins/summernote/summernote-bs4.min.css">
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

  <!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>

  <!-- Navbar -->
  

    <!-- Right navbar links -->
    
    
      
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="../index.asp" class="brand-link">
      <img src="dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">Nhóm 10</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="./img/bach.png" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="admin.asp" class="d-block">Lường Ngọc Bách</a>
          <a href="adlogout.asp" ><style class="fa fa-sign-out"></style></a>
        </div>
      </div>

      

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item menu-open">
            <a href="#" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Manager
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="./product.asp" class="nav-link ">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Product</p>
                </a>
              </li>

              <li class="nav-item">
                <a href="./client.asp" class="nav-link active ">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Client</p>
                </a>
              </li>

              <li class="nav-item">
                <a href="./bill.asp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Bill</p>
                </a>
              </li>

            </ul>
              
          
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
 
  <!-- /.content-wrapper -->

  
          
      
  <div class="table-responsive">
    <table class="table table-striped">
        <thead class="thead-dark">
            <tr>
            <th>
                <nav class="main-header navbar navbar-expand navbar-white navbar-light">
                  <ul class="navbar-nav">
                    <li class="nav-item">
                      <a class="nav-link" data-widget="pushmenu" role="button">
                        <i class="fas fa-bars"></i>
                      </a>
                    </li>
                  </ul>
                </nav>
              </th>
                <th scope="col">Mã Khách Hàng</th>
                <th scope="col">Tên Khách Hàng</th>
                <th scope="col">Tuổi</th>
                <th scope="col">Giới Tính</th>
                <th scope="col">Số Điện Thoại</th>
                <th scope="col">Email</th>
                <th scope="col">Mật Khẩu</th>
                <th scope="col">Địa Chỉ</th>
        
                <th scope="col">Sửa</th>
                <th scope="col">Xóa</th>


            </tr>
        </thead>
        <tbody>
            <% 
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "SELECT * FROM KHACHHANG ORDER BY ma_kh OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                cmdPrep.parameters.Append cmdPrep.createParameter("offset", 3, 1, , offset)
                cmdPrep.parameters.Append cmdPrep.createParameter("limit", 3, 1, , limit)
                
                Set Result = cmdPrep.execute
                Do While Not Result.EOF
            %>
                    <tr>
                    <td></td>
                        <td><%=Result("ma_kh")%></td>
                        <td><%=Result("ten_kh")%></td>
                        <td><%=Result("tuoi_kh")%></td>
                        <td><%=Result("gioi_tinh")%></td>
                        <td><%=Result("sdt_kh")%></td>
                        <td><%=Result("email_kh")%></td>
                        <td><%=Result("mk_kh")%></td>
                        <td><%=Result("diachi_kh")%></td>
                        
                        
                        <td>
                            <a href="editclient.asp?ma_kh=<%=Result("ma_kh")%>" class="btn btn-secondary">Edit</a>
                        </td>
                        <td>
                            <a href="deleteclient.asp?ma_kh=<%=Result("ma_kh")%>" class="btn btn-danger">Delete</a>
                        </td>
                    </tr>
            <%
                    Result.MoveNext
                Loop
            %>
        </tbody>
    </table>
</div>

<nav aria-label="Page Navigation">
    <ul class="pagination justify-content-center my-5">
        <% 
            If pages > 1 Then
                If Clng(page) >= 2 Then
        %>
                    <li class="page-item"><a class="page-link" href="client.asp?page=<%=Clng(page)-1%>">Previous</a></li>
        <%
                End If
                For i = 1 To range
        %>
                    <li class="page-item <%=checkPage(Clng(i) = Clng(page), "active")%>"><a class="page-link" href="client.asp?page=<%=i%>"><%=i%></a></li>
        <%
                Next
                If Clng(page) < pages Then
        %>
                    <li class="page-item"><a class="page-link" href="client.asp?page=<%=Clng(page)+1%>">Next</a></li>
        <%
                End If
            End If
        %>
    </ul>
</nav>

  
  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="plugins/chart.js/Chart.min.js"></script>
<!-- Sparkline -->
<script src="plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="plugins/moment/moment.min.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="dist/js/pages/dashboard.js"></script>
</body>
</html>
