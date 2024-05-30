select * from  layoffs;
 
 -- 1 Remove duplictes
 -- 2 Standerize the data
 -- 3 Null values or bloank column
 -- 4 Remove Any Columns
 
 -- 1 Remove duplictes
 Create table layoffs_staging  
 like layoffs;
 
 select * from  layoffs_staging;
 
 insert  layoffs_staging
 select * 
 from layoffs;
 
 select *,
 row_number() over(
 partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country,  funds_raised_millions) as row_num
 from layoffs_staging;
 
 With dublicate_cte As
 (
 select *,
 row_number() over(
 partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country,  funds_raised_millions) as row_num
 from layoffs_staging
 )
 select *
 from dublicate_cte
 where row_num > 1;
 
 select*
 from layoffs_staging
 where company = 'Casper';
 
 CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   `row_num` int  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 select * 
 from  layoffs_staging2;
 
 insert into layoffs_staging2
 select *,
 row_number() over(
 partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country,  funds_raised_millions) as row_num
 from layoffs_staging;
 
 select*
 from layoffs_staging2
 where company = row_num > 1 ;
 
 delete
 from layoffs_staging2
 where company = row_num > 1 ;

select * 
 from  layoffs_staging2;
 
 
  -- 2 Standerize the data
  
  select company, trim(company)
  from layoffs_staging2;
 
 update layoffs_staging2
 set company = trim(company);
 
 select *
 from  layoffs_staging2
 where industry like 'crypto%';
 
 update layoffs_staging2
 set industry = 'crypto'
 where industry like 'crypto%';
 
select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%' ;

select 	`date`
FROM layoffs_staging2;

update layoffs_staging2
set  `date`= STR_TO_DATE(`date` , '%m/%d/%Y');

Alter table layoffs_staging2
modify column `date` DATE;


 -- 3 Null values or bloank column
 
select *
from layoffs_staging2 t1
join layoffs_staging2 t2
      on t1.company = t2.company
where (t1.industry is  null or t1.industry = '')
and t2.industry is not null;


update  layoffs_staging2 t1
join layoffs_staging2 t2
      on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is  null
and t2.industry is not null;

Update layoffs_staging2
set industry = null
where industry = ''; 

 select *
 from layoffs_staging2
 where total_laid_off is null
 and percentage_laid_off is null;
 
 
DELETE
 from layoffs_staging2
 where total_laid_off is null
 and percentage_laid_off is null;
 
-- 4 Remove Any Columns
select *
 from layoffs_staging2;
 
 alter table layoffs_staging2
 drop column row_num;
 
 


