
-- Shows likelihood of a person would be died in case of she has been infected?
SELECT location, SUM(dead) AS dead, SUM(infected) as infected, (SUM(dead)/SUM(infected) * 100) AS dead_infected_likelihood
FROM covid_info
-- WHERE location LIKE "canada"
GROUP BY location
ORDER BY dead_infected_likelihood asc;


-- Shows likelihood of a person would be died in case of she has been vaccinated?
SELECT location, SUM(dead) AS dead, SUM(vaccinated) as vaccinated, (SUM(dead)/SUM(vaccinated) * 100) AS dead_vaccinated_likelihood
FROM covid_info
-- WHERE location LIKE "canada"
GROUP BY location
ORDER BY dead_vaccinated_likelihood desc;


-- Shows likelihood of a person would be infected in case of she has been vaccinated?
SELECT location, SUM(infected) AS infected, SUM(vaccinated) as vaccinated , (SUM(infected)/SUM(vaccinated) * 100) AS infected_vaccinated_likelihood
FROM covid_info
GROUP BY location
ORDER BY infected_vaccinated_likelihood desc;

-- Which country does have the highest death rate compare to population?
SELECT location, population, SUM(dead) AS dead, (SUM(dead)/population * 100) AS Highest_rate
FROM covid_info
GROUP BY location, population
ORDER BY Highest_rate desc;


-- Which country does have the highest infection rate compare to population?
SELECT location, (total_infected / total_population) as infection_rate
FROM (
    SELECT location, SUM(infected) as total_infected, MAX(population) as total_population
    FROM covid_info
    GROUP BY location
) as subquery
ORDER BY infection_rate DESC
LIMIT 1;