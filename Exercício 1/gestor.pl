%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Sistemas de Representação de conhecimento e Raciocínio - Exercício 1
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% SICStus PROLOG: Declaracoes iniciais
:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Definicoes Iniciais

:- op( 900,xfy,'::' ).
:- dynamic utente/4.
:- dynamic servico/4.
:- dynamic data/3.
:- dynamic consulta/7.
:- dynamic medico/4.



% Extensão do predicado 'utente': ID, Nome, Idade, Cidade => {V, F}

utente(1, 'Pedro', 20, 'Famalicao').
utente(2, 'Nelson', 35, 'Gaia').
utente(3, 'Miguel', 28, 'Barcelos').
utente(4, 'Henrique', 10, 'Braga').
utente(5, 'Rui', 65, 'Famalicao').
utente(6, 'Maria', 20, 'Famalicao').
utente(7, 'Catarina', 43, 'Trofa').
utente(8, 'Gabriela', 80, 'Famalicao').

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado 'servico': ID, Descrição, Instituição, Cidade -> {V, F}

servico(1, 'Geral', 'Sao Joao', 'Porto').
servico(2, 'Cardiologia',  'Sao Joao', 'Porto').
servico(3, 'Dermatologia',  'Sao Joao', 'Porto').
servico(4, 'Ginecologia',  'Sao Joao', 'Porto').
servico(5, 'Radiologia',  'Sao Joao', 'Porto'). 
servico(6, 'Geral', 'Sao Vitor', 'Braga').
servico(7, 'Oncologia', 'Sao Vitor', 'Braga').
servico(8, 'Pediatria', 'Sao Vitor', 'Braga').
servico(9, 'Urologia', 'Sao Vitor', 'Braga').
servico(10, 'Cardiologia', 'Sao Vitor', 'Braga').
servico(11, 'Geral', 'Santa Maria', 'Lisboa').
servico(12, 'Neurologia', 'Santa Maria', 'Lisboa').
servico(13, 'Radiologia', 'Santa Maria', 'Lisboa').
servico(14, 'Pediatria', 'Santa Maria', 'Lisboa').
servico(15, 'Cardiologia', 'Santa Maria', 'Lisboa').

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado 'consulta': Data, ID Utente, ID Serviço, ID Medico, Custo -> {V, F}

consulta(2019, 02, 20, 1, 2, 3, 40).
consulta(2019, 02, 21, 3, 1, 10, 25).
consulta(2019, 02, 25, 1, 3, 6, 50).
consulta(2019, 02, 25, 2, 1, 1, 25).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado 'medico': ID Medico, Nome, Idade, Especialidade -> {V, F}

medico(1, 'Maria', 34, 'Geral').
medico(2, 'Tiago', 55, 'Oncologia').
medico(3, 'Diogo', 49, 'Cardiologia').
medico(4, 'Alexandra', 38, 'Urologia').
medico(5, 'Ivone', 32, 'Pediatria').
medico(6, 'Costa', 63, 'Dermatologia').
medico(7, 'Antonio', 45, 'Ginecologia').
medico(8, 'Ricardo', 34, 'Radiologia').
medico(9, 'Gabriela', 66, 'Neurologia').
medico(10, 'Anibal', 29, 'Geral').


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% REGISTAR UTENTES, SERVIÇOS E CONSULTAS:
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensão do predicado 'regU': ID, Nome, Idade, Cidade -> {V, F}
regU(Id, Nome, Idade, Cidade):- evolucao(utente(Id, Nome, Idade, Cidade)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado 'regS': ID, Descricao, Instituicao, Cidade -> {V, F}
regS(Id, Descricao, Instituicao, Cidade):- evolucao(servico(Id, Descricao, Instituicao, Cidade)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado 'regC': Data, IdU, IdS, IdM, Custo -> {V, F}
regC(Ano, Mes, Dia, IdU, IdS, IdM, Custo):- evolucao(consulta(Ano, Mes, Dia, IdU, IdS, IdM, Custo)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado 'regM': ID, Nome, Idade, Especialidade -> {V, F}
regM(ID, Nome, Idade, Especialidade) :- evolucao(medico(ID, Nome, Idade, Especialidade)).



% Invariante Estrutural:  nao permitir a insercao de conhecimento
%                         repetido

+utente(ID, Nome, I, C) :: (solucoes((ID, Nome, I, C), (utente(ID, Nome, I, C)), R),
                  			comprimento(R, N), 
							N == 1
							).

+servico(ID, D, I, C) :: (solucoes((ID, D, I, C), (servico(ID, D, I, C)), R),
						  comprimento(R, N), 
						  N == 1
						  ).

+consulta(Ano, Mes, Dia, U, S, M, C) :: (solucoes((Ano, Mes, Dia, U, S, M, C), (consulta(Ano, Mes, Dia, U, S, M, C)), R),
							comprimento(R, N), 
							N == 1
							).

+medico(ID, Nome, I, E) :: (solucoes((ID, Nome, I, E), (medico(ID, Nome, I, E)), R),
                  			comprimento(R, N), 
							N == 1
							).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Invariante Referencial: nao admitir mais do que 1 utente
%                         para o mesmo ID

+utente(ID, Nome, I, C) :: (solucoes(ID, utente(ID, Ns, Is, Cs),R),
							comprimento(R, N),
							N==1 
							).
% Invariante Referencial: nao admitir mais do que 1 servico
%                         para o mesmo ID
+servico(ID, D, I, C) :: (solucoes(ID, servico(ID, Ds, Is, Cs), R),
						  comprimento(R, N),
						  N==1 
						 ).

% Invariante Referencia: não admitir mais do que 1 médico para o mesmo ID
+medico(ID, Nome, I, E) :: (solucoes(ID, medico(ID, Ns, Is, Es), R),
							comprimento(R, N),
							N==1 
							).

% Invariante Referencial: nao admitir consultas marcadas a utentes ou servicos ou medicos inexistentes
+consulta(Ano, Mes, Dia, U, S, M, C) :: (utente(U, X, Y, Z), servico(S, A, B, E), medico(M, G, H, I)).


% Invariante Referencial: nao admitir consultas marcadas com um formato de data invalido
+consulta(Ano, Mes, Dia, U, S, M ,C) :: data(Ano, Mes, Dia).


% Invariante Referencial: nao admitir a remocao de utentes onde ja existam consultas para esse utente
-utente(ID, Nome, I, C) :: (solucoes(ID, consulta(Ano, Mes, Dia, ID, Y, W, Z), R),
							comprimento(R, N),
							N==0
							).
% Invariante Referencial: nao admitir a remocao de serviço onde ja existam consultas a utilizar esse serviço
-servico(ID, D, I, C) :: (solucoes(ID, consulta(Ano, Mes, Dia, Y, ID, W, Z), R),
							comprimento(R, N),
							N==0
							).
% Invariante Referencial: nao admitir a remocao de um medico onde ja existam consultas por este realizadas
-medico(ID, Nome, I, E) :: (solucoes(ID, consulta(Ano, Mes, Dia, Y, W, ID, Z), R),
							comprimento(R, N),
							N==0
							).

% Invariante: O Preço duma consulta tem que ser maior que 0
+consulta(Ano, Mes, Dia, U, S, M, Custo) :: Custo > 0.

% Invariante: A consulta tem que ser realizado por um médico cuja especialidade seja o serviço prestado na consulta
+consulta(Ano, Mes, Dia, U, Serv, Med, C) :: (servico(Serv, Desc, X, Y) , medico(Med, W, Z, Esp) , Desc == Esp).

% Invariante: A Idade dum utente > 0
+utente(ID, Nome, Idade, C) :: Idade >= 0.

% Invariante: A Idade dum medico > 28
+medico(ID, N, Idade, E) :: Idade >= 28.

% Invariante: Não existem dois serviços com a mesma descrição na mesma instituição
+servico(ID, Desc, Inst, C) :: (solucoes((Desc, Inst), (servico(X, Desc, Inst, Y)), R),
						  comprimento(R, N), 
						  N == 1 ).

% Invariante: IDs têm que ser naturais
+utente(ID, N, I, C) :- natural(ID).
+servico(ID, D, I, C) :- natural(ID).
+medico(ID, N, I, E) :- natural(ID).
% não é preciso para consulta pois apenas dá para inserir para IDs de utentes, servicos e medicos validos


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% REMOVER UTENTES, SERVIÇOS E CONSULTAS:
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensão do predicado 'remU': ID, Nome, Idade, Cidade -> {V, F}
remU(Id, Nome, Idade, Cidade):- involucao(utente(Id, Nome, Idade, Cidade)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado 'remS': ID, Descricao, Instituicao, Cidade -> {V, F}
remS(Id, Descricao, Instituicao, Cidade):- involucao(servico(Id, Descricao, Instituicao, Cidade)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado 'remC': Data, IdU, IdS, IdM, Custo -> {V, F}
remC(Ano, Mes, Dia, IdU, IdS, IdM, Custo):- involucao(consulta(Ano, Mes, Dia, IdU, IdS, IdM, Custo)).

% Extensão do predicado 'remM': ID, Nome, Idade, Especialidade -> {V, F}
remM(Id, Nome, Idade, Especialidade):- involucao(medico(Id, Nome, Idade, Especialidade)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% IDENTIFICAR AS INSTITUIÇÕES PRESTADORAS DE SERVIÇOS
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensão do predicado que permite Identificar todas as instituições prestadoras de serviços
% 'instituicoes': LInstituicoes -> {V,F}
instituicoes(R) :- solucoes(Inst, servico(ID, D, Inst, C), L) , removeRepetidos(L, R).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% IDENTIFICAR UTENTES/SERVIÇOS/CONSULTAS POR CRITÉRIOS DE SELEÇÃO
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensão do predicado que permite identificar um utente pelo seu Id:
% 'utenteById': Id, Resultado -> {V,F}

utenteById(Id, R):- solucoes((Nome, Idade, Cidade), utente(Id,Nome, Idade, Cidade), R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar utentes pelo seu nome:
% 'utenteByNome': Nome, Resultado -> {V, F}

utenteByNome(Nome, R):- solucoes((Id, Idade, Cidade), utente(Id, Nome, Idade, Cidade), R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar utentes pela sua idade:
% 'utenteByIdade': Idade, Resultado -> {V,F}

utenteByIdade(Idade, R):- solucoes((Id, Nome, Cidade), utente(Id, Nome, Idade, Cidade), R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar utentes pela sua cidade:
% 'utenteByCidade': Cidade, Resultado -> {V,F}

utenteByCidade(Cidade, R):- solucoes((Id, Nome, Idade), utente(Id, Nome, Idade, Cidade), R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar um serviço através do seu ID:
% 'servicoById': Id, Resultado -> {V,F}

servicoById(Id, R):- solucoes((Instituicao, Desc, Cidade), servico(Id, Desc, Instituicao, Cidade), R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar serviços através da sua descrição:
% 'servicoByDescricao': Descricao, Identificador -> {V,F}

servicoByDescricao(Desc, R):- solucoes((Id, Instituicao, Cidade), servico(Id, Desc, Instituicao, Cidade), R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar consultas pela sua data:
% 'consultaByData': Data, Resultado -> {V,F}

consultaByData(Ano, Mes, Dia, R) :- solucoes((IdUtente, IdServico, IdMedico, Custo), consulta(Ano, Mes, Dia, IdUtente, IdServico, IdMedico, Custo), R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar consultas através do Id do utente:
% 'consultaByUtente': IdUtente, Resultado -> {V,F}

consultaByUtente(IdUtente, R) :- solucoes((Ano, Mes, Dia, IdServico, IdMedico, Custo), consulta(Ano, Mes, Dia, IdUtente, IdServico, IdMedico, Custo), R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar consultas pelo Id do seu serviço:
% 'consultaByServiço': IdServico, Resultado -> {V,F}

consultaByServico(IdServico, R) :- solucoes((Ano, Mes, Dia, IdUtente, IdMedico, Custo), consulta(Ano, Mes, Dia, IdUtente, IdServico, IdMedico, Custo), R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar consultas pela sua data:
% 'consultaByCusto': Custo, Resultado -> {V,F}

consultaByCusto(Custo, R) :- solucoes((Ano, Mes, Dia, IdUtente, IdServico, IdMedico), consulta(Ano, Mes, Dia, IdUtente, IdServico, IdMedico, Custo), R).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% IDENTIFICAR SERVIÇOS PRESTADOS POR INSTITUIÇÃO/CIDADE/DATAS/CUSTO:
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensão do predicado que permite identificar os serviços prestados por uma instituição:
% 'servicoByInstituicao': Instituicao, Resultado -> {V,F}

servicoByInstituicao(Instituicao, R) :- solucoes((ID, Nome, Cidade), servico(ID, Nome, Instituicao, Cidade), R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar os serviços prestados numa cidade:
% 'servicoByCidade': Cidade, Resultado -> {V,F}

servicoByCidade(Cidade, R) :- solucoes((ID, Nome, Instituicao), servico(ID, Nome, Instituicao, Cidade), R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar os serviços prestados numa data:
% 'servicoByData': Data, Resultado -> {V,F}

servicoByData(Ano, Mes, Dia, R) :- solucoes((IdS, Nome, Instituicao, Cidade), (servico(IdS, Nome, Instituicao, Cidade), consulta(Ano, Mes, Dia, U, IdS, M, C)), R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar os serviços prestados por um determinado custo:
% 'servicoByCusto': Data, Resultado -> {V,F}

servicoByCusto(Custo, R) :- solucoes((IdS, Nome, Instituicao, Cidade), (servico(IdS, Nome, Instituicao, Cidade), consulta(Ano, Mes, Dia, U, IdS, M, Custo)), R).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% IDENTIFICAR OS UTENTES DE UM SERVIÇO/INSTITUIÇÃO:
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensão do predicado que permite identificar os utentes de um determinado serviço:
% 'utentesByServico': Serviço, Resultado -> {V,F}

utentesByServico(IdS, R) :- solucoes((IdU, Nome, Idade, Cidade), (consulta(Ano, Mes, Dia, IdU, IdS, M, C), utente(IdU, Nome, Idade, Cidade)), L), removeRepetidos(L,R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar os utentes de uma determinada instituição:
% 'utentesByInstituicao': Instituição, Resultado -> {V,F}

utentesByInstituicao(Instituicao, R) :- solucoes((IdU, Nome, Idade, Cidade), (consulta(Ano, Mes, Dia, IdU, IdS, M, C) , servico(IdS, N, Instituicao, Cid) , utente(IdU, Nome, Idade, Cidade)), L), removeRepetidos(L,R).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% IDENTIFICAR SERVIÇOS REALIZADOS POR UTENTE/INSTITUIÇÃO/CIDADE:
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensão do predicado que permite identificar os serviços realizados a um utente:
% 'servByUtente': IDUtente, Resultado -> {V,F}

servByUtente(IdU, R) :- solucoes((IdS, Desc, Inst), (consulta(Ano, Mes, Dia, IdU, IdS, M, C) , servico(IdS, Desc, Inst, Ci)), L), removeRepetidos(L,R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar os serviços realizados numa instituicao:
% 'servByInstituicao': Instituicao, Resultado -> {V,F}

servByInstituicao(Inst, R) :- solucoes((IdS, Desc), (consulta(Ano, Mes, Dia, U, IdS, M, C) , servico(IdS, Desc, Inst, Ci)), L), removeRepetidos(L,R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite identificar os serviços realizados numa cidade:
% 'servByCidade': Cidade, Resultado -> {V,F}

servByCidade(Cidade, R) :- solucoes((IdS, Desc, Inst), (consulta(Ano, Mes, Dia, U, IdS, M, C), servico(IdS, Desc, Inst, Cidade)), L), removeRepetidos(L,R).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% CALCULAR O CUSTO TOTAL DOS CUIDADOS DE SAÚDE POR UTENTE/SERVIÇO/INSTITUIÇÃO/DATA:
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensão do predicado que determina os custos totais dos cuidados prestados a um utente:
% 'custosByUtente': IDUtente, Resultado -> {V,F}

custosByUtente(IdU, R) :- solucoes(Custo, (consulta(Ano, Mes, Dia, IdU, S, M, Custo)), L), soma(L,R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que determina o total dos custos praticados pela realização de um serviço:
% 'custosByServico': IDServico, Resultado -> {V,F}

custosByServico(IdS, R) :- solucoes(Custo, (consulta(Ano, Mes, Dia, U, IdS, M, Custo)), L), soma(L,R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que determina os custos totais ocorridos numa instituição:
% 'custosByInstituicao': Instituicao, Resultado -> {V,F}

custosByInstituicao(Instituicao, R) :- solucoes(Custo, (consulta(Ano, Mes, Dia, U, IdS, M, Custo), servico(IdS, Desc, Instituicao, Ci)), L) , soma(L, R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que determina os custos totais ocorridos numa determinada data:
% 'custosByData': Data, Resultado -> {V,F}

custosByData(Ano, Mes, Dia, R) :- solucoes(Custo, (consulta(Ano, Mes, Dia, U, S, M, Custo)), L), soma(L,R).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PREDICADOS AUXILIARES 
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensao do predicado que permite a evolucao do conhecimento
% 'evolucao': T -> {V,F}

evolucao(Termo) :- solucoes(Invariante, +Termo::Invariante, LInvariantes),
	               insercao(Termo),
	               teste(LInvariantes).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a involucao do conhecimento
% 'involucao': T -> {V,F}

involucao(Termo) :- Termo,
				   solucoes(Invariante, -Termo::Invariante, LInvariantes),
	               remocao(Termo),
	               teste(LInvariantes).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado capaz de averiguar se uma lista de Invariantes é respeitada
% 'teste': LI -> {V,F}

teste([]).
teste([H|T]) :- H, teste(T).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite adicionar termos à base de conhecimento
% 'insercao': T -> {V,F}

insercao(Termo) :- assert(Termo).
insercao(Termo) :- retract(Termo), !, fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado capaz de encontrar todas as possibilidades de prova de um teorema.
% 'solucoes': F, Q, S -> {V,F}

solucoes(F, Q, S) :- Q, assert(tmp(F)), fail.
solucoes(F, Q, S) :- construir(S, []).	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado 'construir': S1,S2 -> {V,F}

construir(S1, S2) :- retract(tmp(X)), !, construir(S1, [X|S2]).
construir(S, S).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que soma um conjunto valores: 
% 'soma': LN, Resultado -> {V,F}

soma([], 0).
soma([H|T], R) :- soma(T, R1), R is H+R1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensão do predicado que permite remover termos da base de conhecimento. 
% 'remocao': Termo -> {V,F}

remocao(Termo) :- retract(Termo).
remocao(Termo) :- assert(Termo), !, fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que calcula o comprimento de uma lista 
% 'comprimento': L, Resultado -> {V,F}

comprimento([], 0).
comprimento([H|T],R) :- comprimento(T,D) , R is D+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado negação: 
% 'nao': Termo -> {V,F}
nao(Termo) :- Termo, !, fail.
nao(Termo).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite verificar se um elemento percente a uma lista: 
% 'contains':  Elemento, Conjunto -> {V,F}

contains(E,[E|T]).
contains(E,[Y|T]) :- E\=Y, contains(E,T).	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite verificar se um numero é natural: 
% 'natural':  Numero -> {V,F}
natural(1).
natural(N) :- M is N-1 , natural(M).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado 'guardar' que permite guardar em ficheiro a base do conhecimento:
% 'guardar': -> {V, F} 
guardar(X) :- save_program(X).

% Extensão do predicado 'carregar' que permite carregar a partir dum ficheiro a base do conhecimento:
% 'carregar': -> {V, F} 
carregar(X) :- restore(X).


% Extensão do predicado 'bissexto': Ano => {V, F}
bissexto(X) :- X mod 4 == 0.

% Extensão do predicado 'data': Ano, Mes, Dia => {V, F}
data(A,M,D) :- M\=2, A>=2000, contains(M,[1,3,5,7,8,10,12]), D>0, D=<31.
data(A,M,D) :- M\=2, A>=2000, contains(M,[4,6,9,11]), D>=1, D=<30.
data(A,M,D) :- M==2 , bissexto(A), A>=2000, D>=1, D=<29.
data(A,M,D) :- M==2 , nao(bissexto(A)), A>=2000, D>=1, D=<28.


% Extensão do predicado 'removeRepetidos' que remove os elementos repetidos duma lista
removeRepetidos([], []).
removeRepetidos([H|T], R) :- contains(H, T) , removeRepetidos(T, R). 
removeRepetidos([H|T], [H|R]) :- nao(contains(H, T)) , removeRepetidos(T, R).
