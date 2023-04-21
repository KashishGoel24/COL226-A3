(* glue.sml Create a lexer and a parser *)
structure InLrVals = InLrValsFun(
                structure Token = LrParser.Token);
structure InLex = InLexFun(
            structure Tokens = InLrVals.Tokens);
structure InParser = JoinWithArg(
                structure ParserData = InLrVals.ParserData
                structure Lex = InLex
                structure LrParser=LrParser);