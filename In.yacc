open DataTypes
open Rational
open Dictionary

val SymbolTable = ref (create())

fun makeVarList (l::L) t = (
        SymbolTable := update (!SymbolTable) l (t l);
        (t l)::(makeVarList L t))
  | makeVarList []     t = []

fun prependAll (l::L) L' = l::(prependAll L L')
  | prependAll []     L' = L'

fun set id expr =
    case lookup (!SymbolTable) id of 
        (INT s) => SETINT (id, expr)
      | (BOOL b) => SETBOOL (id, expr)

%%

%name In 

%term TOK_ADD | TOK_UMINUS | TOK_SUB | TOK_MUL | TOK_DIV | TOK_MOD | TOK_EQ | 
      TOK_NE | TOK_GT | TOK_GE | TOK_LT | TOK_LE | TOK_AND | TOK_OR | TOK_NOT | 
      TOK_ASSIGN | TOK_INVERSE | TOK_VAR | TOK_INTEGER | TOK_BOOLEAN | TOK_RATIONAL | TOK_READ | TOK_CALL | TOK_PRINT 
      TOK_WRITE | TOK_IF | TOK_THEN | TOK_ELSE | TOK_FI | TOK_WHILE | TOK_DO | 
      TOK_OD | TOK_TT | TOK_FF | TOK_SEMICOLON | TOK_PROCEDURE
      TOK_COMMA | TOK_LBRACE | TOK_RBRACE | TOK_LPAREN | TOK_RPAREN | 
      TOK_ID of string | TOK_NUM of int | TOK_EOF | TOK_RAT of rational

%nonterm prog of PROG | declist of DEC list | dec of DEC list | 
         varlist of string list | cmdlist of CMD list | cmd of CMD | 
         cmdseq of CMD list | expr of EXPR

%left TOK_OR
%left TOK_AND
%right TOK_NOT TOK_UMINUS TOK_INV  
%left TOK_EQ TOK_NE TOK_LE TOK_LT TOK_GE TOK_GT
%left TOK_ADD TOK_SUB TOK_RADD TOK_RSUB
%left TOK_MUL TOK_DIV TOK_MOD TOK_RMUL TOK_RDIV

%pos int
%eop TOK_EOF
%noshift TOK_EOF
%nodefault
%verbose
%keyword TOK_PROCEDURE TOK_VAR TOK_INTEGER TOK_BOOLEAN TOK_READ TOK_CALL TOK_PRINT TOK_IF TOK_THEN 
         TOK_ELSE TOK_FI TOK_WHILE TOK_DO TOK_OD TOK_TT TOK_FF
%arg (fileName) : string



%%

prog: declist cmdseq (PROG (declist, cmdseq))

declist: vardeclist                       (vardeclist)
       | procdeflist                      (procdeflist)
       | vardeclist procdeflist           (vardeclist @ procdeflist)

vardeclist : ratvardec intvardec boolvardec             (ratvardec @ intvardec @ boolvardec)
              | ratvardec intvardec                     (ratvardec @ intvardec)
              | ratvardec boolvardec                    (ratvardec @ boolvardec)
              | intvardec boolvardec                    (intvardec @ boolvardec)
              | ratvardec                               (ratvardec)
              | intvardec                               (intvardec)
              | boolvardec                              (boolvardec)
              |

ratvardec : TOK_RATIONAL identlist TOK_SEMICOLON        (makeVarList varlist RATIONAL)

intvardec : TOK_INTEGER identlist TOK_SEMICOLON         (makeVarList varlist INTEGER)

boolvardec : TOK_BOOLEAN identlist TOK_SEMICOLON        (makeVarList varlist BOOLEAN)

identlist : TOK_ID TOK_COMMA identlist                  (TOK_ID::identlist)
            | TOK_ID                                    ([TOK_ID])

procdeflist : procdef TOK_SEMICOLON procdeflist |       (procdef::procdeflist)
              |                                         ([])

procdef : TOK_PROCEDURE TOK_ID prog                     (PROCEDURE(TOK_ID,prog))

cmdseq: TOK_LBRACE cmdlist TOK_RBRACE                   (cmdlist)

cmdlist: cmd TOK_SEMICOLON cmdlist                      (cmd::cmdlist)
       |                       ([])

cmd: TOK_READ TOK_ID                                    (RD TOK_ID)
   | TOK_CALL TOK_ID                                    (CL TOK_ID)
   | TOK_PRINT expr                                     (PR expr)
   | TOK_ID TOK_ASSIGN expr                             (set TOK_ID expr)
   | TOK_IF expr TOK_THEN cmdseq TOK_ELSE cmdseq TOK_FI (ITE (expr,cmdseq1,cmdseq2))
   | TOK_WHILE expr TOK_DO cmdseq TOK_OD                (WH (expr,cmdseq))

expr: expr TOK_ADD expr %prec TOK_ADD (ADD (expr1,expr2))
    | expr TOK_SUB expr %prec TOK_SUB (SUB (expr1,expr2))
    | expr TOK_MUL expr %prec TOK_MUL (MUL (expr1,expr2))
    | expr TOK_DIV expr %prec TOK_DIV (DIV (expr1,expr2))
    | expr TOK_RADD expr %prec TOK_RADD (RADD (expr1,expr2))
    | expr TOK_RSUB expr %prec TOK_RSUB (RSUB (expr1,expr2))
    | expr TOK_RMUL expr %prec TOK_RMUL (RMUL (expr1,expr2))
    | expr TOK_RDIV expr %prec TOK_RDIV (RDIV (expr1,expr2))
    | TOK_INV expr                        (INV (expr))
    | expr TOK_MOD expr %prec TOK_MOD (MOD (expr1,expr2))
    | TOK_ID (case lookup (!SymbolTable) TOK_ID of (INT s) => (IREF TOK_ID) | (BOOL b) => (BREF TOK_ID))
    | TOK_NUM (NUM TOK_NUM)
    | TOK_RAT (RAT TOK_RAT)
    | TOK_UMINUS TOK_NUM (NUM (~1*TOK_NUM))
    | TOK_ADD TOK_NUM (NUM TOK_NUM)
    | expr TOK_OR expr %prec TOK_OR (OR (expr1, expr2))
    | expr TOK_AND expr %prec TOK_AND (AND (expr1, expr2))
    | TOK_NOT expr %prec TOK_NOT (NOT expr)
    | expr TOK_GT expr %prec TOK_GT (GT (expr1, expr2))
    | expr TOK_GE expr %prec TOK_GE (GE (expr1, expr2))
    | expr TOK_LT expr %prec TOK_LT (LT (expr1, expr2))
    | expr TOK_LE expr %prec TOK_LE (LE (expr1, expr2))
    | expr TOK_EQ expr %prec TOK_EQ (EQ (expr1, expr2))
    | expr TOK_NE expr %prec TOK_NE (NE (expr1, expr2))
    | TOK_TT (TRUE)
    | TOK_FF (FALSE)