
#lang racket

(provide (all-defined-out)) 

; #1
(define (sequence low high stride)
  (cond [(= low high) (cons low null) ]
        [(> low high) null]
        [#t (cons low (sequence (+ low stride) high stride))]))

; #2
(define (string-append-map xs suffix)
  (cond [(null? xs) (list)]
        [#t (map (lambda(str)(string-append str suffix)) xs)]))

; #3
(define (list-nth-mod xs n)
  (cond [(<= n -1)(error "list-nth-mod: negative number")]
        [(null? xs)(error "list-nth-mod: empty list")]
        [#t (let ([lstLength (length xs)])(list-ref xs (remainder n lstLength)))]))

; #4
(define (stream-for-n-steps s n)
  (cond [(= n 0)(list)]
        [(= n 1)(cons (car (s)) null)]
        [#t (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))]))   

; #5
(define funny-number-stream
  (letrec([f (lambda(x) (cons (if (= (remainder x 5) 0) (* x -1) x)
                              (lambda() (f(+ x 1)))))])
    (lambda() (f 1))))

; #6
(define dan-then-dog
  (letrec([f (lambda(x) (cons (if (odd? x) "dan.jpg" "dog.jpg")
                              (lambda() (f(+ x 1)))))])
    (lambda() (f 1))))

; #7
(define (stream-add-zero s)
  (define (f x)
    (cons (cons 0 (car (x))) (λ() (f (cdr (x))))))
  (λ()(f s)))
  
; #8
(define (transform-list-into-stream my-list)
  (letrec([f (λ(index) (cons
                        (list-ref my-list (remainder index (length my-list)))
                        (λ() (f(+ index 1)))))])
    (λ() (f 0))))

(define (cycle-lists xs ys)
  
  (define (transform-list-into-stream my-list)
    (letrec([f (λ(index) (cons
                          (list-ref my-list (remainder index (length my-list)))
                          (λ() (f(+ index 1)))))])
      (λ() (f 0))))
  
  (letrec([x-stream (transform-list-into-stream xs)] 
          [y-stream (transform-list-into-stream ys)])
    (define (iterator n x-stream y-stream)
      (cons (cons (car (x-stream)) (car (y-stream)))
            (λ() (iterator (+ n 1) (cdr (x-stream)) (cdr (y-stream))) )))
    (λ()(iterator 0 x-stream y-stream))
  ))
      

  

  

 ;   (
     ; cons first elements from each stream
     ; recurse through cdr of each (they're the same length: infinity)
 ;    (define (f n)
 ;      (cons 
 ;       f (+ n 1)
 ;       ))))
 ; (λ()(f xs ys)))




 