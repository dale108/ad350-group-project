INSERT INTO candidate(first_name, last_name, party)
VALUES 
    ("Jake", "Burt", "Republican"),
	("Silas", "Cox", "Green Party"),
    ("William", "Miller", "Democrat")
		

INSERT INTO ballot(voting_machines_at_site_id, candidate_id)
VALUES 	
	(1, 3), 
	(5, 1), 
	(3, 1), 
	(2, 3), 
	(4, 2)
;


INSERT INTO voter(first_name, last_name, ssn, ballot_id, address_id)
VALUES 
    ("Rick", "Smith", 12345678, 1, 2),
	("Molly", "Miller", 67894044, 2, 3),
    ("Bob", "Williams", 9345935, 3, 4),
    ("Erik", "Jones", 4575546, 4, 1),
    ("Sarah", "Davis", 4444636, 5, 5),
    ("David", "Brown", 5454549, 1, 1),
    ("Rebecca", "Wilson", 78787940, 4, 2)        
;


INSERT INTO 'signature'(path_to_signature_s3)
VALUES 	
    ("testing1.url"),
	("testing2.url"),
	("testing3.url"),
    ("testing4.url"),
	("testing5.url"),
    ("testing6.url"),
	("testing7.url")
;


INSERT INTO voter_signature(signature_id, voter_id)
VALUES 	
    (1, 4),
	(3, 3),
    (5, 2),
    (6, 1),
    (7, 5),
    (2, 7),
    (4, 6)
;


INSERT INTO voter_check_in(timstamp, voting_site_id, voter_id)
    VALUES
        ("2021-03-01 05:05:30", 5, 1),
		("2021-03-01 10:12:15", 4, 7),
        ("2021-03-01 07:45:10", 2, 3),
        ("2021-03-01 05:05:10", 1, 5),
        ("2021-03-01 09:23:00", 3, 2),
        ("2021-03-01 07:45:10", 1, 4),
        ("2021-03-01 12:34:34", 3, 6)
;



INSERT INTO workers_assigned_to_site(date_assigned, election_worker_id)
    VALUES
        ("2021-03-01 07:40:00", 2),
        ("2021-03-01 07:55:00", 1),
        ("2021-03-01 08:30:00", 3),
        ("2021-03-01 08:30:00", 4)
;

INSERT INTO days_worked_at_assignment(checked_in, checked_out, site_id)
    VALUES
        ("2021-03-01 07:35:55", "2021-03-01 04:00:03", 4),
        ("2021-03-01 07:45:20", "2021-03-01 04:10:37", 5),
        ("2021-03-01 08:25:33", "2021-03-01 05:30:26", 1),
        ("2021-03-01 08:25:33", "2021-03-01 05:30:55", 2)
;

INSERT INTO district(district_number, county)
    VALUES
        (3, "King"),
        (7, "Southwest"),
        (5, "El Paso")
;

INSERT INTO voting_machines(last_error, "error_message")
    VALUES
       ("2021-03-16 01:00:35", "Error with ballot"),
       ("2021-05-17 10:22:08", "Error with system")
;

INSERT INTO voting_site(street_address, city, "state", zip_code, district_id)
    VALUES
        ("9600 College Way N", "Seattle", "WA", "98103", 1),
        ("14 E, W Cache La Poudre St", "Colorado Springs", "CO", "80903", 3),
        ("1156 College Dr", "Summit", "MS", "39666", 2),
        ("1701 Broadway", "Seattle", "WA", "98122", 1),
        ("5675 S Academy Blvd", "Colorado Springs", "CO", "80906", 3)
;


INSERT INTO voting_machines_at_site(voting_site_id, voting_machine_id)
    VALUES
       (4 , 1),
       (3 , 1),
       (3, 2),
       (5 , 1),
       (4 , 2)
;




