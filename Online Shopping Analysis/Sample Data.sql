-- Print details of sales where amount are > 20000 and Boxes are < 100
    select *
    from sales
    where Amount > 2000 and Boxes < 100;
    
    -- How many sales did each of Salepersons have in january 2022 ?
       select sum(s.Amount), p.Salesperson
       from sales s
       right join people p on s.SPID = p.SPID
       where year(s.SaleDate) = 2022 and month(s.SaleDate) = 01
       group by p.Salesperson;
        
        -- Which product sells more boxes?
         Select sum(s.Boxes), pr.product
         from sales s
         inner join products pr on s.PID = pr.PID
	     group by pr.product
         order by sum(s.Boxes);
         
         -- Which product sold more boxes in first 7 days of febuary 2022 ?
         select sum(s.Boxes), p.Product
from sales s 
	right join products p on s.PID = p.PID
		where year(s.SaleDate) = 2022 and month(s.SaleDate) = 02 and day(s.SaleDate) between 01 and 07
	group by p.Product
    order by sum(s.Boxes) desc;
    
    -- Q5-Which sales had under 100 customers & 100 boxes? Did any of them occur on Wednesday?
select *,
	case when Customers < 100 and Boxes < 100 and weekday(SaleDate) = 2 then "OK"
		else "Not Ok"
    end as "Result"
from sales
order by Result desc;
    
    