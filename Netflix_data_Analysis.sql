Create Database NetFlixDB;
use netflixDb;
select * from netflix_data;

# Q1. List the Top 10 Movies with Highest Average Rating.
 select Title,Avg(IMDB_SCORE) as Highest_Rating from netflix_data 
 group by title
 order by Highest_rating DESC
 LIMIT 10;
 
# Q2. Calculate the Percentage(%) of movie that belong to each genre in the Database.
      select * from netflix_data;
      select genre, count(*) as Movie_count,
      (count(*)*100.0)/(select count(*) from Netflix_data) as percentage
      from Netflix_data
      group by genre
      order by percentage DESC;
      
# Q3. Rank the Movie & Tv Series on the Basis of their IMBD Score
    select * from netflix_data;
    select title,type,imdb_score,
    DENSE_RANk() over ( order by IMDB_Score DESc) as Rnk
    from netflix_data
    Order by IMDB_Score DESC;
    
# Q4. Find Which Country Have the Highest and lowest movie make.

SELECT production_countries
FROM (
  SELECT production_countries, COUNT(*) AS Tv_series_Count,
         RANK() OVER (ORDER BY Tv_series_Count DESC) AS rank_highest,
         RANK() OVER (ORDER BY Tv_series_Count ASC) AS rank_lowest
  FROM Netflix_data
  GROUP BY production_countries
) AS Tv_series_Count
WHERE rank_highest = 1 OR rank_lowest = 1;

     
# Q5. Find the Average Rating for the movie that belong to Multiple Genres.
use netflixdB;
select genre,
       round(avg(imdb_score),2) as avg_rating from netflix_data
group by genre
order by avg_rating DESC;

# Q6. Categories the Genre on the According to Age-Certification.
          select * from netflix_data;
          Select 
          CASE WHEN Age_certification <='PG' then 'Children'
		  WHEN Age_certification = 'PG-13' then 'Teen'
          WHEN Age_certification IN('R','TV-Y') then 'Adult'
          ELSE 'Unknown'
          END as age_category,genre,
          Count(*) as genre
          from netflix_data
          group by Age_certification,genre
          Order by Genre DESC;

          
# Q7. Find the 2nd highest Movie that are made in Year 2013.
WITH rankedmovies as (
  select title, release_year, imdb_score
  from Netflix_data
  where release_year = 2013
  order by  imdb_score DESC
)
select title,imdb_score
from RankedMovies
limit 1 ,1;





