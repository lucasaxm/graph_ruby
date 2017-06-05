 +------------------------------------------------------------------+
 | Lucas Affonso X. de Morais - GRR20118372 - Login: laxm11         |
 | 2º Trabalho de CI065 - 2017/1                                    |
 +------------------------------------------------------------------+

 Arquivos:

 	- conta-caminhos
 		Arquivo principal do trabalho.

 	- graph.rb, node.rb e edge.rb
 		Implementação de grafo em Ruby, com um parser da estrutura de grafo da biblioteca Graphviz
 		para a classe Graph.

 	- graph_theory.rb
 		Implementação de algoritmos que envolvem Teoria dos Grafos, como o pedido no trabalho.
 		A lógica principal deste trabalho está dentro deste arquivo, no método paths_to_sinks.

 	Implementação:
 		O algoritmo consiste em criar uma cópia do grafo no qual todas as arestas foram invertidas,
 		assim os sumidouros se tornam fontes e vice-versa.
 		Após isso, calculamos o número de caminhos de um nó fonte para todos os outros nós, fazemos
 		isso através do algoritmo de busca em profundidade, adaptado para registrar a quantidade de
 		vezes que cada nó é visitado.
 		Após termos esse resultado, adicionamos os atributos desta fonte nos nós de forma
 		equivalente ao valor registrado de caminhos que existem da fonte ao respectivo nó, porém
 		fazemos isso no grafo não invertido, para que o grafo resultante esteja com suas arestas em
 		nas direções originais.