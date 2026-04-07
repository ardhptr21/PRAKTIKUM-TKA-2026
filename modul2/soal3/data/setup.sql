CREATE DATABASE IF NOT EXISTS identitas_a07;

CREATE TABLE IF NOT EXISTS identitas_a07.anggota (
  nrp VARCHAR(20) PRIMARY KEY,
  nama VARCHAR(100) NOT NULL
);

INSERT INTO identitas_a07.anggota (nrp, nama) VALUES
('5027241022', 'Ardhi Putra Pradana'),
('5027241059', 'Andi Naufal Zaki'),
('5027241082', 'Muhammad Rafi` Adly');