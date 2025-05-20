-- data_agenda.sql
-- Этот файл описывает структуру таблицы 'agenda' и основные SQL-операции.

-- --------------------------------------------------------
--                СОЗДАНИЕ ТАБЛИЦЫ (CREATE TABLE)
-- --------------------------------------------------------
-- Удаляем таблицу, если она уже существует (для удобства при повторном выполнении скрипта)
DROP TABLE IF EXISTS agenda;

-- Создаем таблицу 'agenda' для хранения бронирований
CREATE TABLE agenda (
    id INT AUTO_INCREMENT PRIMARY KEY,          -- Уникальный идентификатор бронирования (автоматически увеличивается)
    booking_date DATE NOT NULL,                 -- Дата бронирования
    booking_time TIME NOT NULL,                 -- Время бронирования
    group_type VARCHAR(50) NOT NULL,            -- Тип группы (например, "Grupo1", "Grupo2")
    activity VARCHAR(255) NOT NULL,             -- Название активности/мероприятия
    school_name VARCHAR(255) NOT NULL,          -- Название центра/школы
    area VARCHAR(255),                          -- Район/местоположение
    assistant VARCHAR(255),                     -- Имя ассистента
    professor VARCHAR(255),                     -- Имя преподавателя
    course VARCHAR(255),                        -- Название курса
    responsible VARCHAR(255),                   -- Имя ответственного лица
    phone VARCHAR(50),                          -- Контактный телефон
    email VARCHAR(255),                         -- Контактный Email
    notes TEXT,                                 -- Дополнительные примечания
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Дата и время создания записи
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Дата и время последнего обновления записи
);

-- Комментарии к полям:
-- id: Первичный ключ, обеспечивает уникальность каждой записи.
-- booking_date, booking_time, group_type: Составной ключ, определяющий уникальный слот бронирования.
-- VARCHAR(255): Строка переменной длины, максимум 255 символов. Подходит для большинства текстовых полей.
-- TEXT: Для длинных текстовых описаний (примечания).
-- DATE: Для хранения даты в формате 'YYYY-MM-DD'.
-- TIME: Для хранения времени в формате 'HH:MM:SS'.
-- NOT NULL: Означает, что поле не может быть пустым.
-- DEFAULT CURRENT_TIMESTAMP: При создании записи автоматически устанавливает текущее время.
-- ON UPDATE CURRENT_TIMESTAMP: При обновлении записи автоматически обновляет время.

-- --------------------------------------------------------
--                ВСТАВКА ДАННЫХ (INSERT)
-- --------------------------------------------------------
-- Пример вставки нового бронирования
INSERT INTO agenda (booking_date, booking_time, group_type, activity, school_name, area, assistant, professor, course, responsible, phone, email, notes)
VALUES
('2024-05-21', '10:00:00', 'Grupo1', 'Taller bachata', 'EIS Sduardo Primo', 'Carlet', 'Pepe', 'Emilio', 'Taller', 'Alex', '+346543211', 'alex@example.com', 'Nesesito VR-gafas.'),
('2024-05-21', '11:45:00', 'Grupo2', 'Teatro', 'EIS AlCudia"', 'AlCudia', 'Viktor', 'Jose', 'Bachata', 'Iurii.', '+346543322', 'zaytsev@example.com', NULL);

-- --------------------------------------------------------
--                ВЫБОРКА ДАННЫХ (SELECT)
-- --------------------------------------------------------
-- 1. Выбрать все бронирования
SELECT * FROM agenda;

-- 2. Выбрать все бронирования на определенную дату
SELECT * FROM agenda WHERE booking_date = '2024-05-21';

-- 3. Выбрать бронирования для определенной группы и времени
SELECT * FROM agenda WHERE group_type = 'Grupo1' AND booking_time = '10:00:00';

-- 4. Выбрать только определенные поля (например, активность и ответственного) для всех бронирований
SELECT activity, responsible, email FROM agenda;

-- 5. Выбрать бронирования, отсортированные по дате и времени
SELECT * FROM agenda ORDER BY booking_date ASC, booking_time ASC;

-- 6. Выбрать количество бронирований на каждую дату
SELECT booking_date, COUNT(*) AS number_of_bookings
FROM agenda
GROUP BY booking_date;

-- 7. Найти бронирования по части названия активности (например, все, что содержит "Урок")
SELECT * FROM agenda WHERE activity LIKE '%Урок%';

-- --------------------------------------------------------
--                ОБНОВЛЕНИЕ ДАННЫХ (UPDATE)
-- --------------------------------------------------------
-- Пример обновления информации для существующего бронирования (например, изменить email ответственного)
-- Предположим, мы хотим обновить запись с id = 1
UPDATE agenda
SET email = 'new_sidorova@example.com', notes = 'Интерактивная доска предоставлена. Добавлен запрос на маркеры.'
WHERE id = 1;

-- Обновить ассистента для всех бронирований на 2024-05-22
UPDATE agenda
SET assistant = 'Новый Ассистент О.С.'
WHERE booking_date = '2024-05-22';

-- --------------------------------------------------------
--                УДАЛЕНИЕ ДАННЫХ (DELETE)
-- --------------------------------------------------------
-- Пример удаления конкретного бронирования по его id
-- Предположим, мы хотим удалить запись с id = 2
DELETE FROM agenda WHERE id = 2;

-- Удалить все бронирования на определенную дату (БУДЬТЕ ОСТОРОЖНЫ С ЭТОЙ КОМАНДОЙ!)
-- DELETE FROM agenda WHERE booking_date = '2024-05-21';

-- Удалить все бронирования (ОЧИСТИТЬ ТАБЛИЦУ - БУДЬТЕ ОЧЕНЬ ОСТОРОЖНЫ!)
-- DELETE FROM agenda;

-- --------------------------------------------------------
--                ДОПОЛНИТЕЛЬНЫЕ ПРИМЕРЫ
-- --------------------------------------------------------

-- Показать структуру таблицы (зависит от СУБД, например, для MySQL)
-- DESCRIBE agenda;
-- Для PostgreSQL: \d agenda
-- Для SQLite: .schema agenda

-- Создание индекса для ускорения поиска по дате (если частые запросы по дате)
CREATE INDEX idx_booking_date ON agenda (booking_date);

-- Создание составного индекса для уникальных слотов (если не используется AUTO_INCREMENT id как основной идентификатор слота)
-- ALTER TABLE agenda ADD CONSTRAINT unique_booking_slot UNIQUE (booking_date, booking_time, group_type);
-- Это нужно делать, если id не является главным идентификатором бронирования, а уникальность слота важна на уровне БД.
-- В нашей структуре с AUTO_INCREMENT id, этот индекс может быть полезен для быстрого поиска уникального слота.

