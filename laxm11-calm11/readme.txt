 +------------------------------------------------------------------+
 | Lucas Affonso X. de Morais - GRR20118372 - Login: laxm11         |
 | Carolina A. de Lara Moraes - GRR20111353 - Login: calm11
 | 3º Trabalho de CI065 - 2017/1                                    |
 +------------------------------------------------------------------+

 Arquivos:

 	- conta-caminhos
 		Arquivo principal do trabalho.

 	- graph.rb, node.rb e edge.rb
 		Implementação de grafo em Ruby, com um parser da estrutura de grafo da biblioteca Graphviz
 		para a classe Graph.

 	- graph_theory.rb
 		Implementação de algoritmos que envolvem Teoria dos Grafos, como o pedido no trabalho.
 		A lógica principal deste trabalho está dentro deste arquivo, no método
 		strongly_connected_components.

 Implementação:
 		Criamos uma cópia do grafo no qual todas as arestas foram invertidas.
 		Após isso, usamos o método scc_util para realizar uma busca em profundidade a partir de algum
 		vértice do grafo que não esteja em nenhum componente forte ainda, este método retorna um conjunto
 		de vértices que estão na arborescencia resultante da busca em profundidade. O mesmo método é
 		aplicado no grafo transposto para o mesmo vértice.
 		Os vértices que estão na intersecção dos 2 conjuntos retornados por scc_util no grafo e no grafo
 		transposto pertencem a um componente forte, e portanto são marcados como pertencentes ao mesmo
 		componente.
 		Essas buscas são repetidas até que todos os vértices do grafo estejam em um componente forte.
 		Ao final do algotitmo é retornado um grafo no qual todos os vértices possuem um atributo que
 		indica a qual componente forte (cluster) eles pertencem.