/*

Shark Tank India Data Exploration

Skills used: Joins, Union, Create Table, Drop Table, Windows Functions, Aggregate Functions

*/


select * from ProjectSharkTank..data


--total epidose

select max(epno) from ProjectSharkTank..data

select count(distinct epno) from ProjectSharkTank..data


--pitches 

select Count(distinct brand) from ProjectSharkTank..data


-- pitches converted

select sum(a.converted_not_converted) funding_received, count(*) total_pitches from
(select amountInvestedlakhs, case when amountInvestedlakhs>0 then 1 else 0 end as converted_not_converted from ProjectSharkTank..data) a


-- success percentage

select cast(sum(a.converted_not_converted)as float) /cast(count(*)as float) from
(select amountInvestedlakhs, case when amountInvestedlakhs>0 then 1 else 0 end as converted_not_converted from ProjectSharkTank..data) a


-- total male

select sum(male) from ProjectSharkTank..data


-- total female

select sum(female) from ProjectSharkTank..data


-- gender ratio

select sum(female)/sum(male) from ProjectSharkTank..data


-- total invested amount

select sum(AmountInvestedlakhs) from ProjectSharkTank..data


--avg equity taken

select avg(equitytakenP) from
(select* from ProjectSharkTank..data where equitytakenP>0) a


-- highest deal taken

select max(amountinvestedlakhs) from ProjectSharkTank..data


-- highest equity taken by shark

select max(equitytakenP) from ProjectSharkTank..data


--startup having atleast one women

select sum(a.female_count) startup_atleast_one_female from
(select female, case when female>0 then 1 else 0 end as female_count from ProjectSharkTank..data) a


-- pitches converted having atleast one female

select sum(b.female_count) from
(select case when a.female>0 then 1 else 0 end as female_count, a.* from
(select * from ProjectSharkTank..data where deal != 'No deal') a) b


-- avg teammembers

select avg(teammembers) from ProjectSharkTank..data


-- amount invested per deal

select avg(a.AmountInvestedlakhs) amount_invested_per_deal from
(select * from ProjectSharkTank..data where deal!= 'no deal') a


-- avgage group of contestants

select avgage, count(avgage) cnt from ProjectSharkTank..data group by avgage order by cnt desc


-- location group of contestants

select location, count(location) cnt from ProjectSharkTank..data group by location order by cnt desc


-- location group of contestants

select sector, count(sector) cnt from ProjectSharkTank..data group by sector order by cnt desc


-- partners deals

select partners, count(partners) cnt from ProjectSharkTank..data where partners != '-' group by partners order by cnt desc


--making the matrics

select 'Ashneer' as keyy, count(ashneeramountinvested) from ProjectSharkTank..data where ashneeramountinvested is not null

select 'Ashneer' as keyy, count(ashneeramountinvested) from ProjectSharkTank..data where ashneeramountinvested is not null and ashneeramountinvested !=0

select 'Ashneer' as keyy, sum(c.ashneeramountinvested), avg(c.ashneerequitytakenP) from 
(select * from ProjectSharkTank..data where ashneerequitytakenP != 0 and ashneerequitytakenP is not null) c


-- making matrices for ashneer by joining above three table

select m.keyy, m.total_deals_present, m.total_deals, n.total_amount_invested, n.avg_equity_taken from
(select a.keyy, a.total_deals_present, b.total_deals from
(select 'Ashneer' as keyy, count(ashneeramountinvested) total_deals_present from ProjectSharkTank..data where ashneeramountinvested is not null) a
inner join
(select 'Ashneer' as keyy, count(ashneeramountinvested) total_deals from ProjectSharkTank..data 
where ashneeramountinvested is not null and ashneeramountinvested !=0) b
on a.keyy= b.keyy) m

inner join
(select 'Ashneer' as keyy, sum(c.ashneeramountinvested) total_amount_invested, avg(c.ashneerequitytakenP) avg_equity_taken from 
(select * from ProjectSharkTank..data where ashneerequitytakenP != 0 and ashneerequitytakenP is not null) c) n

on m.keyy=n.keyy


-- The startup in which highest amount invested

select c.* from
(select brand, sector, amountinvestedlakhs, rank() over(partition by sector order by amountinvestedlakhs desc) rnk
from ProjectSharkTank..data) c
where c.rnk = 1
