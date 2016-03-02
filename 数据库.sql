Create table T_Pro(
Pno varchar(7)primary key,
Pname varchar(20),
Xno varchar(7),
)
Create table T_Xro(
Xno varchar(7)primary key,
Xname varchar(20),
Xzr varchar(20),
)
Create table T_Pclass
(
Classno char(6)primary key,
Classname varchar(20),
Pno varchar(7),
Xno varchar(7),
Itime int,
);
Create table T_Student(
Sno char(12) primary key,
Sname nchar(10),
Ssex char(2),
Bir char(8),
Classno char(6),
Ano char(4),
Spswd varchar(20),
);

Create table T_Teacher(
Tno char(8) primary key,
Tname varchar(20),
Pno varchar(7),
Ano char(4),
Tpswd varchar(20),
);

Create table T_Course(
Cno char(8) primary key,
Cname varchar(20),
Tno char(8),
Take int,
Sem varchar(20),
Classno char(6),
Lim int,
Ano char(4), 
);
Create table T_Sc(
Cno char(8),
Sno char(12), 
Grade int,
primary key(Cno,Sno),
);
Create table T_Eadm(
Ano char(4) primary key,
Aname varchar(20),
Apswd varchar(20),
);
Create table T_Sadm(
Sysno char(4) primary key,
Syssnam varchar(20),
Syspswd varchar(20),
);
Create table T_Status(
CurSemester varchar(30),
NextSemester varchar(30),
IsChooseCourse bit,
IsGradeInput bit,
);

create table T_Type(
Take int,
Tp varchar(20),
)


INSERT 
INTO T_Type
VALUES(1,'���޿�');

INSERT 
INTO T_Type
VALUES(2,'��ѡ��');

INSERT 
INTO T_Type
VALUES(3,'ͨѡ��');

INSERT 
INTO T_Pro
VALUES('0001','�������ѧ�뼼��','0001');
INSERT 
INTO T_Pro
VALUES('0002','��е�����Զ���','0002');

INSERT 
INTO T_Xro
VALUES('0001','�����','��');
INSERT 
INTO T_Xro
VALUES('0002','��е','�Դ�׳');



INSERT 
INTO T_Pclass
VALUES('000101','�����һ��','0001','0001',2014);
INSERT 
INTO T_Pclass
VALUES('000102','���������','0001','0001',2014);
INSERT 
INTO T_Pclass
VALUES('000201','��еһ��','0002','0002',2015);


INSERT 
INTO T_Student
VALUES('201300010001','����ΰ','��','19940903','000101','0001','zmw123');
INSERT 
INTO T_Student
VALUES('201300010002','����','Ů','19940402','000101','0002','wzy123');
INSERT 
INTO T_Student
VALUES('201300010003','����','��','19911101','000101','0001','zz123');
INSERT 
INTO T_Student
VALUES('201300010004','����׳','��','19950108','000101','0003','ldz123');
INSERT 
INTO T_Student
VALUES('201300010005','�Կ�','��','19891108','000101','0001','zk123');
INSERT 
INTO T_Student
VALUES('201300010006','����','��','19860318','000102','0001','zy123');
INSERT 
INTO T_Student
VALUES('201300010007','������','��','19880714','000102','0001','xlx123');
INSERT 
INTO T_Student
VALUES('201300010008','����','��','19900805','000102','0002','hf123');
INSERT 
INTO T_Student
VALUES('201300010009','����','��','19900103','000102','0003','lt123');
INSERT 
INTO T_Student
VALUES('201300010010','�ᾲ','Ů','19911221','000102','0001','yj123');
INSERT 
INTO T_Student
VALUES('201300020001','���컪','��','19970104','000201','0001','yth123');
INSERT 
INTO T_Student
VALUES('201300020002','����Ÿ','Ů','19940515','000201','0002','zxo123');
INSERT 
INTO T_Student
VALUES('201300020003','��С��','Ů','19890415','000201','0002','lxh123');
INSERT 
INTO T_Student
VALUES('201300020004','������','Ů','19940108','000201','0002','lwr123');
INSERT 
INTO T_Student
VALUES('201300020005','����','Ů','19930406','000201','0001','ty123');
INSERT 
INTO T_Student
VALUES('201300020006','��ѩ÷','Ů','19910708','000201','0001','wxm123');
INSERT 
INTO T_Student
VALUES('201300020007','���׾�','��','19891108','000201','0002','zlj123');


INSERT 
INTO T_Course
VALUES('20150101','�������','00010001',1,'2015�괺��','000101',120,'0001');
INSERT 
INTO T_Course
VALUES('20150102','����ԭ��','00010001',2,'2015�괺��','000101',100,'0001');
INSERT 
INTO T_Course
VALUES('20150203','�й������˼����','00010001',2,'2015���＾','000101',80,'0001');
INSERT 
INTO T_Course
VALUES('20150104','��������','00010001',3,'2015�괺��','000101',120,'0001');
INSERT 
INTO T_Course
VALUES('20150205','�й������Ļ�ʷ','00010001',3,'2015���＾','000101',80,'0001');
INSERT 
INTO T_Course
VALUES('20150107','�ߵ���ѧ','00010001',1,'2015�괺��','000102',150,'0002');
INSERT 
INTO T_Course
VALUES('20150206','�����ͼ��ѧ','00010001',1,'2015���＾','000102',80,'0002');
INSERT 
INTO T_Course
VALUES('20150108','��ɢ��ѧ','00020001',1,'2015�괺��','000201',120,'0002');
INSERT 
INTO T_Course
VALUES('20150209','��е��ͼ','00020001',3,'2015���＾','000201',120,'0003');


INSERT 
INTO T_Sc
VALUES('20150101','201300010001',98);
INSERT 
INTO T_Sc
VALUES('20150102','201300010001',88);
INSERT 
INTO T_Sc
VALUES('20150203','201300010001',94);
INSERT 
INTO T_Sc
VALUES('20150104','201300010001',78);
INSERT 
INTO T_Sc
VALUES('20150205','201300010001',71);

INSERT 
INTO T_Sc
VALUES('20150101','201300010002',98);
INSERT 
INTO T_Sc
VALUES('20150102','201300010002',85);
INSERT 
INTO T_Sc
VALUES('20150203','201300010002',95);
INSERT 
INTO T_Sc
VALUES('20150104','201300010002',58);
INSERT 
INTO T_Sc
VALUES('20150205','201300010002',61);

INSERT 
INTO T_Sc
VALUES('20150101','201300010003',58);
INSERT 
INTO T_Sc
VALUES('20150102','201300010003',68);
INSERT 
INTO T_Sc
VALUES('20150203','201300010003',74);
INSERT 
INTO T_Sc
VALUES('20150104','201300010003',88);
INSERT 
INTO T_Sc
VALUES('20150205','201300010003',78);

INSERT 
INTO T_Sc
VALUES('20150101','201300010004',91);
INSERT 
INTO T_Sc
VALUES('20150102','201300010004',81);
INSERT 
INTO T_Sc
VALUES('20150203','201300010004',91);
INSERT 
INTO T_Sc
VALUES('20150104','201300010004',68);
INSERT 
INTO T_Sc
VALUES('20150205','201300010004',77);

INSERT 
INTO T_Sc
VALUES('20150101','201300010005',78);
INSERT 
INTO T_Sc
VALUES('20150102','201300010005',76);
INSERT 
INTO T_Sc
VALUES('20150203','201300010005',74);
INSERT 
INTO T_Sc
VALUES('20150104','201300010005',71);
INSERT 
INTO T_Sc
VALUES('20150205','201300010005',73);

INSERT 
INTO T_Sc
VALUES('20150107','201300010006',68);
INSERT 
INTO T_Sc
VALUES('20150206','201300010006',79);

INSERT 
INTO T_Sc
VALUES('20150107','201300010007',88);
INSERT 
INTO T_Sc
VALUES('20150206','201300010007',79);

INSERT 
INTO T_Sc
VALUES('20150107','201300010008',98);
INSERT 
INTO T_Sc
VALUES('20150206','201300010008',89);

INSERT 
INTO T_Sc
VALUES('20150107','201300010009',61);
INSERT 
INTO T_Sc
VALUES('20150206','201300010009',73);

INSERT 
INTO T_Sc
VALUES('20150107','201300010010',66);
INSERT 
INTO T_Sc
VALUES('20150206','201300010010',76);



INSERT 
INTO T_Sc
VALUES('20150108','201300020001',95);
INSERT 
INTO T_Sc
VALUES('20150209','201300020001',75);

INSERT 
INTO T_Sc
VALUES('20150108','201300020002',55);
INSERT 
INTO T_Sc
VALUES('20150209','201300020002',45);


INSERT 
INTO T_Sc
VALUES('20150108','201300020003',85);
INSERT 
INTO T_Sc
VALUES('20150209','201300020003',78);


INSERT 
INTO T_Sc
VALUES('20150108','201300020004',95);
INSERT 
INTO T_Sc
VALUES('20150209','201300020004',85);


INSERT 
INTO T_Sc
VALUES('20150108','201300020005',78);
INSERT 
INTO T_Sc
VALUES('20150209','201300020005',85);


INSERT 
INTO T_Sc
VALUES('20150108','201300020006',98);
INSERT 
INTO T_Sc
VALUES('20150209','201300020006',89);

INSERT 
INTO T_Sc
VALUES('20150108','201300020007',91);
INSERT 
INTO T_Sc
VALUES('20150209','201300020007',78);




INSERT 
INTO T_Teacher
VALUES('00010001','��ݼݼ','0001','0001','zjj123');
INSERT 
INTO T_Teacher
VALUES('00020001','����','0002','0002','zy123');


INSERT 
INTO T_Eadm
VALUES('0001','����','zy123');
INSERT 
INTO T_Eadm
VALUES('0002','��С��','lxc123');
INSERT 
INTO T_Eadm
VALUES('0003','�ŷ���','zfy123');


INSERT 
INTO T_Sadm
VALUES('1001','����ҫ','lxy123');
INSERT 
INTO T_Sadm
VALUES('1002','���','lg123');


INSERT 
INTO T_Status
VALUES('2015�괺��','2015���＾','true','true');

--delete from T_Sc where Sno='201300010001' ɾ��ѧ��=������ѡ����Ϣ
--delete from T_Student where Ssex='��'
--delete from T_Teacher where Tno='00010001'
--������1 ɾ��ѧ����Ϣ ɾ����Ӧѡ����Ϣ
go
create trigger tri_student
on T_Student
after delete
as
delete from T_Sc
where Sno in
(select Sno from deleted)
--������2 ɾ����ʦ��Ϣ ɾ����Ӧ�̿���Ϣ �Ͷ�Ӧ�̵Ŀε�ѡ����Ϣ

go
create trigger tri_teacher
on T_Teacher
after delete
as
delete from T_Course
where Tno in
(select Tno from deleted)
delete from T_Sc
where Cno in
(select Cno from T_Course where Tno in(select Tno from deleted))

