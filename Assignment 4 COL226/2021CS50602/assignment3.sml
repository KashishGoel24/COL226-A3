structure Calc : sig
	           val parse : unit -> unit
                 end = 
struct

  structure CalcLrVals =
    CalcLrValsFun(structure Token = LrParser.Token)

  structure CalcLex =
    CalcLexFun(structure Tokens = CalcLrVals.Tokens)

  structure CalcParser =
    Join(structure LrParser = LrParser
	 structure ParserData = CalcLrVals.ParserData
	 structure Lex = CalcLex)


  fun invoke lexstream =
      let fun print_error (s,i:int,_) =
	      TextIO.output(TextIO.stdOut,
			    "Error, line " ^ (Int.toString i) ^ ", " ^ s ^ "\n")
       in CalcParser.parse(0,lexstream,print_error,())
      end

  fun parse () = 
      let val lexer = CalcParser.makeLexer (fn _ =>
                                               (case TextIO.inputLine TextIO.stdIn
                                                of SOME s => s
                                                 | _ => ""))
	  val dummyEOF = CalcLrVals.Tokens.EOF(0,0)
	  val dummySEMI = CalcLrVals.Tokens.SEMICOLON(0,0)
	  fun loop lexer =
	      let val (result,lexer) = invoke lexer
		  val (nextToken,lexer) = CalcParser.Stream.get lexer
		  val _ = case result
			    of SOME r =>
				TextIO.output(TextIO.stdOut,
				       "result = " ^ (Rational.showRat(r)) ^ "\n")
			     | NONE => ()
	       in if CalcParser.sameToken(nextToken,dummyEOF) then ()
		  else loop lexer
	      end
       in loop lexer
      end

end 