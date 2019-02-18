FERTIG

Aufgabe 1
=========

Thema: Ausdrücke und Typen

Aufgabenstellung
----------------

In dieser ersten Aufgabe wollen wir uns mit einfachen Ausdrücken und deren Typen
beschäftigen.
Hierfür sind ein paar Werte vorgegeben, für die ihr die Typen bestimmen sollt.


I. Einfache Ausdrücke
---------------------

Überlegt euch für die folgenden 15 Ausdrücke, welchen Typ sie jeweils besitzen.

Tipp: Zwei der Ausdrücke sind ungültig.
Welche sind das und wieso sind sie ungültig?

Beispiel:

   -  '7' :: Char

Aufgaben:

   1. True                       :: Bool
   2. (False, True)              :: (Bool, Bool)
   3. [False, True]              :: [Bool]
   4. "True"                     :: String   
   5. ['4', '2']                 :: [Char]
   6. ["4", "2"]                 :: [String]
   7. ([True], "True")           :: ([Bool],String)
   8. [("a", 'b'), ("A", 'B')]   :: [(String,Char)]
   9. [1, 2, 3]                  :: [Int]
  10. ['O', '0', 0]              :: Fehler: In einer Liste dürfen die Elemente nur von einem Datentyp sein
  11. [[], ['0'], ['1', '2']]    :: [[Char]]
  12. ["foo", ['b', 'a', 'r']]   :: [[Char]]
  13. ("head", head)             :: (String, [a]->a) 
  14. [head, length]             :: [[Int]->Int]
  15. blub                       :: Falsch: Kein gültiger Datentyp

Kontrolliert anschließend eure Ergebnisse mit dem ghci.
Dies ist mit dem Befehl :type möglich.


II. Funktionen
--------------

Analog zur vorherigen Aufgabe sind nun die Typen einiger Funktionen zu
bestimmen.

Beispiel:

    head :: [a] -> a
    head (x:xs) = x
    

Funktionsdefinitionen:

1.   copyMe :: [a] -> [a]                         Der ++ Operator bezieht sich nur auf Listen => beides muss [a] sein
     copyMe xs       = xs ++ xs                   Die Funktion "verbindet" 2 Listen miteinander 

2.   boxIt :: (a,b) -> ([a],[b])                  Die Funktion nimmt 2 Elemente eines Tupels und schreibt jedes Element in eine Liste. Diese sind dann wieder in einem Tupel   miteinander           
     boxIt (x, y)    = ([x], [y])                 


3.   isSmall :: (Num a, Ord a) => a -> Bool       Die Funktion prüft, ob die eingabe kleiner als 10 ist. a wird hier Klassifiziert als Num bzw Ord Wert.
     isSmall n      = n < 10  
 
4.   pair :: a -> b -> (a,b)                      Hier werden 2 Parameter in ein Tupel geschrieben 
     pair x y        = (x, y)

5.   toList :: (a,a) -> [a]                       Hier werden 2 Parameter des gleiches Datentyps als Tupel übergeben und in eineListe geschrieben
     toList (x,y)   = [x,y]

6.   blp :: Bool -> [Bool]                        Hier wird auf dem Parameter (der Bool sein muss) die Funktion pair angewendet, um das Ergebnis welches ein Tupel 
     blp x           = toList (pair x True)       ist  (mit Parameter x und True) dann mithilfe von blp als Liste zu schreiben (mit Elementen vom Typ Bool)
    
7.   (b -> a) -> b -> a                           Diese Funktion wendet eine Funktion an, die wir als ersten Parameter  auf unseren 2ten Parameter x übergeben. 
     apply f x       = f x                        Das Ergebnis ist daher die Funktion f angewendet auf x. ZB apply plus1 3                                            

8.   plus1 :: Num a => a -> a                     Hier wird die Eingabe (a ist hier Klassifiziert als Num) um 1 erhöht                   
     plus1 n         = 1 + n

>   splitAtPos :: Int -> [a] -> ([a],[a])         Hier wird eine beliebige Liste  bis zu Stelle n ausgeschnitten und dann die gleiche Liste ab 
>   splitAtPos n xs = (take n xs, drop n xs)      der Stelle n (bis zum Ende) ausgeschnitten. Diese 2 "neuen" Listen werden dann in ein Tupel geschrieben.


III. Beweise
------------

Die Funktionen sum und prod seien wie folgt definiert:

    sum []     = 0
    sum (x:xs) = x + sum xs

    prod []     = 1
    prod (x:xs) = x * prod xs


mithilfe von Äquivalenzumformungen kann man beispielsweise zeigen,
dass prod [6,7] = 42 gilt:

        prod [6,7]
    <=> prod (6:7:[])     Liste nur anders aufgeschrieben
    <=> 6 * prod (7:[])   Definition von 'prod' angewendet
    <=> 6 * 7 * prod []   Definition von 'prod' angewendet
    <=> 42 * prod []      Definition von '*' angewendet
    <=> 42 * 1            Definition von 'prod' angewendet
    <=> 42                Definition von '*' angewendet

Zeigt nun mithilfe von Äquivalenzumformungen, dass folgende Aussagen gelten:

1.  sum [3,4,5] 		
  <=> sum (3:4:5:[])		Liste nur anders aufgeschrieben
  <=> 3 + sum (4:5:[]) 		Definition von 'sum' angewendet
  <=> 3 + 4 + sum (5:[]) 	Definition von 'sum' angewendet
  <=> 3 + 4 + 5 + sum [] 	Definition von 'sum' angewendet
  <=> 3 + 4 + 5 + 0 		Definition von 'sum' angewendet
  <=> 12			Definition von '+' angewendet
  

    

  2. prod [x] = x   -- für alle Zahlen x gilt:
<=> prod (x:[])	= x		Liste nur anders aufgeschrieben
<=> x * prod []	= x		Definition von 'prod' angewendet
<=> x * 1 	= x		Definition von 'prod' angewendet
<=> x		= x		Definition von '*' angewendet


IV. freiwillige Zusatzaufgabe: Syntaxfehler
-------------------------------------------

Der folgende Ausschnitt enthält drei syntaktische Fehler.
Findet heraus welche dies sind und behebt sie.

n = (div) a (length xs)
    where
       a = 10
      xs = [1..5]
