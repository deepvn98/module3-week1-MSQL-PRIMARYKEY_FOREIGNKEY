create
database tourmanager;
use
tourmanager;
#
Bảng thành phố
create table city
(
    id       int auto_increment primary key,
    cityname varchar(100) unique not null
);
insert into city(cityname) value ('Nha Trang'),
('Hà Nội'),
('Đà Nẵng'),
('Phú Quốc'),
('Phú Yên');
select *
from city;

#
Bảng khách hàng đặt tour
create table customer
(
    id          int auto_increment primary key,
    name        varchar(50) not null unique,
    cmt         varchar(50) unique,
    yearofbirth date,
    city_id     int,
    constraint fk_city foreign key (city_id) references city (id)
);
insert into customer(name, cmt, yearofbirth, city_id) value ('Diệu Nhi','81272843','1994-04-12',3),
    ('sara','81237843','2000-04-04',1),
    ('Minh Hằng','81274843','1993-06-10',2),
    ('Hariwon','81278543','1989-04-08',3),
    ('Khánh Vân','81277843','1997-07-02',2),
    ('picka chu','81278483','1994-03-12',4),
    ('Lê Lộc','81279843','1997-02-10',5),
    ('Lê Khánh','81217843','1994-06-02',1),
    ('Châu Bùi','812127843','1994-04-02',4),
    ('mie','812732843','1994-05-01',2);
select *
from customer;

#
điểm đến du lịch
create table destination
(
    id               int auto_increment primary key,
    destination_name varchar(200) not null,
    city_id          int          not null,
    constraint fk_01 foreign key (city_id) references city (id),
    price            double       not null,
    description      varchar(200)
);
insert into destination(destination_name, city_id, price, description) value ('Nha Trang beach',1,4000,''),
('Vinpearl Land',1,2000,''),
('Đảo Hòn Mun',1,3000,''),
('Đảo Hòn Tằm',1,4000,''),
('Bãi biển Mỹ Khê',3,3000,''),
('Bán đảo Sơn Trà',3,2000,''),
('Bà Nà Hills',3,2000,''),
('Lăng Chủ Tịch',2,1000,''),
('Văn Miếu Quốc Tử Giám',2,1000,''),
('Chùa Một Cột',2,2000,''),
('Bãi Sao Phú Quốc',4,5000,''),
('Chùa Hộ Quốc Phú Quốc',4,3000,''),
('Bãi Khem Phú Quốc',4,4000,''),
('Bãi Khem Phú Quốc',4,3000,''),
('Vịnh Xuân Đài',5,2000,''),
('Hòn Yến',5,2000,''),
('Hòn Lưa',5,2000,'');
select *
from destination;

#bảng
loại tour
create table typetour
(
    id        int auto_increment primary key,
    type_name varchar(100) not null
);
insert into typetour(type_name) value ('A'),
('B');
select *
from typetour;

#
Bảng tour
create table tour
(
    id             int auto_increment primary key,
    id_typetour    int  not null,
    id_destination int  not null,
    start_day      date not null,
    end_day        date not null,
    constraint fk_03 foreign key (id_destination) references destination (id),
    constraint fk_02 foreign key (id_typetour) references typetour (id)
);
insert into tour(id_typetour, id_destination, start_day, end_day) value (2,17,'2021-04-21','2021-4-24'),
(1,15,'2021-03-21','2021-03-24'),
(1,15,'2021-04-21','2021-04-24'),
(2,16,'2021-03-02','2021-03-05');
select *
from tour;
use
tourmanager;
update tour
set id_destination = 5
where id = 25;

#
Tạo bảng bill
create table bill
(
    id          int auto_increment primary key,
    id_tour     int          not null,
    id_customer int          not null,
    constraint fk_04 foreign key (id_tour) references tour (id),
    constraint fk_05 foreign key (id_customer) references customer (id),
    status      varchar(100) not null
);
insert into bill(id_tour, id_customer, status) value (16,1,'paid'),
(17,2,'paid'),
(18,2,'paid'),
(19,3,'not paid'),
(20,4,'not paid'),
(21,5,'paid'),
(22,6,'not paid'),
(23,7,'not paid'),
(24,8,'paid'),
(25,9,'paid'),
(26,10,'not paid');
select *
from bill;

#thống
kê số lượng tour của các thành phố
use tourmanager;
select cityname, count(t.id)
from city
         join destination d on city.id = d.city_id
         join tour t on d.id = t.id_destination
group by cityname;

#
Tính số tour có ngày bắt đầu trong tháng 3
use tourmanager;
select count(tour.id) as total_tourism_in_March
from tour
where start_day >= '2021-02-28'
  and start_day < '2021-04-01';

#
Tính số tour có ngày kêt thúc trong tháng 4
use  tourmanager;
select count(tour.id)
from tour
where end_day >= '2021-03-30'
  and end_day < '2021-05-01';
