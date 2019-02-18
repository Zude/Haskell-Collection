Übung: Grundlagen der Funktionalen Programmierung
Autor: Malte Heins
Datum: 2016-10-19
Thema: ein paar Beispielfunktionen

>   copyMe :: [a] -> [a]
>   copyMe xs       = xs ++ xs

>   boxIt :: (a,b) -> ([a],[b])  
>   boxIt (x, y)    = ([x], [y])


>   isSmall :: (Num a, Ord a) => a -> Bool
>   isSmall n      = n < 10  
 
>   pair :: a -> b -> (a,b)     
>   pair x y        = (x, y)

>   toList :: (a,a) -> [a]
>   toList (x,y)   = [x,y]
>   blp :: Bool -> [Bool]
>   blp x           = toList (pair x True)

>   apply f x       = f x


>   plus1 n         = 1 + n










  



