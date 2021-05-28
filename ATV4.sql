DELIMITER !!
CREATE TRIGGER tri_vendas_ai 
AFTER INSERT ON comivenda
FOR EACH ROW
BEGIN
	DECLARE vTotal_itens float(10,2) DEFAULT 0;
	DECLARE vTotal_item float(10,2)DEFAULT 0;
	DECLARE total_item float(10,2)DEFAULT 0;
	DECLARE fimLoop INT DEFAULT 0;    
    DECLARE condicaoLoop INT DEFAULT 0; 
    DECLARE qtdProduto INT DEFAULT 0; 
    
    #buscando o Valor do produto e a quantidade vendida
    DECLARE busca_itens CURSOR FOR
    SELECT n_valoivenda,n_qtdeivenda
    FROM comivenda
    WHERE n_numevenda = NEW.n_numevenda;
    
    #inserindo o total de linhas para a condição do loop
    SELECT count(n_numevenda) INTO condicaoLoop 
    FROM comivenda
    WHERE n_numevenda = NEW.n_numevenda;  
    
    OPEN busca_itens;   
    
    itens:LOOP
		IF fimLoop=condicaoLoop THEN
			LEAVE itens;
		END IF;
        SET fimLoop=fimLoop+1;        
        
		FETCH busca_itens INTO total_item,qtdProduto;
        
        #Multiplicando o valor Unitario do item pela quantidade vendida 
        SET vTotal_item= total_item*qtdProduto;
        
        #Armazenando na variavel vTotal_itens
        SET vTotal_itens= vTotal_itens + vTotal_item;
        
    END LOOP itens;    
    CLOSE busca_itens;
    
    #Update na tabela n_totavenda com o valor total vendido
    UPDATE comvenda SET n_totavenda = vTotal_itens
    WHERE n_numevenda = NEW.n_numevenda; 
	
END !!
DELIMITER ;
