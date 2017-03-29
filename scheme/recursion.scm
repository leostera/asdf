(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0 ) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

; f(n) = n if n < 3
; f(n) = f(n-1)+2*f(n-2)+3*f(n-3) if n >= 3
(define (series-for-3s n)
  (cond ((< n 3) n)
        ((or (> n 3) (= n 3))
         (+ (series-for-3s (- n 1))
            (* 2 (series-for-3s (- n 2)))
            (* 3 (series-for-3s (- n 3)))))))

(define (series-for-3s-iterative n))

(define (series-for-3s-it i n-1 n-2 n-3 result)
  (cond (= i 1))
  (series-for-3s (- n 1) (- n-1 1) (+ n-1 (* 2 n-2) (* 3 n-3))))
