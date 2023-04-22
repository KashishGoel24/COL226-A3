(* open Rational *)
signature DataTypes =
sig datatype PROG  = PROG of (DEC list)*(CMD list)
    and      DEC   = INTEGER of string| BOOLEAN of string | RATIONAL of string | PROC of string*PROG
    and      CMD   = RD of string | PR of EXPR | CL of string | WH of EXPR*(CMD list) | 
                     ITE of EXPR*(CMD list)*(CMD list) | SETINT of string*EXPR |
                     SETBOOL of string*EXPR | SETRAT of string*EXPR 
    and      EXPR  = ADD of EXPR*EXPR | SUB of EXPR*EXPR | 
                     MUL of EXPR*EXPR | DIV of EXPR*EXPR | UMINUS of EXPR |
                     RADD of EXPR*EXPR | RSUB of EXPR*EXPR | 
                     RMUL of EXPR*EXPR | RDIV of EXPR*EXPR | INV of EXPR |
                     MOD of EXPR*EXPR | NUM of int | IREF of string |
                     OR of EXPR*EXPR | AND of EXPR*EXPR | NOT of EXPR |
                     LT of EXPR*EXPR | GT of EXPR*EXPR | GE of EXPR*EXPR |
                     LE of EXPR*EXPR | EQ of EXPR*EXPR | NE of EXPR*EXPR |
                     TRUE | FALSE | BREF of string

    exception SemanticError;
end;


structure DataTypes =
struct 
    datatype PROG  = PROG of (DEC list)*(CMD list)
    and      DEC   = INTEGER of string| BOOLEAN of string | RATIONAL of string | PROC of string*PROG
    and      CMD   = RD of string | PR of EXPR | CL of string | WH of EXPR*(CMD list) | 
                     ITE of EXPR*(CMD list)*(CMD list) | SETINT of string*EXPR |
                     SETBOOL of string*EXPR | SETRAT of string*EXPR 
    and      EXPR  = ADD of EXPR*EXPR | SUB of EXPR*EXPR | 
                     MUL of EXPR*EXPR | DIV of EXPR*EXPR | UMINUS of EXPR |
                     RADD of EXPR*EXPR | RSUB of EXPR*EXPR | 
                     RMUL of EXPR*EXPR | RDIV of EXPR*EXPR | INV of EXPR |
                     MOD of EXPR*EXPR | NUM of int | IREF of string |
                     OR of EXPR*EXPR | AND of EXPR*EXPR | NOT of EXPR |
                     LT of EXPR*EXPR | GT of EXPR*EXPR | GE of EXPR*EXPR |
                     LE of EXPR*EXPR | EQ of EXPR*EXPR | NE of EXPR*EXPR |
                     TRUE | FALSE | BREF of string

    exception SemanticError;
end;