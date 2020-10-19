--------- TELEFONE ------------
SELECT *

FROM (
        SELECT 
            REPLACE(REPLACE(CPF_CNPJ,'.',''), '-', '') AS CPF_DEV,
            SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(TELEFONE, '(',''),')',''),'-',''),' ',''),1,2) AS DDD_TEL,
            SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(TELEFONE, '(',''),')',''),'-',''),' ',''),3,9) AS TEL_TEL,
            'TELEFONE IMPORTADO VIA IMPORTAÇÃO RODOBENS CONTRATOS' AS OBS_TEL,
            COD_TIPO,
            ROW_NUMBER() OVER(PARTITION BY CPF_CNPJ, TELEFONE ORDER BY CPF_CNPJ) AS RN
        FROM 
            RODOBENS_CONTRATOS_1111
            CROSS APPLY(
                            VALUES(CELULAR,4),
                                  (CEL_CONJ,4),
                                  (TELC_CONJ, 7),
                                  (TEL_COM, 2),
                                  (TEL_RES, 1)
                        ) AS CP (TELEFONE,COD_TIPO)
    ) AS K


WHERE RN = '1'

-------  DEVEDORES ---------
SELECT *
FROM (
        SELECT 
            REPLACE(REPLACE(CPF_CNPJ,'.',''), '-', '') AS CPF_DEV,
            NOME AS NOME_DEV,
            REPLACE(IDENTIDADE, '.', '') AS RG_DEV,
            NASC AS NASCIMENTO_DEV,
            UF AS DESC_UF,
            REPLACE(REPLACE(CPF_CONJ,'.',''), '-', '') AS CONJCPF_DEV,
            NOME_CONJ AS CONJNOME_DEV,
            NACIONAL AS NAC_DEV,
            PROFISSAO AS PROFISSAO_DEV,
            CASE T_PESS
                WHEN 'F' THEN 0
                WHEN 'J' THEN 1
                ELSE 2
            END
            AS COD_TIPESS,
            ROW_NUMBER() OVER(PARTITION BY CPF_CNPJ, CPF_CONJ ORDER BY CPF_CNPJ) AS RN
        FROM 
            RODOBENS_CONTRATOS_1111
            CROSS APPLY(
                            VALUES(CPF_CNPJ),
                                  (CPF_CONJ)
                        ) AS CP   (CPF_DEV)


    ) AS K
WHERE RN = 1