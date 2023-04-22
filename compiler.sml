structure In : 
sig val interpret : string -> DataTypes.PROG
end = 
struct
exception InError;
fun interpret (fileName) = 
    let val inStream = TextIO.openIn fileName;
        val grab : int -> string = fn 
            n => if TextIO.endOfStream inStream
                then ""
                else TextIO.inputN (inStream,n);
        val printError : string * int * int -> unit = fn 
            (msg,line,col) =>
                print (fileName^"["^Int.toString line^":"^Int.toString col^"] "^msg^"\n");
        val (tree,rem) = InParser.parse 
                    (15,
                    (InParser.makeLexer grab fileName),
                    printError,
                    fileName)
            handle InParser.ParseError => raise InError;
        (* Close the source program file *)
        val _ = TextIO.closeIn inStream;
    in tree
    end

fun break(a : PROG) = 
let val PROG x = a
in 
x
end 

fun break1(a : BLK)= 
let val BLK x = a
in 
#1 x , #2 x 
end

fun break2(a : DECSEQ) = 
(* integer x,y,z *)

fun evaluate(e : Exp) = 
(* case e of PLUS(x,y) => solveExp(x + y 
| MINUS *)


fun eval_expression (Num n) = n
(* PROG x=a *)
  | eval_expression (ADD (e1, e2)) = eval_expression e1 + eval_expression e2
  | eval_expression (SUB (e1, e2)) = eval_expression e1 - eval_expression e2
  | eval_expression (MUL (e1, e2)) = eval_expression e1 * eval_expression e2
  | eval_expression (DIV (e1, e2)) = eval_expression e1 div eval_expression e2
  | eval_expression (RADD (e1,e2)) = eval_expression(Rational.add(eval_expression e1, eval_expression e2))
  | eval_expression (RSUB (e1,e2)) = eval_expression(Rational.sub(eval_expression e1, eval_expression e2))
  | eval_expression (RMUL(e1,e2)) = eval_expression(Rational.mul(eval_expression e1, eval_expression e2))
  | eval_expression (RDIV(e1,e2)) = eval_expression(Rational.div(eval_expression e1, eval_expression e2))
  | eval_expression (INV(e1)) = eval_expression(Rational.inverse(eval_expression e1))
  | eval_expression (MOD(e1,e2)) = eval_expression e1 mod eval_expression e2
  | eval_expression (NOT(e1)) = not(eval_expression (e1))
  | eval_expression (OR(e1,e2)) = eval_expression e1 orelse eval_expression e2
  | eval_expression (AND(e1,e2)) = eval_expression e1 andalso eval_expression e2
  | eval_expression (GE(e1,e2)) = eval_expression e1 >= eval_expression e2
  | eval_expression (GT(e1,e2)) = eval_expression e1 > eval_expression e2
  | eval_expression (LE(e1,e2)) = eval_expression e1 < eval_expression e2
  | eval_expression (LT(e1,e2)) = eval_expression e1 <= eval_expression e2
  | eval_expression (EQ(e1,e2)) = eval_expression e1 = eval_expression e2
  | eval_expression (NE(e1,e2)) = eval_expression e1 <> eval_expression e2
  | eval_expression 

end;