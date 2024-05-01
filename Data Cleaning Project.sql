select * from layoffs;
create table layoffs_staging
like layoffs;
select * from layoffs_staging;

insert layoffs_staging
select * from layoffs;


with duplicate_rem as 
(
select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
 from layoffs_staging
 )
 select * from duplicate_rem
 where row_num>1;
 
 delete from duplicate_rem
 where row_num>1;
 
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
 
 select * from layoffs_staging2;
 
 insert into layoffs_staging2
 select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
 from layoffs_staging;
 
 select * from layoffs_staging2
 where row_num>1; 





delete from layoffs_staging2
 where row_num>1; 
 
 select * from layoffs_staging2
 where row_num>1;
 
 delete from layoffs_staging2
 where row_num>1;
 
 delete from layoffs_staging2
 where row_num>1;
 
 delete from layoffs_staging2
 where row_num>1;
 
 select * from layoffs_staging2;
 
 SELECT *,
    COUNT(*) AS CNT
FROM layoffs_staging
GROUP BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions
HAVING COUNT(*) > 1;

delete
    FROM layoffs_staging2
    WHERE row_num NOT IN
    (
        SELECT MAX(row_num)
        FROM layoffs_staging2
        GROUP BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions
        );


DELETE FROM layoffs_staging2
    WHERE row_num NOT IN
(
        SELECT MAX(row_num) 
        FROM layoffs_staging2
        GROUP BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions
	);



DELETE FROM layoffs_staging2
WHERE row_num NOT IN (
    SELECT max_row_num
    FROM (
        SELECT MAX(row_num) as max_row_num
        FROM layoffs_staging2
        GROUP BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
    ) AS subquery_alias
);

SET sql_safe_updates = 0;

select company ,trim(company) from layoffs_staging2;

 
update layoffs_staging2
set company = trim(company);

select distinct industry from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';




select distinct country,trim(trailing '.' from country)
FROM layoffs_staging2
order by 1;

update layoffs_staging2
set country=trim(trailing '.' from country)
where country like 'United States%';


select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`,'%m/%d/%Y');


alter table layoffs_staging2
modify column `date` DATE;

SELECT * from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

select * from layoffs_staging2
where company='B';

select * from layoffs_staging2
where industry is null or industry='';

select * from layoffs_staging2 t1 join layoffs_staging2 t2 on 
t1.company=t2.company
where t1.industry is null and t2.industry is not null;

update layoffs_staging2 t1 join layoffs_staging2 t2 on 
t1.company=t2.company
set t1.industry = t2.industry 
where t1.industry is null and t2.industry is not null;

select * from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

delete from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;


alter table layoffs_staging2
drop column row_num;




 

