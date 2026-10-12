```php
<?php

$conexion = new mysqli("db", "app", "app", "app");

if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

$resultado = $conexion->query("SELECT * FROM mensajes");

?>

<!DOCTYPE html>
<html>
<head>
    <title>UTN DevOps</title>
</head>
<body>

    <h1>Mensajes desde la base de datos</h1>

    <?php while ($fila = $resultado->fetch_assoc()): ?>
        <p>
            <?php echo $fila["id"] . " - " . $fila["texto"]; ?>
        </p>
    <?php endwhile; ?>

</body>
</html>

<?php
$conexion->close();
?>
```
