(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (append! seq1 seq2)
  (accumulate cons seq2 seq1))

(define (dupe x) (list x x))

(define (flatmap proc seq)
  (accumulate append! null (map proc seq)))

(define (flatmap-with-builtins proc seq)
  (foldr append null (map proc seq)))

(define (permutations s)
  (if (null? s) ; empty set
    (list null) ; sequence containing empty set
    (flatmap (lambda (x)
               (map (lambda (p) (cons x p))
                    (permutations (remove x s)))) ; recurse with the rest of the
                                                  ; elements of the set
             s)))
