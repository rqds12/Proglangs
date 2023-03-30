;Seth Kroeker
;COSC 4153 Programming Languages
;Assign 3
;Feb 3, 2023
;Operating System: EndeaverOS
;Editor: VSCode
;Language Racket

#lang racket

;dates are defined as 
;(yyyy mm dd)

;get_month takes in a date tuple and retrieves the month, which is the second element
(define (get_month date)
    (first (rest date))
)

;is_older takes in two dates and compares the two dates
;d1,d2 are dates
(define (is_older d1 d2)
    
    (define (is_older_inner d1 d2)
        (cond 
        [(empty? d1) #f]
        [(< (first d1) (first d2)) #t]
        [(> (first d1) (first d2)) #f]
        [else (is_older_inner (rest d1) (rest d2))]
        )
    )
    (cond
        [(and (= (length d1) 3) (= (length d2) 3)) (is_older_inner d1 d2)]
        
    )
    
)
;number_in_month counts the number of dates that are in the given month
;date is a list
;month is an int
(define (number_in_month date month)
    ;returns an integer value depending on the truth of the statement
    (define (equal_1 x y)
        (cond
        [(= x y) 1]
        [else 0]
        )
    )
    ;inner recursion 
    (define (x date month cont)
        (cond
        [(empty? date) 0]
        [(empty? (first date)) 0]
        [else (+ (equal_1 (first (rest (first date))) month)  (x (rest date) month cont) )]
            
        )
    )
    (x date month 0)
)
;number_in_months returns the number of dates that are in the list of months
;dates is a list of dates
;months is a list of ints
(define (number_in_months dates months) 

    (cond
    [(empty? months) 0]
    [else (+ (number_in_month dates (first months)) (number_in_months dates (rest months)))]
    )
)
;append-my appends two lists
(define (append-my l1 l2)
    (cond 
    [(empty? l1) l2]
    [(null? (cdr l1))  (cons (car l1) l2)]
    [else (cons (car l1) (append-my (rest l1) l2))]
    )
) 
;date_in_month? returns a truth value of whether a given date is in a month
(define (date_in_month? date month)
    (cond
    [(= (get_month date) month) #t]
    [else #f]
    )
)
;filter-my   a generic filter function that filters a list l based on a function f
(define (filter-my f l)
    ;inner recursion so that filtered is the empty list to fill
    (define (filter-inner f l filtered) 
        (cond
        [(empty? l) (list)]
        [else 
            (cond
            [(f (car l))  (append-my (list (car l)) (filter-inner f (rest l) filtered))]
            [else (append-my (list) (filter-inner f (rest l) filtered))]
            )        
        ]
    )
    )
    (filter-inner f l (list))
)
;dates_in_month    returns the dates that are in a given month
;dates is a list of dates
;month is an int
(define (dates_in_month dates month)
    (filter-my (lambda (x) (date_in_month? x month)) dates)
) 

