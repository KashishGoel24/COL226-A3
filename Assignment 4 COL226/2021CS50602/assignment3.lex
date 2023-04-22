
structure Tokens = Tokens

type pos = int
type svalue = Tokens.svalue
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult= (svalue,pos) token

val pos = ref 0
fun eof () = Tokens.EOF(!pos,!pos)
fun error (e,l : int,_) = TextIO.output (TextIO.stdOut, String.concat[
	"line ", (Int.toString l), ": ", e, "\n"
      ])


%%


%header (functor CalcLexFun(structure Tokens: Calc_TOKENS));
alpha=[A-Za-z];
digit=[0-9];
ws = [\ \t];


%%


\n       => (pos := (!pos) + 1; lex());
{ws}+    => (lex());
[~+]?{digit}*"."{digit}*"("{digit}+")" => (Tokens.NUM ((Rational.fromDecimal yytext), !pos, !pos));
[~+]?{digit}+ =>  (Tokens.NUM ((Rational.fromDecimal (yytext ^ ".(0)")), !pos, !pos));

"+"      => (Tokens.ADD(!pos,!pos));
"*"      => (Tokens.MULTIPLY(!pos,!pos));
";"      => (Tokens.SEMICOLON(!pos,!pos));
"-"      => (Tokens.MINUS(!pos,!pos));
"/"      => (Tokens.DIVIDE(!pos,!pos));
"("      => (Tokens.LEFT_BRACKET(!pos,!pos)) ;
")"      => (Tokens.RIGHT_BRACKET(!pos,!pos)) ;
.        => (error (" incorrect expression "^yytext,!pos,!pos); lex());