SELECT pet.nick, pet_type.name
FROM pet, pet_type
WHERE pet.nick = 'Partizan' and
        pet.pet_type_id = pet_type.pet_type_id;

-- | nick     | name |
-- |----------|------|
-- | Partizan | CAT  |


SELECT pet.nick, pet.breed, pet.age
FROM pet, pet_type
WHERE pet.pet_type_id = pet_type.pet_type_id and
        pet_type.name = 'DOG';

-- | nick    | breed   | age |
-- |---------|---------|-----|
-- | Bobik   | unknown | 3   |
-- | Apelsin | poodle  | 5   |
-- | Daniel  | spaniel | 14  |
-- | Markiz  | poodle  | 1   |


SELECT avg(pet.age)
FROM pet, pet_type
WHERE pet.pet_type_id = pet_type.pet_type_id and
        pet_type.name = 'CAT';

-- | avg |
-- |-----|
-- | 6.6 |


SELECT order1.time_order, person.last_name
FROM employee, person, order1
WHERE order1.is_done = 0 and
        order1.employee_id = employee.employee_id and
        employee.person_id = person.person_id;

-- | time_order                 | last_time |
-- |----------------------------|-----------|
-- | 2023-09-19 18:00:00.000000 | Orlov     |
-- | 2023-09-20 10:00:00.000000 | Vorobiev  |
-- | 2023-09-20 11:00:00.000000 | Vorobiev  |
-- | 2023-09-22 10:00:00.000000 | Vorobiev  |
-- | 2023-09-23 10:00:00.000000 | Vorobiev  |
-- | 2023-10-01 11:00:00.000000 | Ivanov    |
-- | 2023-10-02 11:00:00.000000 | Ivanov    |
-- | 2023-10-03 16:00:00.000000 | Orlov     |


SELECT person.first_name, person.last_name, person.phone
FROM person, owner, pet, pet_type
WHERE pet.pet_type_id = pet_type.pet_type_id and
        pet_type.name = 'DOG' and
        pet.owner_id = owner.owner_id and
        owner.person_id = person.person_id;

-- | first_name | last_name | phone        |
-- |------------|-----------|--------------|
-- | Petia      | Petrov    | +79234567890 |
-- | Vasia      | Vasiliev  | +7345678901  |
-- | Galia      | Galkina   | +7567890123  |
-- | Vano       | Ivanov    | +7789012345  |


SELECT pet_type.name, pet.nick
FROM pet_type LEFT JOIN pet ON pet_type.pet_type_id = pet.pet_type_id
order by pet_type.name;

-- | name | nick     |
-- |------|----------|
-- | CAT  | Musia    |
-- | CAT  | Zombi    |
-- | CAT  | Las      |
-- | CAT  | Partizan |
-- | CAT  | Katok    |
-- | COW  | Model    |
-- | DOG  | Bobik    |
-- | DOG  | Apelsin  |
-- | DOG  | Daniel   |
-- | DOG  | Markiz   |
-- | FISH | null     |


SELECT pet.age, pet_type.name, count(*)
FROM pet JOIN pet_type ON pet.pet_type_id = pet_type.pet_type_id
GROUP BY pet.age, pet_type.name
ORDER BY pet.age;

-- | age | name | count |
-- |-----|------|-------|
-- | 1   | DOG  | 1     |
-- | 2   | CAT  | 1     |
-- | 3   | DOG  | 1     |
-- | 5   | CAT  | 1     |
-- | 5   | COW  | 1     |
-- | 5   | DOG  | 1     |
-- | 7   | CAT  | 2     |
-- | 12  | CAT  | 1     |
-- | 14  | DOG  | 1     |

SELECT person.last_name, count(order1.order_id)
FROM
    order1
        JOIN
    employee ON order1.employee_id = employee.employee_id
        JOIN
    person ON employee.person_id = person.person_id
WHERE order1.is_done = 1
GROUP BY person.last_name
HAVING count(order1.order_id) > 3;

-- | last_name | count |
-- |-----------|-------|
-- | Vorobiev  | 11    |


-- Вывести информацию (имя хозяина, кличка и порода животного) о питомцах, имеющих прививку Distemper.

SELECT person.last_name, pet.nick, pet_type.name
FROM person, owner, pet, pet_type, vaccination, vaccination_type
WHERE person.person_id = owner.person_id and
        owner.owner_id = pet.owner_id and
        pet.pet_type_id = pet_type.pet_type_id and
        pet.pet_id = vaccination.pet_id and
        vaccination.vaccination_id = vaccination_type.vaccination_type_id;

-- | last_name | nick   | name |
-- |-----------|--------|------|
-- | Sokolova  | Zombi  | CAT  |
-- | Ivanov    | Markiz | DOG  |
