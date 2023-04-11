CREATE DEFINER=`admin`@`%` TRIGGER `fill_UW1_재고_columns` BEFORE UPDATE ON `UW1_재고` FOR EACH ROW BEGIN
  DECLARE v_제품번호 VARCHAR(255);
  DECLARE v_제품구분번호 TEXT;
  DECLARE v_QR코드 TEXT;
  DECLARE v_제품사 TEXT;
  DECLARE v_구매처 TEXT;
  DECLARE v_구분 TEXT;
  DECLARE v_제품명 TEXT;
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
    PROD.랙별_적재_수,
    PROD.랙별_적재_단위,
    PROD.낱개_가로_cm,
    PROD.낱개_세로_cm,
    PROD.낱개_높이_cm,
    PROD.낱개_중량_kg,
    PROD.사진_1,
    PROD.인화성
  INTO
    v_제품사,
    v_구분,
    v_제품명,
    v_랙별_적재_수,
    v_랙별_적재_단위,
    v_낱개_가로_cm,
    v_낱개_세로_cm,
    v_낱개_높이_cm,
    v_낱개_중량_kg,
    v_사진_1,
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
    NEW.인화성 = v_인화성,
    NEW.추가_상태_1 = v_추가_상태_1,
    NEW.추가_상태_2 = v_추가_상태_2,
    NEW.추가_상태_3 = v_추가_상태_3;

END
