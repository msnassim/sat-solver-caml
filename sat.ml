type eb = V of int | TRUE | FALSE | AND of eb * eb | OR of eb * eb | XOR of eb * eb | NOT of eb;;

let rec insertion liste var = 
	match liste with
	|elt::ll -> if var = elt then liste else elt::(insertion ll var)
	|[] -> var::[];;

let rec append liste1 liste2 =
    match liste1, liste2 with
    |[],x::ll -> liste2
    |x::ll,[] -> liste1
    |[],[] -> []
    |x1::ll1, x2::ll2 -> insertion (append ll1 liste2) x1;;

let l1 = [];;

let rec recherche_var dist equ =
	match dist with
		|(var,ver)::ll -> if var = equ then ver else recherche_var ll equ;;

let rec variable equ =
	match equ with
	|AND(p1,p2) -> append (variable p1) (variable p2)
	|OR(p1,p2) -> append (variable p1) (variable p2)
	|XOR(p1,p2) -> append (variable p1) (variable p2)
	|NOT(p) -> variable p
	|TRUE -> []
	|FALSE -> []
	|_ -> equ::[];;



let rec ens_variable syst = 
	match syst with
	|(v1,v2)::ll -> append (append (variable v1) (variable v2)) (ens_variable ll)
	|[] -> [];;

let rec environnement var a =
	match var with
	|v::[] -> ((v,true)::a)::(((v,false)::a)::[])
	|v::ll -> append ((environnement ll ((v,true)::a))) ((environnement ll ((v,false)::a)));;

let rec eval_exp equ dist =
	match equ with
	|AND(p1,p2) -> (eval_exp p1 dist) && (eval_exp p2 dist)
	|OR(p1,p2) -> (eval_exp p1 dist) || (eval_exp p2 dist)
	|XOR(p1,p2) -> ((eval_exp p1 dist) || (eval_exp p2 dist)) && not ((eval_exp p1 dist) && (eval_exp p2 dist))
	|NOT(p) -> not (eval_exp p dist)
	|TRUE -> true
	|FALSE -> false
	|_ -> recherche_var dist equ;;

let rec eval_sys_equ sys_equ dist =
	match sys_equ with
	|(egaliteGauche, egaliteDroite)::ll -> if (eval_exp egaliteGauche dist) = (eval_exp egaliteDroite dist) then eval_sys_equ ll dist else false
	|[] -> true;;

let rec dist_correct sys_equ sys_dist =
	match sys_dist with
	|di::ll -> if ((eval_sys_equ sys_equ di) = true) then di else dist_correct sys_equ ll
	|[] ->  [((V(1), false))];;

let solveur sys_equ =
	dist_correct sys_equ (environnement (ens_variable sys_equ) []);;

(*ens_variable [OR(V(1), V(2)) = TRUE ; XOR(V(1), V(3)) = V(2)] ;;
append [4;6;8;3;5] [5;4;3;9;10;8];;*)

