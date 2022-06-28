#실습 1) 거래액 데이터 분석
#2017년부터 2021년 3월까지의 전자상거래 추정거래액 (단위 : 백만원)

#1) 데이터 탐색--------------------------------------------------------------

#STEP 1) 모든 컬럼 추출하기
SELECT *
FROM csm_trend

#STEP 2) 특정 컬럼 추출하기

SELECT category, yyyy, mm 
FROM csm_trend

#STEP 3) 중복값 없이 특정 컬럼 추출하기
select distinct category 
from csm_trend 


#2) 특정 연도의 매출 탐색--------------------------------------------------------------
#select DISTINCT category, yyyy 
select DISTINCT yyyy, category 
from csm_trend 

#2-1) 조건이 하나일 때 More Example
####a) 숫자열 (between, 대소비교)
select * 
from csm_trend
WHERE yyyy = 2021 

select * 
from csm_trend
WHERE yyyy >= 2018    


select * 
from csm_trend
WHERE yyyy BETWEEN 2018 and 2019

#다음은 모두 동일한 결과임 !=, <> 같지 않음.
select *
FROM csm_trend 
WHERE yyyy != 2021

select *
FROM csm_trend 
WHERE yyyy <> 2021


####b) 문자열 (=, !=, like, in, not in)
SELECT *
FROM csm_trend 
WHERE category = '가방'

SELECT *
FROM csm_trend 
WHERE category in('컴퓨터 및 주변기기', '가전·전자·통신기기')

SELECT *
FROM csm_trend 
WHERE category NOT in('컴퓨터 및 주변기기', '가전·전자·통신기기')

SELECT *
FROM csm_trend 
WHERE category in('컴퓨터 및 주변기기', '가전·전자·통신기기')

SELECT *
FROM csm_trend 
WHERE category LIKE ('%패션%')

SELECT *
FROM csm_trend 
WHERE category LIKE ('애완%')

SELECT *
FROM csm_trend 
WHERE category not LIKE ('애완%')

##2-2) 조건이 여러개일 때--------------------------------------------------------------
####a) and 조건
SELECT *
FROM csm_trend 
WHERE category LIKE ('애완%')
AND yyyy = 2021

####b) or 조건
SELECT *
FROM csm_trend
WHERE gmv > 1000000 or gmv < 10000

####c) and, or 조건 혼용
SELECT *
FROM csm_trend
#WHERE gmv > 1000000 or gmv < 10000
WHERE (gmv > 1000000 OR gmv < 10000)
AND yyyy = 2020

##3) 카테고리별 매출 분석--------------------------------------------------------------
##More Example) 카테고리별, 연도별 매출
##집계 함수

#SELECT category as cate, yyyy as year_, sum(gmv) as total_gmv
#as 생략 가능
SELECT category cate, yyyy year_, sum(gmv) total_gmv
FROM csm_trend
group by category, yyyy 

SELECT category cate, yyyy year_, sum(gmv) total_gmv
FROM csm_trend
group by 1, 2 # select 절의 컬럼 나열 순서

SELECT category cate, sum(gmv) total_gmv
FROM csm_trend
group by 1  

SELECT yyyy year_, sum(gmv) total_gmv
FROM csm_trend
group by 1

SELECT yyyy year_, sum(gmv) total_gmv
FROM csm_trend
group by yyyy 

SELECT yyyy, mm, platform_type, sum(gmv) total_gmv
FROM csm_trend
group by 1,2,3 

##More Example) 전체 총합
##년도별 gmv 매출 전체 총합
SELECT yyyy, SUM(gmv) total_gmv
from csm_trend
group by 1

##gmv 매출 전체 종합
SELECT SUM(gmv) as total_gmv
from csm_trend

##년도별 집계
SELECT yyyy, SUM(gmv) t_gmv, min(gmv), max(gmv), avg(gmv)
from csm_trend
group by 1

##More Example) 집계함수의 종류
# sum(), min(), max(), avg()

##group by + where 예시
### group by 앞 쪽에 where 절이 옴

SELECT category, yyyy, SUM(gmv) tot_gmv
from csm_trend 
WHERE category ='컴퓨터 및 주변기기'
GROUP BY 1, 2

#### 문제 이해하기
##4)매출이 높은 주요 카테고리만 확인하기--------------------------------------------------------------
SELECT category, yyyy, sum(gmv) as tot_gmv
from csm_trend
WHERE gmv >= 1000000
group by 1, 2

##More Example) where절이랑 같이 쓰기
SELECT category, yyyy , sum(gmv) as tot_gmv
from csm_trend 
group by 1, 2
HAVING sum(gmv) >= 10000000

##5) 매출이 높은 순으로 카테고리 정렬하기--------------------------------------------------------------
SELECT *
from csm_trend 
order by category, yyyy, platform_type 

SELECT category, platform_type, sum(gmv) as tot_gmv 
from csm_trend
group by 1, 2
order by category, tot_gmv DESC 

##내림차순 Example

SELECT category, yyyy, sum(gmv) as tot_gmv 
from csm_trend
group by 1, 2
order by 1, 3 DESC 

SELECT category, yyyy, sum(gmv) as tot_gmv 
from csm_trend
group by 1, 2
order by 1 DESC , 3 DESC 

##[추가 예제 1] 복수의 컬럼으로 정렬

SELECT yyyy, mm, category, sum(gmv) as tot_gmv 
from csm_trend
group by 1, 2, 3
order by 4  DESC   #ASC 


##[추가 예제 2] select 절에 없는 컬럼으로 정렬 가능할까? -> 불가능

#select yyyy, sum(gmv) as tot_gmv
select yyyy, category, sum(gmv) as tot_gmv
from csm_trend
#group by 1
group by 1, 2
ORDER by category 

