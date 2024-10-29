SELECT order1.mark
FROM order1
WHERE order1.employee_id IN
      (SELECT employee.employee_id
       FROM employee
       WHERE employee.spec = 'student')
  and order1.mark > 0;

-- | mark |
-- |------|
-- | 5    |
-- | 5    |
-- | 3    |
-- | 5    |
-- | 4    |
-- | 4    |
-- | 4    |
-- | 4    |
-- | 4    |
-- | 4    |
-- | 5    |


SELECT employee.employee_id
FROM employee
WHERE employee.employee_id NOT IN
      (SELECT order1.employee_id
       FROM order1
       GROUP BY order1.employee_id)

-- | employee_id |
-- |-------------|
-- | 4           |


SELECT person.last_name
FROM person, employee
WHERE person.person_id = employee.person_id and
        employee.employee_id NOT IN
        (SELECT order1.employee_id
         FROM order1
         GROUP BY order1.employee_id)

-- | last_name |
-- |-----------|
-- | Zotov     |


SELECT service.name, order1.time_order, p1.last_name, pet.nick, p2.last_name
FROM service JOIN order1 ON service.service_id = order1.service_id
             JOIN employee ON order1.employee_id = employee.employee_id
             JOIN person p1 ON employee.person_id = p1.person_id
             JOIN pet ON order1.pet_id = pet.pet_id
             JOIN owner ON order1.owner_id = owner.owner_id
             JOIN person p2 ON owner.person_id = p2.person_id;

-- | name    | rime_order                 | last_name | nick     | last_name |
-- |---------|----------------------------|-----------|----------|-----------|
-- | Walking | 2023-09-18 12:00:00.000000 | Vorobiev  | Partizan | Vasiliev  |
-- | Walking | 2023-09-18 14:00:00.000000 | Vorobiev  | Apelsin  | Vasiliev  |
-- | Walking | 2023-09-19 10:00:00.000000 | Vorobiev  | Daniel   | Galkina   |
-- | Combing | 2023-09-19 18:00:00.000000 | Orlov     | Daniel   | Galkina   |
-- | Walking | 2023-09-20 10:00:00.000000 | Vorobiev  | Daniel   | Galkina   |
-- | Walking | 2023-09-20 11:00:00.000000 | Vorobiev  | Daniel   | Galkina   |
-- | Walking | 2023-09-22 10:00:00.000000 | Vorobiev  | Daniel   | Galkina   |
-- | Walking | 2023-09-23 10:00:00.000000 | Vorobiev  | Daniel   | Galkina   |
-- | Milking | 2023-09-30 11:00:00.000000 | Ivanov    | Model    | Sokolov   |
-- | Milking | 2023-10-01 11:00:00.000000 | Ivanov    | Model    | Sokolov   |
-- | Milking | 2023-10-02 11:00:00.000000 | Ivanov    | Model    | Sokolov   |
-- | Combing | 2023-10-03 16:00:00.000000 | Orlov     | Markiz   | Ivanov    |


SELECT owner.description
FROM owner
WHERE owner.description != ''
UNION ALL
SELECT order1.comments
FROM order1
WHERE order1.comments != ''
UNION ALL
SELECT pet.description
FROM pet
WHERE pet.description != '';


-- | description          |
-- |----------------------|
-- | good boy             |
-- | from the ArtsAcademy |
-- | mean                 |
-- | That cat is crazy!   |
-- | Comming late         |
-- | crazy guy            |
-- | very big             |
-- | wild                 |

SELECT person.first_name, person.last_name
FROM person, employee
WHERE person.person_id = employee.person_id and
    EXISTS(SELECT *
           FROM order1
           WHERE order1.employee_id = employee.employee_id and
                   order1.mark = 4)

-- | first_name | last_name |
-- |------------|-----------|
-- | Oleg       | Orlov     |
-- | Vova       | Vorobiev  |


SELECT person.first_name, person.last_name
FROM person, employee, order1
WHERE person.person_id = employee.person_id and
        employee.employee_id = order1.employee_id and
        order1.mark = 4
group by person.first_name, person.last_name;

-- | first_name | last_name |
-- |------------|-----------|
-- | Oleg       | Orlov     |
-- | Vova       | Vorobiev  |
