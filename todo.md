Fase 1: Etapas Preparatórias (Setup e Planejamento)
O objetivo desta fase é garantir que todos os recursos, acessos e ferramentas estejam prontos antes do início das medições.
1. DefiniçãodeEscopo:
o [ ] SGBDs: Selecionar os dois SGBDs a serem utilizados (ex: PostgreSQL e
MySQL).
o [ ] Consultas: Fazer uma análise prévia das 22 consultas TPC-H (Q1-Q22) e selecionar as cinco que serão utilizadas no estudo. (Critério de escolha pode ser a variedade de operações: joins, agregações, subqueries).
2. ConfiguraçãodoAmbientedeAcesso:
o [ ] Acesso ao Servidor: Garantir o acesso SSH ou VPN ao servidor
sanduleak.eic.cefet-rj.br conforme instruções da disciplina.
o [ ] Credenciais: Validar as credenciais de acesso para ambos os SGBDs (PostgreSQL e MySQL) no servidor.
3. ConfiguraçãodasFerramentas:
o [ ] Cliente de BD: Instalar e configurar um cliente de banco de dados (ex: DBeaver, VS Code com plugins de BD, ou os clientes de linha de comando psql e mysql). O uso de clientes de linha de comando é recomendado para medições de tempo precisas.
o [ ] Coleta de Dados: Preparar uma planilha (Excel, Google Sheets) para registrar sistematicamente todos os tempos de execução e planos.
o [ ] Relatório: Acessar o template Overleaf fornecido e criar o projeto para o relatório.
4. ValidaçãodasConsultas(SQL):
o [ ] Obter SQL: Localizar os arquivos SQL oficiais das consultas TPC-H (Q1- Q22) na especificação v2.6.1 fornecida.
o [ ] Adaptação de Dialeto: Executar as cinco consultas selecionadas em ambos os SGBDs para garantir que funcionam. Adaptar a sintaxe (dialeto SQL) se necessário, sem alterar a lógica semântica da consulta.
Fase 2: Processo de Execução (Medição e Análise)
Este é o processo iterativo de coleta e análise de dados.
Etapa 2.1: Coleta de Dados de Baseline (Antes da Otimização)
O objetivo é medir o desempenho "cru" dos SGBDs. 1. ConfigurarMediçãodeTempo:
o Para psql (PostgreSQL): usar o comando \timing on antes de iniciar.
o Para mysql (MySQL): verificar a exibição de tempo de execução ao final da
consulta ou usar SET profiling = 1; (e SHOW PROFILES;). 2. ExecuçãoAlternada(CiclodeMedição):
o Para a Consulta 1 (Q_X):
§ []ExecutarQ_XnoSGBD1(Execução1/5).Registrarotempo. § []ExecutarQ_XnoSGBD2(Execução1/5).Registrarotempo. § []ExecutarQ_XnoSGBD1(Execução2/5).Registrarotempo. § []ExecutarQ_XnoSGBD2(Execução2/5).Registrarotempo. § ...(Repetiraté5execuçõesparacadaSGBD).
o [ ] Repetir o ciclo completo para as Consultas 2, 3, 4 e 5. 3. ColetadePlanosdeExecução(Baseline):
o Para cada uma das cinco consultas, em ambos os SGBDs:
o [ ] Executar EXPLAIN [Consulta SQL] ou EXPLAIN ANALYZE [Consulta SQL].
o [ ] Salvar o plano de execução (texto ou captura de tela) para análise posterior.
Etapa 2.2: Análise e Proposta de Otimização

O objetivo é identificar gargalos e propor soluções. 1. AnálisedePlano:
o [ ] Para cada plano de execução salvo (Etapa 2.1.3), identificar operações custosas (ex: Seq Scan / Full Table Scan em tabelas grandes, tipos de Join ineficientes, uso de arquivos temporários).
2. PropostadeOtimização:
o [ ] Com base na análise, propor pelo menos uma ação de otimização para
cada consulta.
o Opção A (Índices): Identificar colunas usadas em cláusulas WHERE ou JOIN que não possuem índices e propor CREATE INDEX ....
o Opção B (Reescrita): Identificar se a consulta pode ser reescrita de forma mais eficiente (ex: substituindo subqueries, otimizando JOINs).
Etapa 2.3: Coleta de Dados Pós-Otimização
O objetivo é medir o impacto das ações de otimização. 1. AplicarOtimizações:
o [ ] Executar os comandos de otimização (ex: CREATE INDEX ...) em ambos os SGBDs.
2. ExecuçãoAlternada(CiclodeMediçãoOtimizado):
o [ ] Repetir exatamente o processo da Etapa 2.1.2 com as consultas (ou no
SGBD com os novos índices). Registrar todos os novos tempos na planilha. 3. ColetadePlanosdeExecução(Pós-Otimização):
o [ ] Repetir exatamente o processo da Etapa 2.1.3.
o [ ] Salvar os novos planos de execução. Fase 3: Consolidação e Relatório
O objetivo é compilar todos os dados e análises no documento final. 1. ProcessamentodeDados:
o [ ] Na planilha de coleta, calcular a Média e o Desvio Padrão para cada conjunto de 5 execuções (por SGBD, por consulta, antes e depois da otimização).

o [ ] Criar tabelas e/ou gráficos comparativos (ex: Gráfico de barras Média de Tempo (Antes) vs. Média de Tempo (Depois) por SGBD/Consulta).
2. RedaçãodoRelatório(SeguindooTemplate):
o [ ] Introdução: Definir o objetivo do trabalho.
o [ ] Ambiente e Metodologia: Descrever as versões dos SGBDs, as 5 consultas escolhidas (e seus SQLs, talvez em anexo), e detalhar o método de medição (alternância, \timing, EXPLAIN ANALYZE, etc.).
o [ ] Resultados Baseline: Apresentar as tabelas/gráficos com médias e desvios (Antes da Otimização). Fazer a análise comparativa inicial.
o [ ] Análise e Otimização:
§ Paracadaconsulta:
§ Mostraroplanodeexecução(Antes).
§ Justificarogargaloidentificado.
§ Apresentaraaçãodeotimização(oCREATEINDEXouoSQL reescrito).
§ Mostraroplanodeexecução(Depois),destacandoamudança (ex: Seq Scan -> Index Scan).
o [ ] Resultados Pós-Otimização: Apresentar os dados de tempo após a otimização, demonstrando o ganho (ou perda) de desempenho.
o [ ] Conclusão: Resumir os aprendizados, comparar a eficiência dos SGBDs para as cargas de trabalho testadas e discutir limitações do estudo.
o [ ] Revisão Final: Garantir que o relatório atende aos requisitos (6-10 páginas) e está claro e metodologicamente rigoroso.