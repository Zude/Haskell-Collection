Aufgabe 6
=========

Thema: Rekursive Funktionen, Testen mit HUnit

> module Uebung6 where

> -- Prelude importieren und dabei die Funktionen
> -- take, (!!), concat und elem verstecken (für Aufgabenteil I)
> import Prelude hiding (take, (!!), concat, elem)

> -- Prelude "eingeschränkt" importieren, um etwa mit "Prelude.take"
> -- oder "Prelude.!!" die entsprechenden Funktionen doch nutzen zu können.
> import qualified Prelude

> -- Testing framework für Haskell importieren (für Aufgabenteil II):
> -- http://www.haskell.org/haskellwiki/HUnit_1.0_User's_Guide
> import Test.HUnit


I: Rekursive Funktionen
-----------------------

1) Definiert die folgenden Funktionen rekursiv.
   Geht dabei nach dem in der Vorlesung behandelten "Rezept" vor, wobei die
   einzelnen Schritte alle anzugeben sind (Schritte 2-4 als Kommentar, da diese
   ja noch nicht vollständig sind und Schritt 5 als Codeabschnitt).
   Die Funktionen sollen sich genauso verhalten, wie die aus der Prelude.
   Probiert ggf. mit diesen ein wenig herum um zu sehen, wie sie sich in
   Sonderfällen (wie etwa der leeren Liste oder negativen Indizes) verhalten.

a) take :: Int -> [a] -> [a]
-------------------------

(1) Definition des Typs

  take :: Int -> [a] -> [a] 

(2) Aufzählen der Fallunterscheidungen

  take n []		| n < 0  
				| n == 0 
				| n > 0  
  take n (x:xs)	| n < 0  
				| n == 0 
				| n > 0	

(3) Definition der einfachen Fälle

  take n []		| n < 0  = []
				| n == 0 = []
				| n > 0  = []
  take n (x:xs)	| n < 0  = []
				| n == 0 = []

(4) Definition der rekursiven Fälle

 
  take n (x:xs)	| n > 0  = x : take (n-1) xs 

(5) Zusammenfassen und verallgemeinern


> take :: Int -> [a] -> [a] 
> take _ [] = []				 
> take n (x:xs)	
>         | n <= 0 = []
> 	      | n > 0  = x : take (n-1) xs


b) concat :: [[a]] -> [a]
-------------------------

(1) Definition des Typs

  concat :: [[a]] -> [a]

(2) Aufzählen der Fallunterscheidungen

  concat []        
  concat (x:xs)             

(3) Definition der einfachen Fälle

  concat [] = []	
            
  

(4) Definition der rekursiven Fälle

  concat (x:xs)  = x ++ concat xs


(5) Zusammenfassen und verallgemeinern

> concat :: [[a]] -> [a] 
> concat [] = []
> concat (x:xs) = x ++ concat xs

  
c) elem :: Eq a => a -> [a] -> Bool
-----------------------------------

(1) Definition des Typs

  elem :: Eq a => a -> [a] -> Bool


(2) Aufzählen der Fallunterscheidungen
 
  elem y [] 
  elem y (x:xs)  | y == x
                 | y /= x
   

(3) Definition der einfachen Fälle

  elem y [] = False
  elem y (x:xs) | y == x = True
  
(4) Definition der rekursiven Fälle

  elem y (x:xs) | y /= x = elem y xs

(5) Zusammenfassen und verallgemeinern

> elem :: Eq a => a -> [a] -> Bool
> elem y [] = False
> elem y (x:xs)   | y == x = True
>                 | y /= x = elem y xs
              

d) (!!) :: [a] -> Int -> a
--------------------------

(1) Definition des Typs

  (!!) :: [a] -> Int -> a

(2) Aufzählen der Fallunterscheidungen


  (!!) [] y
               | y < 0
               | y > 0
               | y == 0
  (!!) (x:xs) y
               | y < 0
               | y > 0
               | y == 0
               
(3) Definition der einfachen Fälle

  (!!) [] y
               | y < 0  = error "Keine Elemente vorhanden"
               | y > 0  = error "Keine Elemente vorhanden"
               | y == 0 = error "Keine Elemente vorhanden"
  (!!) (x:xs) y
               | y < 0  = error "Falscher Index angegeben"
               | y == 0 = x

(4) Definition der rekursiven Fälle

  (!!) (x:xs) y
               | y > 0  = (!!) xs (y-1) 
               

(5) Zusammenfassen und verallgemeinern

> (!!) :: [a] -> Int -> a
> (!!) [] y = error "Keine Elemente vorhanden"
> (!!) (x:xs) y
>              | y < 0 = error "falscher index"
>              | y == 0 = x
>              | y > 0  = (!!) xs (y-1) 
             


2) Die folgende Funktion "reduce" reduziert eine natürliche Zahl n nach den
   Regeln:
     - Wenn n gerade ist, so wird n halbiert und
     - wenn n ungerade ist, so wird n verdreifacht und um 1 erhöht.

> reduce :: Integer -> Integer
> reduce n | even n    = n `div` 2
>          | otherwise = n * 3 + 1

   Wendet man nun die Funktion wiederholt auf ihr Resultat an, erhält man bei
   einem Startwert von beispielsweise 5 die Folge:
     5, 16, 8, 4, 2, 1, 4, 2, 1, 4, 2, 1, ...

   a) Definiert nun eine rekursive Funktion "collatz :: Integer -> Integer", die
      zählt wieviele Schritte benötigt werden, um eine Zahl n mit der gegebenen
      Funktion "reduce" zum ersten Mal auf 1 zu reduzieren.
      Beispiele:
        collatz  5  =  5
        collatz 16  =  4
        collatz  8  =  3
        collatz  4  =  2
        
> collatz :: Integer -> Integer       
> collatz x  
>     | x == 1 = 0
>     | x /= 1 = 1 + collatz (reduce x)


   b) Ist eure collatz-Funktion linearrekursiv? Und woran erkennt man dies?

Ja sie ist linearrekursiv, da wir nur einen rekusiven Aufruf in der Funktion haben 
(reduce hat keine Rekursion)


3) Gegeben sind zwei Funktionen zur Berechnung der Fibonacci-Zahlen:

> fib   :: Integer -> Integer
> fib 0 = 0
> fib 1 = 1
> fib n = fib (n-1) + fib (n-2)

> fib2 :: Integer -> Integer
> fib2 x = fst (fib2' x)
>          where fib2' 0 = (0, 0)
>                fib2' 1 = (1, 0)
>                fib2' n = (l + p, l)
>                          where (l, p) = fib2' (n-1)

   a) Was für Arten von Rekursion verwenden die beiden Funktionen?
      (mehrfache Rekursion, wechselseitige Rekursion, Linearrekursion, ...)
      Und woran erkennt man dies?
      In fib ist schnell zu sehen, dass dort 2 mal eine Rekursion aufgerufen wird 
      (also Mehrfachrikursiv), wärend in fib2 eine Funktion fib2' aufgreufen wird 
      und im "where teil" fib2' wieder aufgreufen wird.
      Somit ist sie eine lineare Rekursion.
      


   b) Welche Funktion ist effizienter? Und wieso?

    Die zweite Funktion ist Effizienter. Das sieht man schon deswegen, da sie
    linear ist. Gut sehen kann man es aber auch im "where teil", wo ein Rekursiver Aufruf
    gleich 2 Variablen zuweist.

   c) Wie oft wird die Funktion fib rekursiv aufgerufen, wenn "fib 4" berechnet
      werden soll?
 
          8 mal

   d) Wie sieht der genaue Funktionstyp der rekursiven Hilfsfunktion fib2' aus?
      Überlegt Euch dies anhand des Aufrufs in fib2 und des gegebenen Typs.

              fib2' :: Integer -> (Integer, Integer)
              
   e) Wie funktioniert fib2 und wozu dient hierbei die Hilfsfunktion fib2'?
      (Welche Bedeutung haben die beiden Komponenten des Tupels?)

fib2 arbeitet damit, das wir mithilfe von fib2' tupel erzeugen, die in höheren Ebenen aufadiert werden. 
Ein einfacher Fall wird daher höher gegeben und dort werden die Elemente des Tupel dann addiert. 
Das Ergebnis ist Element eines neuen Tupels wo dies wieder passiert. Unser Fst nimmt sich dann am Ende das links stehende Element des Tupels, 
was genau wie bei fib die gesuchte Zahl ist. In den Tupeln stehen immer genau die Zahl und ihr Vorgänger welche addiert dann die neue Fib Zahl ergeben.


II: Testen mit HUnit
--------------------

1) Mit der Testumgebung HUnit können leicht Tests erstellt werden um
   automatisiert prüfen zu können, ob sich bestimmte Funktionen wie geplant
   verhalten.

   Die folgenden Zeilen definieren eine Liste mit Testfällen, die bei einem
   Aufruf von "runTest" alle ausgeführt werden.
   Ein Testfall besteht dabei jeweils aus einer kurzen Beschreibung sowie zwei
   Ausdrücken, die erst ausgewertet und dann miteinander verglichen werden:
     testbeschreibung  ~:  zu_testender_ausdruck  ~?=  erwarteter_ausdruck

   Die Operatoren ~: und ~?= sind in HUnit definiert und dienen der einfacheren
   Erzeugung von Testfällen. Es gibt auch noch weitere Möglichkeiten, schaut
   hierfür ggf. auch mal in die Dokumentation von HUnit:
     http://www.haskell.org/haskellwiki/HUnit_1.0_User's_Guide

> runTest = runTestTT (test testListe) 
>   where testListe =
>           [
>           -- Tests für die take-Funktion aus der Prelude (zur Demonstration von HUnit)
>             "take mit  0 und leerer Liste"                            ~:  Prelude.take 0 ""                   ~?=  ""
>           , "take mit  0 und voller Liste"                            ~:  Prelude.take 0 "123"                ~?=  ""
>           , "take mit  2 und leerer Liste"                            ~:  Prelude.take 2 ""                   ~?=  ""
>           , "take mit  2 und voller Liste"                            ~:  Prelude.take 2 "123"                ~?=  "12"
>           , "take mit  4 und voller Liste"                            ~:  Prelude.take 4 "123"                ~?=  "123"
>           , "take mit -1 und leerer Liste"                            ~:  Prelude.take (-1) ""                ~?=  ""
>           , "take mit -1 und voller Liste"                            ~:  Prelude.take (-1) "123"             ~?=  ""
>
>           -- ...
>           -- Tests für die take-Funktion 
>           , "take mit  0 und leerer Liste"                            ~:  take 0 ""                           ~?=  ""
>           , "take mit  0 und voller Liste"                            ~:  take 0 "123"                        ~?=  ""
>           , "take mit  2 und leerer Liste"                            ~:  take 2 ""                           ~?=  ""
>           , "take mit  2 und voller Liste"                            ~:  take 2 "123"                        ~?=  "12"
>           , "take mit  4 und voller Liste"                            ~:  take 4 "123"                        ~?=  "123"
>           , "take mit -1 und leerer Liste"                            ~:  take (-1) ""                        ~?=  ""
>           , "take mit -1 und voller Liste"                            ~:  take (-1) "123"                     ~?=  ""
>
>           -- ...
>           -- Tests für die concat Funktion
>           , "concat mit leerer Liste in der Liste"                    ~:  concat [leereIntListe]              ~?=  leereIntListe
>           , "concat mit [1] in der Liste"                             ~:  concat [[1]]                        ~?=  [1]
>           , "concat mit voller Liste in der Liste"                    ~:  concat [[1,2]]                      ~?=  [1,2]
>           , "concat mit zwei Listen (voll) in der Liste"              ~:  concat [[1],[2]]                    ~?=  [1,2]
>           , "concat mit negativen Zahlen in den Listen"               ~:  concat [[(-1)],[2,(-5),(-3)]]       ~?=  [(-1),2,(-5),(-3)]
>           , "concat mit einer vollen und leeren Liste in der Liste"   ~:  concat [[3],leereIntListe]          ~?=  [3]
>
>           -- ...
>           -- Tests für die elem Funktion
>           , "elem mit 3 und leerer Liste"                             ~:  elem 3 leereIntListe                ~?=  False
>           , "elem mit 3 und voller Liste (3 enthalten)"               ~:  elem 3 [1,2,3]                      ~?=  True
>           , "elem mit 3 und voller Liste (3 nicht enthalten)"         ~:  elem 3 [1,2,4]                      ~?=  False
>           , "elem mit -3 und voller Liste (-3 enthalten)"             ~:  elem (-3) [(-3),2]                  ~?=  True
>           , "elem mit mit 0 und voller Liste (0 enthalten)"           ~:  elem 0 [0]                          ~?=  True
>
>           -- ...
>           -- Tests für die (!!) Funktion
>           , "(!!) mit leerer liste und 1"                             ~:  (!!)  leereIntListe 1               ~?=  error "Keine Elemente vorhanden"
>           , "(!!) mit Voller Liste aber zu großer Index"              ~:  (!!)  [1] 1                         ~?=  error "Keine Elemente vorhanden"
>           , "(!!) mit voller Liste und valider Index"                 ~:  (!!)  [1,2] 1                       ~?=  2 
>           , "(!!) mit voller Liste aber negativer Index "             ~:  (!!)  [1,2] (-1)                    ~?=  error "Keine Elemente vorhanden"
>
>           -- ...
>           -- ...
>           -- Tests für die (!!) Funktion mit Listkomprehensions
>           , "(!!) mit voller Liste aber negativer Index "             ~:  (!!) x y = [x y | x <- [1,2,3,4,5] , y <- 3]    ~?=  3
>
>           -- ...
>
>           ]
>           where leereIntListe :: [Int]
>                 leereIntListe = []

   a) Überlegt Euch sinvolle Testfälle für die vier Funktionen aus Aufgabe I.1)
      und erweitert den HUnit Test entsprechend. Achtet dabei auch auf
      Sonderfälle, wie leere Listen, negativen Indizes, usw.

   b) Korrigiert eure Implementierungen, falls sich diese nicht immer wie
      erwartet verhalten.

   c) Optional:
      Versucht (beispielsweise mit Hilfe von Listkomprehensions) kombinatorisch
      Testfälle für eine Funktion zu generieren.
