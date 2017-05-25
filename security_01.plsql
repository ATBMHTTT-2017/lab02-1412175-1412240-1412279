grant execute on dbms_crypto to quantri;

--[conn quantri]

--1. tao package co chua 2 ham encrypt/decrypt
CREATE OR REPLACE PACKAGE CRYPT01 IS
  FUNCTION ENCRYPT_LUONG(p_data IN varchar2,key_01 IN VARCHAR2) RETURN RAW DETERMINISTIC;
  FUNCTION DECRYPT_LUONG(p_data IN RAW,key_01 IN VARCHAR2) RETURN NUMBER DETERMINISTIC;
END CRYPT01;


--2. CAI DAT 2 FUNCTION TREN
CREATE OR REPLACE PACKAGE BODY CRYPT01 IS 
  encryption_type PLS_INTEGER :=
							 DBMS_CRYPTO.ENCRYPT_DES
							+DBMS_CRYPTO.CHAIN_CBC
							+DBMS_CRYPTO.PAD_PKCS5;
  FUNCTION ENCRYPT_LUONG(p_data IN varchar2,key_01 IN VARCHAR2) RETURN RAW DETERMINISTIC
  IS
  	encrypted_raw raw(2000);
  BEGIN
       encrypted_raw := dbms_crypto.encrypt(
          src => utl_raw.cast_to_raw(p_data),
          typ => encryption_type,
          key => utl_raw.cast_to_raw(key_01)
      );
      return encrypted_raw;
  END ENCRYPT_LUONG;
  
  FUNCTION DECRYPT_LUONG(p_data IN RAW,key_01 IN VARCHAR2) RETURN NUMBER DETERMINISTIC
  IS
    decrypted_raw raw(2000);
    result varchar2(50);
  BEGIN

       decrypted_raw := dbms_crypto.decrypt(
          src => p_data,
          typ => encryption_type,
          key => utl_raw.cast_to_raw(key_01)
      );
      result :=utl_raw.cast_to_varchar2(decrypted_raw);
      
  END DECRYPT_LUONG;
END CRYPT01;

--3: update table Nhanvien
UPDATE NHANVIEN SET LUONG=CRYPT01.ENCRYPT_LUONG(LUONG,MANV||MANV);

SELECT CRYPT01.ENCRYPT_LUONG(LUONG,MANV||MANV) FROM NHANVIEN;
SELECT CRYPT01.DECRYPT_LUONG(LUONG,MANV||MANV) FROM NHANVIEN;


-- tao procedure cho phep nguoi dang nhap thuc thi
create or replace procedure luongcanhan
as
  v_user varchar2(50);
  result raw(200);
  luong2 varchar2(50);
begin
  v_user:=SYS_CONTEXT('userenv','SESSION_USER');
  v_user:=lower(v_user);
  select luong into result
  from quantri.nhanvien where maNV=v_user;
  luong2 := CRYPT01.DECRYPT_LUONG(result,v_user||v_user);
  DBMS_OUTPUT.PUT_LINE('luong'||luong2);
end luongcanhan;




exec luongcanhan;
set serveroutput on;
grant execute on luongcanhan to nv19;
grant execute on quantri.crypt01 to nv19;