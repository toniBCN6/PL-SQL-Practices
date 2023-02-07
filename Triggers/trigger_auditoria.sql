-- Historial de acciones con fecha, usuario, tipo, tabla

--Tabla para almacenar 
CREATE TABLE auditorias (
      id         NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
      tabla       VARCHAR2(255),
      tipo VARCHAR2(10),
      usuario          VARCHAR2(30),
      fecha DATE
);

-- Trigger sobre la tabla employees
CREATE OR REPLACE TRIGGER employees_audits_trigger
    AFTER 
    UPDATE OR DELETE 
    ON employees
    FOR EACH ROW    
DECLARE
   l_tipo VARCHAR2(10);
BEGIN
   -- tipo de accion
   l_tipo := CASE  
         WHEN UPDATING THEN 'UPDATE'
         WHEN DELETING THEN 'DELETE'
         WHEN INSERTING THEN 'INSERT'
   END;
 
   -- insertar los datos en la tabla   
   INSERT INTO auditorias (tabla, tipo, usuario, fecha)
   VALUES('Employees', l_tipo, USER, SYSDATE);
END;
/

-- Bloque de codigo para provocar el disparador.
UPDATE
   employees
SET
   salary = 2500
WHERE
   employee_id =198;
 
 --Comprobación  
select * from auditorias;

select * from employees;