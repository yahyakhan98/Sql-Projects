-- How much did movies cost per minute?

select runtime,title, budget,round((budget/runtime) , 0 ) as 'Budget_Per_Minute'
from movie;

-- What is the top-5 movies in terms of budget?

select title, budget
from movie
order by budget desc
limit  5; 

-- In terms of release date, how old is every single movie? show top ten youngest movies
select release_date, title,(year(curdate()) - year(release_date)) as Age
from movie
order by age asc
limit 10;

-- In which years did the producer make a movie?

select distinct year(release_date) as release_date
from movie;

-- What is the bottom-10 popular movies, and which company made them? 

SELECT movie.title, SUM(movie.popularity) as sum_popularity, production_company.company_name
FROM movie
JOIN movie_company ON movie.movie_id = movie_company.movie_id
JOIN production_company ON movie_company.company_id = production_company.company_id
GROUP BY movie.title, production_company.company_name
ORDER BY sum_popularity asc
LIMIT 10;

-- Which movies cost less than 50,000 and what were their genres? Just top-10 

SELECT movie.title, movie.budget, genre.genre_name
FROM movie 
JOIN movie_genres ON movie.movie_id = movie_genres.movie_id
JOIN genre ON movie_genres.genre_id = genre.genre_id
WHERE movie.budget < 50000 
ORDER BY movie.budget DESC
limit 10;

-- Which movie companies invested the budget between 150K to 200K and for which movie?

SELECT movie.title, movie.budget, production_company.company_name
FROM movie 
JOIN movie_company ON movie.movie_id = movie_company.movie_id
JOIN production_company ON movie_company.company_id = production_company.company_id
WHERE movie.budget BETWEEN 150000 AND 200000 
ORDER BY budget DESC;


-- which director did make the most popular movie in English and French language?

SELECT language.language_name, person.person_name, COUNT(*) as movie_count, MAX(movie.popularity) as max_popularity
FROM movie
join movie_crew on movie.movie_id = movie_crew.movie_id
join person on movie_crew.person_id = person.person_id
join movie_languages on movie.movie_id = movie_languages.movie_id
join language on movie_languages.language_id = language.language_id
GROUP BY language.language_name, person.person_name
having language.language_name IN ('English','Latin') 
limit 5;

-- 	Make a list of actors(actress) who played after the year 2010.

select person.person_name, movie.title, movie_crew.job 
from movie
join movie_crew on movie.movie_id = movie_crew.movie_id
join person on movie_crew.person_id = person.person_id
where movie_crew.job = "Characters" and release_date > "2010-01-01"
GROUP BY person.person_id, movie.title, movie_crew.job;