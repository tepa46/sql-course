SELECT *
FROM pet
WHERE nick = 'Partizan';

-- | pet_id | nick     | breed   | age | description | pet_type_id | owner_id |
-- |--------|----------|---------|-----|-------------|-------------|----------|
-- | 5      | Partizan | Siamese | 5   | very big    | 2           | 2        |

SELECT nick, breed, age
FROM pet
ORDER BY age;

-- | nick     | breed   | age  |
-- |----------|---------|------|
-- | Markiz   | poodle  | 1    |
-- | Katok    | null    | 2    |
-- | Bobik    | unknown | 3    |
-- | Model    | null    | 5    |
-- | Apelsin  | poodle  | 5    |
-- | Partizan | Siamese | 5    |
-- | Las      | Siamese | 7    |
-- | Zombi    | unknown | 7    |
-- | Musia    | null    | 12   |
-- | Daniel   | spaniel | 14   |


SELECT *
FROM pet
WHERE description != '';

-- | pet_id | nick     | breed   | age | description | pet_type_id | owner_id |
-- |--------|----------|---------|-----|-------------|-------------|----------|
-- | 3      | Katok    | null    | 2   | crazy guy   | 2           | 1        |
-- | 5      | Partizan | Siamese | 5   | very big    | 2           | 2        |
-- | 9      | Zombi    | unknown | 7   | wild        | 2           | 6        |


SELECT avg(age)
FROM pet
WHERE breed = 'poodle';

-- | avg |
-- |-----|
-- | 3   |


SELECT count(distinct (owner_id))
FROM pet;

-- | count |
-- |-------|
-- | 6     |

SELECT breed, count(pet_id)
FROM pet
GROUP BY breed
ORDER BY count(pet_id);

-- | breed   | count |
-- |---------|-------|
-- | spaniel | 1     |
-- | poodle  | 2     |
-- | Siamese | 2     |
-- | unknown | 2     |
-- | null    | 3     |


SELECT breed, count(pet_id)
FROM pet
GROUP BY breed
HAVING count(pet_id) > 1
ORDER BY count(pet_id);

-- | breed   | count |
-- |---------|-------|
-- | poodle  | 2     |
-- | Siamese | 2     |
-- | unknown | 2     |
-- | null    | 3     |


-- Запрос с BETWEEN. Клички питомцев с возрастом от 3 до 7 лет.

SELECT nick, age
FROM pet
WHERE age BETWEEN 3 AND 7;

-- | nick     | age |
-- |----------|-----|
-- | Bobik    | 3   |
-- | Apelsin  | 5   |
-- | Partizan | 5   |
-- | Model    | 5   |
-- | Zombi    | 7   |
-- | Las      | 7   |


-- Запрос с LIKE. Питомцы с кличкой, начинающейся с буквы M.

SELECT nick
FROM pet
WHERE nick LIKE 'M%';

-- | nick   |
-- |--------|
-- | Musia  |
-- | Model  |
-- | Markiz |


-- Запрос с IN. Клички питомцев с породой poodle или Siamese.

SELECT nick, breed
FROM pet
WHERE breed in ('poodle', 'Siamese')
ORDER BY breed

-- | nick     | breed   |
-- |----------|---------|
-- | Apelsin  | poodle  |
-- | Markiz   | poodle  |
-- | Partizan | Siamese |
-- | Las      | Siamese |
