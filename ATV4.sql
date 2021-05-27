DELIMITER !!
CREATE TRIGGER tri_vendas_ai 
AFTER INSERT ON comivenda
FOR EACH ROW
BEGIN
	DECLARE vTotal_itens float(10,2) default 0;
	DECLARE vTotal_item float(10,2)default 0;
	DECLARE total_item float(10,2)default 0;
	DECLARE fimLoop int default 0;    
    DECLARE condicaoLoop int default 0; 
    DECLARE qtdProduto int default 0; 
    
    #buscando o Valor do produto e a quantidade vendida do mesmo
    DECLARE busca_itens CURSOR FOR
    SELECT n_valoivenda,n_qtdeivenda
    FROM comivenda
    WHERE n_numevenda = new.n_numevenda;
    
    #inserindo o total de linhas para a condição do loop
    SELECT count(n_numevenda) INTO condicaoLoop 
    FROM comivenda
    WHERE n_numevenda = new.n_numevenda;  
    
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
    
    UPDATE comvenda set n_totavenda = vTotal_itens
    WHERE n_numevenda = new.n_numevenda; 
	
END !!
DELIMITER ;	


#TESTES-------------------------------------
    
DROP TRIGGER tri_vendas_ai;
delete from  comivenda
where n_numeivenda=45;

INSERT INTO comivenda(n_numeivenda,n_numevenda,n_numeprodu,n_valoivenda,n_qtdeivenda,n_descivenda) VALUES
(45,1,1,1000.5,5,0);
select n_valoivenda,n_qtdeivenda from comivenda WHERE n_numevenda=1;
select * from comvenda ;
select n_numevenda,n_valovenda,n_totavenda from comvenda where n_numevenda=9;
select * from comivenda;



        
        