DROP TABLE IF EXISTS bestillinger;
DROP TABLE IF EXISTS rett_har_allergi;
DROP TABLE IF EXISTS allergier;
DROP TABLE IF EXISTS meny;

CREATE TABLE meny (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rett VARCHAR(100) NOT NULL,
    pris DECIMAL(10,2) NOT NULL,
    beskrivelse TEXT,
    kategori VARCHAR(50)
);

CREATE TABLE bestillinger (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    kunde VARCHAR(100) NOT NULL,
    meny_id INTEGER NOT NULL,
    dato DATE NOT NULL,
    FOREIGN KEY (meny_id) REFERENCES meny(id)
);

CREATE TABLE allergier (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    navn VARCHAR(100) NOT NULL
);

CREATE TABLE rett_har_allergi (
    rett_id INTEGER NOT NULL,
    allergi_id INTEGER NOT NULL,
    PRIMARY KEY (rett_id, allergi_id),
    FOREIGN KEY (rett_id) REFERENCES meny(id),
    FOREIGN KEY (allergi_id) REFERENCES allergier(id)
);

INSERT INTO allergier (navn)
VALUES
    ('Gluten'),
    ('Laktose'),
    ('Nøtter'),
    ('Sulfitter'),
    ('Fisk'),
    ('Skalldyr');

INSERT INTO meny (rett, pris, beskrivelse, kategori)
VALUES
    ('Pizza', 129.00, 'Digg pizza med ost og skinke', 'Hovedrett'),
    ('Pasta', 99.00, 'Kremet pasta med sopp og fløte', 'Hovedrett'),
    ('Salat', 79.00, 'Frisk salat med pinjekjerner og fetaost', 'Forrett'),
    ('Burger', 119.00, 'Saftig burger med pommes frites', 'Hovedrett'),
    ('Sushi', 149.00, 'Fersk sushi med laks og avokado', 'Hovedrett'),
    ('Taco', 89.00, 'Smaksrik taco med ekte meksikansk krydder', 'Hovedrett');

INSERT INTO rett_har_allergi (rett_id, allergi_id)
VALUES
    (1, 1), -- Pizza har Gluten
    (1, 2), -- Pizza har Laktose
    (2, 1), -- Pasta har Gluten
    (2, 2), -- Pasta har Laktose
    (3, 3), -- Salat har Nøtter
    (5, 5), -- Sushi har Fisk
    (5, 6); -- Sushi har Skalldyr

INSERT INTO bestillinger (kunde, meny_id, dato)
VALUES
    ('Ola', 1, '2025-12-07'),
    ('Kari', 3, '2025-12-08'),
    ('Per', 2, '2025-12-09'),
    ('Lise', 5, '2025-12-10'),
    ('Nina', 4, '2025-12-11');

SELECT * FROM meny ORDER BY pris;
SELECT * FROM bestillinger ORDER BY dato;

-- Finn alle retter som inneholder gluten:
SELECT m.rett, m.pris
FROM meny m
JOIN rett_har_allergi rha ON m.id = rha.rett_id
JOIN allergier a ON a.id = rha.allergi_id
WHERE a.navn = 'Gluten';
