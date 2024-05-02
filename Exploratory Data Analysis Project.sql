-- Project 2 Exploratory data analysis
select * from layoffs_staging2;

select MAX(total_laid_off),MAX(percentage_laid_off)
 from layoffs_staging2;


select * from layoffs_staging2 where percentage_laid_off=1
order by total_laid_off desc;

select company,sum(total_laid_off)
from layoffs_staging2 group by company
order by 2 desc;

select industry,sum(total_laid_off)
from layoffs_staging2 group by industry
order by 2 desc;

select `date`,sum(total_laid_off)
from layoffs_staging2 group by `date`
order by 2 desc;

-- which year has more layoffs!!
select year(`date`),sum(total_laid_off)
from layoffs_staging2 group by year(`date`)
order by 2 desc;

-- which stage has more layoffs!!
select stage,sum(total_laid_off)
from layoffs_staging2 group by stage
order by 1 desc;

-- checking the percentages
select company,sum(percentage_laid_off)
from layoffs_staging2 group by company
order by 2 desc;

-- based on the months
select substring(`date`,6,2) as Month,sum(total_laid_off)
from layoffs_staging2
group by `month`
order by 1 asc;

select substring(`date`,1,7) as `MONTH`,sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7)  is not null
group by `MONTH`
order by 1 asc;

-- USING CTEs 
with rolling_total as 
(select substring(`date`,1,7) as `MONTH`,sum(total_laid_off) as total_layoffs
from layoffs_staging2
where substring(`date`,1,7)  is not null
group by `MONTH`
order by 1 asc)

select `MONTH`,total_layoffs,
sum(total_layoffs) over(order by `MONTH`)
FROM rolling_total;

-- finding by year for each company
select company,year(`date`),sum(total_laid_off)
from layoffs_staging2 group by company, year(`date`)
order by 3 desc;

-- ranking companies based on layoffs
with company_ranking (company,years,layoffs) as
(
select company,year(`date`),sum(total_laid_off)
from layoffs_staging2 group by company, year(`date`)
),Company_top_ranks as
(
select *,rank() over(partition by years order by layoffs desc) as `rank`
from company_ranking
where years is not null
)
select *
from Company_top_ranks
where `rank`<=5;