structure Symbol_Table =
struct

    datatype symbol_table = S_TABLE of (string * string * string) list

    exception NotFound
    fun create() = S_TABLE [];

    fun search (S_TABLE table) ident = 
        if table = [] then false
        else if #1(hd(table)) = ident then true
        else search(S_TABLE tl(table)) ident

    fun lookup (S_TABLE table) ident =
        if #1(hd(table)) = ident then #3(hd(table))
        else search(S_TABLE tl(table)) ident
        | lookup (S_TABLE []) ident = raise NotFound;
    
    fun size(S_TABLE table) = 
        if table = [] then 0
        else 1 + size(S_TABLE tl(table));

    fun isEmpty(S_TABLE []) = true
        | isEmpty(S_TABLE table) = false ;

    fun remove (S_TABLE table) ident =
        let
            fun rm head ((a,b,c) :: tail) = 
                if a = ident then rm head tail
                else rm ((a,b,c) :: head) tail
            | rm head [] = head
        in
            S_TABLE (rm [] table)
        end;
    
    fun update(S_TABLE table) ident value =
        let
            fun find_type(S_TABLE table) ident = 
                if #1(hd(table)) = ident then #2(hd(table))
                else find_type(S_TABLE tl(table)) ident
            | find_type (S_TABLE []) ident = raise NotFound;
        in
            (ident,find_type((S_TABLE table) ident),value)::(remove (S_TABLE table) ident)
        end;


end;