/*
Họ và tên học viên: LÊ KIM TIẾN
Ngày sinh: 15/08/1996
*/


-- tao csdl
--create database CungCap
--go
USE master
GO
CREATE DATABASE CungCap
Go
use CungCap
go

-- tạo bản 1 trước (là bảng cho các bảng khác kế thừa)
-- NhaCungCap (MaNCC, TenNCC, TenGiaoDich, DiaChi, DienThoai, Email)
create table NhaCungCap (
	MaNCC varchar(3) PRIMARY KEY,
	TenNCC nvarchar(200),
	TenGiaoDich nvarchar(100) NOT NULL,
	DiaChi nvarchar(500) NOT NULL,
	DienThoai varchar(11),
	Email varchar(255)
)
go
-- LoaiHang (MaLoaiHang, TenLoaiHang)
create table LoaiHang
(
	MaLoaiHang varchar(2) PRIMARY KEY,
	TenLoaiHang nvarchar(500) NOT NULL,
)
go

-- MatHang (MaHang, TenHang, DonViTinh, SoLuongTonKho, GiaVon, MaLoaiHang, MaNCC)
create table MatHang(
	MaHang varchar(4) PRIMARY KEY, 
	TenHang nvarchar(500) NOT NULL, 
	DonViTinh nvarchar(100), 
	SoLuongTonKho int, 
	GiaVon float,
	MaLoaiHang varchar(2),
	MaNCC varchar(3),
	Foreign Key (MaLoaiHang) References LoaiHang(MaLoaiHang),
	Foreign Key (MaNCC) References NhaCungCap(MaNCC)
)
go

-- NhanVien(MaNV, Ho, Ten, NgaySinh, NgayVaoLamViec, DiaChi, DienThoai, LuongCoBan, PhuCap)
create table NhanVien(
	MaNV varchar(4) PRIMARY KEY,
	Ho Nvarchar(200),
	Ten nvarchar(200),
	NgaySinh datetime,
	NgayVaoLamViec datetime,
	DiaChi nvarchar(500),
	DienThoai varchar(11),
	LuongCoBan float,
	PhuCap float
)
go

-- KhachHang (MaKH, TenKH, TenGiaoDich, DiaChi, Email, DienThoai)
create table KhachHang (
	MaKH varchar(5) PRIMARY KEY, 
	TenKH nvarchar(200), 
	TenGiaoDich nvarchar(100), 
	DiaChi nvarchar(500), 
	Email varchar(100), 
	DienThoai varchar(11)
)


-- DonDatHang(SoDH, MaKH, MaNV, NgayDatHang, NgayChuyenHang, NgayNhanHang,DiaChiGiaoHang)
create table DonDatHang(
	SoDH int identity(1,1) PRIMARY KEY, 
	MaKH varchar(5), 
	MaNV varchar(4), 
	NgayDatHang datetime, 
	NgayChuyenHang datetime, 
	NgayNhanHang datetime,
	DiaChiGiaoHang nvarchar(3000)
	Foreign Key (MaKH) References KhachHang(MaKH),
	Foreign Key (MaNV) References NhanVien(MaNV)
)


-- ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia)
create table ChiTietDatHang (
	SoDH int, 
	MaHang varchar(4), 
	GiaBan float, 
	SoLuong int, 
	MucGiamGia float not null
	CONSTRAINT PK_DonDatHang_ChiTietDatHang PRIMARY KEY (SoDH, MaHang)
)


------------------------------------------------------------------------
-- insert bảng 1 trước tương tự như thư tự tạo bảng
-- table LoaiHang
insert into LoaiHang(MaLoaiHang,TenLoaiHang) values ('DC', N'Dụng cụ học tập')
insert into LoaiHang(MaLoaiHang,TenLoaiHang) values ('DT', N'Ðiện tử')
insert into LoaiHang(MaLoaiHang,TenLoaiHang) values ('MM', N'May mặc')
insert into LoaiHang(MaLoaiHang,TenLoaiHang) values ('NT', N'Nội thất')
insert into LoaiHang(MaLoaiHang,TenLoaiHang) values ('TP', N'Thực phẩm')

-- table NhaCungCap
insert into NhaCungCap (MaNCC, TenNCC, TenGiaoDich, DiaChi, DienThoai, Email) values ('DAF', N'Nội thất Đài Loan Dafuco', 'DAFUCO', 'Quy Nhon', '56-888111', 'dafuco@vietnam.com')
insert into NhaCungCap (MaNCC, TenNCC, TenGiaoDich, DiaChi, DienThoai, Email) values ('DQV', N'Công ty máy tính Quang Vu', 'QUANGVU', 'Quy Nhon', '56-888777', 'quangvu@vietnam.com')
insert into NhaCungCap (MaNCC, TenNCC, TenGiaoDich, DiaChi, DienThoai, Email) values ('GOL', N'Công ty sản xuất dụng cụ học sinh Golden', 'GOLDEN', 'Quy Nhon', '56-891135', 'golden@vietnam.com')
insert into NhaCungCap (MaNCC, TenNCC, TenGiaoDich, DiaChi, DienThoai, Email) values ('MVT', N'Công ty may mặc Việt Tiến', 'VIETTIEN', N'Sài gòn', '08-808803', 'viettien@vietnam.com')
insert into NhaCungCap (MaNCC, TenNCC, TenGiaoDich, DiaChi, DienThoai, Email) values ('SCM', N'Siêu thị Coop-mart', 'COOPMART', 'Quy Nhon', '56-888666', 'coopmart@vietnam.com')
insert into NhaCungCap (MaNCC, TenNCC, TenGiaoDich, DiaChi, DienThoai, Email) values ('VNM', N'Công ty sữa Việt Nam', 'VINAMILK',N'Hà Nội', '04-891135', 'vinamilk@vietnam.com')

-- table NhanVien
insert into NhanVien(MaNV, Ho, Ten, NgaySinh, NgayVaoLamViec, DiaChi, DienThoai, LuongCoBan, PhuCap) values ('A001', N'Ðậu Tố', 'Anh', '1986-03-07', '2009-03-01', 'Quy Nhon', '56-647995', 10000000, 1000000)
insert into NhanVien(MaNV, Ho, Ten, NgaySinh, NgayVaoLamViec, DiaChi, DienThoai, LuongCoBan, PhuCap) values ('D001', N'Nguyễn Minh', N'Ðang', '1987-12-29', '2009-03-01', 'Quy Nhon', '0905-779919', 14000000, 0)
insert into NhanVien(MaNV, Ho, Ten, NgaySinh, NgayVaoLamViec, DiaChi, DienThoai, LuongCoBan, PhuCap) values ('H001', N'Lý Thị Bích', 'Hoa', '1986-05-20', '2009-03-01', N'An Khương', NULL, 9000000, 1000000)
insert into NhanVien(MaNV, Ho, Ten, NgaySinh, NgayVaoLamViec, DiaChi, DienThoai, LuongCoBan, PhuCap) values ('H002', N'Ông Hồng', N'Hải', '1987-08-11', '2009-03-01', N'Ðà Nẵng', '0905-611725', 12000000, 0)
insert into NhanVien(MaNV, Ho, Ten, NgaySinh, NgayVaoLamViec, DiaChi, DienThoai, LuongCoBan, PhuCap) values ('H003', N'Trần Nguyễn Đức', N'Hồng', '1986-04-09', '2009-03-01', 'Quy Nhon', NULL, 11000000, 0)
insert into NhanVien(MaNV, Ho, Ten, NgaySinh, NgayVaoLamViec, DiaChi, DienThoai, LuongCoBan, PhuCap) values ('M001', N'Hồ  Thị Phuong', 'Mai', '1987-09-14', '2009-03-01', 'Ty Son', NULL, 9000000, 500000)
insert into NhanVien(MaNV, Ho, Ten, NgaySinh, NgayVaoLamViec, DiaChi, DienThoai, LuongCoBan, PhuCap) values ('P001', N'Nguyễn Hồi', 'Phong', '1986-06-14', '2009-03-01', 'Quy Nhon', '56-891135', 13000000, 0)
insert into NhanVien(MaNV, Ho, Ten, NgaySinh, NgayVaoLamViec, DiaChi, DienThoai, LuongCoBan, PhuCap) values ('Q001', N'Truong Thị Thu', 'Quang', '1987-06-17', '2009-03-01', 'Ayunpa', '0979-792176', 10000000, 500000)
insert into NhanVien(MaNV, Ho, Ten, NgaySinh, NgayVaoLamViec, DiaChi, DienThoai, LuongCoBan, PhuCap) values ('T001', N'Nguyễn Đức', N'Thông', '1984-09-13', '2009-03-01', N'Phú Mỹ', '0955-593893', 1200000, 0)

--table KhachHang
insert into KhachHang (MaKH, TenKH, TenGiaoDich, DiaChi, Email, DienThoai) values ('T0001', N'Công ty sữa Việt Nam', 'VINAMILK', N'Hà Nội', 'vinamilk@.com', '04-891135')
insert into KhachHang (MaKH, TenKH, TenGiaoDich, DiaChi, Email, DienThoai) values ('T0002', N'Công ty may mặc Việt Tiến', 'VIETTIEN', N'Sài gòn', 'viettien@.com', '08-808803')
insert into KhachHang (MaKH, TenKH, TenGiaoDich, DiaChi, Email, DienThoai) values ('V0001', N'Tổng công ty thực phẩm dinh dưỡng', 'NUTRIFOOD', N'Sài gòn', 'nutrifood@.com', '08-809890')
insert into KhachHang (MaKH, TenKH, TenGiaoDich, DiaChi, Email, DienThoai) values ('V0002', N'Công ty điện máy Hà Nội', 'MACHANOI', N'Hà Nội', 'machanoi@.com', '04-898399')
insert into KhachHang (MaKH, TenKH, TenGiaoDich, DiaChi, Email, DienThoai) values ('V0003', N'Hãng hàng không Việt Nam', 'VIETNAMAIRLINES', N'Sài gòn', 'mairlines@.com', '08-888888')
insert into KhachHang (MaKH, TenKH, TenGiaoDich, DiaChi, Email, DienThoai) values ('V0004', N'Công ty dụng cụ học sinh MIC', 'MIC', N'Hà Nội', 'mic@vietnam.com', '04-804408')

--table MatHang
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('DC01', N'Vở học sinh cao cấp', 'GOL', 'DC', 20000, N'Ram', 48000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('DC02', N'Bút bi học sinh', 'GOL', 'DC', 2000, N'Cây', 2000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('DC03', N'Hộp motor', 'GOL', 'DC', 2000, N'Hộp', 7500)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('DC04', N'Bút mực cao cấp', 'GOL', 'DC', 2000, N'Cây', 20000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('DC05', N'Bút chì 2B', 'GOL', 'DC', 2000, N'Cây', 3000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('DC06', N'Bút chì 4B', 'GOL', 'DC', 2000, N'Cây', 6000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('DT01', N'LCD Nec', 'DQV', 'DT', 10, N'Cái', 3100000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('DT02', N'Ổ cứng 80GB', 'DQV', 'DT', 20, N'Cái', 800000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('DT03', N'Bàn phím Mitsumi', 'DQV', 'DT', 20, N'Cái', 150000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('DT04', N'Tivi LCD', 'DQV', 'DT', 10, 'Cái', 20000000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('DT05', N'Máy tính xách tay NEC', 'DQV', 'DT', 60, N'Cái', 18000000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('MM01', N'Ðồng phục Công sở', 'MVT', 'MM', 140, N'BỘ', 340000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('MM02', N'Veston nam', 'MVT', 'MM', 30, N'BỘ', 500000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('MM03', N'Áo so mi nam', 'MVT', 'MM', 20, N'Cái', 75000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('NT01', N'Bàn ghế ăn', 'DAF', 'NT', 20, N'BỘ', 1000000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('NT02', N'Bàn ghế Salon', 'DAF', 'NT', 20, N'BỘ', 150000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('TP01', N'Sữa Hộp XYZ', 'VNM', 'TP', 10, N'Hộp', 4000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('TP02', N'Sữa XO', 'VNM', 'TP', 12, N'Hộp', 180000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('TP03', N'Sữa tuoi Vinamilk không đường', 'VNM', 'TP', 5000, N'Hộp', 3500)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('TP04', N'Táo', 'SCM', 'TP', 12, N'Ký', 12000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('TP05', N'Cà chua', 'SCM', 'TP', 15, N'Ký', 5000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('TP06', N'Bánh AFC', 'SCM', 'TP', 100, N'Hộp', 3000)
insert into  MatHang (MaHang, TenHang, MaNCC , MaLoaiHang, SoLuongTonKho, DonViTinh, GiaVon) values ('TP07', N'Mì tơm A-One', 'SCM', 'TP', 150, N'Thùng', 40000)

--table DonDatHang
insert into  DonDatHang(MaKH, MaNV, NgayDatHang, NgayChuyenHang, NgayNhanHang,DiaChiGiaoHang)  values( 'T0001', 'A001', '2011-09-12', '2011-09-17', '2011-09-18', N'Hà Nội')
insert into  DonDatHang(MaKH, MaNV, NgayDatHang, NgayChuyenHang, NgayNhanHang, DiaChiGiaoHang) values( 'T0001', 'A001', '2011-08-20', '2011-08-22', '2011-08-24', N'Hà Nội')
insert into  DonDatHang(MaKH, MaNV, NgayDatHang, NgayChuyenHang, NgayNhanHang, DiaChiGiaoHang) values( 'T0002', 'H002', '2011-07-15', '2011-07-19', '2011-07-20', N'Sài gòn')
insert into  DonDatHang(MaKH, MaNV, NgayDatHang, NgayChuyenHang, NgayNhanHang, DiaChiGiaoHang) values( 'V0001', 'H003', '2011-05-18', '2011-05-24', '2011-05-26', N'Sài gòn')
insert into  DonDatHang(MaKH, MaNV, NgayDatHang, NgayChuyenHang, NgayNhanHang, DiaChiGiaoHang) values( 'V0002', 'P001', '2011-02-14', '2011-02-15', '2011-02-17', N'Hà Nội')
insert into  DonDatHang(MaKH, MaNV, NgayDatHang, NgayChuyenHang, NgayNhanHang, DiaChiGiaoHang) values( 'V0003', 'D001', '2011-09-12', '2011-09-12', '2011-09-15', N'Hà Nội')
insert into  DonDatHang(MaKH, MaNV, NgayDatHang, NgayChuyenHang, NgayNhanHang, DiaChiGiaoHang) values( 'V0004', 'H003', '2011-02-13', '2011-02-13', '2011-02-13', N'Hà Nội')
insert into  DonDatHang(MaKH, MaNV, NgayDatHang, NgayChuyenHang, NgayNhanHang, DiaChiGiaoHang) values( 'T0002', 'Q001', '2011-09-11', '2011-09-12', '2011-09-13', N'Sài gòn')
insert into  DonDatHang(MaKH, MaNV, NgayDatHang, NgayChuyenHang, NgayNhanHang, DiaChiGiaoHang) values( 'V0001', 'A001', '2011-04-17', '2011-04-20', '2011-04-22', N'Sài gòn')

--table ChiTietDatHang
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (1, 'TP01', 4000, 5, 0)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (1, 'TP02', 180000, 5, 5000)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (1, 'TP03', 12000, 5, 0)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (1, 'TP06', 3000, 50, 0)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (1, 'TP07', 40000, 100, 0)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (2, 'MM01', 340000, 30, 10000)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (2, 'MM02', 500000, 20, 20000)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (3, 'MM01', 340000, 30, 10000)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (3, 'MM02', 500000, 30, 20000)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (4, 'MM01', 340000, 80, 10000)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (5, 'TP03', 3000, 1000, 0)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (6, 'DT01', 3100000, 2, 100000)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (6, 'DT05', 18000000, 20, 1000000)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (7, 'TP03', 3000, 200, 0)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (8, 'DT04', 20000000, 2, 1000000)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (9, 'DC01', 48000, 1000, 0)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (9, 'DC02', 2000, 1000, 0)
insert into  ChiTietDatHang (SoDH, MaHang, GiaBan, SoLuong, MucGiamGia) values (9, 'DC03', 7500, 1000, 0)


--------------------------------
-- 2.1 Họ tên, địa chỉ và thâm niên (số năm làm việc) của các nhân viên trong công ty.
select Ho + ' ' + Ten as HoTen, YEAR(getdate()) - YEAR(NgayVaoLamViec)  as ThamNien, NgayVaoLamViec 
from NhanVien

-- 2.2 Những đơn hàng nào yêu cầu giao hàng ngay tại công ty đặt hàng và những đơn đó là của công ty nào?
select a.SoDH, a.MaKH, a.DiaChiGiaoHang, b.TenNCC as TenCongTy, b.DiaChi as DiaChiCongTy
from DonDatHang a
inner join NhaCungCap b on a.DiaChiGiaoHang = b.DiaChi
order by a.SoDH

-- 2.3 Xoá khỏi bảng MATHANG những mặt hàng có số lượng bằng 0 hoặc mặt hàng đó chưa từng được đặt mua trong bất kỳ đơn đặt hàng nào.
-- đề cho sai có soluongtonkho chứ không có cột soluong
delete MatHang where SoLuongTonKho = 0 
and MaHang not in (select MaHang from ChiTietDatHang) -- mã hàng không tồn tài trong chi tiết đơn hàng => ko có ai đặt

-- 2.4 Mỗi nhân viên của công ty đã lập bao nhiêu đơn đặt hàng (nếu chưa hề lập hóa đơn nào thì cho kết quả là 0)
select a.MaNV,a.Ho,a.Ten, COUNT(b.SoDH) as SoDonDatHang
from NhanVien a
left join DonDatHang b on a.MaNV = b.MaNV
group by a.MaNV,a.Ho,a.Ten
order by COUNT(b.SoDH) desc

-- 2.5 Tổng số tiền lời mà công ty thu được từ mỗi mặt hàng trong năm 2011
-- vì giá vốn và giá bán như nhau nên bị lỗ
select Sum(((b.GiaBan*b.SoLuong) - (GiaVon*SoLuong)) - MucGiamGia) as LoiNhuan
from MatHang a
join ChiTietDatHang b on a.MaHang = b.MaHang
join DonDatHang c on b.SoDH = c.SoDH
where YEAR(c.NgayNhanHang) = 2011

-- 2.6 Giảm 25% lương của những nhân viên trong năm 2011 không lập được bất kỳ đơn đặt hàng nào
-- nếu có cộng thêm phụ cấp thì cộng tiền phụ cấp trước khi trừ
select MaNV,Ho,Ten, LuongCoBan --, (LuongCoBan + PhuCap)  - (LuongCoBan*0.25) as LuongSauKhiDaGiam
, LuongCoBan - (LuongCoBan*0.25) as LuongSauKhiDaGiam 
from NhanVien
where MaNV not in (select MaNV from DonDatHang)

-- 2.7 Tạo View chứa tổng doanh thu của từng mặt hàng. Biết Tổng Doanh Thu = 
--((SoLuong * DonGia) - MucGiamGia)). Sử dụng view vừa tạo để tìm tên những mặt hàng có 
--tổng doanh thu lớn nhất
-- Đề cho không có đơn giá chỉ có giá bán và giá vốn => 

create view v_DoanhThuTheoTungSanPham
as
	select a.MaHang,a.TenHang,Sum((GiaBan*SoLuong) - MucGiamGia) as LoiNhuan
	from MatHang a
	join ChiTietDatHang b on a.MaHang = b.MaHang
	group by  a.MaHang,a.TenHang

-- test view 
select*from v_DoanhThuTheoTungSanPham

-- 2.8 Tạo stored procedure nhận 3 tham số là mã mặt hàng (code), giá bán X, giá bán Y. 
--Cho biết những số đơn hàng (SoDH) có giá bán mặt hàng thuộc mã code nằm trong khoảng 
--từ X đến Y
create proc sp_TraCuuDonHang
@Code varchar(5),
@GiaBanX float,
@GiaBanY float
as
begin
	select distinct a.SoDH
	from DonDatHang a
	join ChiTietDatHang b on a.SoDH = b.SoDH
	where b.MaHang = @Code and b.GiaBan BETWEEN @GiaBanX and @GiaBanY 
end

--exec sp_TraCuuDonHang 'MM01', 300000,340000

-- 2.9 Cho biết những đơn đặt hàng nào gồm tất cả các mặt hàng có trong đơn đặt hàng số 5.
select a.*
from DonDatHang a
join ChiTietDatHang b on a.SoDH = b.SoDH
and b.SoDH <> 5
and exists(select c.MaHang from ChiTietDatHang c where c.SoDH = 5 and b.MaHang = c.MaHang)

-- 2.10 Sử dụng biểu thức bảng chung (Common Table Expression – CTE) cho biết tên những mặt hàng có số lượng tồn kho không phải là nhiều nhất hoặc ít nhất

WITH Sales_CTE (MaxSL,MinSL)  
AS  
(  
    SELECT max(SoLuongTonKho) as MaxSL, MIN(SoLuongTonKho) as MinSL
    FROM MatHang
)  
SELECT MaHang,SoLuongTonKho
FROM MatHang a
where SoLuongTonKho not in (select MaxSL from Sales_CTE)
and SoLuongTonKho not in (select MinSL from Sales_CTE)
order by a.SoLuongTonKho

-- 2.11 Cho biết khách hàng là Công ty sữa Việt Nam đã đặt mua những mặt hàng gì của 
--nhà cung cấp Công ty may mặc Việt Tiến trong tháng 8 năm 2011.
--Yêu cầu thực hiện câu truy vấn này bằng 2 cách: chưa tối ưu và đã tối ưu.
-- C1 chưa tối ưu
select d.*
from KhachHang a
join DonDatHang b on a.MaKH = b.MaKH
join ChiTietDatHang c on b.SoDH = c.SoDH
join MatHang d on c.MaHang = d.MaHang and d.MaNCC = 'MVT' 
where b.MaKH = 'T0001' and MONTH(b.NgayNhanHang) = 8

-- c2
select c.*
from DonDatHang a
join ChiTietDatHang b on a.SoDH = b.SoDH and a.MaKH = 'T0001' and MONTH(a.NgayNhanHang) = 8
join MatHang c on b.MaHang = c.MaHang and c.MaNCC = 'MVT'


-- 2.12 Tạo mới 1 cursor và sử dụng cursor này để in bảng thống kê sau:

DECLARE vendor_cursor CURSOR FOR SELECT * FROM MatHang
OPEN vendor_cursor  
-- NEXT FROM vendor_cursor
WHILE @@FETCH_STATUS = 0  
BEGIN 
	PRINT 'ZXZX '

	FETCH NEXT FROM vendor_cursor   
END
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;     









