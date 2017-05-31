BÁO CÁO QUÁ TRÌNH THỰC HIỆN

YÊU CẦU SỐ 1: Giải pháp mã hóa thông tin lương để chỉ nhân viên được phép xem lương của mình

Sinh viên thực hiện: 1412279 - Trần Đình Lâm


NỘI DUNG QUÁ TRÌNH THỰC HIỆN

1. Cách giải quyết:
	- Sử dụng mã hóa đối xứng sử dụng key là Mã nhân viên của từng nhân viên.
	- Khi nhân viên đăng nhập và sử dụng hàm truy xuất lương, hệ thống dùng Mã nhân viên để giải mã.
	  Điều này đảm bảo mỗi nhân viên chỉ xem được lương của mình thông qua hàm trên

2. Các bước thực hiện:
	- Gán quyền EXEC trên DBMS_CRYPTO cho người quản trị hệ thống để tạo 2 hàm
	- Tạo Package có tên CRYPT01 chứa 2 hàm ENCYPT_LUONG và DDECRYPT_LUONG
	- Cài đặt 2 hàm trên với Key là Mã nhân viên, Data là LUONG. Ta sử dụng thuật toán 
	  mã hóa DES nên Key cần 8Bytes, trong khi Mã nhân viên hiện hành là 4Bytes.
	- Cập nhật lại Table NHANVIEN với LUONG tính bằng hàm ENCRYPT_LUONG:
		UPDATE NHANVIEN SET LUONG=CRYPT01.ENCRYPT_LUONG(LUONG, MANV||MANV );
	- Tạo Procedure truy cập "luongcanhan" và cấp quyền trên Procedure này cho nhân viên
	
3. Kiểm tra kết quả:
	- Sử dụng nv19 để đăng nhập và thực hiện truy xuất lương