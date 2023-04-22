functor InLrValsFun(structure Token : TOKEN)
 : sig structure ParserData : PARSER_DATA
       structure Tokens : In_TOKENS
   end
 = 
struct
structure ParserData=
struct
structure Header = 
struct
open DataTypes
open Dictionary
open Rational

val SymbolTable = ref (create())

fun makeVarList (l::L) t = (
        SymbolTable := update (!SymbolTable) l (t l);
        (t l)::(makeVarList L t))
  | makeVarList []     t = []


fun set id expr = 
    case lookup (!SymbolTable) id of 
        (INTEGER s) => SETINT (id, expr)
      | (BOOLEAN b) => SETBOOL (id, expr)
      | (RATIONAL r) => SETRAT (id, expr)
      (* raise error *)


end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\001\000\137\000\003\000\137\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\137\000\008\000\137\000\009\000\137\000\
\\010\000\069\000\011\000\068\000\012\000\137\000\013\000\137\000\
\\014\000\137\000\015\000\137\000\016\000\137\000\017\000\137\000\
\\018\000\137\000\030\000\137\000\034\000\137\000\038\000\137\000\000\000\
\\001\000\001\000\138\000\003\000\138\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\138\000\008\000\138\000\009\000\138\000\
\\010\000\069\000\011\000\068\000\012\000\138\000\013\000\138\000\
\\014\000\138\000\015\000\138\000\016\000\138\000\017\000\138\000\
\\018\000\138\000\030\000\138\000\034\000\138\000\038\000\138\000\000\000\
\\001\000\001\000\139\000\003\000\139\000\004\000\139\000\005\000\139\000\
\\006\000\139\000\007\000\139\000\008\000\139\000\009\000\139\000\
\\010\000\139\000\011\000\139\000\012\000\139\000\013\000\139\000\
\\014\000\139\000\015\000\139\000\016\000\139\000\017\000\139\000\
\\018\000\139\000\030\000\139\000\034\000\139\000\038\000\139\000\000\000\
\\001\000\001\000\140\000\003\000\140\000\004\000\140\000\005\000\140\000\
\\006\000\140\000\007\000\140\000\008\000\140\000\009\000\140\000\
\\010\000\140\000\011\000\140\000\012\000\140\000\013\000\140\000\
\\014\000\140\000\015\000\140\000\016\000\140\000\017\000\140\000\
\\018\000\140\000\030\000\140\000\034\000\140\000\038\000\140\000\000\000\
\\001\000\001\000\141\000\003\000\141\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\141\000\008\000\141\000\009\000\141\000\
\\010\000\069\000\011\000\068\000\012\000\141\000\013\000\141\000\
\\014\000\141\000\015\000\141\000\016\000\141\000\017\000\141\000\
\\018\000\141\000\030\000\141\000\034\000\141\000\038\000\141\000\000\000\
\\001\000\001\000\142\000\003\000\142\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\142\000\008\000\142\000\009\000\142\000\
\\010\000\069\000\011\000\068\000\012\000\142\000\013\000\142\000\
\\014\000\142\000\015\000\142\000\016\000\142\000\017\000\142\000\
\\018\000\142\000\030\000\142\000\034\000\142\000\038\000\142\000\000\000\
\\001\000\001\000\143\000\003\000\143\000\004\000\143\000\005\000\143\000\
\\006\000\143\000\007\000\143\000\008\000\143\000\009\000\143\000\
\\010\000\143\000\011\000\143\000\012\000\143\000\013\000\143\000\
\\014\000\143\000\015\000\143\000\016\000\143\000\017\000\143\000\
\\018\000\143\000\030\000\143\000\034\000\143\000\038\000\143\000\000\000\
\\001\000\001\000\144\000\003\000\144\000\004\000\144\000\005\000\144\000\
\\006\000\144\000\007\000\144\000\008\000\144\000\009\000\144\000\
\\010\000\144\000\011\000\144\000\012\000\144\000\013\000\144\000\
\\014\000\144\000\015\000\144\000\016\000\144\000\017\000\144\000\
\\018\000\144\000\030\000\144\000\034\000\144\000\038\000\144\000\000\000\
\\001\000\001\000\146\000\003\000\146\000\004\000\146\000\005\000\146\000\
\\006\000\146\000\007\000\146\000\008\000\146\000\009\000\146\000\
\\010\000\146\000\011\000\146\000\012\000\146\000\013\000\146\000\
\\014\000\146\000\015\000\146\000\016\000\146\000\017\000\146\000\
\\018\000\146\000\030\000\146\000\034\000\146\000\038\000\146\000\000\000\
\\001\000\001\000\147\000\003\000\147\000\004\000\147\000\005\000\147\000\
\\006\000\147\000\007\000\147\000\008\000\147\000\009\000\147\000\
\\010\000\147\000\011\000\147\000\012\000\147\000\013\000\147\000\
\\014\000\147\000\015\000\147\000\016\000\147\000\017\000\147\000\
\\018\000\147\000\030\000\147\000\034\000\147\000\038\000\147\000\000\000\
\\001\000\001\000\148\000\003\000\148\000\004\000\148\000\005\000\148\000\
\\006\000\148\000\007\000\148\000\008\000\148\000\009\000\148\000\
\\010\000\148\000\011\000\148\000\012\000\148\000\013\000\148\000\
\\014\000\148\000\015\000\148\000\016\000\148\000\017\000\148\000\
\\018\000\148\000\030\000\148\000\034\000\148\000\038\000\148\000\000\000\
\\001\000\001\000\149\000\003\000\149\000\004\000\149\000\005\000\149\000\
\\006\000\149\000\007\000\149\000\008\000\149\000\009\000\149\000\
\\010\000\149\000\011\000\149\000\012\000\149\000\013\000\149\000\
\\014\000\149\000\015\000\149\000\016\000\149\000\017\000\149\000\
\\018\000\149\000\030\000\149\000\034\000\149\000\038\000\149\000\000\000\
\\001\000\001\000\150\000\003\000\150\000\004\000\150\000\005\000\150\000\
\\006\000\150\000\007\000\150\000\008\000\150\000\009\000\150\000\
\\010\000\150\000\011\000\150\000\012\000\150\000\013\000\150\000\
\\014\000\150\000\015\000\150\000\016\000\150\000\017\000\150\000\
\\018\000\150\000\030\000\150\000\034\000\150\000\038\000\150\000\000\000\
\\001\000\001\000\160\000\003\000\160\000\004\000\160\000\005\000\160\000\
\\006\000\160\000\007\000\160\000\008\000\160\000\009\000\160\000\
\\010\000\160\000\011\000\160\000\012\000\160\000\013\000\160\000\
\\014\000\160\000\015\000\160\000\016\000\160\000\017\000\160\000\
\\018\000\160\000\030\000\160\000\034\000\160\000\038\000\160\000\000\000\
\\001\000\001\000\161\000\003\000\161\000\004\000\161\000\005\000\161\000\
\\006\000\161\000\007\000\161\000\008\000\161\000\009\000\161\000\
\\010\000\161\000\011\000\161\000\012\000\161\000\013\000\161\000\
\\014\000\161\000\015\000\161\000\016\000\161\000\017\000\161\000\
\\018\000\161\000\030\000\161\000\034\000\161\000\038\000\161\000\000\000\
\\001\000\001\000\052\000\002\000\051\000\019\000\050\000\021\000\049\000\
\\036\000\048\000\037\000\047\000\045\000\046\000\046\000\045\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\154\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\154\000\013\000\154\000\
\\014\000\154\000\015\000\154\000\016\000\154\000\017\000\154\000\
\\018\000\154\000\030\000\154\000\034\000\154\000\038\000\154\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\155\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\155\000\013\000\155\000\
\\014\000\155\000\015\000\155\000\016\000\155\000\017\000\155\000\
\\018\000\155\000\030\000\155\000\034\000\155\000\038\000\155\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\156\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\156\000\013\000\156\000\
\\014\000\156\000\015\000\156\000\016\000\156\000\017\000\156\000\
\\018\000\156\000\030\000\156\000\034\000\156\000\038\000\156\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\157\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\157\000\013\000\157\000\
\\014\000\157\000\015\000\157\000\016\000\157\000\017\000\157\000\
\\018\000\157\000\030\000\157\000\034\000\157\000\038\000\157\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\158\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\158\000\013\000\158\000\
\\014\000\158\000\015\000\158\000\016\000\158\000\017\000\158\000\
\\018\000\158\000\030\000\158\000\034\000\158\000\038\000\158\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\159\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\159\000\013\000\159\000\
\\014\000\159\000\015\000\159\000\016\000\159\000\017\000\159\000\
\\018\000\159\000\030\000\159\000\034\000\159\000\038\000\159\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\072\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\067\000\013\000\066\000\
\\014\000\065\000\015\000\064\000\016\000\063\000\017\000\145\000\
\\018\000\145\000\030\000\145\000\034\000\145\000\038\000\145\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\072\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\067\000\013\000\066\000\
\\014\000\065\000\015\000\064\000\016\000\063\000\017\000\152\000\
\\018\000\152\000\030\000\152\000\034\000\152\000\038\000\152\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\072\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\067\000\013\000\066\000\
\\014\000\065\000\015\000\064\000\016\000\063\000\017\000\153\000\
\\018\000\153\000\030\000\153\000\034\000\153\000\038\000\153\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\072\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\067\000\013\000\066\000\
\\014\000\065\000\015\000\064\000\016\000\063\000\017\000\062\000\
\\018\000\151\000\030\000\151\000\034\000\151\000\038\000\151\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\072\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\067\000\013\000\066\000\
\\014\000\065\000\015\000\064\000\016\000\063\000\017\000\062\000\
\\018\000\061\000\030\000\082\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\072\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\067\000\013\000\066\000\
\\014\000\065\000\015\000\064\000\016\000\063\000\017\000\062\000\
\\018\000\061\000\034\000\060\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\072\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\067\000\013\000\066\000\
\\014\000\065\000\015\000\064\000\016\000\063\000\017\000\062\000\
\\018\000\061\000\038\000\133\000\000\000\
\\001\000\001\000\077\000\003\000\076\000\004\000\075\000\005\000\074\000\
\\006\000\073\000\007\000\072\000\008\000\071\000\009\000\070\000\
\\010\000\069\000\011\000\068\000\012\000\067\000\013\000\066\000\
\\014\000\065\000\015\000\064\000\016\000\063\000\017\000\062\000\
\\018\000\061\000\038\000\134\000\000\000\
\\001\000\020\000\043\000\000\000\
\\001\000\023\000\120\000\024\000\120\000\039\000\120\000\041\000\120\000\000\000\
\\001\000\023\000\011\000\024\000\010\000\025\000\009\000\039\000\119\000\
\\041\000\119\000\000\000\
\\001\000\023\000\011\000\024\000\010\000\039\000\116\000\041\000\116\000\000\000\
\\001\000\024\000\121\000\039\000\121\000\041\000\121\000\000\000\
\\001\000\024\000\010\000\039\000\113\000\041\000\113\000\000\000\
\\001\000\024\000\010\000\039\000\117\000\041\000\117\000\000\000\
\\001\000\026\000\034\000\027\000\033\000\028\000\032\000\029\000\031\000\
\\033\000\030\000\042\000\130\000\045\000\029\000\000\000\
\\001\000\031\000\128\000\032\000\128\000\035\000\128\000\038\000\128\000\
\\047\000\128\000\000\000\
\\001\000\031\000\105\000\000\000\
\\001\000\032\000\107\000\000\000\
\\001\000\035\000\104\000\000\000\
\\001\000\038\000\110\000\047\000\110\000\000\000\
\\001\000\038\000\123\000\000\000\
\\001\000\038\000\124\000\040\000\036\000\000\000\
\\001\000\038\000\127\000\000\000\
\\001\000\038\000\131\000\000\000\
\\001\000\038\000\132\000\000\000\
\\001\000\038\000\135\000\000\000\
\\001\000\038\000\136\000\000\000\
\\001\000\038\000\025\000\000\000\
\\001\000\038\000\035\000\000\000\
\\001\000\038\000\037\000\000\000\
\\001\000\038\000\038\000\000\000\
\\001\000\038\000\041\000\000\000\
\\001\000\039\000\112\000\041\000\112\000\000\000\
\\001\000\039\000\114\000\041\000\114\000\000\000\
\\001\000\039\000\115\000\041\000\115\000\000\000\
\\001\000\039\000\118\000\041\000\118\000\000\000\
\\001\000\039\000\122\000\041\000\122\000\000\000\
\\001\000\039\000\017\000\041\000\126\000\000\000\
\\001\000\041\000\111\000\000\000\
\\001\000\041\000\125\000\000\000\
\\001\000\041\000\019\000\000\000\
\\001\000\042\000\129\000\000\000\
\\001\000\042\000\042\000\000\000\
\\001\000\043\000\056\000\000\000\
\\001\000\044\000\103\000\000\000\
\\001\000\045\000\021\000\000\000\
\\001\000\045\000\026\000\000\000\
\\001\000\045\000\055\000\000\000\
\\001\000\045\000\083\000\000\000\
\\001\000\046\000\080\000\000\000\
\\001\000\046\000\081\000\000\000\
\\001\000\047\000\000\000\000\000\
\\001\000\047\000\109\000\000\000\
\"
val actionRowNumbers =
"\032\000\058\000\036\000\033\000\
\\060\000\063\000\075\000\068\000\
\\068\000\068\000\057\000\056\000\
\\035\000\050\000\061\000\069\000\
\\042\000\037\000\051\000\044\000\
\\052\000\053\000\055\000\060\000\
\\032\000\054\000\065\000\030\000\
\\015\000\015\000\015\000\070\000\
\\066\000\031\000\068\000\059\000\
\\034\000\062\000\045\000\037\000\
\\038\000\015\000\027\000\010\000\
\\009\000\014\000\013\000\015\000\
\\015\000\072\000\073\000\026\000\
\\028\000\047\000\071\000\043\000\
\\064\000\029\000\063\000\015\000\
\\015\000\015\000\015\000\015\000\
\\015\000\015\000\015\000\015\000\
\\015\000\015\000\015\000\015\000\
\\015\000\015\000\015\000\015\000\
\\022\000\024\000\011\000\012\000\
\\063\000\067\000\041\000\025\000\
\\023\000\019\000\018\000\017\000\
\\016\000\021\000\007\000\006\000\
\\005\000\004\000\020\000\008\000\
\\003\000\002\000\001\000\000\000\
\\039\000\046\000\049\000\063\000\
\\040\000\048\000\074\000"
val gotoT =
"\
\\001\000\106\000\002\000\006\000\003\000\005\000\004\000\004\000\
\\008\000\003\000\009\000\002\000\010\000\001\000\000\000\
\\000\000\
\\010\000\010\000\000\000\
\\009\000\012\000\010\000\011\000\000\000\
\\006\000\014\000\007\000\013\000\000\000\
\\013\000\016\000\000\000\
\\000\000\
\\005\000\018\000\000\000\
\\005\000\020\000\000\000\
\\005\000\021\000\000\000\
\\000\000\
\\000\000\
\\010\000\022\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\011\000\026\000\012\000\025\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\006\000\037\000\007\000\013\000\000\000\
\\002\000\038\000\003\000\005\000\004\000\004\000\008\000\003\000\
\\009\000\002\000\010\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\014\000\042\000\000\000\
\\014\000\051\000\000\000\
\\014\000\052\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\005\000\055\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\011\000\056\000\012\000\025\000\000\000\
\\000\000\
\\014\000\057\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\014\000\076\000\000\000\
\\014\000\077\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\013\000\082\000\000\000\
\\014\000\083\000\000\000\
\\014\000\084\000\000\000\
\\014\000\085\000\000\000\
\\014\000\086\000\000\000\
\\014\000\087\000\000\000\
\\014\000\088\000\000\000\
\\014\000\089\000\000\000\
\\014\000\090\000\000\000\
\\014\000\091\000\000\000\
\\014\000\092\000\000\000\
\\014\000\093\000\000\000\
\\014\000\094\000\000\000\
\\014\000\095\000\000\000\
\\014\000\096\000\000\000\
\\014\000\097\000\000\000\
\\014\000\098\000\000\000\
\\014\000\099\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\013\000\100\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\013\000\104\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\"
val numstates = 107
val numrules = 53
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle General.Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(List.map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = int
type arg = string
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit
 | TOK_NUM of unit ->  (int) | TOK_ID of unit ->  (string)
 | expr of unit ->  (EXPR) | cmdseq of unit ->  (CMD list)
 | cmd of unit ->  (CMD) | cmdlist of unit ->  (CMD list)
 | boolvardec of unit ->  (DEC list)
 | intvardec of unit ->  (DEC list) | ratvardec of unit ->  (DEC list)
 | procdef of unit ->  (DEC) | procdeflist of unit ->  (DEC list)
 | identlist of unit ->  (string list)
 | vardeclist of unit ->  (DEC list) | declist of unit ->  (DEC list)
 | prog of unit ->  (PROG) | block of unit ->  (PROG)
end
type svalue = MlyValue.svalue
type result = PROG
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn (T 38) => true | (T 21) => true | (T 22) => true | (T 23) => true
 | (T 25) => true | (T 26) => true | (T 27) => true | (T 28) => true
 | (T 29) => true | (T 30) => true | (T 31) => true | (T 32) => true
 | (T 33) => true | (T 34) => true | (T 35) => true | (T 36) => true
 | _ => false
val preferred_change : (term list * term list) list = 
nil
val noShift = 
fn (T 46) => true | _ => false
val showTerminal =
fn (T 0) => "TOK_ADD"
  | (T 1) => "TOK_UMINUS"
  | (T 2) => "TOK_SUB"
  | (T 3) => "TOK_MUL"
  | (T 4) => "TOK_DIV"
  | (T 5) => "TOK_MOD"
  | (T 6) => "TOK_EQ"
  | (T 7) => "TOK_RADD"
  | (T 8) => "TOK_RSUB"
  | (T 9) => "TOK_RMUL"
  | (T 10) => "TOK_RDIV"
  | (T 11) => "TOK_NE"
  | (T 12) => "TOK_GT"
  | (T 13) => "TOK_GE"
  | (T 14) => "TOK_LT"
  | (T 15) => "TOK_LE"
  | (T 16) => "TOK_AND"
  | (T 17) => "TOK_OR"
  | (T 18) => "TOK_NOT"
  | (T 19) => "TOK_ASSIGN"
  | (T 20) => "TOK_INV"
  | (T 21) => "TOK_VAR"
  | (T 22) => "TOK_INTEGER"
  | (T 23) => "TOK_BOOLEAN"
  | (T 24) => "TOK_RATIONAL"
  | (T 25) => "TOK_READ"
  | (T 26) => "TOK_CALL"
  | (T 27) => "TOK_PRINT"
  | (T 28) => "TOK_IF"
  | (T 29) => "TOK_THEN"
  | (T 30) => "TOK_ELSE"
  | (T 31) => "TOK_FI"
  | (T 32) => "TOK_WHILE"
  | (T 33) => "TOK_DO"
  | (T 34) => "TOK_OD"
  | (T 35) => "TOK_TT"
  | (T 36) => "TOK_FF"
  | (T 37) => "TOK_SEMICOLON"
  | (T 38) => "TOK_PROCEDURE"
  | (T 39) => "TOK_COMMA"
  | (T 40) => "TOK_LBRACE"
  | (T 41) => "TOK_RBRACE"
  | (T 42) => "TOK_LPAREN"
  | (T 43) => "TOK_RPAREN"
  | (T 44) => "TOK_ID"
  | (T 45) => "TOK_NUM"
  | (T 46) => "TOK_EOF"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn _ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 46) $$ (T 43) $$ (T 42) $$ (T 41) $$ (T 40) $$ (T 39) $$ (T 38)
 $$ (T 37) $$ (T 36) $$ (T 35) $$ (T 34) $$ (T 33) $$ (T 32) $$ (T 31)
 $$ (T 30) $$ (T 29) $$ (T 28) $$ (T 27) $$ (T 26) $$ (T 25) $$ (T 24)
 $$ (T 23) $$ (T 22) $$ (T 21) $$ (T 20) $$ (T 19) $$ (T 18) $$ (T 17)
 $$ (T 16) $$ (T 15) $$ (T 14) $$ (T 13) $$ (T 12) $$ (T 11) $$ (T 10)
 $$ (T 9) $$ (T 8) $$ (T 7) $$ (T 6) $$ (T 5) $$ (T 4) $$ (T 3) $$ (T 
2) $$ (T 1) $$ (T 0)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (fileName):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( MlyValue.prog prog1, prog1left, prog1right)) :: 
rest671)) => let val  result = MlyValue.block (fn _ => let val  (prog
 as prog1) = prog1 ()
 in (prog)
end)
 in ( LrTable.NT 0, ( result, prog1left, prog1right), rest671)
end
|  ( 1, ( ( _, ( MlyValue.cmdseq cmdseq1, _, cmdseq1right)) :: ( _, ( 
MlyValue.declist declist1, declist1left, _)) :: rest671)) => let val  
result = MlyValue.prog (fn _ => let val  (declist as declist1) = 
declist1 ()
 val  (cmdseq as cmdseq1) = cmdseq1 ()
 in (PROG (declist, cmdseq))
end)
 in ( LrTable.NT 1, ( result, declist1left, cmdseq1right), rest671)

end
|  ( 2, ( ( _, ( MlyValue.procdeflist procdeflist1, _, 
procdeflist1right)) :: ( _, ( MlyValue.vardeclist vardeclist1, 
vardeclist1left, _)) :: rest671)) => let val  result = 
MlyValue.declist (fn _ => let val  (vardeclist as vardeclist1) = 
vardeclist1 ()
 val  (procdeflist as procdeflist1) = procdeflist1 ()
 in (vardeclist @ procdeflist)
end)
 in ( LrTable.NT 2, ( result, vardeclist1left, procdeflist1right), 
rest671)
end
|  ( 3, ( ( _, ( MlyValue.boolvardec boolvardec1, _, boolvardec1right)
) :: ( _, ( MlyValue.intvardec intvardec1, _, _)) :: ( _, ( 
MlyValue.ratvardec ratvardec1, ratvardec1left, _)) :: rest671)) => let
 val  result = MlyValue.vardeclist (fn _ => let val  (ratvardec as 
ratvardec1) = ratvardec1 ()
 val  (intvardec as intvardec1) = intvardec1 ()
 val  (boolvardec as boolvardec1) = boolvardec1 ()
 in (ratvardec @ intvardec @ boolvardec)
end)
 in ( LrTable.NT 3, ( result, ratvardec1left, boolvardec1right), 
rest671)
end
|  ( 4, ( ( _, ( MlyValue.intvardec intvardec1, _, intvardec1right))
 :: ( _, ( MlyValue.ratvardec ratvardec1, ratvardec1left, _)) :: 
rest671)) => let val  result = MlyValue.vardeclist (fn _ => let val  (
ratvardec as ratvardec1) = ratvardec1 ()
 val  (intvardec as intvardec1) = intvardec1 ()
 in (ratvardec @ intvardec)
end)
 in ( LrTable.NT 3, ( result, ratvardec1left, intvardec1right), 
rest671)
end
|  ( 5, ( ( _, ( MlyValue.boolvardec boolvardec1, _, boolvardec1right)
) :: ( _, ( MlyValue.ratvardec ratvardec1, ratvardec1left, _)) :: 
rest671)) => let val  result = MlyValue.vardeclist (fn _ => let val  (
ratvardec as ratvardec1) = ratvardec1 ()
 val  (boolvardec as boolvardec1) = boolvardec1 ()
 in (ratvardec @ boolvardec)
end)
 in ( LrTable.NT 3, ( result, ratvardec1left, boolvardec1right), 
rest671)
end
|  ( 6, ( ( _, ( MlyValue.boolvardec boolvardec1, _, boolvardec1right)
) :: ( _, ( MlyValue.intvardec intvardec1, intvardec1left, _)) :: 
rest671)) => let val  result = MlyValue.vardeclist (fn _ => let val  (
intvardec as intvardec1) = intvardec1 ()
 val  (boolvardec as boolvardec1) = boolvardec1 ()
 in (intvardec @ boolvardec)
end)
 in ( LrTable.NT 3, ( result, intvardec1left, boolvardec1right), 
rest671)
end
|  ( 7, ( ( _, ( MlyValue.ratvardec ratvardec1, ratvardec1left, 
ratvardec1right)) :: rest671)) => let val  result = 
MlyValue.vardeclist (fn _ => let val  (ratvardec as ratvardec1) = 
ratvardec1 ()
 in (ratvardec)
end)
 in ( LrTable.NT 3, ( result, ratvardec1left, ratvardec1right), 
rest671)
end
|  ( 8, ( ( _, ( MlyValue.intvardec intvardec1, intvardec1left, 
intvardec1right)) :: rest671)) => let val  result = 
MlyValue.vardeclist (fn _ => let val  (intvardec as intvardec1) = 
intvardec1 ()
 in (intvardec)
end)
 in ( LrTable.NT 3, ( result, intvardec1left, intvardec1right), 
rest671)
end
|  ( 9, ( ( _, ( MlyValue.boolvardec boolvardec1, boolvardec1left, 
boolvardec1right)) :: rest671)) => let val  result = 
MlyValue.vardeclist (fn _ => let val  (boolvardec as boolvardec1) = 
boolvardec1 ()
 in (boolvardec)
end)
 in ( LrTable.NT 3, ( result, boolvardec1left, boolvardec1right), 
rest671)
end
|  ( 10, ( rest671)) => let val  result = MlyValue.vardeclist (fn _ =>
 ([]))
 in ( LrTable.NT 3, ( result, defaultPos, defaultPos), rest671)
end
|  ( 11, ( ( _, ( _, _, TOK_SEMICOLON1right)) :: ( _, ( 
MlyValue.identlist identlist1, _, _)) :: ( _, ( _, TOK_RATIONAL1left,
 _)) :: rest671)) => let val  result = MlyValue.ratvardec (fn _ => let
 val  (identlist as identlist1) = identlist1 ()
 in (makeVarList(identlist)(RATIONAL))
end)
 in ( LrTable.NT 7, ( result, TOK_RATIONAL1left, TOK_SEMICOLON1right),
 rest671)
end
|  ( 12, ( ( _, ( _, _, TOK_SEMICOLON1right)) :: ( _, ( 
MlyValue.identlist identlist1, _, _)) :: ( _, ( _, TOK_INTEGER1left, _
)) :: rest671)) => let val  result = MlyValue.intvardec (fn _ => let
 val  (identlist as identlist1) = identlist1 ()
 in (makeVarList(identlist)(INTEGER))
end)
 in ( LrTable.NT 8, ( result, TOK_INTEGER1left, TOK_SEMICOLON1right), 
rest671)
end
|  ( 13, ( ( _, ( _, _, TOK_SEMICOLON1right)) :: ( _, ( 
MlyValue.identlist identlist1, _, _)) :: ( _, ( _, TOK_BOOLEAN1left, _
)) :: rest671)) => let val  result = MlyValue.boolvardec (fn _ => let
 val  (identlist as identlist1) = identlist1 ()
 in (makeVarList(identlist)(BOOLEAN))
end)
 in ( LrTable.NT 9, ( result, TOK_BOOLEAN1left, TOK_SEMICOLON1right), 
rest671)
end
|  ( 14, ( ( _, ( MlyValue.identlist identlist1, _, identlist1right))
 :: _ :: ( _, ( MlyValue.TOK_ID TOK_ID1, TOK_ID1left, _)) :: rest671))
 => let val  result = MlyValue.identlist (fn _ => let val  (TOK_ID as 
TOK_ID1) = TOK_ID1 ()
 val  (identlist as identlist1) = identlist1 ()
 in (TOK_ID::identlist)
end)
 in ( LrTable.NT 4, ( result, TOK_ID1left, identlist1right), rest671)

end
|  ( 15, ( ( _, ( MlyValue.TOK_ID TOK_ID1, TOK_ID1left, TOK_ID1right))
 :: rest671)) => let val  result = MlyValue.identlist (fn _ => let
 val  (TOK_ID as TOK_ID1) = TOK_ID1 ()
 in ([TOK_ID])
end)
 in ( LrTable.NT 4, ( result, TOK_ID1left, TOK_ID1right), rest671)
end
|  ( 16, ( ( _, ( MlyValue.procdeflist procdeflist1, _, 
procdeflist1right)) :: _ :: ( _, ( MlyValue.procdef procdef1, 
procdef1left, _)) :: rest671)) => let val  result = 
MlyValue.procdeflist (fn _ => let val  (procdef as procdef1) = 
procdef1 ()
 val  (procdeflist as procdeflist1) = procdeflist1 ()
 in (procdef::procdeflist)
end)
 in ( LrTable.NT 5, ( result, procdef1left, procdeflist1right), 
rest671)
end
|  ( 17, ( rest671)) => let val  result = MlyValue.procdeflist (fn _
 => ([]))
 in ( LrTable.NT 5, ( result, defaultPos, defaultPos), rest671)
end
|  ( 18, ( ( _, ( MlyValue.prog prog1, _, prog1right)) :: ( _, ( 
MlyValue.TOK_ID TOK_ID1, _, _)) :: ( _, ( _, TOK_PROCEDURE1left, _))
 :: rest671)) => let val  result = MlyValue.procdef (fn _ => let val 
 (TOK_ID as TOK_ID1) = TOK_ID1 ()
 val  (prog as prog1) = prog1 ()
 in (PROC(TOK_ID,prog))
end)
 in ( LrTable.NT 6, ( result, TOK_PROCEDURE1left, prog1right), rest671
)
end
|  ( 19, ( ( _, ( _, _, TOK_RBRACE1right)) :: ( _, ( MlyValue.cmdlist 
cmdlist1, _, _)) :: ( _, ( _, TOK_LBRACE1left, _)) :: rest671)) => let
 val  result = MlyValue.cmdseq (fn _ => let val  (cmdlist as cmdlist1)
 = cmdlist1 ()
 in (cmdlist)
end)
 in ( LrTable.NT 12, ( result, TOK_LBRACE1left, TOK_RBRACE1right), 
rest671)
end
|  ( 20, ( ( _, ( MlyValue.cmdlist cmdlist1, _, cmdlist1right)) :: _
 :: ( _, ( MlyValue.cmd cmd1, cmd1left, _)) :: rest671)) => let val  
result = MlyValue.cmdlist (fn _ => let val  (cmd as cmd1) = cmd1 ()
 val  (cmdlist as cmdlist1) = cmdlist1 ()
 in (cmd::cmdlist)
end)
 in ( LrTable.NT 10, ( result, cmd1left, cmdlist1right), rest671)
end
|  ( 21, ( rest671)) => let val  result = MlyValue.cmdlist (fn _ => (
[]))
 in ( LrTable.NT 10, ( result, defaultPos, defaultPos), rest671)
end
|  ( 22, ( ( _, ( _, _, TOK_RPAREN1right)) :: ( _, ( MlyValue.TOK_ID 
TOK_ID1, _, _)) :: _ :: ( _, ( _, TOK_READ1left, _)) :: rest671)) =>
 let val  result = MlyValue.cmd (fn _ => let val  (TOK_ID as TOK_ID1)
 = TOK_ID1 ()
 in (RD TOK_ID)
end)
 in ( LrTable.NT 11, ( result, TOK_READ1left, TOK_RPAREN1right), 
rest671)
end
|  ( 23, ( ( _, ( MlyValue.TOK_ID TOK_ID1, _, TOK_ID1right)) :: ( _, (
 _, TOK_CALL1left, _)) :: rest671)) => let val  result = MlyValue.cmd
 (fn _ => let val  (TOK_ID as TOK_ID1) = TOK_ID1 ()
 in (CL TOK_ID)
end)
 in ( LrTable.NT 11, ( result, TOK_CALL1left, TOK_ID1right), rest671)

end
|  ( 24, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: ( _, ( _, 
TOK_PRINT1left, _)) :: rest671)) => let val  result = MlyValue.cmd (fn
 _ => let val  (expr as expr1) = expr1 ()
 in (PR expr)
end)
 in ( LrTable.NT 11, ( result, TOK_PRINT1left, expr1right), rest671)

end
|  ( 25, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: _ :: ( _, ( 
MlyValue.TOK_ID TOK_ID1, TOK_ID1left, _)) :: rest671)) => let val  
result = MlyValue.cmd (fn _ => let val  (TOK_ID as TOK_ID1) = TOK_ID1
 ()
 val  (expr as expr1) = expr1 ()
 in (set TOK_ID expr)
end)
 in ( LrTable.NT 11, ( result, TOK_ID1left, expr1right), rest671)
end
|  ( 26, ( ( _, ( _, _, TOK_FI1right)) :: ( _, ( MlyValue.cmdseq 
cmdseq2, _, _)) :: _ :: ( _, ( MlyValue.cmdseq cmdseq1, _, _)) :: _ ::
 ( _, ( MlyValue.expr expr1, _, _)) :: ( _, ( _, TOK_IF1left, _)) :: 
rest671)) => let val  result = MlyValue.cmd (fn _ => let val  (expr
 as expr1) = expr1 ()
 val  cmdseq1 = cmdseq1 ()
 val  cmdseq2 = cmdseq2 ()
 in (ITE (expr,cmdseq1,cmdseq2))
end)
 in ( LrTable.NT 11, ( result, TOK_IF1left, TOK_FI1right), rest671)

end
|  ( 27, ( ( _, ( _, _, TOK_OD1right)) :: ( _, ( MlyValue.cmdseq 
cmdseq1, _, _)) :: _ :: ( _, ( MlyValue.expr expr1, _, _)) :: ( _, ( _
, TOK_WHILE1left, _)) :: rest671)) => let val  result = MlyValue.cmd
 (fn _ => let val  (expr as expr1) = expr1 ()
 val  (cmdseq as cmdseq1) = cmdseq1 ()
 in (WH (expr,cmdseq))
end)
 in ( LrTable.NT 11, ( result, TOK_WHILE1left, TOK_OD1right), rest671)

end
|  ( 28, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (ADD (expr1,expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 29, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (SUB (expr1,expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 30, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (MUL (expr1,expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 31, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (DIV (expr1,expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 32, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (RADD (expr1,expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 33, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (RSUB (expr1,expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 34, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (RMUL (expr1,expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 35, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (RDIV (expr1,expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 36, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: ( _, ( _, 
TOK_INV1left, _)) :: rest671)) => let val  result = MlyValue.expr (fn
 _ => let val  (expr as expr1) = expr1 ()
 in (INV (expr))
end)
 in ( LrTable.NT 13, ( result, TOK_INV1left, expr1right), rest671)
end
|  ( 37, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (MOD (expr1,expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 38, ( ( _, ( MlyValue.TOK_ID TOK_ID1, TOK_ID1left, TOK_ID1right))
 :: rest671)) => let val  result = MlyValue.expr (fn _ => let val  (
TOK_ID as TOK_ID1) = TOK_ID1 ()
 in (
case lookup (!SymbolTable) TOK_ID of (INTEGER s) => (IREF TOK_ID) | (BOOLEAN b) => (BREF TOK_ID)
)
end)
 in ( LrTable.NT 13, ( result, TOK_ID1left, TOK_ID1right), rest671)

end
|  ( 39, ( ( _, ( MlyValue.TOK_NUM TOK_NUM1, TOK_NUM1left, 
TOK_NUM1right)) :: rest671)) => let val  result = MlyValue.expr (fn _
 => let val  (TOK_NUM as TOK_NUM1) = TOK_NUM1 ()
 in (NUM TOK_NUM)
end)
 in ( LrTable.NT 13, ( result, TOK_NUM1left, TOK_NUM1right), rest671)

end
|  ( 40, ( ( _, ( MlyValue.TOK_NUM TOK_NUM1, _, TOK_NUM1right)) :: ( _
, ( _, TOK_UMINUS1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  (TOK_NUM as TOK_NUM1) = TOK_NUM1 ()
 in (NUM (~1*TOK_NUM))
end)
 in ( LrTable.NT 13, ( result, TOK_UMINUS1left, TOK_NUM1right), 
rest671)
end
|  ( 41, ( ( _, ( MlyValue.TOK_NUM TOK_NUM1, _, TOK_NUM1right)) :: ( _
, ( _, TOK_ADD1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  (TOK_NUM as TOK_NUM1) = TOK_NUM1 ()
 in (NUM TOK_NUM)
end)
 in ( LrTable.NT 13, ( result, TOK_ADD1left, TOK_NUM1right), rest671)

end
|  ( 42, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (OR (expr1, expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 43, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (AND (expr1, expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 44, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: ( _, ( _, 
TOK_NOT1left, _)) :: rest671)) => let val  result = MlyValue.expr (fn
 _ => let val  (expr as expr1) = expr1 ()
 in (NOT expr)
end)
 in ( LrTable.NT 13, ( result, TOK_NOT1left, expr1right), rest671)
end
|  ( 45, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (GT (expr1, expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 46, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (GE (expr1, expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 47, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (LT (expr1, expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 48, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (LE (expr1, expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 49, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (EQ (expr1, expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 50, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (NE (expr1, expr2))
end)
 in ( LrTable.NT 13, ( result, expr1left, expr2right), rest671)
end
|  ( 51, ( ( _, ( _, TOK_TT1left, TOK_TT1right)) :: rest671)) => let
 val  result = MlyValue.expr (fn _ => (TRUE))
 in ( LrTable.NT 13, ( result, TOK_TT1left, TOK_TT1right), rest671)

end
|  ( 52, ( ( _, ( _, TOK_FF1left, TOK_FF1right)) :: rest671)) => let
 val  result = MlyValue.expr (fn _ => (FALSE))
 in ( LrTable.NT 13, ( result, TOK_FF1left, TOK_FF1right), rest671)

end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.block x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : In_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun TOK_ADD (p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_UMINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_SUB (p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_MUL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_DIV (p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_MOD (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_EQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 6,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_RADD (p1,p2) = Token.TOKEN (ParserData.LrTable.T 7,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_RSUB (p1,p2) = Token.TOKEN (ParserData.LrTable.T 8,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_RMUL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 9,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_RDIV (p1,p2) = Token.TOKEN (ParserData.LrTable.T 10,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_NE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 11,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_GT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 12,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_GE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 13,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_LT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 14,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_LE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 15,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_AND (p1,p2) = Token.TOKEN (ParserData.LrTable.T 16,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_OR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 17,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_NOT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 18,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_ASSIGN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 19,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_INV (p1,p2) = Token.TOKEN (ParserData.LrTable.T 20,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_VAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 21,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_INTEGER (p1,p2) = Token.TOKEN (ParserData.LrTable.T 22,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_BOOLEAN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 23,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_RATIONAL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 24,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_READ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 25,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_CALL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 26,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_PRINT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 27,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_IF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 28,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_THEN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 29,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_ELSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 30,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_FI (p1,p2) = Token.TOKEN (ParserData.LrTable.T 31,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_WHILE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 32,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_DO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 33,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_OD (p1,p2) = Token.TOKEN (ParserData.LrTable.T 34,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_TT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 35,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_FF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 36,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_SEMICOLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 37,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_PROCEDURE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 38,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_COMMA (p1,p2) = Token.TOKEN (ParserData.LrTable.T 39,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_LBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 40,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_RBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 41,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_LPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 42,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_RPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 43,(
ParserData.MlyValue.VOID,p1,p2))
fun TOK_ID (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 44,(
ParserData.MlyValue.TOK_ID (fn () => i),p1,p2))
fun TOK_NUM (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 45,(
ParserData.MlyValue.TOK_NUM (fn () => i),p1,p2))
fun TOK_EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 46,(
ParserData.MlyValue.VOID,p1,p2))
end
end
