USE PRACTICE1
/*1- Mostrar todas las ordenes (sales.orders) presentando los campos:
 OrderId, OrderDate formato (dd/mm/yyyy), fecha requerida (dd/mm/yyyy), custId.*/
 --Use TSQL2012 
 SELECT
 OrderId,
 orderdate,
 requireddate,
 format (orderdate, 'd','es-es') as 'Orderdate Modified',
 format (requireddate, 'd','es-es') as 'Requereddate Modified',
 custid
 FROM sales.orders;
 SELECT * FROM sales.Orders
 /*2- Mostrar todas las ordenes (sales.orders) presentando los campos
 OrderId, OrderDate formato (dd/mm/yyyy), fecha requerida (dd/mm/yyyy),
  custId, cuando (where) el pa�s de la orden sea Germany.*/
SELECT
	OrderId,
	format (orderdate, 'd','es-es') as 'OrderdateN',
	format (requireddate, 'd','es-es') as 'RequereddateN',
	custid
FROM sales.orders
WHERE shipcountry = 'Germany';
 
 /*3- Mostrar las ordenes (sales.orders) cuando (where) el campo shipaddress 
 contenga la palabra Sh.*/
SELECT *
FROM sales.orders
WHERE shipaddress like '%sh%';
--(EXTRA)Y para buscar el indice de la palabra a buscar
SELECT
	CHARINDEX('sh', shipaddress)
FROM sales.orders 
WHERE shipaddress like '%sh%';

/*4- Realizar una consulta mostrando las ordenes (sales.orders) cuando el campo shipaddress inicie con la palabra Sh.*/
SELECT * FROM sales.orders where shipaddress like 'sh%';

/*5- Realizar una consulta mostrando las �rdenes (sales.orders) cuando el freight sea mayor a 30 y menor 40.
Operador (AND) para poder tener dos filtros en el where.*/
SELECT * FROM sales.orders where freight > 30 AND freight < 40;

/*6- Realizando una consulta mostrando la cantidad de �rdenes
(sales.orders) con freight mayor a 40 y shipperId a 1 o 2 o 3*/
SELECT * FROM sales.orders where freight > 500 AND (shipperid = 1 or shipperid = 2 or shipperid = 3);

/*7- Realizar una consulta mostrando las �rdenes (sales.orders)
con freight Mayor a 30 y shipperid 1 y 2*/
SELECT * FROM sales.orders where freight > 30 AND (shipperid = 1 or shipperid = 2);

/*7-1 Mostrar una consulta de ordenes �rdenes (sales.orders) con freight menor a 20 y shipperid igual a 3.
(Nota: tienes punto adicional si puedes combinar en 1 solo query las consultas 7 y 7-1).*/
SELECT * FROM sales.orders where freight < 20 AND shipperid = 3;

/*8- Realizar una consulta de las ordenes tabla Sales.Orders mostrando el OrderId,
orderdate formato (mm/dd/yyyy),fecha actual formato (mm/dd/yyyy) y a su vez un campo 
donde se visualicela cantidad de d�as que paso desde el orderdate hasta la fecha de hoy, 
y un campo que muestre la cantidad de d�as que paso desde el orderDate hasta el shippedDate.
, Mostrar en un campo lo siguiente: si el shippedDate es mayor al requiredDate devolver 
�No puntual� de lo contrario �Puntual�.*/

SELECT orderid,format (orderdate, 'd','es-es') as 'OrderdateN' FROM sales.orders where freight < 20 AND shipperid = 3;
SELECT * FROM sales.Orders;

/*9- Realizar una consulta mostrando el orderdate de la tabla sales.orders separado
 (una columna para Dias, una para Meses, una para anos)*/
 SELECT * FROM sales.orders;

 /*10-Mostrar la cantidad de sales.customers cuando el contacttitle sea Owner.*/

SELECT count(contacttitle) as Cantidad_Clientes FROM sales.Customers where contacttitle = 'Owner';
SELECT * FROM sales.Customers where contacttitle = 'Owner';

/*11- Mostrar de la tabla sales.customers en una sola columna la uni�n del contacttitle,
y del contact name el nombre que esta despu�s de la �,�. Ejemplo: Contacttitle = Owner,
ContactName=Allen, Michael Resultado= Owner Michael*/

SELECT contactname, contacttitle, contactname + ' ' + contacttitle as concatenacion  FROM sales.Customers;

/*12- Mostrar de la tabla sales.customers su campo custid,CompanyName sin el texto Customer, y del campo phone: Reemplazar
los puntos por guiones. Con un 1 � delante ejemplo (1- (5) 456-7890), del campo Fax: si el valor es nulo mostrar el texto �N/A�.*/

--SELECT custid,companyname, phone,fax FROM sales.Customers where fax = 'NULL'

/*14- De la tabla Sales.OrderDetails mostrar los campos, orderid, productId, unitPrice,qty, discount,
Calcular un nuevo campo llamado total que ser� el resultado de unitPrice*qty � (unitPrice*qty* Discount).*/

SELECT orderid, productid,unitprice,qty,discount, unitprice*qty - (unitprice*qty*discount) as total FROM Sales.OrderDetails

/*Mostrar un nuevo campo que sea igual a, si Qty < 10 entonces mostrar �Producto Agotado� de lo contrario �Producto en existencia�.*/

SELECT orderid,productid,unitprice,qty,discount FROM sales.OrderDetails

Begin
declare @new int;
SELECT
@new= qty
FROM
sales.OrderDetails
	if @new < 10
	begin
		SELECT orderid,productid,unitprice,qty,discount, 'Producto agotado' as state FROM sales.OrderDetails
	end
	else
	begin
	SELECT orderid,productid,unitprice,qty,discount, 'Producto en existencia' as state FROM sales.OrderDetails
	end
end


/*15- Mostrar la columna productID de Production.Products a�adiendo 8 ceros delante, tomando en
cuenta el siguiente patr�n vimos en clase:
00000000
00000001
00000010
00000100*/

SELECT RIGHT('00000000' + Ltrim(Rtrim(productid)),8) as productid FROM Production.Products

/*16- Utilizando la columna shipRegion de la tabla sales.orders mostrar la cantidad de �rdenes en la tabla.*/

SELECT count(shipregion) as CantShipregio FROM sales.Orders

/*17- Realizar una consulta a la tabla orders mostrando el orderid,custid,empid, orderdate, requireddate y shippeddate.
adicional a esto usted debe hacer lo necesario para poder mostrar lo siguiente: 
? Si la diferencia de d�as que existe entre el orderdate y required date es igual a 28 o 29 entonces mostrar 'SLA DE
3 SEMANAS', si es igual a 14 o 15 mostrar 'SLA 2 SEMANAS'.
? Si es igual a 42 mostrar 'SLA DE 4 SEMANAS' y si no cumple con ninguna de las anteriores mostrar 'N/A'*/

SELECT orderid, empid, orderdate, requireddate, shippeddate,
DATEDIFF(DAY, orderdate, requireddate) as LosDiasTrascurridos,
iif(DATEDIFF(DAY, orderdate, requireddate) between 14 and 15,'SLA 2 SEMANAS',
iif(DATEDIFF(DAY, orderdate, requireddate) between 28 and 29,'SLA 3 SEMANAS',
iif(DATEDIFF(DAY, orderdate, requireddate) = 42 ,'SLA 4 SEMANAS',
iif(DATEDIFF(DAY, orderdate, requireddate) > 42, 'N/A','N/A')))) as Semanas  FROM Sales.Orders

/*18- Realizar una consulta mostrando los productos y su respectiva categor�a (categoryName)*/

SELECT categoryName FROM Production.Products, Production.Categories

/*19- mostrar el top de los 15 �ltimos productos creados mostrando el orderDate, requireddate y shippeddate
utilizando un formato de fecha distinto para cada uno*/

SELECT  Top 15 
format (orderdate,'d', 'SI') as OrderDate,
format (requireddate,'d', 'es-ES') as RequiredDate, 
format (shippeddate,'d', 'en-US') as ShippedDate
FROM Production.Products, Sales.Orders
ORDER BY productname desc

/*20-tomando en cuenta que tenemos la tabla sales.orders y sales.orderdetails usted debe hacer lo 
necesario para podermostrar el total de las ventas realizadas, agrup�ndolas de la siguiente forma:
AnoOrden, MesOrden, Total*/

SELECT YEAR(orderdate) as A�oOrden, MONTH(orderdate) as MesOrden, 
sum(unitprice * qty) as Total FROM Sales.OrderDetails, Sales.Orders
GROUP BY MONTH(orderdate), YEAR(orderdate)

--21- Dado los siguientes querys usted debe ejecutar cada uno si existe alguna diferencia entre los resultados debe
--explicarla:
--1
SELECT Emp.empid,
Emp.firstname+' '+Emp.lastname as Empleado,
cust.contactname,
o.orderid,
O.orderdate
FROM hr.Employees Emp inner join sales.Orders O
on emp.empid = o.empid
left join sales.Customers Cust
on Cust.custid = o.custid
ORDER BY empid desc
--2
SELECT Emp.empid,
Emp.firstname+' '+Emp.lastname as Empleado,
cust.contactname,
o.orderid,
O.orderdate
FROM hr.Employees Emp inner join sales.Orders O
on emp.empid = o.empid
right join sales.Customers Cust
on o.custid = Cust.custid
ORDER BY empid asc
-- el orden diferente ascendente y decendente,  el uso de left y right joins

 /*22- Dada la tabla stats.score realizar lo siguiente:
a-Mostrar cada examen.
b-Mostrar la cantidad de estudiantes que hay por cada examen.
c-Mostrar la cantidad de estudiantes que aprobaron el examen. Logica:(si el score es mayor o igual a 70 )
*/

SELECT distinct testid as Test, count (studentid) as Students,(SELECT count (studentid) FROM Stats.Scores 
where score >=70) as Nota FROM Stats.Scores
GROUP BY testid


SELECT DATEDIFF(month, '2007-01-01', getdate());

/* 24- Mostrar en un resultado los campos empid, FullName empleado (HR.EMPLOYEES) mostrando la primera 
y ultima orden este empleado creo. Los empleados no deben salir duplicados. */

SELECT distinct firstname +' ' + lastname as FullNameEmpleado, A.empid, 
orderdate FROM HR.Employees, sales.Orders A

/*25- Mostrar en un resultado los campos empid, FullName empleado (HR.EMPLOYEES) mostrando el producto con el
precio m�nimo y el producto con el precio m�ximo para la primera orden el empleado creo*/
SELECT distinct  firstname +' '+lastname as fullNameEmpleado , A.empid, orderdate , productname, unitprice 
FROM HR.Employees,Sales.Orders A, Production.Products
where   unitprice = (SELECT MIN(Products.unitprice) FROM production.Products)
or unitprice = (SELECT MAX(Products.unitprice) FROM production.Products)

/*26- Mostrar los suplidores (Production.suppliers) cuando el campo contacttitle Contenga la literal
'Manag'*/ 

SELECT * FROM Production.Suppliers
where contacttitle like '%manag%'


/*27- tomando la tabla suppliers nos fijamos el companyName viene bajo el patron 
supplier Codigo, tomando esto en cuenta separar el companany name mostrando en una 
columna el Supplier y  en otra el literal restante sin espacio.*/ 

SELECT supplierid ,SUBSTRING(companyname,0,9) as Supplier ,SUBSTRING(companyname,10,8) as Codigo, 
contactname, contacttitle, address, city, region, postalcode, country, phone, fax 
FROM Production.Suppliers


/*28- tomando la tabla products y Suppliers mostrar los campos supplierid, contactname, 
el producto con el precio mayor para cada suplidor, la cantidad de productos total de 
ese suplidor y la cantidad de productos que poseen orden creada. Para los ejercicios que 
busquen el minimo y m�ximo deben saber que pueden hacer filtros contra minimo y m�ximo en
su sentencia where.*/
SELECT  Production.ProductS.supplierid, Production.Suppliers.contactname, Production.ProductS.productname,
(SELECT MAX(unitprice)  FROM Production.Products) as MAYorPrecio,
(SELECT COUNT(productid)  FROM Production.Products) as CantidadProduct, 
(SELECT COUNT(productid)  FROM Sales.OrderDetails) as  cantOrden
FROM Production.Suppliers
inner join Production.Products on Production.ProductS.supplierid = Production.Suppliers.supplierid
GROUP BY Production.Products.supplierid, Production.ProductS.productname, Production.Suppliers.contactname
ORDER BY Production.Products.supplierid, Production.Suppliers.contactname, Production.ProductS.productname


/*29- Mostrar una consulta la cantidad de empleados que hay por pa�s usar tabla employees,
country.*/ 
SELECT country, count(empid) as cantidad FROM HR.Employees
GROUP BY country

/*30- Mostrar los pa�ses de las ordenes (tabla orders shipcountry) y la cantidad de clientes Que ha creado
ordenes. usar shipcountry*/

SELECT shipcountry, COUNT(custid) as cantidadClientes FROM Sales.Orders
GROUP BY shipcountry 
ORDER BY shipcountry asc

/*31- la cantidad de �rdenes por pa�s. usar shipcountry */

SELECT shipcountry, COUNT(orderid) as cantidadOrdenes FROM Sales.Orders
GROUP BY shipcountry 

/*32- Mostrar los empleados id, nombre y la cantidad de �rdenes que ha creado.
usar employees y orders.*/
SELECT Sales.Orders.empid, firstname+' '+lastname as FullName, count(orderid) as CantOrdenes 
FROM sales.orders
inner join HR.Employees on HR.Employees.empid = Sales.Orders.empid
where Sales.Orders.empid = HR.Employees.empid
GROUP BY Sales.Orders.empid, firstname, lastname