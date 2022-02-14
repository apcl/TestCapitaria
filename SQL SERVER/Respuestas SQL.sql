-- 1 Escriba una Query que entregue la lista de alumnos para el curso "programación"

	SELECT NOMBRE
	FROM ALUMNOS A
		INNER JOIN ALUMNOS_POR_CURSO B
			ON A.ID_ALUMNO = B.ID_ALUMNO
		INNER JOIN CURSOS C
			ON B.ID_CURSO = C.ID_CURSO
	WHERE C.DESCRIPCION = 'PROGRAMACIÓN';

-- 2 Escriba una Query que calcule el promedio de notas de un alumno en un curso.

	SELECT AVG(NOTA) AS 'PROMEDIO'
	FROM EVALUACIONES A
		INNER JOIN ALUMNOS B
			ON B.ID_ALUMNO = A.ID_ALUMNO
		INNER JOIN PRUEBAS C
			ON C.ID_PRUEBA = A.ID_PRUEBA
		INNER JOIN CURSOS D
			ON D.ID_CURSO = C.ID_CURSO
	WHERE B.NOMBRE = 'PEDRO COFRÉ'
		AND D.DESCRIPCION = 'PROGRAMACIÓN';

-- 3 Escriba una Query que entregue a los alumnos y el promedio que tiene en cada curso.

	SELECT B.NOMBRE, D.DESCRIPCION, AVG(A.NOTA) AS 'PROMEDIO'
	FROM EVALUACIONES A
		INNER JOIN ALUMNOS B
			ON B.ID_ALUMNO = A.ID_ALUMNO
		INNER JOIN PRUEBAS C
			ON C.ID_PRUEBA = A.ID_PRUEBA
		INNER JOIN CURSOS D
			ON D.ID_CURSO = C.ID_CURSO
	GROUP BY B.NOMBRE, D.DESCRIPCION
	ORDER BY B.NOMBRE ASC;

-- 4 Escriba una Query que lista a todos los alumnos con más de un curso con promedio rojo.

	SELECT NOMBRE, COUNT(*) AS 'CURSOS CON PROMEDIO ROJO'
	FROM (
		SELECT B.NOMBRE
		FROM EVALUACIONES A
			INNER JOIN ALUMNOS B
				ON B.ID_ALUMNO = A.ID_ALUMNO
			INNER JOIN PRUEBAS C
				ON C.ID_PRUEBA = A.ID_PRUEBA
			INNER JOIN CURSOS D
				ON D.ID_CURSO = C.ID_CURSO
		GROUP BY B.NOMBRE, D.DESCRIPCION
			HAVING AVG(A.NOTA) < 4
	) AS REPROBADOS
	GROUP BY (NOMBRE)
		HAVING COUNT(*) > 1
	

-- 5 Dejando de lado el problema del cólegio se tiene una tabla con información de jugadores de tenis: PLAYERS(Nombre, Pais, Ranking). 
--   Suponga que Ranking es un número de 1 a 100 que es distinto para cada jugador. Si la tabla en un momento dado tiene solo 20 registros, 
--   indique cuantos registros tiene la tabla que resulta de la siguiente consulta:	

	SELECT c1.Nombre, c2.Nombre
	FROM PLAYERS c1, PLAYERS c2
	WHERE c1.Ranking > c2.Ranking


	RESPUESTA = B => 190