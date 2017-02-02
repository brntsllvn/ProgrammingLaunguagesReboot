
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








 