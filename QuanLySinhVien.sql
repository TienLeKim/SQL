USE Master
GO
IF EXISTS (SELECT * FROM sysdatabases WHERE name='QLSV')
	DROP DATABASE QLSV
GO
-- Data Definition Language - DDL
CREATE DATABASE QLSV
GO
USE QLSV
GO
CREATE TABLE Khoa (			MaKhoa nvarchar(4) PRIMARY KEY,
							Tenkhoa nvarchar(50),
							SLCBGD int DEFAULT 0 CHECK (SLCBGD BETWEEN 0 AND 4)
					   ) 
CREATE TABLE MonHoc (		MaMH nvarchar(4) PRIMARY KEY,
							TenMH nvarchar(50) NOT NULL,
							SoTCToiThieu int
						)
CREATE TABLE SinhVien (		MSSV nvarchar(6) PRIMARY KEY CHECK (MSSV LIKE '[A-Z][0-9][0-9][0-9][0-9][FM]'), 
						    Ten nvarchar(50) NOT NULL,
							PhaiNu int,
							DiaChi nvarchar(50)  NOT NULL,	
							SoDienThoai nvarchar(10) 
								CHECK (SoDienThoai LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' 
									OR SoDienThoai LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
							MaKhoa Nvarchar (4),
							SoCMND nvarchar(10)  UNIQUE,
							NgaySinh date,
							NgayNhapHoc date,
							NgayVaoDoan date,
							NgayVaoDang date,
							NgayRaTruong date,
							DTBTichLuy float DEFAULT 0,
							SoTCTichLuy int DEFAULT 0,
							FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa)
						)
CREATE TABLE GiaoVien (		MaGV nvarchar(4) PRIMARY KEY CHECK (MaGV LIKE '[A-Z][0-9][0-9][FM]'), 
						    TenGV nvarchar(50) NOT NULL,
							MaKhoa nvarchar(4),
							FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa)
						)
CREATE TABLE GiangDay (		MaKhoaHoc nvarchar (4) PRIMARY KEY CHECK (MaKhoaHoc LIKE '[K][0-9][0-9][0-9]'), 
						    MaGV nvarchar (4),
							MaMH nvarchar (4),
							HocKy int CHECK (HocKy IN(1,2,3)),	
							NienKhoa nvarchar (50),
							NgayBatDauLyThuyet date,
							NgayBatDauThucHanh date,
				 			NgayKetThuc date,
							TongSoTC int CHECK (TongSoTC BETWEEN 2 AND 6),
							SoTCLT int CHECK (SoTCLT >0),
							SoTCTH int CHECK (SoTCTH >0),
							SoTietLT int CHECK (SoTietLT >0),
							SoTietTH int CHECK (SoTietTH >0),
							FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH),
							FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV)
						)
CREATE TABLE KetQua (		MSSV nvarchar(6), 
							MaKhoaHoc nvarchar(4),
							DiemKiemTraGiuaKy float CHECK (DiemKiemTraGiuaKy BETWEEN 0 AND 10),
							DiemThiLan1 decimal(5,2) CHECK (DiemThiLan1 BETWEEN 0 AND 10) , 
							DiemThiLan2 decimal(5,2) CHECK (DiemThiLan2 BETWEEN 0 AND 10),
							DiemKhoaHoc decimal(5,2) CHECK (DiemKhoaHoc BETWEEN 0 AND 10),
							PRIMARY KEY (MSSV, MaKhoaHoc),
							FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV),
							FOREIGN KEY (MaKhoaHoc) REFERENCES GiangDay(MaKhoaHoc)
				    )	
ALTER TABLE SinhVien
--ADD CHECK (YEAR(NgayNhapHoc)-YEAR(NgaySinh)>=18)
ADD CHECK (DATEDIFF (year,NgaySinh,NgayNhapHoc)>=18)

ALTER TABLE SinhVien
ADD CHECK (YEAR(NgayVaoDoan)-YEAR(NgaySinh)>=16)

-- Data Manipulation Language - DML
SET DATEFORMAT dmy
--Table Khoa
INSERT INTO Khoa VALUES('CNTT', N'Công Nghệ Thông Tin', 0)
INSERT INTO Khoa  VALUES('TOAN', N'Toán', 0)
INSERT INTO Khoa  VALUES('SINH', N'Sinh Học', 0) 
--Table MonHoc
INSERT INTO MonHoc VALUES ('CSDL', N'Cơ Sở Dữ Liệu', 2)
INSERT INTO MonHoc VALUES ('CTDL', N'Cấu Trúc Dữ Liệu', 5)
INSERT INTO MonHoc VALUES ('KTLT', N'Kỹ Thuật Lập Trình', 4)
INSERT INTO MonHoc VALUES ('CWIN', N'Lập Trình C Trên WinDows', 3)
INSERT INTO MonHoc VALUES ('TRR', N'Toán Rời Rạc', 6)

--Table SinhVien
INSERT INTO SINHVIEN VALUES ('C0001F',N'BÙI THÚY AN', 1, N'223 Trần Hưng Đạo, HCM','38132202','CNTT', '135792468','14/08/1992', '01/10/2010',NULL, NULL,'15/11/2012', 0, 0)
INSERT INTO SINHVIEN VALUES ('C0002M',N'NGUYỄN THANH TÙNG', 0, N'140 Cống Quỳnh, HCM','38125678','CNTT', '987654321','23/11/1992', '01/10/2010', NULL, NULL, NULL, 0, 0)
INSERT INTO SINHVIEN VALUES ('T0003M',N'NGUYỄN THÀNH LONG', 0, N'112/4 Cống Quỳnh, HCM','0918345623','TOAN', '123456789','17/08/1991','01/10/2010','19/5/2007','01/5/2012', NULL, 0, 0)
INSERT INTO SINHVIEN VALUES ('C0004F',N'HOÀNG THỊ HOA', 1, N'90 Nguyễn Văn Cừ, HCM','38320123','CNTT', '246813579', '02/09/1991', '17/10/2010', NULL, NULL, NULL, 0, 0)
INSERT INTO SINHVIEN VALUES ('T0005M',N'TRẦN HỒNG SƠN', 0, N'54 Cao Thắng, HCM','38345987','TOAN', '864297531','24/04/1993', '15/10/2011','02/09/2010', NULL, NULL, 0, 0)

--Table GiaoVien
INSERT INTO GiaoVien VALUES ('C01F', N'Pham Thị Thảo', 'CNTT'),
							('T02M', N'Lâm Hoàng Vũ', 'TOAN'),
							('C03M', N'Trần Văn Tiến', 'CNTT'),
							('C04M', N'Hoàng Vuong', 'CNTT')
--Table GiangDay
INSERT INTO GiangDay VALUES ('K001', 'C01F', 'CSDL', 1, '2011-2012', '15/09/2011', '01/10/2011', '02/01/2012', 4, 3, 1, 45, 30),
							('K002', 'C04M', 'KTLT', 1, '2011-2012', '17/02/2012', '01/3/2012', '18/05/2012', 4, 3, 1, 45, 30),
							('K003', 'C03M', 'CTDL', 1, '2012-2013', '11/09/2012', '14/3/2012', '03/01/2013', 4, 3, 1, 45, 30),
							('K004', 'C04M', 'CWIN', 1, '2012-2013', '13/09/2012', '13/10/2012', '14/01/2013', 4, 3, 1, 45, 30),
							('K005', 'T02M', 'TRR', 1, '2012-2013', '14/09/2012', '02/10/2012', '18/01/2013', 4, 3, 1, 45, 30)

--Table KetQua
INSERT INTO KetQua VALUES	('C0001F', 'K001', 8.5, 5,0 ,6.4),
							('C0001F', 'K003', 8.5, 9,0 ,8.6),
							('T0003M', 'K004', 9, 7,0 ,7.8),
							('C0001F', 'K002', 9, 7,0 ,7.8),
							('T0003M', 'K003', 6, 2,2.5 ,3.9),
							('T0005M', 'K003', 9, 7,0 ,7.8),
							('C0002M', 'K001', 7, 2,5 ,5.8),
							('T0003M', 'K002', 6.5,2,3 ,4.4),
							('T0005M', 'K005', 7, 10,0 ,8.8),
							('C0001F', 'K004', 8, 9,0 ,8.6)
-- Structured Query Language -SQL
SELECT ALL| DISTINCT | TOP n PERCENT  *|FieldName|
FROM TableName
WHERE COnditional
ORDER BY fieldName ASC|DESC

SELECT Ten,PhaiNu
FROM SInhVien
--1.	Cho biết tên, địa chỉ, điện thọai của tất cả các sinh viên.
SELECT Ten, DiaCHi, SoDienThoai
FROM SinhVien
--2.	Cho biết tên các môn học và số tín chỉ của từng môn học.
SELECT TenMH,SoTC_ToiThieu
FROM MonHoc
--3.	Cho biết kết quả học tập của sinh viên có Mã số “T0003M”.
SELECT * 
FROM KetQua
WHERE MSSV='T0003M'
--4.	Cho biết tên các giáo viên có ký tự thứ 3 của họ và tên là “A”.
SELECT *
FROM GiaoVien
WHERE TenGV LIKE '__A%'
--1 ký tự ? , _
--n ky tu  * , %
--5.	Cho biết tên những môn học có chứa chữ “dữ” (ví dụ như các môn Cơ sở dữ liệu, 
--Cấu trúc dữ liệu,...).
SELECT *
FROM MonHoc
WHERE TenMH LIKE N'%dữ%'
--6.	Cho biết tên các giáo viên có ký tự đầu tiên của họ và tên là các ký tự “P” hoặc “L”.
SELECT*
FROM GiaoVien 
--WHERE TenGV LIKE'P%' OR TenGV LIKE 'L%'
WHERE TenGV LIKE '[PL]%' 
--7.	Cho biết tên, địa chỉ của những sinh viên có địa chỉ trên đường “Cống Quỳnh”.
SELECT*
FROM SinhVien 
WHERE DiaChi like N'%Cống quỳnh%'
--8. Cho biết mã môn học, tên môn học, mã khóa học và số tín chỉ của những môn học có cấu trúc 
--của mã môn học như sau: ký tự thứ 1 là “C”, ký tự thứ 3 là “D”.
select M.MaMH,TenMH,MaKhoaHoc, SoTCToiThieu
from MonHoc M INNER JOIN GiangDay G ON M.MaMH = G.MaMH
where M.MaMH like 'C_D_'
--9.	Cho biết tên các môn học được dạy trong niên khóa 2011-2012.
SELECT M.MAMH,TENMH,NIENKHOA
FROM MonHoc M INNER JOIN GiangDay G ON M.MaMH=G.MaMH
WHERE NIENKHOA = '2011-2012'
--WHERE NIENKHOA LIKE '%2011-2012%'
--10.	Cho biết tên khoa, mã số sinh viên, tên, địa chỉ của các SV theo từng Khoa sắp theo thứ 
--tự A-Z của tên sinh viên.
SELECT TENKHOA, MSSV, TEN, DIACHI
FROM KHOA K INNER JOIN SINHVIEN S ON K.MAKHOA=S.MAKHOA
ORDER BY TEN

--11.	Cho biết tên môn học, tên sinh viên, điểm tổng kết của sinh viên qua từng khóa học 
--(DiemKhoaHoc).
SELECT TenMH, Ten, DiemKhoaHoc
FROM MonHoc M	INNER JOIN GiangDay G ON M.MaMH=G.MaMH
				INNER JOIN KetQua K ON G.MaKhoaHoc=K.MaKhoaHoc
				INNER JOIN SinhVien S ON K.MSSV=S.MSSV
--12.	Cho biết tên và điểm tổng kết của sinh viên qua từng khóa học (DiemKhoaHoc) của các SV 
--học môn ‘CSDL’ với DiemKhoaHoc từ 6 đến 7.
SELECT TEN,DIEMKHOAHOC,TENMH
FROM monhoc M inner join Giangday G on M.MaMH=G.MaMH
			inner join Ketqua K on G.MAKHOAHOC=K.MAKHOAHOC
			INNER JOIN SINHVIEN S ON K.MSSV=S.MSSV
WHERE M.MaMH='CSDL' AND DIEMKHOAHOC BETWEEN 6 AND 7

--13.	Cho biết Tên sinh viên, tên môn học, mã khóa học, điểm tổng kết của sinh viên qua từng 
--khóa học (DiemKhoaHoc) của SV có tên là ‘TUNG’.
SELECT TEN, TENMH, K.MAKHOAHOC,DIEMKHOAHOC
FROM KETQUA K INNER JOIN SINHVIEN S ON S.MSSV=K.MSSV  
		INNER JOIN GIANGDAY G ON K.MAKHOAHOC=G.MAKHOAHOC
		INNER JOIN MONHOC M ON M.MAMH=G.MAMH
WHERE TEN LIKE N'%TÙNG%'

--14.	Cho biết tên khoa, tên môn học mà những sinh viên trong khoa đã học. Yêu cầu khi kết quả 
--có nhiều dòng trùng nhau, chỉ hiển thị 1 dòng làm đại diện
SELECT DISTINCT  TENKHOA, TENMH
FROM KHOA INNER JOIN SINHVIEN ON KHOA.MAKHOA=SINHVIEN.MAKHOA
INNER JOIN KETQUA ON SINHVIEN.MSSV=KETQUA.MSSV
				INNER JOIN GIANGDAY ON KETQUA.MAKHOAHOC=GIANGDAY.MAKHOAHOC
				INNER JOIN MONHOC ON MONHOC.MAMH=GIANGDAY.MAMH
--15.	Cho biết tên khoa, mã khóa học mà giáo viên của khoa có tham gia giảng dạy.
SELECT TENKHOA, MAKHOAHOC
FROM KHOA INNER JOIN GIAOVIEN ON KHOA.MAKHOA=GIAOVIEN.MAKHOA
			INNER JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV
--16.	Cho biết tên sinh viên, mã môn học, tên môn học, DiemKhoaHoc của những SV đã học môn 
--‘CSDL’ hoặc ‘CTDL’.
SELECT TEN, MONHOC.MAMH, TENMH, DIEMKHOAHOC
FROM SINHVIEN INNER JOIN KETQUA ON SINHVIEN.MSSV=KETQUA.MSSV
				INNER JOIN GIANGDAY ON KETQUA.MAKHOAHOC=GIANGDAY.MAKHOAHOC
				INNER JOIN MONHOC ON GIANGDAY.MAMH=MONHOC.MAMH
--WHERE MONHOC.MAMH ='CSDL' OR MONHOC.MAMH ='CTDL'
WHERE MONHOC.MAMH IN ('CSDL','CTDL')
--17.	Cho biết tên những giáo viên tham gia giảng dạy môn “Ky thuat lap trinh”.
SELECT TenGV, TenMH
FROM Giaovien GV inner join GiangDay GD on GV.MaGV=GD.MaGV
				inner join MonHoc MH on GD.MaMH=MH.MaMH
WHERE MH.TenMH like N'Kỹ Thuật Lập Trình'

--18.	Cho biết tên môn học mà giáo biên “Tran Van Tien” tham gia giảng dạy trong học kỳ 1 
--niên khóa 2012-2013.
SELECT TENMH 
FROM GIAOVIEN INNER JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV
				INNER JOIN MONHOC ON GIANGDAY.MAMH=MONHOC.MAMH
WHERE TENGV =N'Trần Văn Tiến'
and HOCKY = '1' AND NIENKHOA ='2012-2013'

--19.	Cho biết tên những sinh viên đã có điểm trong table Kết quả (yêu cầu loại bỏ các tên trùng nhau 
--nếu có).
SELECT DISTINCT TEN
FROM SINHVIEN SV INNER JOIN KETQUA KQ ON SV.MSSV=KQ.MSSV
--20.	Cho hiển thị 35% dữ liệu có trong table table kết quả.
SELECT TOP 35 PERCENT *
FROM KETQUA
--21.	Cho biết tên 3 sinh viên có DiemKhoaHoc cao nhất trong table kết quả.
SELECT  TOP 3 TEN, Diemkhoahoc, MaKhoaHoc
FROM SINHVIEN SV INNER JOIN KETQUA KQ ON SV.MSSV=KQ.MSSV
ORDER BY Diemkhoahoc DESC--descending
--22.	Cho biết mã, tên các SV có DiemKhoaHoc của 1 môn học nào đó trên 8 
--(kết quả các môn khác có thể <=8).
SELECT DISTINCT S.MSSV, TEN 
FROM SinhVien S INNER JOIN KETQUA K ON S.MSSV=K.MSSV
WHERE DiemKhoaHoc >=8
--23.	Cho biết mã, tên các SV có tất cả các DiemKhoaHoc đều trên 8. Lưu ý cần loại những 
--sinh viên chưa hề có điểm trong table kết quả.
SELECT MSSV, Ten
FROM SinhVien
WHERE MSSV NOT IN (SELECT DISTINCT MSSV
					FROM KetQua
					WHERE DiemKhoaHoc<8)
		AND MSSV NOT IN (SELECT DISTINCT MSSV
					FROM KetQua)
--24.	Lần lượt sử dụng các hàm xếp hạng: Row_Number, Dense_Rank, Rank để xuất các kết quả 
--a.- MSSV	DiemKhoaHoc	XepHang
SELECT S.MSSV, DIEMKHOAHOC,ROW_NUMBER() OVER(ORDER BY DIEMKHOAHOC DESC) AS SAPXEP
FROM SinhVien S INNER JOIN KetQua K ON S.MSSV=K.MSSV
--b.- MSSV	DiemKhoaHoc	XepHang
SELECT S.MSSV, DIEMKHOAHOC, DENSE_RANK() OVER(ORDER BY DIEMKHOAHOC DESC) AS XEPHANG
FROM SinhVien S INNER JOIN KetQua K ON S.MSSV=K.MSSV
--c.- MSSV	DiemKhoaHoc	XepHang
SELECT S.MSSV, DIEMKHOAHOC, RANK() OVER(ORDER BY DIEMKHOAHOC DESC) AS XEPHANG
FROM SinhVien S INNER JOIN KetQua K ON S.MSSV=K.MSSV
--d.- TT	Ten	MSSV
SELECT DISTINCT ROW_NUMBER()OVER(ORDER BY TEN) AS STT, TEN,MSSV
FROM SINHVIEN
--e.- MSSV	Ten	DiemKhoaHoc	XepHang
SELECT SV.MSSV, Ten, DiemKhoaHoc, DENSE_RANK() OVER (PARTITION BY Ten
							ORDER BY DiemKhoaHoc desc ) AS XepHang
FROM SinhVien SV INNER JOIN KetQua KQ ON SV.MSSV = KQ.MSSV
ORDER BY Ten
--f.- Tên Khoa	Tên môn học	STT SV	Họ tên SV	DiemKhoaHoc

--3.3.2	Aggregate Functions
--25.	Có bao nhiêu SV.
SELECT COUNT(*)
FROM SinhVien
--26.	Có bao nhiêu GV.
SELECT COUNT(*)
FROM GiaoVien
--27.	Có bao nhiêu SV có thuộc tính Phái Nữ là Yes và thuộc khoa “CNTT”.
SELECT COUNT(*) as SoLuongSVNu_KhoaCNTTT
FROM SinhVien
WHERE PhaiNu=1 AND MaKhoa='CNTT'
--28.	Có bao nhiêu giáo viên khoa CNTT.
SELECT COUNT(*) AS SOLUONGGV
FROM GiaoVien
WHERE MaKhoa='CNTT'
--29.	Có bao nhiêu môn học được giảng dạy trong học kỳ I năm 2011-2012.
SELECT DISTINCT COUNT(*) AS 'SL MON HOC'
FROM GiangDay 
WHERE HocKy=1 AND NienKhoa='2011-2012'
--30.	Có bao nhiêu SV học môn CSDL.
SELECT COUNT (MSSV) AS 'Số lượng'
FROM KETQUA INNER JOIN GIANGDAY ON KETQUA.MAKHOAHOC=GIANGDAY.MAKHOAHOC
WHERE MAMH= 'CSDL'
--31.	Cho biết số lượng môn học đã tham gia và điểm TB của tất cả các DiemKhoaHoc của SV có mã số ‘T0003M’.
SELECT COUNT(GD.MAMH) AS 'Số lượng môn học', AVG (DIEMKHOAHOC) AS DIEMTB
FROM KETQUA KQ INNER JOIN  GIANGDAY GD ON KQ.MAKHOAHOC=GD.MAKHOAHOC
INNER JOIN MONHOC ON MONHOC.MAMH=GD.MAMH
WHERE MSSV='T0003M'
--32.	Cho biết mã, tên, địa chỉ và điểm TB của tất cả các DiemKhoaHoc của từng SV.
SELECT S.MSSV, Ten, DiaChi , AVG(DiemKhoaHoc) DiemTrungBinh
FROM SinhVien S INNER JOIN KetQua K ON S.MSSV=K.MSSV
GROUP BY S.MSSV, Ten, DiaChi 
--33.	Cho biết số lượng DiemKhoaHoc >=8 của từng sinh viên (chỉ xuất kết quả cho những sinh viên có DiemKhoaHoc >=8). 
--Họ tên SV	SL DiemKhoaHoc >=8
SELECT TEN, COUNT(DIEMKHOAHOC) AS'Số lượng'
FROM SINHVIEN SV INNER JOIN KETQUA KQ ON SV.MSSV=KQ.MSSV
WHERE  DIEMKHOAHOC >=8
GROUP BY TEN
--34.	Cho biết tên khoa, số lượng sinh viên có trong từng khoa (chỉ xuất kết quả cho những khoa có sinh viên).
--TenKhoa	SLSV
SELECT TENKHOA, COUNT (MSSV) AS SOLUONGSV
FROM Sinhvien S INNER JOIN Khoa K ON S.MaKhoa=K.MaKhoa
GROUP BY TENKHOA
--35.	Cho biết tên khoa, số lượng khóa học mà giáo viên của khoa có tham gia giảng dạy (chỉ xuất kết quả cho những khoa có giáo viên tham gia giảng dạy trong các khóa học).
--TenKhoa	SL Khóa học
SELECT TENKHOA,  COUNT (MAKHOAHOC) AS 'Số lượng khóa'
FROM KHOA K INNER JOIN GIAOVIEN GV ON K.MAKHOA = GV.MAKHOA
			INNER JOIN GIANGDAY GD ON GV.MAGV=GD.MAGV
GROUP BY TENKHOA
--36.	Cho biết số lượng tín chỉ lý thuyết, số lượng tín chỉ thực hành mà từng sinh viên đã tham gia (gồm MSSV, tên SV, số lượng tín chỉ lý thuyết, số lượng tín chỉ thực hành).
SELECT S.MSSV, TEN,SUM(SOTCLT) AS 'TỔNG SỐ TC LT' , SUM(SOTCTH) AS ' TỔNG SỐ TC TH'
FROM SinhVien S INNER JOIN KetQua K ON S.MSSV=K.MSSV
				INNER JOIN GiangDay g ON K.MaKhoaHoc=G.MaKhoaHoc
GROUP BY S.MSSV, TEN
--37.	Cho biết tên tất cả các giáo viên cùng với số lương khóa học, số lượng tín chỉ (lý thuyết + thực hành) mà từng giáo viên đã tham gia giảng dạy. 
SELECT TenGV, SUM (TongsoTC) AS Tongsotinchi, count (MAmh) as Tongkhoahoc
FROM Giaovien GV inner join Giangday GD ON GV.MAGV=GD.MAGV
GROUP BY TenGV

SELECT  TenGV, count (MaKhoaHoc) as soloung,SUM(SoTCLT+SoTCTH) as tongTC
FROM GiaoVien GV	INNER JOIN GiangDay GD ON GV.MaGV = GD.MaGV	
GROUP BY TenGV

--38.	Giả sử người ta muốn thống kê số lượng sinh viên theo từng nhóm điểm (với nhóm điểm được làm tròn không lấy số lẻ từ DiemKhoaHoc trong table Kết quả):
--Yêu cầu: Đếm xem mỗi nhóm trong DiemKhoaHoc_PhanNhom có bao nhiêu sinh viên.
SELECT ROUND(DiemKhoaHoc,0), COUNT(*)
FROM KetQua
GROUP BY ROUND(DiemKhoaHoc,0)

--39.	Cho biết tên những sinh viên chỉ mới thi đúng một môn.
SELECT Ten,COUNT (*) AS SLMon
FROM SinhVien S INNER JOIN KetQua K ON S.MSSV=K.MSSV
GROUP BY Ten
Having count (*)
--40.	Cho biết mã, tên, địa chỉ và điểm của các SV có điểm trung bình (của tất cả các DiemKhoaHoc) >8.5.
SELECT S.MSSV,TEN, DiaChi, DiemKhoaHoc, COUNT(DiemKhoaHoc) AS DTB
FROM SinhVien S INNER JOIN KetQua K ON S.MSSV=K.MSSV
GROUP BY S.MSSV,TEN, DiaChi, DiemKhoaHoc
HAVING AVG(DiemKhoaHoc)>=8.5
--41.	Cho biết Mã khóa học, học kỳ, năm, số lượng SV tham gia của những khóa học có số lượng SV tham gia từ 2 đến 4 người.
SELECT GD.MAKHOAHOC, HOCKY, NIENKHOA, COUNT (MSSV) AS SLSV 
FROM KETQUA KQ INNER JOIN GIANGDAY GD ON KQ.MAKHOAHOC=GD.MAKHOAHOC
GROUP BY GD.MAKHOAHOC, HOCKY, NIENKHOA
HAVING COUNT (MSSV) BETWEEN 2 AND 4
--42.	Cho biết các SV đã học đủ 2 môn ‘CSDL’ & ’CTDL’ hoặc có DiemKhoaHoc của 1 trong 2 môn này >=8.
--43.	Trả lời “Có” hoặc “không”
a.-	Cho biết sinh viên có mã số ‘C0001F’  có tham  gia khóa học ‘K1’ hay không?
b.-	Cho biết khóa học K1 có sinh viên bị thi lại (DiemKhoaHoc <5) hay không? 
c.-	Cho biết Khoa CNTT có sinh viên Nữ đạt DiemKhoaHoc cả 2 môn ‘CSDL’ & ’CTDL’ >=5 hay không?  
d.-	Cho biết giáo viên tên 'THAO' có dạy môn học nào trong năm 2011-2012 hay không?  
44.	Giả sử cần tạo dữ liệu gồm 3 cột MSSV, Họ tên, Học bổng. Trong đó những sinh viên có điểm trung bình của tất cả các môn đều phải >=7 sẽ nhận học bổng là 1tr, ngược lại, học bổng =0.
45.	Giả sử cần tạo dữ liệu gồm 3 cột MSSV, Họ tên, Xếp loại. Trong đó cột Xếp loại căn cứ  trên điểm trung bình (của tất cả các DiemKhoaHoc) theo quy định xếp loại như sau:



