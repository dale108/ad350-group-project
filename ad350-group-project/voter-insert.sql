INSERT INTO candidate(first_name, last_name, party)
VALUES 
    ("Jake", "Burt", "Republican"),
	("Silas", "Cox", "Green Party"),
    ("William", "Miller", "Democrat" )
		

INSERT INTO ballot(voting_machine_id, selected_candidate_id)
VALUES 	
	(1, 3), 
	(2, 1), 
	(3, 1), 
	(4, 3), 
	(5, 2), 
	(1, 1)
;


INSERT INTO voter(ballot_id, first_name, last_name, ssn, address_id)
VALUES 
    (1, "Rick", "Smith", 12345678, 3),
	(2, "Molly", "Miller", 67894044, 6),
    (6, "Bob", "Williams", 9345935, 8),
    (4, "Erik", "Jones", 4575546, 7),
    (5, "Sarah", "Davis", 4444636, 5),
    (1, "David", "Brown", 5454549, 8),
    (4, "Rebecca", "Wilson", 78787940, 4)        
;


INSERT INTO 'signature'(path_to_signature_s3)
VALUES 	
    ("testing1.url"),
	("testing2.url"),
	("testing3.url"),
    ("testing4.url"),
	("testing5.url"),
    ("testing6.url"),
	("testing7.url"),
;


INSERT INTO voter_signature(voter_id, signature_id)
VALUES 	
    (1, 4),
	(3, 3),
    (5, 2),
    (6, 1),
    (7, 5),
    (2, 7),
    (4, 6)
;


INSERT INTO voter_check_in(voter_id, voting_site_id, DATETIME)
        (1, 3, "2021-03-01 05:05:30"),
		(7, 4, "2021-03-01 10:12:15"),
        (3, 2, "2021-03-01 07:45:10"),
        (5, 1, "2021-03-01 05:05:10"),
        (2, 4, "2021-03-01 09:23:00"),
        (4, 3, "2021-03-01 07:45:10"),
        (6, 2, "2021-03-01 12:34:34")
;




