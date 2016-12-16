
fun same_string(s1 : string, s2 : string) = s1 = s2

(*-----------*)
(* Problem 1 *)
(*-----------*)

(*-----*)
(* (a) *)
(*-----*)
fun all_except_option(str,strLst) =
  let
      fun aux(strLst,acc) =
	case strLst of
	    [] => acc
	  | head::tail => if same_string(str,head)
			  then aux(tail,acc)
			  else aux(tail,head::acc)
  in
      let
	  val auxResult = aux(strLst,[])
	  val listContainsStr = length auxResult <> length strLst
      in
      case strLst of
	  [] => NONE		    
	| _ => if listContainsStr then SOME(auxResult) else NONE	  
      end
  end						     
   
(*-----*)
(* (b) *)
(*-----*)
fun get_substitutions1(strLstLst,name) =
  case strLstLst of
      [] => []
    | head::tail => case all_except_option(name, head) of
			NONE => get_substitutions1(tail,name)
		      | SOME(x) => x @ get_substitutions1(tail,name)

(*-----*)
(* (c) *)
(*-----*)							
fun get_substitutions2(strLstLst,name) =
  let fun aux(strLstLst,acc) = case strLstLst of
	    [] => acc
	  | head::tail => case all_except_option(name, head) of
			      NONE => aux(tail,acc)
			    | SOME([]) => aux(tail,acc) 
			    | SOME(x) => aux(tail,x @ acc)
  in
      aux(strLstLst,[]) 
  end

(*-----*)
(* (d) *)
(*-----*) 
fun similar_names(strLstLst,{first=fir,middle=mid,last=las}) =
  case strLstLst of [] => [{first=fir,middle=mid,last=las}] | _ =>
      let
	  val subs = get_substitutions2(strLstLst,fir)
	  fun createAlternateNames(subs) =
	    case subs of
		[] => [{first=fir,middle=mid,last=las}]
	      | head::tail => createAlternateNames(tail) @ [{first=head,middle=mid,last=las}] 
      in
	  createAlternateNames(subs)
      end

(*-----------*)
(* Problem 2 *)
(*-----------*)
			     
(* you may assume that Num is always used with values 2, 3, ..., 10 though it will not really come up *)
	  
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(*-----*)
(* (a) *)
(*-----*)	      
fun card_color(someCard) =
  case someCard of
      (Hearts,_) => Red
    | (Diamonds,_) => Red
    | (Spades,_) => Black
    | (Clubs,_) => Black 

(*-----*)
(* (b) *)
(*-----*)		   
fun card_value(someCard) =
  case someCard of
      (_,Jack) => 10
    | (_,King) => 10
    | (_,Queen) => 10
    | (_,Ace) => 11 
    | (_,Num x) => x

(*-----*)
(* (c) *)
(*-----*)
exception MyExceptionForStuffs
		       
fun remove_card(cards,cardToRemove,ex) =
  let
      fun aux(cards,cardToRemove) =
	case cards of  
	    [] => []
	  | head::tail => if head = cardToRemove
			  then tail
			  else head :: remove_card(tail,cardToRemove,ex)
      val result = aux(cards,cardToRemove)
  in
      case result of
	  [] => raise ex
	| _ => if length result = length cards
	       then raise ex
	       else result
  end

(*-----*)
(* (d) *)
(*-----*)      
fun all_same_color(cards) =
  case cards of
      [] => false
    | _::[] => true 
    | (headSuit,headRank)::((neckSuit,neckRank)::rest) =>
      (headSuit = neckSuit andalso all_same_color((neckSuit,neckRank)::rest))

(*-----*)
(* (e) *)
(*-----*)
fun sum_cards(cards) =
  let
      fun aux_sum(cards,acc) =
	case cards of
	    [] => acc
	  | head::[] => card_value(head)+acc  
	  | head::tail => aux_sum(tail,card_value(head)+acc)
  in
      aux_sum(cards,0)
  end
		     

	      
