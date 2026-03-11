# Walkthrough Soal 2

1. build

```sh
docker build -t database-shinji .
```

2. run

```sh
docker run -d --name database-shinji \
  --hostname database-shinji \
  --cpus="2" \
  --memory="2048m" \
  -v $PWD/db:/var/data/db \
  database-shinji
```

3. exec sql

```sh
docker exec -it database-shinji bash
```

4. query

```sql
CREATE DATABASE modul1_a07_database;
USE modul1_a07_database;

CREATE TABLE anggota (
  NRP VARCHAR(20) PRIMARY KEY,
  Nama VARCHAR(100) NOT NULL,
  Departemen VARCHAR(100) NOT NULL
);

INSERT INTO anggota (NRP, Nama, Departemen) VALUES
('5027241022', 'Ardhi Putra Pradana', 'Teknologi Informasi'),
('5027241082', 'Muhammad Rafi` Adly', 'Teknologi Informasi'),
('5027241059', 'Andi Naufal Zaki', 'Teknologi Informasi');

SELECT * FROM anggota;
```
