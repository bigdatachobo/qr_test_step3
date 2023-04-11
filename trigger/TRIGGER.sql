USE VMStset;

-- GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
-- FLUSH PRIVILEGES;

-- SET GLOBAL log_bin_trust_function_creators = 1;

DROP TRIGGER IF EXISTS VMStset.fill_UW1_재고_columns;
DROP TRIGGER IF EXISTS VMStset.delete_UW1_재고_columns;

''' 작동 안함
DELIMITER $$
CREATE TRIGGER fill_UW1_재고_columns
BEFORE INSERT ON VMStset.UW1_재고 -- 관리번호열에 데이터가 입력시 트리거 발동 
FOR EACH ROW
BEGIN
  UPDATE VMStset.UW1_재고 AS INV
    JOIN VMStset.UW1_관리번호 AS MANG ON INV.관리번호 = MANG.관리번호
    JOIN VMStset.제품번호 AS PROD ON PROD.제품번호 = SUBSTRING_INDEX(INV.관리번호, '_', 1)
  SET
      NEW.INV.제품번호 = SUBSTRING_INDEX(INV.관리번호, '_', 1),
      NEW.INV.제품구분번호 = SUBSTRING_INDEX(INV.관리번호, '_', -1),
      NEW.INV.QR코드 = MANG.QR코드,
	  NEW.INV.제품사 = PROD.제품사,
      NEW.INV.구매처 = MANG.구매처,
      NEW.INV.구분 = PROD.구분,
      NEW.INV.제품명 = PROD.제품명,
      NEW.INV.모델명 = PROD.모델명,
      NEW.INV.적재수량 = PROD.적재수량,
      NEW.INV.랙별_적재_단위 = PROD.랙별_적재_단위,
      NEW.INV.낱개_가로_cm = PROD.낱개_가로_cm,
      NEW.INV.낱개_세로_cm = PROD.낱개_세로_cm,
      NEW.INV.낱개_높이_cm = PROD.낱개_높이_cm,
      NEW.INV.낱개_중량_kg = PROD.낱개_중량_kg,
      NEW.INV.유통기한 = MANG.유통기한,
      NEW.INV.입고일 = MANG.입고일,
      NEW.INV.입고_경과일 = MANG.입고_경과일,
      NEW.INV.입고담당자 = MANG.입고담당자,
      NEW.INV.수량_입고대기 = MANG.수량_입고대기,
      NEW.INV.수량_재고 = MANG.수량_재고,
      NEW.INV.수량_가능 = MANG.수량_가능,
      NEW.INV.수량_출고예정 = MANG.수량_출고예정,
      NEW.INV.수량_출고완료 = MANG.수량_출고완료,
      NEW.INV.사진_1 = PROD.사진_1,
      NEW.INV.사진_2 = PROD.사진_2,
	  NEW.INV.사진_3 = PROD.사진_3,
      NEW.INV.사진_4 = PROD.사진_4,
      NEW.INV.사진_5 = PROD.사진_5,
      NEW.INV.인화성 = PROD.인화성,
      NEW.INV.추가_상태_1 = MANG.추가_상태_1,
      NEW.INV.추가_상태_2 = MANG.추가_상태_2,
      NEW.INV.추가_상태_3 = MANG.추가_상태_3
  WHERE
    INV.관리번호 = NEW.관리번호;
END $$
DELIMITER ;
'''

DELIMITER $$
CREATE TRIGGER fill_UW1_재고_columns
BEFORE UPDATE ON VMStset.UW1_재고
FOR EACH ROW
BEGIN
  DECLARE v_제품번호 VARCHAR(255);
  DECLARE v_제품구분번호 TEXT;
  DECLARE v_QR코드 TEXT;
  DECLARE v_제품사 TEXT;
  DECLARE v_구매처 TEXT;
  DECLARE v_구분 TEXT;
  DECLARE v_제품명 TEXT;
  DECLARE v_모델명 TEXT;
  DECLARE v_랙별_적재_수 TEXT;
  DECLARE v_랙별_적재_단위 TEXT;
  DECLARE v_낱개_가로_cm TEXT;
  DECLARE v_낱개_세로_cm TEXT;
  DECLARE v_낱개_높이_cm TEXT;
  DECLARE v_낱개_중량_kg TEXT;
  DECLARE v_유통기한 TEXT;
  DECLARE v_입고일자 TEXT;
  DECLARE v_입고_경과일 TEXT;
  DECLARE v_입고담당자 TEXT;
  DECLARE v_수량_입고대기 TEXT;
  DECLARE v_수량_재고 TEXT;
  DECLARE v_수량_가능 TEXT;
  DECLARE v_수량_출고예정 TEXT;
  DECLARE v_수량_출고완료 TEXT;
  DECLARE v_사진_1 TEXT;
  DECLARE v_사진_2 TEXT;
  DECLARE v_사진_3 TEXT;
  DECLARE v_사진_4 TEXT;
  DECLARE v_사진_5 TEXT;
  DECLARE v_인화성 TEXT;
  DECLARE v_추가_상태_1 TEXT;
  DECLARE v_추가_상태_2 TEXT;
  DECLARE v_추가_상태_3 TEXT;

  SELECT 
    SUBSTRING_INDEX(NEW.관리번호, '_', 1),
    SUBSTRING_INDEX(NEW.관리번호, '_', -1) 
  INTO 
    v_제품번호,
	v_제품구분번호;

  SELECT
    MANG.QR코드,
    MANG.구매처,
    MANG.유통기한,
    MANG.입고일자,
    MANG.입고_경과일,
    MANG.입고담당자,
    MANG.수량_입고대기,
    MANG.수량_재고,
    MANG.수량_가능,
    MANG.수량_출고예정,
    MANG.수량_출고완료,
    MANG.추가_상태_1,
    MANG.추가_상태_2,
    MANG.추가_상태_3
  INTO
    v_QR코드,
    v_구매처,
    v_유통기한,
    v_입고일자,
    v_입고_경과일,
    v_입고담당자,
    v_수량_입고대기,
    v_수량_재고,
    v_수량_가능,
    v_수량_출고예정,
    v_수량_출고완료,
    v_추가_상태_1,
    v_추가_상태_2,
    v_추가_상태_3
  FROM VMStset.UW1_관리번호 AS MANG
  WHERE MANG.관리번호 = NEW.관리번호;

  SELECT
    PROD.제품사,
    PROD.구분,
    PROD.제품명,
    PROD.모델명,
    PROD.랙별_적재_수,
    PROD.랙별_적재_단위,
    PROD.낱개_가로_cm,
    PROD.낱개_세로_cm,
    PROD.낱개_높이_cm,
    PROD.낱개_중량_kg,
    PROD.사진_1,
    PROD.사진_2,
    PROD.사진_3,
    PROD.사진_4,
    PROD.사진_5,
    PROD.인화성
  INTO
    v_제품사,
    v_구분,
    v_제품명,
    v_모델명,
    v_랙별_적재_수,
    v_랙별_적재_단위,
    v_낱개_가로_cm,
    v_낱개_세로_cm,
    v_낱개_높이_cm,
    v_낱개_중량_kg,
    v_사진_1,
    v_사진_2,
    v_사진_3,
    v_사진_4,
    v_사진_5,
    v_인화성
  FROM VMStset.제품번호 AS PROD
  WHERE PROD.제품번호 = v_제품번호;

  SET
    NEW.제품번호 = v_제품번호,
    NEW.제품구분번호 = v_제품구분번호,
    NEW.QR코드 = v_QR코드,
    NEW.제품사 = v_제품사,
    NEW.구매처 = v_구매처,
    NEW.구분 = v_구분,
    NEW.제품명 = v_제품명,
    NEW.모델명 = v_모델명,
    NEW.랙별_적재_수 = v_랙별_적재_수,
    NEW.랙별_적재_단위 = v_랙별_적재_단위,
    NEW.낱개_가로_cm = v_낱개_가로_cm,
    NEW.낱개_세로_cm = v_낱개_세로_cm,
    NEW.낱개_높이_cm = v_낱개_높이_cm,
    NEW.낱개_중량_kg = v_낱개_중량_kg,
    NEW.유통기한 = v_유통기한,
    NEW.입고일자 = v_입고일자,
    NEW.입고_경과일 = v_입고_경과일,
    NEW.입고담당자 = v_입고담당자,
    NEW.수량_입고대기 = v_수량_입고대기,
    NEW.수량_재고 = v_수량_재고,
    NEW.수량_가능 = v_수량_가능,
    NEW.수량_출고예정 = v_수량_출고예정,
    NEW.수량_출고완료 = v_수량_출고완료,
    NEW.사진_1 = v_사진_1,
    NEW.사진_2 = v_사진_2,
    NEW.사진_3 = v_사진_3,
    NEW.사진_4 = v_사진_4,
    NEW.사진_5 = v_사진_5,
    NEW.인화성 = v_인화성,
    NEW.추가_상태_1 = v_추가_상태_1,
    NEW.추가_상태_2 = v_추가_상태_2,
    NEW.추가_상태_3 = v_추가_상태_3;

END $$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER delete_UW1_재고_columns
BEFORE UPDATE ON VMStset.UW1_재고 -- 관리번호열에 데이터가 입력시 트리거 발동 
FOR EACH ROW
BEGIN
  IF NEW.관리번호 = '' THEN
    SET
        NEW.제품번호 = '',
        NEW.제품구분번호 = '',
        NEW.QR코드 = '',
        NEW.제품사 = '',
        NEW.구매처 = '',
        NEW.구분 = '',
        NEW.제품명 = '',
        NEW.모델명 = '',
        NEW.랙별_적재_수 = '',
        NEW.랙별_적재_단위 = '',
        NEW.낱개_가로_cm = '',
        NEW.낱개_세로_cm = '',
        NEW.낱개_높이_cm = '',
        NEW.낱개_중량_kg = '',
        NEW.유통기한 = '',
        NEW.입고일자 = '',
        NEW.입고_경과일 = '',
        NEW.입고담당자 = '',
        NEW.수량_입고대기 = '',
        NEW.수량_재고 = '',
        NEW.수량_가능 = '',
        NEW.수량_출고예정 = '',
        NEW.수량_출고완료 = '',
        NEW.상태 = '',
        NEW.사진_1 = '',
        NEW.사진_2 = '',
        NEW.사진_3 = '',
        NEW.사진_4 = '',
        NEW.사진_5 = '',
        NEW.인화성 = '',
        NEW.추가_상태_1 = '',
        NEW.추가_상태_2 = '',
        NEW.추가_상태_3 = '',
        NEW.비고 = '';
  END IF;
END $$
DELIMITER ;
