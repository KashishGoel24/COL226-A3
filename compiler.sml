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
end;