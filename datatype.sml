open Rational
signature DATATYPES =
sig datatype PROG  = PROG of (DEC list)*(CMD list)
    and      DEC   = VARI of VARDEC| PROC of PROCDEF
    and      VARDEC   = INT of string | BOOL of string | RATIONAL of string
    and      PROCDEF  = PROCEDURE of string*PROG
    and      CMD   = RD of string | PR of EXPR | CL of EXPR | WH of EXPR*(CMD list) | 
                     ITE of EXPR*(CMD list)*(CMD list) | SETINT of string*EXPR |
                     SETBOOL of string*EXPR | SETRAT of string*EXPR 
    and      EXPR  = ADD of EXPR*EXPR | SUB of EXPR*EXPR | 
                     MUL of EXPR*EXPR | DIV of EXPR*EXPR | UMINUS of EXPR |
                     RADD of EXPR*EXPR | RSUB of EXPR*EXPR | 
                     RMUL of EXPR*EXPR | RDIV of EXPR*EXPR | INV of EXPR |
                     MOD of EXPR*EXPR | NUM of int | IREF of string | RAT of rational |
                     OR of EXPR*EXPR | AND of EXPR*EXPR | NOT of EXPR |
                     LT of EXPR*EXPR | GT of EXPR*EXPR | GE of EXPR*EXPR |
                     LE of EXPR*EXPR | EQ of EXPR*EXPR | NE of EXPR*EXPR |
                     TRUE | FALSE | BREF of string

    exception SemanticError;
end;


structure DataTypes =
struct 
    datatype PROG  = PROG of (DEC list)*(CMD list)
    and      DEC   = VARI of VARDEC| PROC of PROCDEF
    and      VARDEC   = INT of string | BOOL of string | RATIONAL of string
    and      PROCDEF  = PROCEDURE of string*PROG
    and      CMD   = RD of string | PR of EXPR | CL of EXPR | WH of EXPR*(CMD list) | 
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

(* structure AST =
struct
	type id = string

	datatype boolbool = AND | OR
	datatype intint = PLUS | MINUS | TIMES | DIV | MOD
    datatype rationalrational = PLUS | MINUS | TIMES | DIV
	datatype intbool = LESSTHAN | GREATERTHAN
    datatype rationalbool = LESSTHAN | GREATERTHAN
	datatype binop = EQUALS | BB of boolbool | II of intint | IB of intbool | RR of rationalrational | RB of rationalbool
	datatype unop = NOT | NEGATE | INVERSE

	datatype typ = Int | Bool | Rational | Arrow of typ * typ

	datatype 	value = IntVal of int | BoolVal of bool | Lambda of id * typ * typ * exp
	and			decl	= ValDecl of id * exp
	and			exp		= BoolExp of bool
						| IntExp of int
                        | RatExp of Rational (* Bring Rational from external file *)
						| VarExp of id
						(* | LetExp of decl * exp *)
						| ITExp of exp * exp * exp
						| BinExp of binop * exp * exp
						| UnExp of unop * exp
						| AppExp of exp * exp
						| LambdaExp of value
						| FuncExp of id * value
end                         *)