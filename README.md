# MYSQL

MyISAM

Bloqueo de tabla

Aumento del rendimiento si nuestra aplicación realiza un elevado número de consultas “Select”.

Las tablas pueden llegar a dar problemas en la recuperación de datos.

Permite hacer búsquedas full-text

Menor consumo memoria RAM

Mayor velocidad en general a la hora de recuperar datos.

Ausencia de características de atomicidad ya que no tiene que hacer comprobaciones de la integridad referencial, ni bloquear las tablas para realizar las operaciones, esto nos lleva como los anteriores puntos a una mayor velocidad.

InnoDB

Bloqueo de registros

Soporte de transacciones

Rendimiento

Concurrencia

Confiabilidad

Permite hacer búsquedas full-text (mysql >= 5.6)

Encontré este enlace con una buena discusión al respecto: MyISAM vs InnoDB (Ventajas y diferencias)