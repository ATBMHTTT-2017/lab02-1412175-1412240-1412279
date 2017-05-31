BÁO CÁO QUÁ TRÌNH THỰC HIỆN

YÊU CẦU SỐ 1: Xây dựng giải pháp để nhân viên và trưởng dự án xác định 
	      thông tin lương có đúng là do trưởng dự án thiết lập không

Sinh viên thực hiện: 1412279 - Trần Đình Lâm


NỘI DUNG QUÁ TRÌNH THỰC HIỆN

1. Cách giải quyết:
	- Với yêu cầu này ta cần sử dụng thuật toán mã hóa bất đối xứng
	- Ta sử dụng thuật toán tạo chữ kí điện tử:
	  +Bên tạo sẽ gửi dữ liệu, kèm theo một dãy số đã được mã hóa thành dãy ### bằng Private Key.
	   Dãy số này là kết quả băm từ chính dữ liệu cần gửi.
	  + Bên nhận sẽ nhận dữ liệu và Dãy mã hóa ###. Bên nhận thực hiện 2 thao tác:
	      Thao tác 1: Băm dữ liệu bằng chính xác thuật toán bên tạo đã băm.
	      Thao tác 2: Giải mã ### bằng Public Key do bên tạo cung cấp.
            Khi đó 2 kết quả của 2 thao tác trên phải trùng khớp nhau. 

2. Các bước thực hiện:
	- Trưởng dự án A cấp lương cho Nhân viên B.
	- Trưởng dự án A tạo thêm 1 cột X, Mã hóa bất đối xứng bằng Private Key, dữ liệu là kết quả băm từ LUONG.
	  Kết quả mã hóa lưu vào cột X đã tạo.
	- Nhân viên B đọc cột LUONG và X. Thực hiện 2 thao tác:
	   + Thao tác 1: Băm LUONG bằng chính thuật toán trưởng dự án A đã băm, cho ra kết quả KQ1
	   + Thao tác 2: Giải mã cột X bằng Public Key trưởng dự án A cung cấp, cho ra kết quả KQ2
	- So sánh KQ1 và KQ2, nếu khớp nhau tức người tạo chính xác là A.  
	
3. Kiểm tra kết quả:
