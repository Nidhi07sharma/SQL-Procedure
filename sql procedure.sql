create database sql_procedure_process;
use sql_procedure_process;
create table Product (ProductID int,Product_Name varchar(100));
create table ProductDescription (ProductID int,ProductDescription varchar(800));
insert into Product values (106,"HL Road Frame- Black, 58");
insert into Product values (178,"HL Road Frame- Red, 58");
insert into Product values (687,"Sport-100 Frame- Black, 8");
insert into Product values (992,"Metallic Road Frame- Red, 34");
Desc Product;
select *from Product;
insert into ProductDescription values (106,'Replacement mountain wheel for entry-level rider.')
,(178,'Sturdy alloy features a quick-release hub.')
,(687,'Aerodynamic rims for smooth riding.'),(992,'Slick black');
select *from ProductDescription;
Drop  table ProductDesciption;
##creating a simple stored procedure##
DELIMITER //

DROP PROCEDURE IF EXISTS GetProductDesc;

CREATE PROCEDURE GetProductDesc()
BEGIN
    SELECT P.ProductID, P.Product_Name, PD.ProductDescription
    FROM Product P
    INNER JOIN ProductDescription PD ON P.ProductID = PD.ProductID;
END //

DELIMITER ;
CALL GetProductDesc();
DROP PROCEDURE IF EXISTS GetProductDesc;
#creating a procedure with in parameter
DELIMITER //

CREATE PROCEDURE GetProductDesc(in in_ProductID int)
BEGIN
    SELECT P.ProductID, P.Product_Name, PD.ProductDescription
    FROM Product P
    INNER JOIN ProductDescription PD ON P.ProductID = PD.ProductID
    WHERE P.ProductID = in_ProductID;
END //

DELIMITER ;
CALL GetProductDesc(106);
##creating procedure with default parameter values
select *from Product;
DROP PROCEDURE IF EXISTS GetProductDesc;
DELIMITER //
Drop table author;
create table author (author_id integer primary key, 
                            authorName varchar(30), 
                            email varchar (25), gender varchar (6));
create table book (BookId integer not null unique, 
                        ISBN integer primary key, 
                       book_name varchar (30) not null, 
                        author integer, ed_num integer, 
                      price integer, pages integer, 
         foreign key (author) references author (author_id) on delete cascade);
         
         
insert into author values 
              (1, "Kraig Muller", "Wordnewton@gmail.com", "Male");
insert into author values
              (2, "Karrie Nicolette", "karrie23@gmail.com", "Female");
insert into book values
              (1, 001, "Glimpses of the past", 1, 1, 650, 396);
insert into book values
              (2, 002, "Beyond The Horizons of Venus", 1, 1, 650, 396);
insert into book values
              (3, 003, "Ultrasonic Aquaculture", 2, 1, 799, 500);
insert into book values
              (4, 004, "Cryogenic Engines", 2, 1, 499, 330);          
select *from author; 
select *from book;      
drop procedure if Exists update_price;       
delimiter //
create procedure update_price (IN temp_ISBN varchar(10), IN new_price integer)
                begin
                update book set price=new_price where ISBN=temp_ISBN;
                end; 
//
call update_price(001, 700);
delimiter ;

##procedure with out parameter
delimiter //
create procedure disp_max(OUT highestprice integer)
                 begin
                 select max(price) into highestprice from book;
                 end; 
//
call disp_max(@M);
delimiter ;