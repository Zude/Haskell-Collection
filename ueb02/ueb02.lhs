FERTIG

Aufgabe 2
=========

Thema: Polymorphie und Typklassen

Aufgabenstellung
----------------

In dieser Aufgabe wollen wir uns mit polymorphen Typen, also Typen die
Typvariablen enthalten, und dem Überladen von Typen beschäftigen.


I.

Guckt euch die Haskell-Typhierarchie unter [1] an. In welchen Fällen
sollte man Typen (z.B. Int oder Char) nutzen und wo sollte man lieber
auf Typklassen (Eq, Ord etc.) zurückgreifen?

[1] https://www.haskell.org/onlinereport/basic.html#standard-classes

Typen sollte man dann benutzen, wenn die Funktion die man zb selbst erstellt,
nur für einen speziellen Typen gelten soll. Es gibt durchaus Funktionen die in
ihrer Art nur für einen Typen sinnvoll sind.
Soll die Funktion aber ein größeres Spektrum abdecken, also für mehrere Typen 
funktionieren, macht natürlich die Typklasse mehr Sinn.
Ein Typ ist of zu "eingeschränkt" wärend eine Typklasse ein Spektrum Sinnvoller Typen
abdeckt. Bsp: Die == Funktion. Diese macht auch Sinn bei anderen Typen und nicht nur
bei Ints zb. 


II.

Gegeben sind die beiden folgenden Funktionsdefinitionen (inkl. Typsignatur):

 longList l :: [Int] -> Bool
 longList l = length l > 10

 smaller :: Int -> (Int -> Int)
 smaller x y = if x <= y then x else y

> isEq :: Double -> Double -> Double -> Bool
> isEq x y z = (x == y) && (y == z)

1) a) Was macht die Funktion "longList"?
   Die Funktion nimmt als Parameter eine Liste, wertet die Länge dieser Liste aus
   und schaut, ob dieser Wert größer als 10 ist. Das Ergebniss ist daher ein Bool.

   b) Wie müsste der Typ definiert
      werden, damit sie dies nicht mehr ausschließlich für Listen mit Elementen vom
      Typ Int, sondern mit beliebigen Listen (also z.B. auch String) berechnen kann?
      --> Probiert eure Lösung auch aus. Entfernt hierzu z.B. einfach oben die
          '> ' vor der Definition und definiert die Funktion hier neu.

> longList :: [a] -> Bool
> longList l = length l > 10

2) Wie muss der Typ der Funktion "smaller" aussehen, damit sie nicht nur mit
   Int, sondern mit allen Typen funktioniert, auf denen eine Ordnung definiert
   ist?
   --> Probiert eure Lösung mit Zahlen und mit Zeichenketten aus (auf beiden
       Typen ist eine Ordnung definiert.
       
> smaller :: (Ord a) => a -> (a -> a)
> smaller x y = if x <= y then x else y       

3) Wie muss der Typ der Funktion "isEq" aussehen, damit sie nicht nur mit
   Double, sondern mit allen Typen funktioniert, auf denen ein Vergleich möglich
   ist?
    isEq :: (Eq a) => a -> a -> a -> Bool


III.

Analog zu letzter Woche sind nun die Typen einiger Ausdrücke und Funktionen
zu bestimmen.

1.

[(+), (-), (*)]  (Num a) => a -> a -> a


2.

[(+), (-), (*), mod] :: (Integral a) => a -> a -> a


3.

present :: (Show a, Show b) => a -> b -> String

> present x y = show x ++ ", " ++ show y


4.

showAdd :: (Num a) => a -> a -> [a]


> showAdd x y = [x, y] ++ [x + y]


IV.

Gegeben ist folgende Additionsfunktion:

addUnit :: (Double, String) -> (Double, String) -> (Double, String)

Der Aufruf
addUnit (2, "kg") (4, "kg")
ergibt (6, "kg").

Für den Aufruf
addUnit (3, "g") (5, "g")
lautet das Ergebnis (8, "g").

In welchen Fällen kann eine solche Definition Sinn machen?

Die Definition ist daher Sinnvoll, da vorher geprüft wird ob die 2 Zahlen die gleiche Einheit haben und 
abhängig davon die Zahlen addieren. 2g + 2kg wären ja nicht 4 sondern 2002g. Diese Funktion verhindert also das
Zusammenrechnen, sofern die Einheiten unterschiedlich sind.
