--Trigger -> Gatilho

--ESTRUTURA DE UMA TRIGGER

DELIMITER $ --MUDAR DELIMITADOR

CREATE TRIGGER NOME
BEFORE/AFTER INSERT/DELETE/UPDATE ON TABELA
FOR EACH ROW --PARA CADA LINHA
BEGIN -- INICIO

	--QUALQUER COMANDO SQL ;

END -- FIM

$ --#
