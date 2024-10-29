UPDATE order1
SET comments = concat('(s)', comments)
WHERE order1.employee_id IN
      (SELECT employee.employee_id
       FROM employee
       WHERE employee.spec = 'student');

-- | order_id | owner_id | service_id | pet_id | employee_id | time_order                 | is_done | mark | comments           |
-- |----------|----------|------------|--------|-------------|----------------------------|---------|------|--------------------|
-- | 19       | 3        | 1          | 6      | 3           | 2023-09-23 10:00:00.000000 | 0       | 0    | (s)                |
-- | 10       | 2        | 1          | 5      | 3           | 2023-09-18 17:00:00.000000 | 1       | 4    | (s)                |
-- | 11       | 2        | 1          | 4      | 3           | 2023-09-18 18:00:00.000000 | 1       | 4    | (s)                |
-- | 12       | 2        | 1          | 5      | 3           | 2023-09-18 12:00:00.000000 | 1       | 4    | (s)                |
-- | 13       | 2        | 1          | 4      | 3           | 2023-09-18 14:00:00.000000 | 1       | 4    | (s)                |
-- | 14       | 3        | 1          | 6      | 3           | 2023-09-19 10:00:00.000000 | 1       | 5    | (s)                |
-- | 16       | 3        | 1          | 6      | 3           | 2023-09-20 10:00:00.000000 | 0       | 0    | (s)                |
-- | 17       | 3        | 1          | 6      | 3           | 2023-09-20 11:00:00.000000 | 0       | 0    | (s)                |
-- | 18       | 3        | 1          | 6      | 3           | 2023-09-22 10:00:00.000000 | 0       | 0    | (s)                |
-- | 1        | 1        | 1          | 1      | 3           | 2023-09-11 08:00:00.000000 | 1       | 5    | (s)                |
-- | 4        | 1        | 1          | 1      | 3           | 2023-09-11 00:00:00.000000 | 1       | 5    | (s)                |
-- | 5        | 1        | 1          | 1      | 3           | 2023-09-16 11:00:00.000000 | 1       | 3    | (s)Comming late    |
-- | 6        | 1        | 1          | 1      | 3           | 2023-09-17 17:00:00.000000 | 1       | 5    | (s)                |
-- | 8        | 2        | 1          | 5      | 3           | 2023-09-17 18:00:00.000000 | 1       | 4    | (s)                |
-- | 9        | 2        | 1          | 4      | 3           | 2023-09-17 10:00:00.000000 | 1       | 4    | (s)                |
-- | 3        | 1        | 2          | 3      | 2           | 2023-09-11 09:00:00.000000 | 1       | 4    | That cat is crazy! |
-- | 7        | 1        | 2          | 2      | 2           | 2023-09-17 18:00:00.000000 | 1       | 5    |                    |
-- | 15       | 3        | 2          | 6      | 2           | 2023-09-19 18:00:00.000000 | 0       | 0    |                    |
-- | 23       | 5        | 2          | 8      | 2           | 2023-10-03 16:00:00.000000 | 0       | 0    | null               |
-- | 2        | 1        | 2          | 2      | 2           | 2023-09-11 09:00:00.000000 | 1       | 4    |                    |
-- | 22       | 4        | 3          | 7      | 1           | 2023-10-02 11:00:00.000000 | 0       | 0    | null               |
-- | 20       | 4        | 3          | 7      | 1           | 2023-09-30 11:00:00.000000 | 1       | 5    |                    |
-- | 21       | 4        | 3          | 7      | 1           | 2023-10-01 11:00:00.000000 | 0       | 0    | null               |


DELETE FROM order1
WHERE order1.is_done = 0 and
        order1.service_id IN
        (SELECT service.service_id
         FROM service
         WHERE service.name = 'Combing');


-- [2024-10-28 19:02:52] 2 rows affected in 8 ms
-- Были удалены следующие строки
-- | order_id | owner_id | service_id | pet_id | employee_id | time_order                 | is_done | mark | comments           |
-- |----------|----------|------------|--------|-------------|----------------------------|---------|------|--------------------|
-- | 15       | 3        | 2          | 6      | 2           | 2023-09-19 18:00:00.000000 | 0       | 0    |                    |
-- | 23       | 5        | 2          | 8      | 2           | 2023-10-03 16:00:00.000000 | 0       | 0    | null               |


INSERT INTO person(person_id, last_name, first_name, phone, address)
VALUES ((SELECT MAX(person.person_id) + 1 FROM person),
        'Shishin',
        'Kirill',
        '+7952812',
        'BRZD');

-- [2024-10-28 22:06:27] 1 row affected in 10 ms


CREATE TABLE Document
(
    Document_ID      INTEGER     NOT NULL,
    Person_ID        INTEGER     NOT NULL,
    Document_Type    VARCHAR(25) NOT NULL,
    Document_Number  VARCHAR(25) NOT NULL,
    CONSTRAINT Document_PK PRIMARY KEY (Document_ID)
);

ALTER TABLE
    Document
    ADD
        CONSTRAINT FK_Document_Person FOREIGN KEY (Person_ID) REFERENCES person (person_id)
            ON UPDATE CASCADE ON DELETE CASCADE;

INSERT INTO Document(document_id, person_id, document_type, document_number)
VALUES (1, 11, 'birth certificate', '76'),
       (2, 11, 'passport', '78');

-- | document_id | person_id | document_type     | document_number |
-- |-------------|-----------|-------------------|-----------------|
-- | 1           | 11        | birth certificate | 76              |
-- | 2           | 11        | passport          | 78              |


UPDATE person
SET person_id=58
WHERE person.first_name = 'Kirill' and person.last_name = 'Shishin';

-- | document_id | person_id | document_type     | document_number |
-- |-------------|-----------|-------------------|-----------------|
-- | 1           | 58        | birth certificate | 76              |
-- | 2           | 58        | passport          | 78              |

DELETE FROM person
WHERE person.first_name = 'Kirill' and person.last_name = 'Shishin';

-- | document_id | person_id | document_type     | document_number |
-- |-------------|-----------|-------------------|-----------------|

-- Теперь таблица пустая!

