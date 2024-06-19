-- 創建公司資料庫表格
create database `company_db`;
use `company_db`;

-- 員工表格 -------------------------------------------
create table `employee`(
`emp_id` int primary key,
`name` varchar(20),
`birth_date` date,
`sex` varchar(1),
`salary` int,
`branch_id` int,
`sup_id` int
);

-- 部門表格
create table `branch`(
`branch_id` int primary key,
`branch_name` varchar(20),
`manager_id` int,
foreign key (`manager_id`) references `employee`(`emp_id`) on delete set null  -- 如果employee裡的某個人emp_id離職了，且他原本是部門經理，則manager_id就設為null
);

alter table `employee`
add foreign key(`branch_id`)
references `branch`(`branch_id`)
on delete set null;

alter table `employee`
add foreign key(`sup_id`)
references `employee`(`emp_id`)
on delete set null;

-- 客戶表格
create table `client`(
`client_id` int primary key,
`client_name` varchar(20),
`phone` varchar(20)
);

-- 對接表格
create table `works_with`(
`emp_id` int,
`client_id` int,
`total_sales` int,
primary key(`emp_id`, `client_id`),
foreign key(`emp_id`) references `employee`(`emp_id`) on delete cascade,  -- 如果employee裡的某個人emp_id離職了，則這個表格中的這整筆資料(row)都刪掉 -- emp_id是employee的primary key不能被設為null
foreign key(`client_id`) references `client`(`client_id`) on delete cascade
);

-- 新增公司資料 ---------------------------------------------
describe table `employee`;
select * from  `client`;

insert into `branch` value(1, '研發', null);
insert into `branch` value(2, '行政', null);
insert into `branch` value(3, '資訊', null);

insert into `employee` value(206, '小黃', '1998-10-08', 'F', 50000, 1, Null);
insert into `employee` value(207, '小綠', '1985-09-16', 'M', 29000, 2, 206);
insert into `employee` value(208, '小黑', '2000-12-19', 'M', 35000, 3, 206);
insert into `employee` value(209, '小白', '1997-01-22', 'F', 39000, 3, 207);
insert into `employee` value(210, '小藍', '1925-11-10', 'F', 84000, 1, 207);

update `branch`
set `manager_id` = 206
where `branch_id` = 1;

update `branch`
set `manager_id` = 207
where `branch_id` = 2;

update `branch`
set `manager_id` = 208
where `branch_id` = 3;

insert into `client` value(400, '阿狗', '254354335');
insert into `client` value(401, '阿貓', '25633889');
insert into `client` value(402, '旺來', '45354345');
insert into `client` value(403, '露西', '54354365');
insert into `client` value(404, '艾瑞克', '18783783');

insert into `works_with` value(206, 400, 70000);
insert into `works_with` value(207, 401, 24000);
insert into `works_with` value(208, 400, 9800);
insert into `works_with` value(209, 403, 24000);
insert into `works_with` value(210, 404, 87940);

-- 查看表格內所有資料
select * from `branch`;
select * from `employee`;
select * from `client`;
select * from `works_with`;
select * from `branch`;

-- 練習 -------------------------------------------

-- 1. 取得所有員工資料
select * from  `employee`;

-- 2. 取得所有客戶資料
select * from  `client`;

-- 3. 按薪水低到高取得員工資料
select * from  `employee` order by `salary`;

-- 4. 按薪水前三高
select * from  `employee` order by `salary` desc
limit 3;

-- 5. 取得所有員工的名字
select `name` from  `employee`;

-- 6. 取得不重複的部門id
select distinct `branch_id` from  `employee`;



-- aggregate function 聚合函數 -------------------------------------------

-- 1-1. 取得員工人數
select count(*) from `employee`;

-- 1-2. 取得屬性sup_id的筆數
select count(`sup_id`) from `employee`;

-- 2. 取得所有出生於 1970-01-01 之後的女性員工人數
select count(*) 
from `employee` 
where `birth_date` > '1970-01-01' and `sex` = 'F';

-- 3. 取得所有員工的平均薪水
select avg(`salary`) from `employee`;

-- 4. 取得所有員工薪水的總和
select sum(`salary`) from `employee`;

-- 5. 取得薪水最高的員工
select max(`salary`) from `employee`;

-- 6. 取得薪水最低的員工
select min(`salary`) from `employee`;

-- wildcards 萬用字元  -------------------------------------------
--  % 代表多個字元
--  _ 代表一個字元 

-- 1. 取得電話號碼尾數是335的客戶
select * from `client`
where `phone` like '%335';

-- 2. 取得姓艾的客戶
select * from `client`
where `client_name` like '艾%';

-- 3. 取得生日在12月的員工
select * from `employee`
where `birth_date` like '_____12___';

-- union ------------------------------------------- 上下連接column

-- 1. 員工名字 union 客戶名字 (合併屬性形態要一致 ex. [int union int] )
select `name` from `employee`
union
select `client_name` from `client`;
  
-- 2. 員工id + 員工名字 union 客戶id + 客戶名字 (合併屬性個數要一致 ex. [兩個 union 兩個] )
-- `屬性名` as `待命名` 改每個column的名稱
select `emp_id` as `total_id`, `name` as `total_name` from `employee`
union
select `client_id`, `client_name` from `client`;

-- 3. 員工薪水 union 銷售金額
select `salary` as `total_money` from `employee`
union
select `total_sales` from `works_with`;

-- join ------------------------------------------- 左右連接 row
insert into `branch` values(4, '偷懶', null);
-- 取得所有部門經理的名字
select `emp_id`, `name`, `branch_name` from `employee` 
join `branch`
on `emp_id` = `manager_id`;   
-- 等上   下方寫法是以防屬性名字相同
select `employee`.`emp_id`, `employee`.`name`, `branch`.`branch_name` 
from `employee` 
join `branch`
on `employee`.`emp_id` = `branch`.`manager_id`;   
--  left join 不管右邊條件成不成立，皆會回傳左邊所有資料，右方不成立的情況則會回傳null  (right join以此類推)
select `employee`.`emp_id`, `employee`.`name`, `branch`.`branch_name` 
from `employee` 
left join `branch`
on `employee`.`emp_id` = `branch`.`manager_id`;  

-- subquery 子查詢 ------------------------------------------- 

-- 1. 找出研發部門的經理名字
-- 找manager_id
select `manager_id` from `branch`
where `branch_name` = '研發';
-- 對應回名字
select `name`
from `employee`
where `emp_id` = (
	select `manager_id` from `branch`
	where `branch_name` = '研發'
);

-- 2. 找出對單一位客戶銷售金額超過50000的員工名字
select `name` from `employee` 
where `emp_id` in(
	select `emp_id` from `works_with`
	where `total_sales` > 50000
);

-- on delete ------------------------------------------- 
delete from `employee`
where `emp_id` = 207;

select * from `branch`;
select * from `works_with`;
