SELECT 'ISTE-330-02, PE 01' as 'Terence Budu-Biney';

-- ISTE-330/722 Database Connectivity and Access
-- PE 01 - SQL review
-- Students: Replace the entire line "-- {Replace this entire line with your answer}.
-- 		Make sure you remove the double dashes.
--      Replace {put your name here} with your first and last name.
--      Do NOT remove the SELECT "QUESTION #"
--      Before sending this file to the dropbox, 
--      Start a new MySQL session, 'source' the travel.sql then run this 
--      script and check it against the expected output and NO errors.
--      You may receive a warning on a date query, that is OK.
--      Replace the { } comment with the database you are using for this exercise
--      then run this script to see what it does. It should execute cleanly.
--

-- Remove the comment marks on the next line, then add the database name
   use travel;
 

-- 1.
SELECT '1. What are the names and complete addresses of all passengers listed in order by last name?' AS 'QUESTION 1';

select fname,lname,street,city,state,p.zip 
from passenger p join zips z 
on p.zip=z.zip order by  lname;

-- 2.	
SELECT '2. What are the trip numbers, departure times, and departure locations code for all bus trips?' AS 'QUESTION 2';

select t.tripnum,t.departuretime,t.departureloccode from trip t 
join trip_directory td on t.tripnum = td.tripnum 
join tripcodes tc on td.triptype = tc.triptype 
where typename = 'bus';

-- 3.	
SELECT '3. What are the names of the passengers who are traveling in October?' AS 'QUESTION 3';

select concat(fname, " ", lname) as Passenger 
from passenger p join trip_people tp using(passengerid) 
where month(date) = 10;

-- 4.	
SELECT '4. How many trips in the trip directory leave from each city?' AS 'QUESTION 4';

select Location, count(*) as 'Number of Departures' 
from locations l join trip_directory td 
on l.LocationCode = td.DepartureLocCode
group by Location;

-- 5.	
SELECT '5. Who, if anyone, is working the Rochester trip to Buffalo during September 2017?' AS 'QUESTION 5';

select name from staff s join trip t using(tripnum) 
join locations l on t.ArrivalLocCode = l.LocationCode 
where Location = 'Buffalo' and monthname(s.date) = 'september';

-- 6.	
SELECT '6. Greg Zalewski who works for Rides ‘R’ Us is from Framingham. Who, if anyone, will he meet from his town when he works on a trip, and during what trip number?' AS 'QUESTION 6';

select distinct tripnum, concat(fname, " ",lname) as 'People from Framingham' 
from staff s left join trip t using(tripnum,date) 
left join trip_people tp using(tripnum,date) 
left join passenger p using(passengerid) 
left join zips z using(zip) 
where s.name = 'Greg Zalewski'
and z.city = 'Framingham';

-- 7.
SELECT '7.	What people from Rochester, travel by bus?' AS 'QUESTION 7';

select fname, lname from passenger p
join zips z using(zip) join trip_people tp using(passengerid)
join trip t using(date, tripnum) join trip_directory td using(tripnum)
join tripcodes tc using(triptype) where z.city = 'Rochester' and tc.typename = 'Bus';
    
-- 8.
SELECT '8. What is the description of the equipment on which Rich Gleason travels?' AS 'QUESTION 8';

select EquipmentDescription as equipmentdescription from equipment e
join trip tr using(equipid) join trip_people tp 
using(date, tripnum) join passenger p using(passengerid)
where p.fname = 'Rich' and p.lname = 'Gleason';
    
-- 9.	
SELECT '9. How many passengers travel by plane?' AS 'QUESTION 9';

select count(*) as 'Plane People' from passenger p 
join trip_people tp using(passengerid) join trip tr
using(date, tripnum) join trip_directory td using(tripnum)
join tripcodes tc using(triptype) where tc.typename = 'Plane';
    
-- 10.	
SELECT '10. On which scheduled flights might there be people with cell phones?' AS 'QUESTION 10';

select distinct t.tripnum, t.date from trip t
join trip_people tp using(date, tripnum)
join passenger p using(passengerid) 
join phones ph using(passengerid) 
join trip_directory td using(tripnum)
join tripcodes tc using(triptype)
where ph.phonetype = 'Cell' and tc.typename = 'plane';
    
-- 11.	
SELECT '11. On how many trips has each piece of equipment been used?' AS 'QUESTION 11';

select equipid, equipmentname, count(tripnum) as NumTrips
from equipment e left join trip t using(equipid) 
group by equipid;

-- 12.	
SELECT '12. What equipment has never been used on a trip?' AS 'QUESTION 12';

select equipid, equipmentname, count(tripnum) as NumTrips
from equipment e left join trip t using(equipid) 
group by equipid having NumTrips = 0;
   
-- 13.	
SELECT '13. During the period of 9/1/2017 through 10/31/2017, what types of transportation had more than 1 trip?' AS 'QUESTION 13';

select typename, count(tripnum) as NumTrips 
from trip t join trip_directory td using(tripnum)
join tripcodes tc using(triptype) 
where t.date between '2017/9/1' and '2017/10/31' 
group by typename having NumTrips > 1;

-- 14. Using only one statement, display the first 3 dates and last 3 dates from trip_people. Place a --- between the sets of 3 as shown. Note the order of the 2nd set of 3 is reversed. Extra-bonus for getting the last 3 dates ascending. An answer receiving full points MUST use ONE statement and no temporary tables. Half points for anything else.
SELECT '14. First 3 and last 3 of trip_people by date.' as 'Question 14';

select TripNum, Date, PassengerID 
from (select * from trip_people order by date limit 3) as tp 
union (select "---","---","---" from trip_people) 
union(select * from trip_people order by date desc limit 3);

-- 15.	
SELECT '15. On the trip number 3030 on October 10, 2017, display how many staff are there, \n  where is the travel from and to and what equipment is being used?' AS 'QUESTION 15';

set @Trip_number = 3030;
set @Trip_date = '2017-10-10';
select @Trip_number as Date, @Trip_date as 'Trip #', count(distinct s.tripnum)  as '# staff', 
(select l.location from locations l where location ='Boston') 
as Departure, (select l.location from locations l where location = 'Nassau') as Arrival, 
typename as Mode, equipmentname as Equipment from staff s join 
trip t using(date,tripnum)join equipment e using(equipid) 
join trip_directory td using(tripnum) join tripcodes tc using(triptype); 
