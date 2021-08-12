DECLARE @json NVARCHAR(MAX), @firstname nvarchar(30),@lastname nvarchar(30),@phonenumber nvarchar(30),@address nvarchar(30),
@city nvarchar(30),@object nvarchar(30),@quantity nvarchar(30),@rate nvarchar(30) ,@pricevalue nvarchar(30),
@purchasedate datetime
SET @json = N'{
      "customer":[
         {
            "firstName":"Ananthi",
            "lastName":"Velumani",
            "phonenumber":"9876543210",
            "address":"1/172,sathy",
            "city":"Erode",
            "product":[
               {
                  "object":"Pencil",
                  "quantity":"2",
                  "rate":"1",
                  "pricevalue":"2",
                  "purchasedate":"2021-06-20"
               },
			    {
                  "object":"Eraser",
                  "quantity":"2",
                  "rate":"1",
                  "pricevalue":"2",
                  "purchasedate":"2021-06-20"
               }
            ]
         },
         {
            "firstName":"Madhana",
            "lastName":"Ilango",
            "phonenumber":"9876543211",
            "address":"72,sathy",
            "city":"Erode",
            "product":[
               {
                  "object":"Pencil",
                  "quantity":"2",
                  "rate":"1",
                  "pricevalue":"2",
                  "purchasedate":"2021-06-20"
               },
                {
                  "object":"Pen",
                  "quantity":"2",
                  "rate":"1",
                  "pricevalue":"2",
                  "purchasedate":"2021-06-20"
               }
            ]
         },
		 {
            "firstName":"Arvind",
            "lastName":"Chandrasekaran",
            "phonenumber":"9276543212",
            "address":"12,annanagar",
            "city":"Chennai",
            "product":[
               {
                  "object":"Pencil",
                  "quantity":"2",
                  "rate":"1",
                  "pricevalue":"2",
                  "purchasedate":"2021-06-20"
               },
                {
                  "object":"Eraser",
                  "quantity":"2",
                  "rate":"1",
                  "pricevalue":"2",
                  "purchasedate":"2021-06-20"
               }
            ]
         },
		 {
            "firstName":"Sree",
            "lastName":"Parvathi",
            "phonenumber":"9876653210",
            "address":"172,sathya nagar",
            "city":"Erode",
            "product":[
               {
                  "object":"Pencil",
                  "quantity":"2",
                  "rate":"1",
                  "pricevalue":"2",
                  "purchasedate":"2021-06-20"
               },
                {
                  "object":"stapler",
                  "quantity":"2",
                  "rate":"40",
                  "pricevalue":"40",
                  "purchasedate":"2021-06-20"
               }
            ]
         },
		 {
            "firstName":"Ravi",
            "lastName":"Prasath",
            "phonenumber":"9843210789",
            "address":"12,Gandhistreet",
            "city":"Salem",
            "product":[
               {
                  "object":"Pencil",
                  "quantity":"2",
                  "rate":"1",
                  "pricevalue":"2",
                  "purchasedate":"2021-06-20"
               },
                {
                  "object":"Whitener",
                  "quantity":"1",
                  "rate":"15",
                  "pricevalue":"15",
                  "purchasedate":"2021-06-20"
               }
            ]
         },
		 {
            "firstName":"Chandra",
            "lastName":"Lekha",
            "phonenumber":"7896543210",
            "address":"207,KKnagar",
            "city":"Salem",
            "product":[
               {
                  "object":"Pen",
                  "quantity":"2",
                  "rate":"1",
                  "pricevalue":"2",
                  "purchasedate":"2021-06-20"
               },
                {
                  "object":"Pencil-box",
                  "quantity":"2",
                  "rate":"40",
                  "pricevalue":"40",
                  "purchasedate":"2021-06-20"
               }
            ]
         },
		 {
            "firstName":"Chandra",
            "lastName":"Lekha",
            "phonenumber":"7896543210",
            "address":"207,KKnagar",
            "city":"Salem",
            "product":[
               {
                  "object":"Pen",
                  "quantity":"2",
                  "rate":"1",
                  "pricevalue":"2",
                  "purchasedate":"2021-06-20"
               },
                {
                  "object":"Pencil-box",
                  "quantity":"2",
                  "rate":"40",
                  "pricevalue":"40",
                  "purchasedate":"2021-06-20"
               }
            ]
         },
		 
		 {
            "firstName":"Arvind",
            "lastName":"Chandrasekaran",
            "phonenumber":"9276543212",
            "address":"12,annanagar",
            "city":"Chennai",
            "product":[
               {
                  "object":"Pen",
                  "quantity":"2",
                  "rate":"1",
                  "pricevalue":"2",
                  "purchasedate":"2021-06-25"
               },
                {
                  "object":"A4sheet",
                  "quantity":"2",
                  "rate":"4",
                  "pricevalue":"4",
                  "purchasedate":"2021-06-25"
               }
            ]
         },
		 {
            "firstName":"Peri",
            "lastName":"Peri",
            "phonenumber":"9276543888",
            "address":"12,annasalai",
            "city":"Chennai",
            "product":[
               {
                  "object":"Pencil",
                  "quantity":"2",
                  "rate":"1",
                  "pricevalue":"2",
                  "purchasedate":"2021-06-25"
               }
            ]
         }
		  
      ]
}';
---      2nd way: by json_value
declare @demotable table(id int identity,firstName NVARCHAR(30),
lastName NVARCHAR(30),
phonenumber NVARCHAR(30),
address NVARCHAR(30),
city NVARCHAR(30),
object NVARCHAR(30),
quantity NVARCHAR(30),
rate NVARCHAR(30),
pricevalue NVARCHAR(30) ,
purchasedate datetime 
)
insert into @demotable
select  
JSON_VALUE(A.value,'$.firstName') as firstName,
JSON_VALUE(A.value,'$.lastName') as lastName,
JSON_VALUE(A.value,'$.phonenumber') as phonenumber,
JSON_VALUE(A.value,'$.address') as address,
JSON_VALUE(A.value,'$.city') as city,
JSON_VALUE(A.value,'$.product[0].object') as object,
JSON_VALUE(A.value,'$.product[0].quantity') as quantity,
JSON_VALUE(A.value,'$.product[0].rate') as rate,
JSON_VALUE(A.value,'$.product[0].pricevalue') as pricevalue,
JSON_VALUE(A.value,'$.product[0].purchasedate') as purchasedate
from openjson(@json,'$.customer') as A
--select * from @demotable
--------------CURSOR------------
DECLARE db_cursor CURSOR FOR 

SELECT firstname,lastname,phonenumber,address,
city,object,quantity,rate,pricevalue,purchasedate
from @demotable
OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @firstname,@lastname,@phonenumber,@address,@city,@object,@quantity,
@rate,@pricevalue,@purchasedate

WHILE @@FETCH_STATUS = 0  
BEGIN  
 
insert into customers1(firstname,lastname,phonenumber,address,city) values (@firstname,@lastname,@phonenumber,@address,@city)
insert into products1 (object,quantity,rate,pricevalue,purchasedate) values (@object,@quantity,@rate,@pricevalue,@purchasedate)

FETCH NEXT FROM db_cursor INTO @firstname,@lastname,@phonenumber,@address,@city,
@object,@quantity,@rate,@pricevalue,@purchasedate
select firstname,lastname,phonenumber,address,city from customers1
select object,quantity,rate,pricevalue,purchasedate from products1
END 

CLOSE db_cursor  
DEALLOCATE db_cursor 












