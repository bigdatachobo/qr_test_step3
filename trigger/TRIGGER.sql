DELIMITER $$
USE VMStset;
CREATE TRIGGER fill_UW1_재고_columns
AFTER INSERT ON UW1_재고 -- 관리번호열에 데이터가 입력시 트리거 발동 
FOR EACH ROW
BEGIN
  UPDATE UW1_재고 AS INV
    JOIN UW1_관리번호 AS MANG ON INV.관리번호 = MANG.관리번호
    JOIN 제품번호 AS PROD ON PROD.제품번호 = SUBSTRING_INDEX(INV.관리번호, '_', 1)
  SET
      INV.제품번호 = SUBSTRING_INDEX(INV.관리번호, '_', 1),
      INV.제품구분번호 = SUBSTRING_INDEX(INV.관리번호, '_', -1),
      INV.QR코드 = MANG.QR코드,
      INV.제품사 = PROD.제품사,
      INV.구매처 = MANG.구매처,
      INV.구분 = PROD.구분,
      INV.제품명 = PROD.제품명,
      INV.모델명 = PROD.모델명,
      INV.적재수량 = PROD.적재수량,
      INV.랙별_적재_단위 = PROD.랙별_적재_단위,
      INV.낱개_가로_cm = PROD.낱개_가로_cm,
      INV.낱개_세로_cm = PROD.낱개_세로_cm,
      INV.낱개_높이_cm = PROD.낱개_높이_cm,
      INV.낱개_중량_kg = PROD.낱개_중량_kg,
      INV.유통기한 = MANG.유통기한,
      INV.입고일 = MANG.입고일,
      INV.입고_경과일 = MANG.입고_경과일,
      INV.입고담당자 = MANG.입고담당자,
      INV.수량_입고대기 = MANG.수량_입고대기,
      INV.수량_재고 = MANG.수량_재고,
      INV.수량_가능 = MANG.수량_가능,
      INV.수량_출고예정 = MANG.수량_출고예정,
      INV.수량_출고완료 = MANG.수량_출고완료,
      INV.사진_1 = PROD.사진_1,
      INV.사진_2 = PROD.사진_2,
      INV.사진_3 = PROD.사진_3,
      INV.사진_4 = PROD.사진_4,
      INV.사진_5 = PROD.사진_5,
      INV.인화성 = PROD.인화성,
      INV.추가_상태_1 = MANG.추가_상태_1
      INV.추가_상태_2 = MANG.추가_상태_2
      INV.추가_상태_3 = MANG.추가_상태_3
  WHERE
    INV.관리번호 = NEW.관리번호;
END $$
DELIMITER ;
