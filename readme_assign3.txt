Assignment 3 Readme file
Reference: https://docs.racket-lang.org/reference/index.html

Assumptions:
Dates are given as (list yyyy mm dd)


Test Cases

is_older(d1 d2) -> #t/#f

(is_older (list 2001 1 2) (list 2001 1 2)) 

(is_older (list 2001 1 2) (list 2001 1 3))
(is_older (list 2001 1 2) (list 2001 2 1))
(is_older (list 2001 1 2) (list 2001 2 2))

(is_older (list 2003 5 12) (list 2003 4 12) )
(is_older (list 2003 5 12) (list 2003 4 13))
(is_older (list 2003 5 12) (list 2003 3 11))
(is_older (list 2003 5 12) (list 2001 5 12))

#f
#t
#t
#t
#f
#f
#f
#f

number_in_month(date month) -> number

(number_in_month (list (list 2001 1 1) (list 2001 1 2) (list 2001 2 5) (list 2003 3 5) (list 2003 3 3) (list 2005 7 6)) 1)
(number_in_month (list (list 2001 1 1) (list 2001 1 2) (list 2001 2 5) (list 2003 3 5) (list 2003 3 3) (list 2005 7 6)) 2)
(number_in_month (list (list 2001 1 1) (list 2001 1 2) (list 2001 2 5) (list 2003 3 5) (list 2003 3 3) (list 2005 7 6)) 3)
(number_in_month (list (list 2001 1 1) (list 2001 1 2) (list 2001 2 5) (list 2003 3 5) (list 2003 3 3) (list 2005 7 6)) 4)
(number_in_month (list (list 2001 1 1) (list 2001 1 2) (list 2001 2 5) (list 2003 3 5) (list 2003 3 3) (list 2005 7 6)) 5)

2
1
2
0
0

number_in_months(dates months) -> number

(number_in_months (list (list 2001 1 2) (list 2001 2 3) (list 2002 3 5) (list 2002 5 9)
                        (list 2002 5 12) (list 2002 5 14) (list 2004 1 2) (list 2004 7 6) 
                        (list 2008 9 12) (list 2008 5 13) )
                        (list 1 5 7))

(number_in_months (list (list 2001 1 2) (list 2001 2 3) (list 2002 3 5) (list 2002 5 9)
                        (list 2002 5 12) (list 2002 5 14) (list 2004 1 2) (list 2004 7 6) 
                        (list 2008 9 12) (list 2008 5 13) )
                        (list 1 4 8))

(number_in_months (list  )
                        (list 1 4 8))

7
2
0


dates_in_month(dates month)-> list

(dates_in_month (list 
                    (list 2005 5 6) (list 2006 3 12) (list 2005 5 6) (list 2005 6 5) 
                    (list 2006 12 3) (list 2005 3 5) (list 2008 11 5) (list 2009 3 5)
                    (list 2010 4 30) (list 2011 9 8) (list 2011 12 6) (list 2022 12 25) (list 2023 12 25)

                ) 5)

(dates_in_month (list 
                    (list 2005 5 6) (list 2006 3 12) (list 2005 5 6) (list 2005 6 5) 
                    (list 2006 12 3) (list 2005 3 5) (list 2008 11 5) (list 2009 3 5)
                    (list 2010 4 30) (list 2011 9 8) (list 2011 12 6) (list 2022 12 25) (list 2023 12 25)

                ) 12)

(dates_in_month (list 
                    (list 2005 5 6) (list 2006 3 12) (list 2005 5 6) (list 2005 6 5) 
                    (list 2006 12 3) (list 2005 3 5) (list 2008 11 5) (list 2009 3 5)
                    (list 2010 4 30) (list 2011 9 8) (list 2011 12 6) (list 2022 12 25) (list 2023 12 25)

                ) 9)

(dates_in_month (list 
                    (list 2005 5 6) (list 2006 3 12) (list 2005 5 6) (list 2005 6 5) 
                    (list 2006 12 3) (list 2005 3 5) (list 2008 11 5) (list 2009 3 5)
                    (list 2010 4 30) (list 2011 9 8) (list 2011 12 6) (list 2022 12 25) (list 2023 12 25)

                ) 7)

'((2005 5 6) (2005 5 6))
'((2006 12 3) (2011 12 6) (2022 12 25) (2023 12 25))
'((2011 9 8))
'()
