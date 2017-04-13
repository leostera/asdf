(define (square x) (* x x))

(define (square-list-1 items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons (square (car things))
                  answer))))
  (iter items null))

(define (square-list-2 items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons answer
                  (square (car things))))))
  (iter items null))

(define (square-list-3 items)
  (if (null? items)
    null
    (cons (square (car items))
          (square-list-3 (cdr items)))))

(define (square-list-1-and-reverse items)
  (define (iter things answer)
    (if (null? things)
      (reverse answer)
      (iter (cdr things)
            (cons (square (car things))
                  answer))))
  (iter items null))

(define (square-list-2-and-flatten items)
  (define (iter things answer)
    (if (null? things)
      (flatten answer)
      (iter (cdr things)
            (cons answer
                  (square (car things))))))
  (iter items null))

(square-list-1 (list 1 2 3))
(square-list-2 (list 1 2 3))
(square-list-3 (list 1 2 3))
(square-list-1-and-reverse (list 1 2 3))
(square-list-2-and-flatten (list 1 2 3))
(map square (list 1 2 3))
