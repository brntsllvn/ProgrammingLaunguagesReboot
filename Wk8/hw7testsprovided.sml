(* University of Washington, Programming Languages, Homework 7
   hw7testsprovided.sml *)
(* Will not compile until you implement preprocess and eval_prog *)

(* These tests do NOT cover all the various cases, especially for intersection *)

use "hw7.sml";

(* Must implement preprocess_prog and Shift before running these tests *)

fun real_equal(x,y) = Real.compare(x,y) = General.EQUAL;

(* Preprocess tests *)

let 
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(1.0,1.0,2.0,2.0))
	val LineSegment(e,f,g,h) = LineSegment(1.0,1.0,2.0,2.0)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "preprocess leaves LineSegment as is\n")
	else (print "preprocess screwed it up!\n")
end;

let
	val Point(a,b) = preprocess_prog(LineSegment(3.2,4.1,3.2,4.1))
	val Point(c,d) = Point(3.2,4.1)
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "preprocess converts a LineSegment to a Point successfully\n")
	else (print "preprocess does not convert a LineSegment to a Point succesfully\n")
end;

let 
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,4.1,~3.2,~4.1))
	val LineSegment(e,f,g,h) = LineSegment(~3.2,~4.1,3.2,4.1)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "preprocess flips an improper LineSegment successfully\n")
	else (print "preprocess does not flip an improper LineSegment successfully\n")
end;

let 
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,4.1,3.2,~4.1))
	val LineSegment(e,f,g,h) = LineSegment(3.2,~4.1,3.2,4.1)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "preprocess flips an improper LineSegment successfully\n")
	else (print "preprocess does not flip an improper LineSegment successfully\n")
end;

let 
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,4.1,~3.2,4.1))
	val LineSegment(e,f,g,h) = LineSegment(~3.2,4.1,3.2,4.1)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "preprocess flips an improper LineSegment successfully\n")
	else (print "preprocess does not flip an improper LineSegment successfully\n")
end;

let 
    val Intersect(Point(x1,x2),Point(x5,x6))
	= preprocess_prog(Intersect(LineSegment(~3.7,1.5,~3.7,1.5),LineSegment(~3.7,1.5,~3.7,1.5))) 
    val Intersect(Point(y1,y2),Point(y5,y6))
	= Intersect(Point(~3.7,1.5),Point(~3.7,1.5))
in
	if real_equal(x1,y1) andalso real_equal(x2,y2) andalso real_equal(x5,y5) andalso real_equal(x6,y6)
	then (print "pass\n")
	else (print "fail\n")
end;


(* eval_prog tests with Shift*)
let 
	val Point(a,b) = (eval_prog (preprocess_prog (Shift(3.0, 4.0, Point(4.0,4.0))), []))
	val Point(c,d) = Point(7.0,8.0) 
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "eval_prog with empty environment worked\n")
	else (print "eval_prog with empty environment is not working properly\n")
end;

(* line *)
(* b + deltaY − m · deltaX *)
let 
	val Line(a,b) = (eval_prog (Shift(3.0, 4.0, Line(4.0,4.0)), []))
	val Line(c,d) = Line(4.0,~4.0) 
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "line shift worked: PASS\n")
	else (print "line shift broke! FAIL\n")
end;

(* A VerticalLine becomes a VerticalLine shifted by deltaX ; the deltaY is irrelevant *)
let 
	val VerticalLine(a) = (eval_prog (Shift(3.0, 4.0, VerticalLine(4.0)), []))
	val VerticalLine(b) = VerticalLine(7.0)
in
	if real_equal(a,b)
	then (print "vertical line shift worked: PASS\n")
	else (print "vertical line shift broke! FAIL\n")
end;

(* A LineSegment has its endpoints shift by deltaX and deltaY *)
let 
	val LineSegment(a,b,c,d) = (eval_prog (Shift(4.0, 4.0, LineSegment(0.0,0.0,1.0,1.0)), []))
	val LineSegment(e,f,g,h) = LineSegment(4.0,4.0,5.0,5.0)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "shift line segment: PASS\n")
	else (print "shift line segment: Fail\n")
end;

(* Using a Var *)
let 
	val Point(a,b) = (eval_prog (Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0))]))
	val Point(c,d) = Point(7.0,8.0) 
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "eval_prog with 'a' in environment is working properly: PASS\n")
	else (print "eval_prog with 'a' in environment is not working properly: FAIL\n")
end;


(* Shift(1.0,1.0,Intersect(Line(1.0,1.0),Line(1.0,0.0))) was expected to evaluate to NoPoints *)


val x = eval_prog(Shift(1.0,1.0,Intersect(Line(1.0,1.0),Line(1.0,0.0))),[])


(*
(* With Variable Shadowing *)
let 
	val Point(a,b) = (eval_prog (Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0)),("a",Point(1.0,1.0))]))
	val Point(c,d) = Point(7.0,8.0) 
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "eval_prog with shadowing 'a' in environment is working properly\n")
	else (print "eval_prog with shadowing 'a' in environment is not working properly\n")
end;




*)
