# Sat-solver-caml 
Un solveur de sat écrit en Ocaml ! 

## Qu'est ce qu'un problème SAT ? 

Le problème de satisfiabilité booléenne est un problème de décision classique en informatique, qui,
étant donné une formule de logique propositionnelle détermine s’il existe une instance des variables
ou clauses qui vérifie la formule donné.
La problème est le suivant étant donné un système d’équations booléennes à n variables, déterminer
V1,V2,…,Vn tels que le système est satisfait.
Un solveur de SAT prend souvent en argument une/des formule(s) en forme normale conjonctive
(CNF).

## Comment faire marcher l'algorithme ? 
- Lancer utop.
- Charger le fichier sat .ml en faisant ``` #use sat.ml;;```
- Pour le système suivant par exemple :   
  
  ``` Pour le système :
  | V1 OR V2 = TRUE
  | V1 XOR V3 = V2
  | NOT (V1 AND (V2 AND V3 )) = TRUE
  ````
- Il faut mettre :
  ```ocaml 
  # solveur [(OR(V(1),V(2)),TRUE);(XOR(V(1),V(3)),V(2));(NOT(AND(AND(V(1),V(2)),V(3))),TRUE)] ;;
  ````
- le résultat devrait être le suivant :
  
  ```ocaml - : (eb * bool) list list =
      [[(V 2, true); (V 1, true); (V 3, false)];
      [(V 2, false); (V 1, true); (V 3, true)];
      [(V 2, true); (V 1, false); (V 3, true)]]
  ````
  
