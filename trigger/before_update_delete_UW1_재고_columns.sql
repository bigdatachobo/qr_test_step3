CREATE DEFINER=`admin`@`%` TRIGGER `delete_UW1_재고_columns` BEFORE UPDATE ON `UW1_재고` FOR EACH ROW BEGIN
  IF NEW.관리번호 = '' THEN
    SET
        NEW.제품번호 = '',
        NEW.제품구분번호 = '',
        NEW.QR코드 = '',
        NEW.제품사 = '',
        NEW.구매처 = '',
        NEW.구분 = '',
        NEW.제품명 = '',
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
        NEW.인화성 = '',
        NEW.추가_상태_1 = '',
        NEW.추가_상태_2 = '',
        NEW.추가_상태_3 = '',
        NEW.비고 = '';
  END IF;
END
