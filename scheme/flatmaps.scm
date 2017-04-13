(require math/number-theory)

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

(define (count from to)
  (define (iter n acc)
    (if (< n 0)
      null
      (cons acc (iter (- n 1) (+ acc 1)))))
  (iter (- to from) from))

(define (sum-pair n) (+ (car n) (cadr n)))

(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (count 1 (- i 1))))
           (count 1 n)))

(define (prime-sum? n) (prime? (sum-pair n)))

(define (prime-sums n)
  (map sum-pair
       (filter prime-sum?
               (unique-pairs n))))
