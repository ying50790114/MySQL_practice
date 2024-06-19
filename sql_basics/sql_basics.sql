-- MySQL資料型態介紹 -- 
-- int          -- 整數
-- decimal(m,n) -- 小數，m位數中，小數位佔n個
-- varchar(n)   -- 字串
-- blob         -- (binary large object) 圖片、影片、檔案...
-- date         -- 'YYYY-MM-DD'
-- timestamp    -- 'YYYY-MM-DD HH:MM:SS'
-- <>           -- 不等於

-- 創建資料庫
create database `database_name`;
show databases;                                  -- 顯示資料庫
drop database `database_name`;                   -- 刪除資料庫

-- 在某資料庫內創建表格
use `database_name`;

create table `student`(
`student_id` int primary key,
`name` varchar(20),
`major` varchar(20));

-- 同上
create table `student`(
`student_id` int,
`name` varchar(20),
`major` varchar(20),
primary key(`student_id`));

describe `student`;                               -- 顯示表格
drop table `student`;                             -- 刪除表格
 
alter table `student` add gpa decimal(3, 2);      -- 修改表格
alter table `student` drop column gpa;

-- 存入資料
select * from `student`;                          -- 列出表格中所有資料
insert into `student` value(1, '小白', '歷史');
insert into `student`(`name`, `major`, `student_id`) value('小藍', '英語', 2);   -- 指定順序
insert into `student`(`major`, `student_id`) value('數學', 3);  -- 沒填入等於 Null

-- constraints (not null、unique、default ...)
create table `student`(
`student_id` int,
`name` varchar(20) not null,
`major` varchar(20) unique,
primary key(`student_id`));

-- 修改update、刪除delete表格內資料
set sql_safe_updates = 0;

create table `student`(
`student_id` int primary key,
`name` varchar(20),
`major` varchar(20),
`score` int);

update `student`             
set `major` = '英語文學'
where `major` = '英語';

update `student`             
set `major` = '生化'
where `major` = '生物' or `major` = '化學';

update `student`             
set `name` = '小灰', `major` = '物理'
where `student_id` = 1;

delete from `student`
where `student_id` = 4;

delete from `student`
where `score` < 60;

-- 取得資料
select `name`, `major` 
from `student` 
order by `score` desc;            -- default asc

select *
from `student` 
order by `score`, `student_id`   -- 若score一樣，則用student_id排序
limit 3;                         -- 顯示前3筆

select *
from `student` 
where `major` = '英語';
-- where `major` = in('英語', '歷史', '生物');
-- 同上
-- where `major` = '英語' or `major` = '歷史' or `major` = '生物'; 

