CREATE TABLE mensajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    texto VARCHAR(255)
);

INSERT INTO mensajes (texto) VALUES
('Hola desde MariaDB'),
('Docker funciona correctamente'),
('Este dato viene de la base de datos');