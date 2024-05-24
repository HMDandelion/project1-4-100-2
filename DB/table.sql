CREATE TABLE IF NOT EXISTS `tbl_assigned_material`
(
    `assigned_material_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '담당자재 코드',
    `spec_code`    INT NOT NULL COMMENT '스펙 코드',
    `client_code`    INT NOT NULL COMMENT '거래처코드',
    PRIMARY KEY ( `assigned_material_code` )
) COMMENT = '담당자재';


CREATE TABLE IF NOT EXISTS  `tbl_authority`
(
    `authority_code`    INT NOT NULL COMMENT '권한코드',
    `authority_name`    VARCHAR(100) NOT NULL COMMENT '권한명',
    PRIMARY KEY ( `authority_code` )
) COMMENT = '권한';


CREATE TABLE IF NOT EXISTS `tbl_bom`
(
    `bom_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT 'BOM 코드',
    `quantity`    INT NOT NULL UNIQUE KEY
        COMMENT '수량',
    `sequence`    INT NOT NULL COMMENT '조립 순서',
    `product_code`    INT NOT NULL COMMENT '상품 코드',
    `spec_code`    INT NOT NULL COMMENT '스펙 코드',
    PRIMARY KEY ( `bom_code` )
) COMMENT = 'BOM';


CREATE TABLE IF NOT EXISTS `tbl_client`
(
    `client_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '거래처코드',
    `client_name`    VARCHAR(100) NOT NULL COMMENT '거래처명',
    `address`    VARCHAR(255) NOT NULL COMMENT '주소',
    `address_detail`    VARCHAR(255) NOT NULL COMMENT '상세주소',
    `postcode`    VARCHAR(10) NOT NULL COMMENT '우편번호',
    `representative_name`    VARCHAR(100) NOT NULL COMMENT '대표명',
    `phone`    VARCHAR(20) NOT NULL COMMENT '연락처',
    `client_type`    VARCHAR(20) NOT NULL COMMENT '거래처 구분',
    `status`    VARCHAR(20) DEFAULT 'ACTIVE' NOT NULL COMMENT '상태',
    PRIMARY KEY ( `client_code` )
) COMMENT = '거래처';


CREATE TABLE IF NOT EXISTS `tbl_department`
(
    `department_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '부서코드',
    `department_name`    VARCHAR(100) NOT NULL COMMENT '부서명',
    `status`    VARCHAR(20) DEFAULT 'ACTIVE' NOT NULL COMMENT '상태',
    `created_at`    DATETIME NOT NULL COMMENT '생성일시',
    `updated_at`    DATETIME COMMENT '수정일시',
    PRIMARY KEY ( `department_code` )
) COMMENT = '부서';


CREATE TABLE IF NOT EXISTS  `tbl_emp_auth`
(
    `emp_auth_code`    INT NOT NULL COMMENT '권한부여코드',
    `authority_code`    INT NOT NULL COMMENT '권한코드',
    `employee_code`    INT NOT NULL COMMENT '사원코드',
    PRIMARY KEY ( `emp_auth_code` )
) COMMENT = '권한부여';




CREATE TABLE IF NOT EXISTS `tbl_employee`
(
    `employee_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '사원코드',
    `employee_no`    VARCHAR(50) NOT NULL COMMENT '사번',
    `employee_name`    VARCHAR(100) NOT NULL COMMENT '이름',
    `phone`    VARCHAR(20) NOT NULL COMMENT '연락처',
    `email`    VARCHAR(100) NOT NULL COMMENT '이메일',
    `password`    VARCHAR(255) NOT NULL COMMENT '비밀번호',
    `ssn`    CHAR(14) NOT NULL COMMENT '주민등록번호',
    `position_code`    INT NOT NULL COMMENT '직급코드',
    `department_code`    INT NOT NULL COMMENT '부서코드',
    `profile_image`    VARCHAR(255) COMMENT '프로필 이미지',
    `hire_date`    DATE NOT NULL COMMENT '입사일시',
    `resign_date`    DATE COMMENT '퇴사일시',
    `status`    VARCHAR(20) DEFAULT 'ACTIVE' NOT NULL COMMENT '상태',
    `created_at`    DATETIME NOT NULL COMMENT '생성일시',
    `updated_at`    DATETIME COMMENT '수정일시',
    `refresh_token`    VARCHAR(300) COMMENT '리프레시토큰',
    PRIMARY KEY ( `employee_code` )
) COMMENT = '사원';


CREATE TABLE IF NOT EXISTS `tbl_estimate`
(
    `estimate_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '견적코드',
    `created_at`    DATETIME NOT NULL COMMENT '생성일시',
    `updated_at`    DATETIME COMMENT '수정일시',
    `deadline`    DATE NOT NULL COMMENT '마감일시',
    `status`    VARCHAR(20) DEFAULT 'ACTIVE' NOT NULL COMMENT '상태',
    `is_ordered`    BOOLEAN DEFAULT false NOT NULL COMMENT '주문전환여부',
    `client_code`    INT NOT NULL COMMENT '거래처코드',
    PRIMARY KEY ( `estimate_code` )
) COMMENT = '상품 견적';


CREATE TABLE IF NOT EXISTS `tbl_estimate_product`
(
    `estimate_product_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '견적상품코드',
    `quantity`    INT NOT NULL COMMENT '수량',
    `price`    INT NOT NULL COMMENT '단가',
    `estimate_code`    INT NOT NULL COMMENT '견적코드',
    `product_code`    INT NOT NULL COMMENT '상품 코드',
    PRIMARY KEY ( `estimate_product_code` )
) COMMENT = '견적 목록';


CREATE TABLE IF NOT EXISTS `tbl_line`
(
    `line_code`    BIGINT NOT NULL COMMENT '라인 코드',
    `line_name`    VARCHAR(50) NOT NULL COMMENT '라인 이름',
    `line_production`    INT COMMENT '생산량',
    `line_status`    VARCHAR(20) COMMENT '상태',
    `employee_code`    INT NOT NULL COMMENT '담당자코드',
    PRIMARY KEY ( `line_code` )
) COMMENT = 'tbl_line';


CREATE TABLE IF NOT EXISTS `tbl_material_order`
(
    `order_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '계약 코드',
    `order_date`    DATE NOT NULL COMMENT '계약 일자',
    `delivery_due_date`    DATE NOT NULL COMMENT '배송 예정 일자',
    `client_code`    INT NOT NULL COMMENT '거래처코드',
    `status`    VARCHAR(20) DEFAULT '계약완료' NOT NULL COMMENT '상태',
    `is_regular_contract`    BOOLEAN NOT NULL DEFAULT FALSE COMMENT '정기계약여부',
    `employee_code`    INT NOT NULL COMMENT '사원코드',
    `arrival_datetime`    DATETIME COMMENT '입고일자',
    `plan_code`    INT COMMENT '생산 계획 코드',
    `is_deleted`    BOOLEAN DEFAULT FALSE NOT NULL COMMENT '삭제여부',
    `deletion_reason`    VARCHAR(100) COMMENT '삭제사유',
    PRIMARY KEY ( `order_code` )
) COMMENT = '원자재 주문';


CREATE TABLE IF NOT EXISTS `tbl_material_specification`
(
    `spec_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '스펙 코드',
    `material_name`    VARCHAR(50) NOT NULL COMMENT '자재 이름',
    `remarks`    VARCHAR(200) COMMENT '비고',
    `unit`    VARCHAR(20) NOT NULL COMMENT '측정단위',
    `spec_category_code`    INT NOT NULL COMMENT '스펙 분류 코드',
    `safety_stock`    INT NOT NULL COMMENT '안전재고 기준량',
    `specification`    VARCHAR(100) NOT NULL COMMENT '스펙',
    PRIMARY KEY ( `spec_code` )
) COMMENT = '원자재 스펙';


CREATE TABLE IF NOT EXISTS `tbl_material_stock`
(
    `stock_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '재고 코드',
    `division`    VARCHAR(20) DEFAULT '양품' NOT NULL COMMENT '구분',
    `spec_code`    INT NOT NULL COMMENT '스펙 코드',
    `warehouse_code`    INT NOT NULL COMMENT '창고 코드',
    `incoming_quantity`    INT DEFAULT 0 NOT NULL COMMENT '입고 수량',
    `actual_quantity`    INT DEFAULT 0 NOT NULL COMMENT '실수량',
    `storage_datetime`    DATETIME NOT NULL COMMENT '적재 일시',
    `remarks`    VARCHAR(200) COMMENT '비고',
    `inspection_datetime`    DATETIME COMMENT '점검일시',
    `modification_datetime`    DATETIME COMMENT '수정 일시',
    `modification_reason`    VARCHAR(200) COMMENT '수정사유',
    `order_code`    INT NOT NULL COMMENT '계약 코드',
    PRIMARY KEY ( `stock_code` )
) COMMENT = '원자재 재고';


CREATE TABLE IF NOT EXISTS `tbl_material_usage`
(
    `usage_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '사용 코드',
    `usage_datetime`    DATETIME NOT NULL COMMENT '사용 일시',
    `employee_code`    INT NOT NULL COMMENT '사원코드',
    `work_order_code`    INT NOT NULL COMMENT '작업 지시서 코드',
    `status`    VARCHAR(20) DEFAULT '준비됨' NOT NULL COMMENT '상태',
    PRIMARY KEY ( `usage_code` )
) COMMENT = '원자재 사용';


CREATE TABLE IF NOT EXISTS `tbl_order`
(
    `order_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '주문코드',
    `order_datetime`    DATETIME DEFAULT now() NOT NULL COMMENT '주문일시',
    `updated_at`    DATETIME COMMENT '수정일시',
    `deadline`    DATE NOT NULL COMMENT '마감일시',
    `status`    VARCHAR(20) DEFAULT 'ORDER_RECEIVED' NOT NULL COMMENT '상태',
    `completed_at`    DATETIME COMMENT '완료일시',
    `client_code`    INT NOT NULL COMMENT '거래처코드',
    `estimate_code`    INT NOT NULL COMMENT '견적코드',
    PRIMARY KEY ( `order_code` )
) COMMENT = '상품 주문';


CREATE TABLE IF NOT EXISTS `tbl_order_product`
(
    `order_product_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '주문상품코드',
    `quantity`    INT NOT NULL COMMENT '수량',
    `price`    INT NOT NULL COMMENT '단가',
    `order_code`    INT NOT NULL COMMENT '주문코드',
    `product_code`    INT NOT NULL COMMENT '상품 코드',
    PRIMARY KEY ( `order_product_code` )
) COMMENT = '주문 목록';


CREATE TABLE IF NOT EXISTS `tbl_order_spec`
(
    `order_spec_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '주문목록 코드',
    `order_quantity`    INT DEFAULT 0 NOT NULL COMMENT '주문수량',
    `price`    INT DEFAULT 0 NOT NULL COMMENT '가격',
    `order_code`    INT NOT NULL COMMENT '계약 코드',
    `spec_code`    INT NOT NULL COMMENT '스펙 코드',
    PRIMARY KEY ( `order_spec_code` )
) COMMENT = '주문목록';


CREATE TABLE IF NOT EXISTS `tbl_planned_order_list`
(
    `order_code`    INT NOT NULL COMMENT '주문코드',
    `plan_code`    INT NOT NULL COMMENT '생산 계획 코드',
    `planned_list_code`    INT NOT NULL COMMENT '계획 주문 목록 코드',
    PRIMARY KEY ( `planned_list_code` )
) COMMENT = '계획 주문 목록';



CREATE TABLE IF NOT EXISTS `tbl_position`
(
    `position_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '직급코드',
    `position_name`    VARCHAR(100) NOT NULL COMMENT '직급명',
    `rank`    INT NOT NULL COMMENT '순위',
    `status`    VARCHAR(20) DEFAULT 'ACTIVE' NOT NULL COMMENT '상태',
    `created_at`    DATETIME NOT NULL UNIQUE KEY
        COMMENT '생성일시',
    `updated_at`    DATETIME COMMENT '수정일시',
    PRIMARY KEY ( `position_code` )
) COMMENT = '직급';


CREATE TABLE IF NOT EXISTS  `tbl_product`
(
    `product_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '상품 코드',
    `porudct_name`    VARCHAR(100) NOT NULL COMMENT '이름',
    `launch_date`    DATETIME NOT NULL COMMENT '출시일',
    `price`    INT NOT NULL COMMENT '정가',
    `unit`    VARCHAR(20) NOT NULL COMMENT '단위',
    `updated_at`    DATETIME COMMENT '상태 수정 날짜',
    `status`    VARCHAR(20) DEFAULT 'ACTIVE' NOT NULL COMMENT '상태',
    PRIMARY KEY ( `product_code` )
) COMMENT = '상품';


CREATE TABLE IF NOT EXISTS `tbl_product_spec`
(
    `code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '상품 스펙 코드',
    `color`    VARCHAR(50) NOT NULL COMMENT '컬러',
    `type`    VARCHAR(50) NOT NULL COMMENT '종류',
    `product_code`    INT COMMENT '상품 코드',
    `size`    VARCHAR(50) COMMENT '사이즈',
    PRIMARY KEY ( `code` )
) COMMENT = '상품 스펙';


CREATE TABLE IF NOT EXISTS `tbl_production_detail`
(
    `production_detail_code`    BIGINT NOT NULL COMMENT '생산 상세 코드',
    `work_order_code`    INT NOT NULL COMMENT '작업 지시서 코드',
    `production_staus_code`    BIGINT NOT NULL COMMENT '생산 현황 코드',
    `employee_code`    INT NOT NULL COMMENT '사원코드',
    `inspection_date`    DATETIME NOT NULL COMMENT '품질 검수 일자',
    `memo`    VARCHAR(50) COMMENT '비고',
    `defect_quantity`    INT COMMENT '불량 수량',
    `completely_quantity`    INT COMMENT '양품 수',
    `defect_reason`    VARCHAR(50) COMMENT '불량 사유',
    `defect_status`    VARCHAR(20) COMMENT '불량 처리',
    `attachment_file`    VARCHAR(50) COMMENT '첨부파일',
    PRIMARY KEY ( `production_detail_code` )
) COMMENT = '생산 상세';


CREATE TABLE IF NOT EXISTS `tbl_production_management`
(
    `production_staus_code`    BIGINT NOT NULL COMMENT '생산 현황 코드',
    `product_code`    INT NOT NULL COMMENT '상품 코드',
    `start_at`    DATETIME NOT NULL COMMENT '생산 시작 일시',
    `completed_at`    DATETIME NOT NULL COMMENT '생산 마감 일시',
    `attachment_file`    VARCHAR(50) COMMENT '생산 관리 서류(첨부 서류)',
    `production_current`    INT COMMENT '현재 생산량',
    `production_status`    VARCHAR(20) NOT NULL COMMENT '상태',
    `inspection_status`    VARCHAR(20) NOT NULL COMMENT '품질 검수 처리',
    PRIMARY KEY ( `production_staus_code` )
) COMMENT = '일일 생산 보고서';



CREATE TABLE IF NOT EXISTS `tbl_production_plan`
(
    `plan_code`    INT NOT NULL COMMENT '생산 계획 코드',
    `creation_at`    DATETIME NOT NULL COMMENT '생성 일자',
    `start_at`    DATE NOT NULL COMMENT '시작일자',
    `description`    VARCHAR(255) COMMENT '적요',
    `upated_at`    DATETIME NOT NULL COMMENT '수정 일시',
    `end_at`    DATE NOT NULL COMMENT '종료일자',
    PRIMARY KEY ( `plan_code` )
) COMMENT = '생산 계획';


CREATE TABLE IF NOT EXISTS `tbl_production_plan_list`
(
    `plan_list_code`    INT NOT NULL COMMENT '생산 계획 목로 코드',
    `required_quantity`    INT NOT NULL COMMENT '생산 필요 수량',
    `panned_quantity`    INT NOT NULL COMMENT '생산 계획 수량',
    `plan_code`    INT NOT NULL COMMENT '생산 계획 코드',
    `product_code`    INT NOT NULL COMMENT '상품 코드',
    PRIMARY KEY ( `plan_list_code` )
) COMMENT = '생산 계획 목록';


CREATE TABLE IF NOT EXISTS `tbl_release`
(
    `release_code`    BIGINT NOT NULL COMMENT '출고 코드',
    `status`    VARCHAR(20) DEFAULT 'WAIT' NOT NULL COMMENT '상태',
    `order_code`    INT NOT NULL COMMENT '주문코드',
    `created_at`    DATETIME AUTO_INCREMENT UNIQUE KEY
        COMMENT '생성 일시',
    PRIMARY KEY ( `release_code` )
) COMMENT = '상품 출고';

ALTER TABLE IF NOT EXISTS `tbl_release`
    ADD CONSTRAINT `tbl_release_PK` PRIMARY KEY ( `release_code` );


CREATE TABLE IF NOT EXISTS `tbl_release_change`
(
    `release_change_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '출고 상태 변경 이력 코드',
    `status`    VARCHAR DEFAULT 'SHIPPING' NOT NULL COMMENT '상태',
    `change_at`    VARCHAR NOT NULL COMMENT '시간',
    `release_code`    BIGINT NOT NULL COMMENT '출고 코드',
    PRIMARY KEY ( `release_change_code` )
) COMMENT = '출고 상태 변경 이력';


CREATE TABLE IF NOT EXISTS `tbl_return`
(
    `return_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '반품코드',
    `return_datetime`    DATETIME DEFAULT now() NOT NULL COMMENT '반품신청일시',
    `client_code`    INT NOT NULL COMMENT '거래처코드',
    `order_code`    INT NOT NULL COMMENT '주문코드',
    `manage_type`    VARCHAR(20) NOT NULL COMMENT '관리유형',
    `manage_status`    VARCHAR(20) DEFAULT 'RETURN_RECEIVED' NOT NULL COMMENT '관리진행상태',
    `return_status`    VARCHAR(20) DEFAULT 'AWAITING_INSPECTION' NOT NULL COMMENT '반환상품상태',
    `exchange_order`    INT COMMENT '교환주문코드',
    `updated_at`    DATETIME COMMENT '수정일시',
    PRIMARY KEY ( `return_code` )
) COMMENT = '상품 반품';


CREATE TABLE IF NOT EXISTS `tbl_return_product`
(
    `return_product_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '반품상품코드',
    `quantity`    INT NOT NULL COMMENT '전체수량',
    `refund_price`    INT NOT NULL COMMENT '환불단가',
    `return_code`    INT NOT NULL COMMENT '반품코드',
    `product_code`    INT NOT NULL COMMENT '상품 코드',
    `defective_quantity`    INT COMMENT '불량 수량',
    `inspection_status`    BOOLEAN DEFAULT 'false' NOT NULL COMMENT '검수여부',
    PRIMARY KEY ( `return_product_code` )
) COMMENT = '반품 목록';


CREATE TABLE IF NOT EXISTS `tbl_spec_category`
(
    `spec_category_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '스펙 분류 코드',
    `spec_category_name`    VARCHAR(50) NOT NULL COMMENT '스펙 분류 명',
    PRIMARY KEY ( `spec_category_code` )
) COMMENT = '스펙 분류';


CREATE TABLE IF NOT EXISTS `tbl_stock`
(
    `stock_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '재고 코드',
    `quantity`    INT NOT NULL AUTO_INCREMENT UNIQUE KEY
        COMMENT '개수',
    `created_at`    DATETIME NOT NULL COMMENT '생성일',
    `is_delete`    BOOLEAN DEFAULT 'false' NOT NULL AUTO_INCREMENT UNIQUE KEY
        COMMENT '삭제 여부',
    `type`    VARCHAR(50) DEFAULT 'PRODUCTS' NOT NULL COMMENT '종류',
    `product_code`    INT NOT NULL COMMENT '상품 코드',
    PRIMARY KEY ( `stock_code` )
) COMMENT = '상품 재고';


CREATE TABLE IF NOT EXISTS `tbl_stock_usage`
(
    `stock_usage_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '재고_사용 코드',
    `used_quantity`    INT DEFAULT 0 COMMENT '사용 수량',
    `stock_code`    INT NOT NULL COMMENT '재고 코드',
    `usage_code`    INT NOT NULL COMMENT '사용 코드',
    `transmission_status`    BOOLEAN DEFAULT 'TRUE' COMMENT '전달여부',
    PRIMARY KEY ( `stock_usage_code` )
) COMMENT = '원자재 재고_사용';


CREATE TABLE IF NOT EXISTS  `tbl_storage`
(
    `storage_code`    INT NOT NULL AUTO_INCREMENT
        COMMENT '창고 보관 코드',
    `inital_quantity`    INT NOT NULL COMMENT '초기수량',
    `destroy_quantity`    INT NOT NULL COMMENT '파손수량',
    `is_delete`    VARCHAR(50) NOT NULL COMMENT '삭제 여부',
    `updated_at`    DATETIME COMMENT '수정 일시',
    `stock_code`    INT COMMENT '재고 코드',
    `warehouse_code`    INT NOT NULL COMMENT '창고 코드',
    `actual_quantity`    INT COMMENT '실수량',
    `created_at`    DATETIME COMMENT '생성일',
    PRIMARY KEY ( `storage_code` )
) COMMENT = '상품 창고 보관';


CREATE TABLE IF NOT EXISTS `tbl_warehouse`
(
    `warehouse_code`    INT NOT NULL COMMENT '창고 코드',
    `name`    VARCHAR(50) NOT NULL COMMENT '창고 이름',
    `location`    VARCHAR(50) NOT NULL AUTO_INCREMENT UNIQUE KEY
        COMMENT '창고 위치',
    `volume`    INT NOT NULL COMMENT '창고 수용량',
    `employee_code`    INT NOT NULL COMMENT '사원코드',
    PRIMARY KEY ( `warehouse_code` )
) COMMENT = '창고';

ALTER TABLE `tbl_warehouse`
    ADD CONSTRAINT `tbl_warehouse_PK` PRIMARY KEY ( `warehouse_code` );


CREATE TABLE IF NOT EXISTS `tbl_work_order`
(
    `work_order_code`    INT NOT NULL COMMENT '작업 지시서 코드',
    `work_written_date`    DATETIME NOT NULL COMMENT '작성 날짜',
    `ordered_quantity`    INT NOT NULL COMMENT '지시 수량',
    `completion_status`    VARCHAR(20) DEFAULT 'INPROGRESS' NOT NULL COMMENT '종결 여부',
    `work_modifued_date`    DATETIME COMMENT '수정 일시',
    `line_code`    BIGINT NOT NULL COMMENT '라인 코드',
    `work_order_date`    DATE NOT NULL COMMENT '작업 지시 일자',
    `product_code`    INT NOT NULL COMMENT '상품 코드',
    PRIMARY KEY ( `work_order_code` )
) COMMENT = '작업 지시서';

ALTER TABLE `tbl_work_order`
    ADD CONSTRAINT `tbl_work_order_PK` PRIMARY KEY ( `work_order_code` );

