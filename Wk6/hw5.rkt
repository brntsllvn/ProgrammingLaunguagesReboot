;; Programming Languages, Homework 5

#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value;
;; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

; a
(define (racketlist->mupllist lst)
  (cond [(null? lst) (aunit)]
        [(null? (cdr lst)) (apair (car lst) (aunit))]
        [#t (apair (car lst) (racketlist->mupllist (cdr lst)))]))

; b
(define (mupllist->racketlist lst)
  (cond [(aunit? lst) (list)]
        [(and (apair? lst) (aunit? (apair-e2 lst))) (list (apair-e1 lst))]
        [#t (cons (apair-e1 lst) (mupllist->racketlist (apair-e2 lst)))]
        ))
        
;; Problem 2

;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  (cond [(var? e) 
         (envlookup env (var-string e))]
        [(add? e)
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1) (int? v2))
               (int (+ (int-num v1) (int-num v2)))
               (error "MUPL addition applied to non-number")))
         ]
        [(int? e) e]
        [(aunit? e) (aunit)]
        [(apair? e)
         (let ([v1 (eval-under-env (apair-e1 e) env)]
               [v2 (eval-under-env (apair-e2 e) env)])
         (apair v1 v2))]
        [(fun? e)
         (closure env (fun (fun-nameopt e) (fun-formal e) (fun-body e)))]
        [(closure? e) (closure (closure-env e) (closure-fun e))]
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
           (if (and (int? v1) (int? v2))
               (if (> (int-num v1) (int-num v2))
                   (eval-under-env (ifgreater-e3 e) env)
                   (eval-under-env (ifgreater-e4 e) env))
               (error "MUPL ifgreater applied to non-number")))
         ]
        [(fst? e)
         (let ([v (eval-under-env (fst-e e) env)])
           (if (apair? v)
               (apair-e1 v)
               (error "MULP fst not operating on apair")
               ))]
        [(snd? e)
         (let ([v (eval-under-env (snd-e e) env)])
           (if (apair? v)
               (apair-e2 v)
               (error "MULP snd not operating on apair")
               ))]
        [(isaunit? e)
         (let ([v (eval-under-env (isaunit-e e) env)])
         (if (aunit? v) (int 1) (int 0)))]
        [(mlet? e)
         (letrec ([var-name (mlet-var e)]
                  [v (eval-under-env (mlet-e e) env)]
                  [new-env-var (cons var-name v)]
                  [new-env (cons new-env-var env)])
           (eval-under-env (mlet-body e) new-env))]
        [(call? e)
         (if (not (closure? (call-funexp e)))
             (error "MUPL call does not contain closure")
             (letrec ([my-closure (call-funexp e)]
                      [call-param (eval-under-env (call-actual e) '())]

                      [my-closure-env  (closure-env my-closure)]

                      [my-closure-func (closure-fun my-closure)]
                      [my-closure-func-name   (fun-nameopt my-closure-func)]
                      [my-closure-func-formal (fun-formal  my-closure-func)]
                      [my-closure-func-body   (fun-body    my-closure-func)]

                      ; extended to map function's name to the closure
                      [new-env (cons (cons my-closure-func-formal call-param ) my-closure-env)]
                      
                      [evaluated-closure-func-body (eval-under-env my-closure-func-body new-env)])
               evaluated-closure-func-body
               ))]
        [#t (error (format "bad MUPL expression: ~v" e))]))

;(struct call (funexp actual)       #:transparent)
;(struct closure (env fun)          #:transparent) 
;(struct fun  (nameopt formal body) #:transparent)


;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3

(define (ifaunit e1 e2 e3)
  (if (aunit? (eval-under-env e1 '()))
      (eval-under-env e2 '())
      (eval-under-env e3 '())))

(define (mlet* lstlst e2)
  (define (f listlist env)
    (cond [(null? listlist) (aunit)]
          [(null? (cdr listlist))
           (letrec
               ([head-var (car (car listlist))]
                [head-exp (cdr (car listlist))]
                [evaluated-head-exp (eval-under-env head-exp env)]
                [new-env (cons (cons head-var evaluated-head-exp) env)])
                new-env)]
          [#t (letrec
                  ([head-var (car (car listlist))]
                   [head-exp (cdr (car listlist))]
                   [evaluated-head-exp (eval-under-env head-exp env)]
                   [new-env (cons (cons head-var evaluated-head-exp) env)]
                   [tail (cdr listlist)])
                (f tail new-env))])
    )
  (eval-under-env e2 (f lstlst '())))




(define (ifeq e1 e2 e3 e4) "CHANGE")

;; Problem 4

(define mupl-map "CHANGE")

(define mupl-mapAddN 
  (mlet "map" mupl-map
        "CHANGE (notice map is now in MUPL scope)"))


