Create Database CrimeManagement;
use CrimeManagement;

Create table Crime(
CrimeID int Primary key,
IncidentType varchar(255),
IncidentDate Date,
Location varchar(255),
Description TEXT,
Status varchar(20)
);

Create table Victim(
VictimID int primary key,
CrimeID int,
Name varchar(255),
ContactInfo varchar(255),
Injuries VARCHAR(255),
FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);
 SuspectID INT PRIMARY KEY,
 CrimeID INT,
 Name VARCHAR(255),
 Description TEXT,
 CriminalHistory TEXT,
 FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);
VALUES
 (1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
 (2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under 
Investigation'),
 (3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed');
VALUES
 (1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries'),
 (2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased');
VALUES
 (1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions'),
 (2, 2, 'Unknown', 'Investigation ongoing', NULL),
 (3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests');
VALUES
 (4, 'Theft', '2022-09-11', '111 Main road, Cityville', 'Pick poketing at Bus Station', 'Open'),
FROM
    crime c
LEFT JOIN
    suspect s ON c.CrimeID = s.CrimeID
LEFT JOIN
    victim v ON c.CrimeID= v.CrimeID
WHERE
    c.Status = 'Open';
FROM crime;
FROM crime;
ADD age INT DEFAULT 0;
ADD age INT DEFAULT 0;
    person_id,
    person_name,
    age
FROM
    (
        SELECT
            SuspectID AS person_id,
            Name AS person_name,
            age
        FROM
            suspect
        UNION ALL
        SELECT
            VictimID AS person_id,
            Name AS person_name,
            age
        FROM
            victim
    ) AS persons_involved
ORDER BY
    age DESC;

-- Find the average age of persons involved in incidents.
SELECT AVG(age) AS average_age
FROM (
    SELECT age FROM suspect
    UNION ALL
    SELECT age FROM victim
) AS combined_age;

-- List incident types and their counts, only for open cases.
SELECT
    IncidentType,
    COUNT(*) AS incident_count
FROM
    crime
WHERE
    Status = 'Open'
GROUP BY
    IncidentType;
    VictimID,
    name,
    age
FROM
    victim
WHERE
    name LIKE '%Doe%';
union
Select name from suspect where CrimeID in (select CrimeID from crime where status='Open'or status='Closed');

-- List incident types where there are persons aged 30 or 35 involved.
SELECT DISTINCT c.IncidentType from crime c left join victim v on v.CrimeID=c.CrimeID where v.age=30 or v.age=35
union
select DISTINCT c.IncidentType from crime c left join suspect s on s.CrimeID=c.CrimeID where s.age=30 or s.age=35;

--Find persons involved in incidents of the same type as 'Robbery'.
union
Select name,age from suspect where CrimeID in (select CrimeID from crime where IncidentType='Robbery');
VALUES
 (4, 4, 'Alice Johnson', 'Armed and masked robber', 'Previous robbery convictions');
FROM Crime C
JOIN Victim V ON C.CrimeID = V.CrimeID
JOIN Suspect S ON C.CrimeID = S.CrimeID AND V.Name = S.Name;

--Retrieve all incidents along with victim and suspect details.
SELECT c.*,s.*,v.*
FROM
    crime c
LEFT JOIN
    victim v ON c.CrimeID = v.CrimeID
LEFT JOIN
    suspect s ON c.CrimeID = s.CrimeID;

-- Find incidents where the suspect is older than any victim.
SELECT
    c.*
FROM
    crime c
JOIN
    suspect s ON c.CrimeID = s.CrimeID
JOIN
    victim v ON c.CrimeID = v.CrimeID
WHERE
    s.age > ANY (SELECT age FROM victim WHERE v.CrimeID = c.CrimeID);

-- Find suspects involved in multiple incidents:
    SuspectID,
    name,
    COUNT(DISTINCT CrimeID) AS num_incidents
FROM
    suspect
GROUP BY
    SuspectID,name
HAVING
    COUNT(DISTINCT CrimeID) > 1;

-- List incidents with no suspects involved.
SELECT
    c.*
FROM
    crime c
LEFT JOIN
    suspect s ON c.CrimeID = s.CrimeID
WHERE
    s.SuspectID IS NULL;

-- List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery'
SELECT C.*
FROM Crime C
WHERE IncidentType = 'Homicide'
  AND NOT EXISTS (
    SELECT 1
    FROM Crime
    WHERE CrimeID <> C.CrimeID AND IncidentType <> 'Robbery');
-- Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or 'No Suspect' if there are none.
SELECT
    c.*,
    COALESCE(s.name, 'No Suspect') AS suspect_name
FROM
    crime c
LEFT JOIN
    suspect s ON c.CrimeID = s.CrimeID;

-- List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault'
SELECT
    s.*
FROM
    suspect s
JOIN
    crime c ON s.CrimeID = c.CrimeID
WHERE
    c.IncidentType IN ('Robbery', 'Assault');





