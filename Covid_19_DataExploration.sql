/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables,  Aggregate Functions, Creating Views, Converting Data Types

*/

select *
from `unified-post-402918.Covid_19_project.CovidDeaths`
order by 3, 4


select *
from `unified-post-402918.Covid_19_project.CovidVaccinations`
order by 3, 4

--gather data that we are using in our analysis

select location, date, total_cases, new_cases,total_deaths, population
from `unified-post-402918.Covid_19_project.CovidDeaths`
order by 1,2

-- finding out total cases vs total deaths

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 As DeathPercentage
from `unified-post-402918.Covid_19_project.CovidDeaths`
order by 1,2

-- find out for usa
-- chances of death if you contract covid
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 As DeathPercentage
from `unified-post-402918.Covid_19_project.CovidDeaths`
where location like "%States%"
order by 1,2

-- looking for over all population
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 As DeathPercentage
from `unified-post-402918.Covid_19_project.CovidDeaths`
--where location like "%States%"
order by 1,2

-- Total cases vs population in us
-- look for what percentage of population got covid

select location, population,  total_cases, total_deaths, (total_deaths/population)*100 As DeathPercentage
from `unified-post-402918.Covid_19_project.CovidDeaths`
where location like "%States%"
order by 1,2

--looking for countries with Highest Infection rate compare to population
select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 As PercentPopulationInfected
from `unified-post-402918.Covid_19_project.CovidDeaths`
--where location like "%States%"
group by location, population
order by PercentPopulationInfected desc


--looking for countries with Highest Death per population
select location, MAX(CAST(total_deaths AS INT64)) as TotalDeathCount
from `unified-post-402918.Covid_19_project.CovidDeaths`
--where location like "%States%"
where continent is not null
group by location
order by TotalDeathCount desc

-- LETS BREAK THINGS DOWN BY CONTINENT PER DEATH COUNT
select continent, MAX(CAST(total_deaths AS INT64)) as TotalDeathCount
from `unified-post-402918.Covid_19_project.CovidDeaths`
--where location like "%States%"
where continent is not null
group by continent
order by TotalDeathCount desc

--GLOBEL NUMBERS
SELECT date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, 
CASE 
 WHEN  SUM(new_cases) = 0 THEN 0
 ELSE SUM(CAST(new_deaths as int))/ SUM(new_cases) * 100 
 END as Deathpercentage
from `unified-post-402918.Covid_19_project.CovidDeaths`
--where location like "%States%"
where continent is not null
group by date
order by 1,2
--
SELECT date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths,  SUM(CAST(new_deaths as int))/SUM(new_cases) *100 as Deathpercentage
from `unified-post-402918.Covid_19_project.CovidDeaths`
--where location like "%States%"
where continent is not null
group by date
order by 1,2 -- this query showing error

SELECT  SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths,  SUM(CAST(new_deaths as int))/SUM(new_cases) *100 as Deathpercentage
from `unified-post-402918.Covid_19_project.CovidDeaths`
--where location like "%States%"
where continent is not null
--group by date
order by 1,2 

--using CovidVaccination table
select *
from `unified-post-402918.Covid_19_project.CovidVaccinations`

select * 
from `unified-post-402918.Covid_19_project.CovidDeaths` as dea
   join `unified-post-402918.Covid_19_project.CovidVaccinations` as vac
   on dea.location = vac.location
   and dea.date = vac.date

 --looking for total population Vs Vaccination  
select dea.continent, dea.location, dea.date, vac.new_vaccinations
from `unified-post-402918.Covid_19_project.CovidDeaths` as dea
   join `unified-post-402918.Covid_19_project.CovidVaccinations` as vac
   on dea.location = vac.location
   and dea.date = vac.date
   where dea.continent is not null
   order by  2,3

   -- using CTEs

  

WITH PopVsVac AS (
    SELECT 
        dea.continent, 
        dea.location, 
        dea.date, 
        dea.population, 
        vac.new_vaccinations,
        SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
    FROM 
        `unified-post-402918.Covid_19_project.CovidDeaths` AS dea
    JOIN 
        `unified-post-402918.Covid_19_project.CovidVaccinations` AS vac
    ON 
        dea.location = vac.location
        AND dea.date = vac.date
    WHERE 
        dea.continent IS NOT NULL
)
SELECT 
    *, (RollingPeopleVaccinated/population)*100 as PercentRollingCount
FROM 
    PopVsVac;


-- Temp tabels

DROP Table if exists #PercentPopulationVaccinated

Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

WITH PercentPopulationVaccinated AS (
    SELECT
     dea.continent, 
        dea.location, 
        dea.date, 
        dea.population, 
        vac.new_vaccinations,
        SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
    FROM 
        `unified-post-402918.Covid_19_project.CovidDeaths` AS dea
    JOIN 
        `unified-post-402918.Covid_19_project.CovidVaccinations` AS vac
    ON 
        dea.location = vac.location
        AND dea.date = vac.date
    WHERE 
        dea.continent IS NOT NUll
)

WITH PercentPopulationVaccinated AS (
    SELECT
        dea.continent, 
        dea.location, 
        dea.date, 
        dea.population, 
        vac.new_vaccinations,
        SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
    FROM 
        `unified-post-402918.Covid_19_project.CovidDeaths` AS dea
    JOIN 
        `unified-post-402918.Covid_19_project.CovidVaccinations` AS vac
    ON 
        dea.location = vac.location
        AND dea.date = vac.date
    WHERE 
        dea.continent IS NOT NULL
)
In this corrected version, "NULL" is capitalized in the WHERE clause, ensuring it is syntactically correct.



User
Syntax error: Expected ")" but got end of script at [17:34]
ChatGPT
The query you provided seems to be incomplete or there might be a syntax error at the end of the script. The error message suggests that the parser was expecting a closing parenthesis ")" but instead found the end of the script.


WITH PercentPopulationVaccinated AS (
    SELECT
        dea.continent, 
        dea.location, 
        dea.date, 
        dea.population, 
        vac.new_vaccinations,
        SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
    FROM 
        `unified-post-402918.Covid_19_project.CovidDeaths` AS dea
    JOIN 
        `unified-post-402918.Covid_19_project.CovidVaccinations` AS vac
    ON 
        dea.location = vac.location
        AND dea.date = vac.date
    WHERE 
        dea.continent IS NOT NULL
)

-- Define a temporary view within the query
WITH PercentPopulationVaccinated AS (
    SELECT
        dea.continent, 
        dea.location, 
        dea.date, 
        dea.population, 
        vac.new_vaccinations,
        SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
    FROM 
        `unified-post-402918.Covid_19_project.CovidDeaths` AS dea
    JOIN 
        `unified-post-402918.Covid_19_project.CovidVaccinations` AS vac
    ON 
        dea.location = vac.location
        AND dea.date = vac.date
    WHERE 
        dea.continent IS NOT NULL
)

SELECT *
FROM PercentPopulationVaccinated;



	and dea.date = vac.date
where dea.continent is not null 


