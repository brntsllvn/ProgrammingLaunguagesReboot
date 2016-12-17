(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* Solutions for problem 1 follow *)

(* 1.a
   Step 1: Filter the string out of the list into a new value
        2: Check if the filtered list is now smaller. If so, return SOME. *)
fun all_except_option(str, strs) =
  let
    fun filter [] = []
      | filter (x::xs') = if same_string(str, x) then xs' else x :: filter(xs')
    val filtered_strs = filter(strs)
  in
    if length(strs) > length(filtered_strs) then SOME filtered_strs else NONE
  end


(* 1.b
   For each list of strings, check if there are any substitutions.
   When there are substitutions, append them to the list of results. *)
fun get_substitutions1(sls, s) =
  case sls of
         [] => []
       | sl::sls' => case (all_except_option(s, sl)) of
                         NONE =>  get_substitutions1(sls', s)
                       | SOME sl => sl @ get_substitutions1(sls', s)


(* 1c: Like 1b, but with a tail-recursive function.
       The helper function splits the (string list) list into head and tail.
       - If there's no tail, stop recursing, test for a match, and return the
         accumulator with any matching aliases from the final string.
       - If there is a tail, add any matches, then keep recursing. *)
fun get_substitutions2 (sls, s) =
  let
    fun subs ([], acc) = acc
      | subs (sl::sls', acc) =
        case (sls', all_except_option(s, sl)) of
             ([], NONE) => acc
           | ([], SOME x) => acc @ x
           | (sls', NONE) => acc @ subs(sls', acc)
           | (sls', SOME x) => acc @ x @ subs(sls', acc)
  in
   subs (sls, [])
  end 

(* 1d
   Recursive alias expansion. I couldn't use tail recursion as ordering matters,
   and names aren't associative, AFAICT.
   Start with the original name. Then, find the aliased name in each substition,
   replace the first name with it, and cons the result to the list of names. *)
fun similar_names (sls, name) =
  let
    val {first=f, middle=m, last=l} = name
    fun alias [] = []
      | alias (s::subs') = {first=s, middle=m, last=l} :: alias(subs')
  in
    {first=f, middle=m, last=l} :: alias(get_substitutions1(sls, f))
  end
    

(* QUESTION 2 *)
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove


(* 2.a *)
fun card_color (Clubs, rank) = Black
  | card_color (Spades, rank) = Black
  | card_color (_, rank) = Red (* Other suits are Red *)

(* 2.b *)
fun card_value (suit, Ace) = 11
  | card_value (suit, Num x) = x
  | card_value (suit, rank) = 10 (* Any other card is royal, so is worth 10 *)

(* 2.c *)
fun remove_card (cs, c, e) =
  case cs of
       [] => raise e
     | c_hd::[] => if c = c_hd then [] else raise e
     | c_hd::cs' => if c = c_hd then cs' else c_hd :: remove_card (cs', c, e)

(* 2.d *)
fun all_same_color cards =
  case cards of
       [] => true
     | c1::[] => true
     | c1::(c2::[]) => card_color c1 = card_color c2
     | c1::(c2::cs) => card_color c1 = card_color c2
                       andalso all_same_color (c2::cs)

(* 2.e *)
fun sum_cards cards =
  let fun add ([], acc) = acc
    | add (c::cs', acc) = acc + card_value c + add (cs', acc)
  in
    add (cards, 0)
  end

(* 2.f *)
fun score (cards, goal) =
  let
    (* Calculate same_color bonus here, use after +/- val of delta is known. *)
    val color_bonus = 1 + (if all_same_color cards then 1 else 0)
    val delta = sum_cards(cards) - goal
  in
    (if delta <= 0 then ~delta else 3* delta) div color_bonus
  end

(* 2.g *)
fun officiate (cards, moves, goal) =
  let
    fun play ([], moves, held) = score (held, goal) (* raise IllegalMove? *)
      | play (cards, [], held) = score (held, goal)
      | play (c::cards', m::moves', held) =
        if sum_cards held >= goal then score (held, goal)
        else case m of
             Draw => play(cards', moves', c::held)
           | Discard d => play(c::cards', moves',
                               remove_card(held, d, IllegalMove))
  in
    play (cards, moves, [])
  end
