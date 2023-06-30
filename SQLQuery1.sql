create database DO_AN_WEB

Use DO_AN_WEB
GO
create table SANPHAM(
	ma_sp INT IDENTITY(1,1),
	ten_sp NVARCHAR(50) NOT NULL,
	loai NVARCHAR(50) NOT NULL,
	ten_nhacc NVARCHAR(50) NOT NULL,
	gia_nhap REAL NOT NULL,
	gia_ban REAL NOT NULL,
	mau_sp NCHAR(20) NOT NULL,
	soluong_ton INT NOT NULL DEFAULT 0,
	hinh_anh_sp TEXT NOT NULL,
	PRIMARY KEY (ma_sp)
);
create table QUANLY(
	ma_ql INT IDENTITY(1,1),
	ten_ql NVARCHAR(50) NOT NULL,
	email_ql VARCHAR(50) NOT NULL,
	password_ql VARCHAR(50) NOT NULL,
	sdt_ql CHAR(11) NOT NULL,
	PRIMARY KEY (ma_ql)
);
create table KHACHHANG(
	ma_kh INT IDENTITY(1,1),
	ten_kh NVARCHAR(50) NOT NULL,
	tuoi_kh INT NOT NULL,
	gioi_tinh NVARCHAR(5) NOT NULL,
	sdt_kh CHAR(11) NOT NULL,
	email_kh VARCHAR(50) NOT NULL,
	password_kh VARCHAR(50)NOT NULL,
	diachi_kh NVARCHAR(50) NOT NULL,
	PRIMARY KEY (ma_kh)
);
create table NHACUNGCAP(
	ma_nhacc INT IDENTITY(1,1),
	ten_nhacc NVARCHAR(50) NOT NULL,
	sdt_nhacc CHAR(11) NOT NULL,
	email_nhacc VARCHAR(50)NOT NULL,
	diachi_nhacc NVARCHAR(50) NOT NULL,
	PRIMARY KEY (ma_nhacc)
);
create table HOADONBAN(
	mahoadon_ban INT IDENTITY(1,1),
	tongtien_ban REAL NOT NULL DEFAULT 0,
	ma_kh INT NOT NULL,
	ngay_ban DATETIME NOT NULL,
	trang_thai bit NOT NULL DEFAULT 0,
	PRIMARY KEY (mahoadon_ban),
	FOREIGN KEY (ma_kh) REFERENCES KHACHHANG(ma_kh),
);
create table CTHOADONBAN(
	macthoadon_ban INT IDENTITY(1,1),
	mahoadon_ban INT NOT NULL,
	ma_sp INT NOT NULL,
	soluong_ban INT NOT NULL,
	PRIMARY KEY (macthoadon_ban),
	FOREIGN KEY (mahoadon_ban) REFERENCES HOADONBAN(mahoadon_ban),
	FOREIGN KEY (ma_sp) REFERENCES SANPHAM(ma_sp),
);
create table HOADONNHAP(
	mahoadon_nhap INT IDENTITY(1,1),
	tongtien_nhap REAL NOT NULL DEFAULT 0,
	ngay_nhap DATETIME NOT NULL,
	trang_thai bit NOT NULL DEFAULT 0,
	PRIMARY KEY (mahoadon_nhap),
);
create table CTHOADONNHAP(
	macthoadon_nhap INT IDENTITY(1,1),
	mahoadon_nhap INT NOT NULL,
	ma_nhacc INT NOT NULL,
	ma_sp INT NOT NULL,
	soluong_nhap INT NOT NULL,
	dongia_nhap REAL NOT NULL,
	PRIMARY KEY (macthoadon_nhap),
	FOREIGN KEY (mahoadon_nhap) REFERENCES HOADONNHAP(mahoadon_nhap),
	FOREIGN KEY (ma_nhacc) REFERENCES NHACUNGCAP(ma_nhacc),
	FOREIGN KEY (ma_sp) REFERENCES SANPHAM(ma_sp)
);
--mk_kh -> password_kh KHACHHANG
--password -> password_ql QUANLY
--check xem hoadonnhap co trang thai ko
--xoa ten_sp, loai trong CTHOADONNHAP vì trước khi nhập sản phẩm mới sẽ phải nhập vào bảng SANPHAM trước
--xoa ten_sp, loai trong CTHOADONBAN vì có thể đối chiếu từ bảng này sang bảng SANPHAM

------------------------------------------Nhập sản phẩm---------------------------------------------

﻿USE DO_AN_WEB
GO
INSERT INTO SANPHAM (ten_sp, loai, ten_nhacc, gia_nhap, gia_ban, mau_sp, soluong_ton, hinh_anh_sp)
VALUES 
	('Oyster Perpetual', 'Rolex', 'Rolex', 1000000, 2000000, 'silver', 1,'watch_pic\product1.png'),
	('Oyster Perpetual', 'Rolex', 'Rolex', 2000000, 4000000, 'white', 1,'watch_pic\product2.png'),
	('Satellite wave gps', 'Citizen', 'Citizen', 1500000, 3000000, 'blue', 1,'watch_pic\product3.png'),
	('Master collection', 'Longines', 'Longines', 1800000, 3600000, 'silver', 1,'watch_pic\product4.png'),
	


USE DO_AN_WEB
GO
INSERT INTO NHACUNGCAP(ten_nhacc,sdt_nhacc,email_nhacc,diachi_nhacc)
VALUES	
	('Rolex','0123456789','rolex@gmail.com','Sweden'),
	('Citizen','0987654321','citizen@gmail.com','Japan'),
	('Longines','0135792468','longines@gmail.com','Sweden'),
	('Patek Philippe','0246813579','patek@gmail.com','Sweden')

USE DO_AN_WEB;
GO
DELETE FROM HOADONBAN;

CREATE TRIGGER CalculateTotalPrice
ON CTHOADONBAN
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE HOADONBAN
    SET tongtien_ban = ISNULL((
            SELECT SUM(S.soluong_ban * SP.gia_ban)
            FROM CTHOADONBAN AS S
            INNER JOIN SANPHAM AS SP ON S.ma_sp = SP.ma_sp
            WHERE S.mahoadon_ban = HOADONBAN.mahoadon_ban
        ), 0)
    WHERE mahoadon_ban IN (SELECT mahoadon_ban FROM inserted) OR
        mahoadon_ban IN (SELECT mahoadon_ban FROM deleted);
END;


