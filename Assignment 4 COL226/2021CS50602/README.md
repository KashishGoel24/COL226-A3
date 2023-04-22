## THE BIG RATIONAL PACKAGE 

# Objective : 
The objective of this assignment is to build a command line user interface for rational number expressions. Here, the rational numbers may be represented in the fractional form or the decimal form.

# USING THE COMPILER :

1. When opening the terminal then first open the directory of the folder
2. After opening the terminal, write sml in the terminal
3. Then write " CM.make "assignment3.cm" ; "
4. Next in the terminal write " Calc.parse(); "
5. Now you can write the rational expressions as many as you want
6. Once you are done with writing the rational expression, press ctrl + C to get the results

# Documentation of Context-free Grammar for Rational Numbers :

Let the Grammar for Rational Numbers be defined as G = <N,T,P,E'> where N = {E',S,R,F,I,N,B,C,D} and T = {",","+","-","(",")","/","0","1","2","3","4","5","6","7","8","9"}

and the Production rules P are below as follows :-

E' -> SR/F | SI.N(R) | R
S  -> + | ~ | eps 
N  -> I
I  -> 0 | F | eps  
R  -> 0 | F 
F  -> BC 
C  -> D | DC 
D  -> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
B  -> 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9


# Documentation of Context-free Grammar for Rational Number Expressions is :

Let the Grammar for Rational Number Expressions be defined as G = <N',T',P',E> where N' = {E,T,H,E',S,R,F,I,N,B,C,D,V,V',L,L',U,U'} and T' = {",","*","+","-","(",")","/","0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","x","Y","Z"}

and the Production rules P' are below as follows :-

E -> E + T | E - T | T 
T -> T * H | T / H | H 
H -> E' | (E) | V

V -> L'V | L'
L' -> L | D | LL' | DL'
L -> U | U'
U -> "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U" | "V" | "W" | "x" | "Y" | "Z"
U' -> "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z"


E' -> SR/F | SI.N(R) | (SR,F) | R
S  -> + | ~ | eps 
N  -> I
I  -> 0 | F | eps  
R  -> 0 | F 
F  -> BC 
C  -> D | DC 
D  -> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
B  -> 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

# DESIGN DECISIONS : 

FOR RATIONAL CALCULATOR :
    There must be spaces between the operand and operators while writing the rational expression


# ACKNOWLEDGEMENTS :

I have extensively used the lex, grm and sml file from the SML NJ documentation available for building an integer calculator.