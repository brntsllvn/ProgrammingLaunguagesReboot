#lang racket
;; Programming Languages Homework 5 Simple Test
;; Save this file to the same directory as your homework file
;; These are basic tests. Passing these tests does not guarantee that your code will pass the actual homework grader

;; Be sure to put your homework file in the same folder as this test file.
;; Uncomment the line below and, if necessary, change the filename
(require "hw5.rkt")

(require rackunit)

(define tests
  (test-suite
   "Sample tests for Assignment 5"
   
   ;; check racketlist to mupllist with normal list
   (check-equal? (racketlist->mupllist (list)) (aunit))
   (check-equal? (racketlist->mupllist (list (int 3))) (apair (int 3) (aunit)))
   (check-equal? (racketlist->mupllist (list (int 3) (int 4)))
                 (apair (int 3) (apair (int 4) (aunit))) "racketlist->mupllist test")
   (check-equal? (racketlist->mupllist (list (apair (int 1) (aunit))))
                 (apair (apair (int 1) (aunit)) (aunit)))
      
   ;; check mupllist to racketlist with normal list
   (check-equal? (mupllist->racketlist (aunit)) (list))
   (check-equal? (mupllist->racketlist (apair (int 4) (aunit))) (list (int 4)))
   (check-equal? (mupllist->racketlist (apair (int 3) (apair (int 4) (aunit))))
                 (list (int 3) (int 4)) "racketlist->mupllist test")
   (check-equal? (mupllist->racketlist (apair (apair (int 1) (aunit)) (aunit)))
                 (list (apair (int 1) (aunit))))

   ;; test drive envlookup
   (check-exn exn:fail? (λ () (envlookup (list) "hi")))
   (check-equal? (envlookup (list (cons "var" 2)) "var") 2)
   (check-equal? (envlookup (list (cons "var" 2) (cons "hi" 17)) "hi") 17)
   (check-exn exn:fail? (λ () (envlookup (list (cons "var" 2)) "hi")))

   (check-equal? (eval-under-env (int 17) (list)) (int 17))
   (check-equal? (eval-under-env (add (int 1) (int 2)) (list)) (int 3))
   (check-equal? (eval-under-env (add (int 1) (var "hi")) (list (cons "hi" (int 17)))) (int 18))
   (check-equal? (eval-under-env (aunit) (list)) (aunit))
   (check-exn exn:fail? (λ () (eval-under-env (add (int 1) (aunit)))))
   (check-equal? (eval-under-env (apair (int 1) (int 1)) (list)) (apair (int 1) (int 1)))
   (check-equal? (eval-under-env (apair (add (int 1) (int 2)) (aunit)) (list)) (apair (int 3) (aunit)))
   (check-equal? (eval-under-env (fun "myfun" "x" "x+2") (list))
                 (closure (list) (fun "myfun" "x" "x+2")))
   (check-equal? (eval-under-env (closure (list) (fun "myfun" "x" "x+2")) (list))
                 (closure (list) (fun "myfun" "x" "x+2")))
   
   ;; ifgreater
   (check-exn exn:fail? (λ() (eval-exp (ifgreater (int 3) (aunit) (int 3) (int 2)))))
   (check-equal? (eval-exp (ifgreater (int 3) (int 4) (int 3) (int 2))) (int 2) "ifgreater test")
   (check-equal? (eval-exp (ifgreater (int 5) (int 4) (int 1) (int 0))) (int 1))
   
   ;; mlet test
   (check-equal? (eval-exp (mlet "x" (int 1) (var "x"))) (int 1))
   (check-equal? (eval-exp (mlet "x" (int 1) (add (int 5) (var "x")))) (int 6) "mlet test")
   (check-exn exn:fail? (λ() (eval-exp (mlet "x" (int 1) (var "y")))))
   
   ;; call test
   (check-exn exn:fail? (λ() (eval-exp (call (var "x") (var "x")))))
   (check-equal? (eval-exp (call (closure '() (fun #f "x" (var "x"))) (int 2))) (int 2))
   (check-equal? (eval-exp (call (closure '() (fun #f "x" (add (var "x") (int 7)))) (int 1))) (int 8) "call test")
   (check-equal? (eval-exp (call (closure '() (fun #f "x" (add (var "x") (int 7)))) (add (int 1) (int 3)))) (int 11))
   (check-equal? (eval-exp (call (closure '() (fun "my-func" "x" (var "x"))) (int 2))) (int 2))
   
   ;; fst
   (check-exn exn:fail? (λ() (eval-exp (fst (aunit))))) 
   (check-equal? (eval-exp (fst (apair (int 1) (int 2)))) (int 1))
   (check-equal? (eval-exp (fst (apair (add (int 1) (int 3)) (int 2)))) (int 4))
   
   ;; snd
   (check-exn exn:fail? (λ() (eval-exp (snd (aunit))))) 
   (check-equal? (eval-exp (snd (apair (int 1) (int 2)))) (int 2) "snd test")
   (check-equal? (eval-exp (snd (apair (int 1) (add (int 1) (int 3))))) (int 4) "snd test")
   
   ;; isaunit test
   (check-equal? (eval-exp (isaunit (aunit))) (int 1))
   (check-equal? (eval-exp (isaunit (closure '() (fun #f "x" (aunit))))) (int 0) "isaunit test")
   
   ;; ifaunit test
   (check-equal? (eval-exp (ifaunit (aunit) (int -1) (int 2))) (int -1))
   (check-equal? (eval-exp (ifaunit (int 1) (int 2) (int 3))) (int 3) "ifaunit test")
   
   ;; mlet* test
   (check-equal? (eval-exp (mlet* (list (cons "x" (int 10))) (var "x"))) (int 10) "mlet* test")
   
   ;; ifeq test
   ;(check-equal? (eval-exp (ifeq (int 1) (int 2) (int 3) (int 4))) (int 4) "ifeq test")
   
   ;; mupl-map test
   ;(check-equal? (eval-exp (call (call mupl-map (fun #f "x" (add (var "x") (int 7)))) (apair (int 1) (aunit)))) 
   ;              (apair (int 8) (aunit)) "mupl-map test")
   
   ;; problems 1, 2, and 4 combined test
   ;(check-equal? (mupllist->racketlist
   ;(eval-exp (call (call mupl-mapAddN (int 7))
   ;                (racketlist->mupllist 
   ;                 (list (int 3) (int 4) (int 9)))))) (list (int 10) (int 11) (int 16)) "combined test")
   
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)
