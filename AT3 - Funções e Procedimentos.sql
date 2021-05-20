 DELIMITER //
 CREATE FUNCTION inserirAluno(
 dataNasc DATE ,
 totCred INT,
 mgp DOUBLE,
 nomeAluno VARCHAR(60),
 email VARCHAR(60)) 
 RETURNS VARCHAR(60) DETERMINISTIC
 BEGIN
	INSERT INTO Aluno (cod_curso, dat_nasc, tot_cred, mgp, nom_alun, email) 
    VALUES (null,dataNasc,totCred, mgp,nomeAluno,email);
    RETURN nomeAluno;
 END // 
 DELIMITER ;

 
 DELIMITER //  
 CREATE PROCEDURE sequenciaWhile()
 BEGIN
	DECLARE numero INT DEFAULT 1 ;
	DECLARE numFinal VARCHAR(20) DEFAULT "";
		WHILE numero <= 5 DO
			SET numFinal= concat(numFinal,concat(numero,","));
			SET numero = numero+1;	
		END WHILE;
    SELECT numFinal as "str";
 END //  
 DELIMITER ;  

 DELIMITER //  
 CREATE PROCEDURE sequenciaRepeat()
 BEGIN
	DECLARE numero int DEFAULT 0 ;
	DECLARE numFinal VARCHAR(20) DEFAULT "";
	REPEAT		
		set numero = numero+1;		
		set numFinal= concat(numFinal,concat(numero,","));		
    UNTIL numero >= 9
    END REPEAT;
    select numFinal as "result";
 END //  
 DELIMITER ;