FERTIG 
Aufgabe 5
=========

Thema: Zeichenketten, Listcomprehension, Rekursive Funktionen, Äquivalenzumformungen

> module Uebung5 where

> -- Prelude ohne "sum", "and" und "last" importieren
> import Prelude hiding (sum, and, last)

> -- Modul "Char", für die Funktionen "ord" und "chr"
> import Data.Char (ord, chr)


I: Zeichen(ketten)
------------------

Mit den Funktionen "ord :: Char -> Int" und "chr :: Int -> Char" aus dem
Modul "Char" kann ein Zeichen in die entsprechende Ordinalzahl und wieder
zurück in das Zeichen konvertiert werden.
Beispiele:
  ord 'a'  =  97
  ord 'b'  =  98
  ord 'A'  =  65
  ord '0'  =  48
  ord '1'  =  49
  ord '9'  =  57
  chr 98   =  'b'
  chr 99   =  'c'
  chr 48   =  '0'

1) a) Entwickelt eine Funktion "chrIdx :: Char -> Int", die für einen Buchstaben
      (sowohl große, als auch kleine Buchstaben) den Index / die Position im
      Alphabet bestimmt. Es soll eine Zahl zwischen 0 und 25 rauskommen.
      Für alle anderen Zeichen braucht die Funktion nicht definiert zu werden.
      Ihr könnt dann jedoch auch eine Fehlermeldung (mit: error "...") ausgeben.
      Beispiele:
        chrIdx 'a'  =  0
        chrIdx 'B'  =  1
        chrIdx 'z'  =  25
        
> between left element right = (left >= element) && (element <= right)

> isLowerCase :: Char -> Bool
> isLowerCase x = between 'a' x 'z'

> isUpperCase :: Char -> Bool
> isUpperCase x = between 'A' x 'Z'

> chrIdx :: Char -> Int
> chrIdx x 
>         | isLowerCase = ord x - ord 'a'  
>         | isUpperCase = ord x - ord 'A'
>         | otherwise                    = error "blablub"



   b) Formuliert diese Funktion einmal mithilfe von Guards/Wächtern und einmal
      mit Verzweigungen (nennt sie dann beispielsweise "chrIdx2").

> chrIdx2 :: Char -> Int
> chrIdx2 x = if (ord x > 96) && (ord x < 124)
>             then ord x - ord 'a'
>             else if (ord x > 64) && (ord x < 92)
>             then ord x - ord 'A' 
>             else  error "blubbla"

2) Schreibt eine weitere kleine Funktion, die einen Buchstabenindex (Int
   zwischen 0 und 25) um einen angegebenen Wert verschiebt und anschließend
   wieder einen gültigen Buchstabenindex (also wieder ein Int zwischen 0 und 25)
   zurückgibt (also eine Rotation).
   Die Funktion soll "shiftIdx" heißen und zwei Parameter vom Typ Int bekommen.
   Der erste Parameter ist der Wert für die Verschiebung und der zweite
   Parameter ist der zu verschiebende Index.
   Beispiele:
     shiftIdx   1   0  =  1
     shiftIdx   2   4  =  6
     shiftIdx   2  25  =  1
     shiftIdx (-2)  0  =  24

> shiftIdx :: Int -> Int -> Int
> shiftIdx x y = (x + y) `mod`  26
   

3) Die folgende Funktion verschiebt den Wert eines Buchstaben c um einen
   angegebenen Wert n, unter Verwendung der Funktionen aus Aufgabe 1) und 2).
   Außerdem werden dabei kleine Buchstaben in Großbuchstaben ungewandelt.
   (Markiert diese Definition als Code (mit "> "), sobald ihr die benötigten
   Funktionen implementiert habt.)

> shiftChr'     :: Int -> Char -> Char
> shiftChr' n c = chr (shiftIdx n (chrIdx c) + ord 'A')

   a) Was passiert, wenn die Funktion mit einem Zeichen aufgerufen wird, welches
      kein Buchstabe ist? Und woran liegt das?
      
      Es wird der Error von chridx aufgerufen (BLABLUB), 
      da der Index auserhalb des Gültigkeitsbereich liegt.



   b) Definiert eine Funktion "shiftChr", die sich für Buchstaben genauso wie
      die Hilfsfunktion shiftChr' verhält (sie kann diese einfach verwenden),
      aber für nicht-Buchstaben keine Verschiebung vornimmt.
      Beispiele:
        shiftChr 1 'a'  =  'B'
        shiftChr 1 'Z'  =  'A'
        shiftChr 1 '7'  =  '7'

> shiftChr     :: Int -> Char -> Char
> shiftChr n c 
>      | (ord c < 96 && ord c > 92) || ord c > 124 || ord c < 64 = c
>      | otherwise = chr (shiftIdx n (chrIdx c) + ord 'A')



4) Entwickelt nun mit Hilfe einer Listcomprehension! eine kleine Funktion
   "rot13 :: String -> String", die die Werte aller Buchstaben in einer
   Zeichenkette um 13 Stellen verschiebt. Verwendet hierfür die Funktion
   "shiftChr" aus Aufgabe 3b), damit Zeichen, die keine Buchstaben sind,
   hierbei nicht verändert werden.
   Beispiele:
     rot13 "Hallo Welt"  =  "UNYYB JRYG"
     rot13 "UNYYB JRYG"  =  "HALLO WELT"
     rot13 "Test 123"    =  "GRFG 123"
     
> rot13 :: String -> String
> rot13 s = [ x | x <- map (shiftChr 13 ) s] 


II: Rekursive Funktionen
------------------------

1) Die aus der Vorlesung bekannte Definition der Funktion sum:

> sum        :: Num a => [a] -> a
> sum []     = 0
> sum (x:xs) = x + (sum xs)

   Über eine Äquivalenzumformung lässt sich zeigen, dass sum [1,2,3] = 6 gilt:

       sum [1,2,3]
   <=> sum (1:2:3:[])       Liste nur anders aufgeschrieben
   <=> 1 + sum (2:3:[])     Definition von 'sum' angewendet
   <=> 1 + 2 + sum (3:[])   Definition von 'sum' angewendet
   <=> 3 + sum (3:[])       Definition vom ersten '+' angewendet
   <=> 3 + 3 + sum []       Definition von 'sum' angewendet
   <=> 6 + sum []           Definition vom ersten '+' angewendet
   <=> 6 + 0                Definition von 'sum' angewendet
   <=> 6                    Definition von '+' angewendet

   q.e.d. 

   a) Entwickelt analog zu sum eine rekursive Funktion "and :: [Bool] -> Bool",
      die eine logische Und-Verknüfpung aller Werte einer Liste durchführt.
      Beispiele:
        and [True, False, True]  =  False
        and [True, True]         =  True

> and :: [Bool] -> Bool
> and [] = True 
> and (x:xs) = x && (and xs)
 
       
   b) Wie oft wird die Funktion aufgerufen, wenn "and [True, True]" ausgewertet
      werden soll?
      
      Sie wird 3 mal aufgerufen,
      der Generelle Funktionsaufruf, dann für das zweite True und dann
      für die leere liste.



   c) Beweist mit Hilfe von Äquivalenzumformungen, dass
      and [True, True, False] = False gilt.
      
      and [True, True, False]
  <=> and (True:True:False:[])
  <=> True && and (True:False:[])
  <=> True && True and (False:[])
  <=> True && True && False and []
  <=> False && and []
  <=> False && True
  <=> False
  	

2) Schreibt eine rekursive Variante der Funktion "rot13" aus Aufgabe I 4), die
   ohne Listcomprehension arbeitet.

> rot13' :: String -> String
> rot13' "" = ""
> rot13' (x:xs) = shiftChr 13 x : rot13 xs 

3) Wie könnte man die Funktion "last :: [a] -> a", die das letzte Element einer
   Liste zurückgibt, rekursiv definieren?
   Tipp: Ebenso wie head, ist auch last für leere Listen nicht definiert.

> last :: [a] -> a
> last [] = error "Apfelkuchen"
> last [x] = x 
> last (x:xs) = last xs

4) In der letzten Übung sollte optional eine Hilfsfunktion entwickelt werden,
   die überprüft, ob alle Elemente in einer Liste vom Typ [Int] gerade Zahlen
   sind.
   Die folgenden Funktionsdefinitionen erfüllen beispielsweise diese Aufgabe:

     validateSumLst     :: [Int] -> Bool
     validateSumLst xs  = [ x | x <- xs, not (even x) ] == []

     validateSumLst2    :: [Int] -> Bool
     validateSumLst2 xs = and [ even x | x <- xs ]

     validateSumLst3    :: [Int] -> Bool
     validateSumLst3 xs = and (map even xs)


   Definiert nun eine Funktion, die diese Aufgabe rekursiv erfüllt (also ohne
   Listcomprehension und ohne "map").

> validateSumLst4 :: [Int] -> Bool
> validateSumLst4 [] = error "Bananenkuchen"
> validateSumLst4 [x] = even x
> validateSumLst4 (x:xs) = even x && (validateSumLst4 xs)




