FERTIG
Aufgabe 4
=========

Thema: Lambda-Ausdrücke, Listcomprehension

> module Uebung4 where

I. Lambda-Ausdrücke
-------------------

Gegeben sind zwei Listen pairLst und tripleLst mit Zahlentupeln

> pairLst :: Num a => [(a,a)]
> pairLst = [(3,1), (74,75), (17,4), (08,15)]

> tripleLst :: Num a => [(a,a,a)]
> tripleLst = [(1,2,3), (99,99,0), (79,61,83), (4,8,16)]

und eine Funktion sumLst, die eine Liste von Paaren verarbeitet:

> sumLst    :: Num a => [(a,a)] -> [a]
> sumLst xs = map f xs
>             where f (x,y) = x + y

1) a) Die Funktion sumLst ist auf eine der beiden Listen anwendbar,
      welche ist dies und wie sieht das Resultat aus?

Auf die Funktion pairLst, da wir dort eine Liste von Tupeln haben, und wir genau diese
als Parameter in sumLst brauchen.

   b) Wie funktioniert die Funktion sumLst?
   
Die Funktion sumLst addiert die Elemente eines Tupels in einer Liste und gibt eine Liste
von den Ergebnissen aus.



2) Welchen Typ besitzt die Funktion f, die auf jedes Element der Liste xs
   angewendet wird?

f :: (Int,Int) -> Int


3) In welchem Bereich (im Code) ist f sichtbar?
   Kann f beispielsweise in einer komplett anderen Funktion verwendet werden?

Nein kann sie nicht. f ist wie eine "lokale Variable" (im übertragenen Sinne) und nur
innerhalb der Funktion in der sie steht gültig und auch sichbar


4) Schreibt die Funktion sumLst so um, dass die Funktion f, die auf jedes
   Listenelement angewendet werden soll nicht extra mit 'where' definiert werden
   muss, sondern direkt als Lambda-Ausdruck an das 'map' übergeben wird.
   (Nennt diese neue Funktion dann z.B. sumLst')

 sumLst    :: Num a => [(a,a)] -> [a] 
 sumLst xs = map (\(a,b) -> a + b) xs


   Probiert aus, ob die neue Funktion das selbe Ergebnis liefert, wie sumLst.


5) Die folgende Funktion multipliziert ihre drei Argumente miteinander.

> mult       :: Num a => a -> a -> a -> a
> mult x y z = x * y * z

   Wie könnte ein Lambda-Ausdruck aussehen, der dieselbe Berechnung durchführt?
   

> mult2 = (\x ->( \y -> (\z -> x*y*z)))

   Es gibt mehrere Möglichkeiten, fallen Euch noch weitere ein?

> mult3 x = \y -> (\z -> x*y*z)

> mult4 x y = \z -> x*y*z


   Um Eure Funktionen zu testen, könnt Ihr die folgende Funktion mapTriple
   verwenden:

> mapTriple  :: Num a => (a -> a -> a -> a) -> [a]
> mapTriple f = map (\ (x,y,z) -> f x y z ) tripleLst

   Was ergibt ein Aufruf von mapTripel mit mult?

mapTriple wendet eine Funktion auf jedes Element einer Liste an. Die Elemente dieser
Liste bestehen diesmal aber aus Tripel. Diese Elemente werden zusammen multipliziert.


   Überprüft, ob Eure anderen mult-Funktionen dasselbe Ergebnis berechnen.

Tun sie

II. Listcomprehension
---------------------

1) a) Definiert mit Hilfe einer Listcomprehension eine Funktion
      pairLstGen :: Int -> [(Int,Int)], die eine Liste mit allen Kombinationen
      der Zahlen 1 bis n erzeugt, wobei n als Argument übergeben wird.
      Beispielresultat für n=5:
        pairLstGen 5 = [(1,1),(1,2),(1,3),(1,4),(1,5),(2,1),(2,2),...,(5,5)]

> pairLstGen n = [(m,n) | m <-[1..n], n <- [1..n]] 


   b) Erweitert die Listcomprehension nun so, dass nur noch die Zahlenpaare
      generiert werden, bei denen die Summe gerade ist.
      Nennt diese Funktion pairLstGenEven.
      Zur Bestimmung, ob eine Zahl gerade ist, könnt Ihr die Funktion even
      aus dem Prelude Modul verwenden.

> pairLstGenEven n = [(m,n) | m <-[1..n], n <- [1..n], even (m+n)]


   c) Wieviele "Generator-Regeln" und wieviele "Wächter"/"Guards" habt Ihr in
      1a und 1b jeweils verwendet?
1a: 2 Generator-Regeln und 0 Guard
1b: 2 Generator-Regeln und 1 Guard



2) Überprüft Euer Ergebnis aus 1b mit der Funktion sumLst.
   (Kommen hier nur gerade Zahlen raus?)

Ja klappt! 


   Schreibt hierfür optional noch eine Funktion die das Resultat von sumLst
   auf gerade Zahlen überprüft und als Ergebnis ein Bool ausgibt.
   Ihr könnt diese Funktion beispielsweise wieder mit einer Listcomprehension
   oder mit der Funktion and (aus dem Prelude Modul) umsetzen.




3) Schreibt die folgende Funktion zur Verarbeitung von Int-Listen so um,
   dass sie nicht mehr mit map, sondern mit einer Listcomprehension arbeitet:

> squareLst    :: [Int] -> [Int]
> squareLst xs = map (\ x -> x*x) xs

   Nennt diese Funktion dann squareLst'.

> squareLst' xs = [ x*x | x <- xs]



4) Schreibt (ähnlich zu Aufgabe 1a) eine Funktion, die Tripel von Zahlen
   erzeugt, bei denen allerdings das zweite Element nicht kleiner sein darf,
   als das erste Element und das dritte Element darf nicht kleiner sein als das
   zweite Element.
   Verwendet hierfür jedoch _keine_ Wächter-Regeln in der Listcomprehension.
   Beispielresultat für n=5:
     tripleLstGen 5 = [(1,1,1),(1,1,2),(1,1,3),(1,1,4),(1,1,5),(1,2,2),...]

> tripleLstGen n = [(m,a,o) | m <- [1..n], a <- [1..n], o <- [1..n], a <= o, m <= a] 

5) Mit der Funktionen "words :: String -> [String]" kann eine Zeichenkette in
   eine Liste von Wörtern, die durch Leerzeichen getrennt sind, aufgeteilt
   werden. Die Funktion "unwords :: [String] -> String" erzeugt aus einer
   solchen Liste wieder eine einfache Zeichenkette.
   Beispiel: words "Hallo Welt 123"           = ["Hallo", "Welt", "123"]
             unwords ["Hallo", "Welt", "123"] = "Hallo Welt 123"
   Beide Funktionen sind bereits im Modul Prelude definiert.

   a) Entwickelt eine Funktion "yoda :: String -> String", die eine Zeichenkette
      zunächst in zwei Listen von Wörtern aufteilt, dann die beiden Listen
      vertauscht und anschließend wieder eine Zeichenkette daraus macht.
      Die Umsortierung soll mit Hilfe der Funktion splitHalf (aus der letzten
      Übung) erfolgen, wobei hier die beiden Hälften einfach vertauscht werden

> splitHalf    :: [a] -> ([a], [a])
> splitHalf xs = splitAt (length xs `div` 2) xs

> yoda :: String -> String
> yoda s = [ x |x <- (unwords(snd(splitHalf(words s))) ++ " " ++ unwords(fst(splitHalf(words s))))]


      Testet Eure Funktion mit ein paar Sätzen.
      z.B. mit:
        yoda "du hast noch viel zu lernen"   
          => "viel zu lernen du hast noch"                                                 
        yoda "ich werde die klausur bestehen"
          => "die klausur bestehen ich werde"


   b) Die folgende Aufgabe ist optional:
      Schreibt eine eigene Funktion "myUnwords :: [String] -> String",
      die wie unwords aus einer Liste von Wörtern einen Satz erzeugt.
      Verwendet hierfür jedoch eine Listcomprehension!
      
> myUnwords :: [String] -> String
> myUnwords [s] = [ x | x <- s]


