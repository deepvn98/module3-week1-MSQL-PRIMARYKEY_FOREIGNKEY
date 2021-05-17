#
tạo CSDL
create
database filestudent;

#
Tạo bản class
create table filestudent.class
(
    id         int auto_increment,
    name       varchar(100) not null,
    language   varchar(100) not null,
    desciption varchar(100),
    constraint pk_01 primary key (id)
);
insert into filestudent.class(name, language, desciption) value ('python','python',''),
('java02','java',''),
('js','java',''),
('PHP','java','');
update filestudent.class
set language ='javascrip'
where name = 'js';

#
Tạo bảng address
create table filestudent.address
(
    id      int auto_increment,
    address varchar(100) not null,
    constraint pk_address primary key (id)
);
insert into filestudent.address(address) value ('Bắc Giang'),
('Bắc Ninh'),
('Hà Nội'),
('Vĩnh phúc'),
('Hà Tây');

#
Tạo bảng student
create table filestudent.students
(
    id         int auto_increment,
    fullname   varchar(100) not null,
    address_id int          not null,
    phone      varchar(20) unique,
    class_id   int          not null,
    constraint pk_student primary key (id),
    constraint fk_class foreign key (class_id) references filestudent.class (id),
    constraint fk_address foreign key (address_id) references filestudent.address (id)
);
alter table filestudent.students
    modify column phone varchar (20) unique not null;
insert into filestudent.students(fullname, address_id, phone, class_id) value ('Híu',2,'01234432434',1),
('Sáng',1,'0123443232434',1),
('Lực',5,'012344304',2),
('Phương',3,'0123560432434',1),
('Hà',3,'01203447654',1),
('Hoàng',4,'0128324304',3),
('Công',3,'0124302434',5),
('Toàn',4,'01807434432434',4),
('Tùng',3,'017344324304',3),
('Khánh',3,'05744532434',2);
select *
from filestudent.students;

#
Tạo bảng course
create table filestudent.course
(
    id         int auto_increment,
    constraint pk_course primary key (id),
    name       varchar(100) not null unique,
    desciption varchar(200)
);
insert into filestudent.course(name, desciption) value ('jv01',''),
('js01',''),
('jv02',''),
('php01',''),
('python01','');

#
Tạo bảng point
create table filestudent.point
(
    id         int auto_increment,
    constraint pk_point primary key (id),
    course_id  int    not null,
    student_id int    not null,
    constraint fk_point1 foreign key (course_id) references filestudent.course (id),
    constraint fk_point2 foreign key (student_id) references filestudent.students (id),
    point      double not null
);
insert into filestudent.point(course_id, student_id, point) value (7,21,10),
(8,22,8),
(9,23,10),
(10,24,9),
(11,25,8),
(7,26,9),
(8,27,7),
(9,28,8),
(10,29,10),
(11,30,9),
(11,21,8),
(8,24,10),
(7,26,7),
(10,28,9),
(8,29,8);
#
Thống kê số lượng học viên các lớp
# use filestudent;
#
select class.name         as classname,
       count(students.id) as demhocsinh #
from class #
         inner join students on class.id = students.class_id #
group by class.name
    #
order by demhocsinh
    # lay ra hoc vien va lop
    use filestudent;
select fullname, class.name
from students
         join class on students.class_id = class.id;
select s.fullname, c.name
from students s
         join class c on s.class_id = c.id;
select c.name as tenlop, count(class_id) as sooluonghocvien
from students s
         join class c on s.class_id = c.id
group by c.name;

#
thống kê số lượng học viên các tỉnh
use filestudent;
select a.address, s.fullname
from address a
         join students s on a.id = s.address_id;
select address, count(students.id)
from students
         join address a on a.id = students.address_id
group by a.address;

#
tính số điểm trung bình của các môn
select avg(point), name
from point
         join course c on c.id = point.course_id
group by name;

#
hiển thị tổng số người có cùng điểm số
use filestudent;
select point as Diemso, count(course_id) as tongnguoi
from point
         right join course c on c.id = point.course_id
         left join students s on point.student_id = s.id
group by point;
