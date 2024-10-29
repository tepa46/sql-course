CREATE VIEW dogs AS
SELECT
    pet.nick,
    pet.breed,
    pet.age,
    person.first_name,
    person.last_name
FROM pet, pet_type, person, owner
WHERE pet.pet_type_id = pet_type.pet_type_id and
        pet_type.name = 'DOG' and
        pet.owner_id = owner.owner_id and
        owner.person_id = person.person_id;

-- | nick    | breed   | age | first_name | last_name |
-- |---------|---------|-----|------------|-----------|
-- | Bobik   | unknown | 3   | Petia      | Petrov    |
-- | Apelsin | poodle  | 5   | Vasia      | Vasiliev  |
-- | Daniel  | spaniel | 14  | Galia      | Galkina   |
-- | Markiz  | poodle  | 1   | Vano       | Ivanov    |


SELECT dogs.nick, dogs.last_name
FROM dogs
WHERE dogs.breed = 'poodle';

-- | nick    | last_name |
-- |---------|-----------|
-- | Apelsin | Vasiliev  |
-- | Markiz  | Ivanov    |


CREATE VIEW employee_rating AS
SELECT
    person.last_name,
    person.first_name,
    COUNT(*),
    AVG(order1.mark) as avg
FROM person, employee, order1
WHERE order1.employee_id = employee.employee_id and
      employee.person_id = person.person_id and
      order1.is_done = 1
GROUP BY person.last_name, person.first_name;

-- | last_name | first_name | count | avg                |
-- |-----------|------------|-------|--------------------|
-- | Ivanov    | Vania      | 1     | 5                  |
-- | Orlov     | Oleg       | 3     | 4.3333333333333333 |
-- | Vorobiev  | Vova       | 11    | 4.2727272727272727 |


SELECT *
FROM employee_rating
ORDER BY employee_rating.avg DESC;

-- | last_name | first_name | count | avg                |
-- |-----------|------------|-------|--------------------|
-- | Ivanov    | Vania      | 1     | 5                  |
-- | Orlov     | Oleg       | 3     | 4.3333333333333333 |
-- | Vorobiev  | Vova       | 11    | 4.2727272727272727 |

CREATE VIEW client AS
SELECT DISTINCT person.last_name, person.first_name, person.phone, person.address
FROM person, owner, order1
WHERE order1.owner_id = owner.owner_id and
        owner.person_id = person.person_id;

-- | last_name  | first_name | phone        | address                |
-- |------------|------------|--------------|------------------------|
-- | Sokolov    | S.         | +7678901234  | "Srednii pr VO, 27-1"  |
-- | Ivanov     | Vano       | +7789012345  | "Malyi pr VO, 33-2"    |
-- | Vasiliev   | Vasia      | +7345678901  | "Nevskii pr, 9-11"     |
-- | Petrov     | Petia      | +79234567890 | "Sadovaia ul, 17\2-23" |
-- | Galkina    | Galia      | +7567890123  | "10 linia VO, 35-26"   |


-- Удалим описание у некоторых клиентов.
UPDATE person
SET address = ''
WHERE last_name IN ('Sokolov', 'Ivanov', 'Vasiliev');

-- | last_name  | first_name | phone        | address                |
-- |------------|------------|--------------|------------------------|
-- | Sokolov    | S.         | +7678901234  |                        |
-- | Ivanov     | Vano       | +7789012345  |                        |
-- | Vasiliev   | Vasia      | +7345678901  |                        |
-- | Petrov     | Petia      | +79234567890 | "Sadovaia ul, 17\2-23" |
-- | Galkina    | Galia      | +7567890123  | "10 linia VO, 35-26"   |


-- Views containing DISTINCT or GROUP BY are not automatically updatable.
-- UPDATE client
-- SET address = '?'
-- WHERE address = '';

-- Сделал парочку выборок как в предыдущих пунктах.

SELECT *
FROM client
WHERE address = '';

-- | last_name  | first_name | phone        | address                |
-- |------------|------------|--------------|------------------------|
-- | Sokolov    | S.         | +7678901234  |                        |
-- | Ivanov     | Vano       | +7789012345  |                        |
-- | Vasiliev   | Vasia      | +7345678901  |                        |

SELECT *
FROM client
ORDER BY last_name;

-- | last_name  | first_name | phone        | address                |
-- |------------|------------|--------------|------------------------|
-- | Galkina    | Galia      | +7567890123  | "10 linia VO, 35-26"   |
-- | Ivanov     | Vano       | +7789012345  |                        |
-- | Petrov     | Petia      | +79234567890 | "Sadovaia ul, 17\2-23" |
-- | Sokolov    | S.         | +7678901234  |                        |
-- | Vasiliev   | Vasia      | +7345678901  |                        |
