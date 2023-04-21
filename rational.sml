signature BIGINT = sig
    type bigint
    exception DivisionByZero
    val add: bigint * bigint -> bigint
    val subtract : bigint * bigint -> bigint
    val multiply : bigint * bigint -> bigint
    val divide : bigint * bigint -> bigint
    val equal : bigint * bigint -> bool
    val less : bigint * bigint -> bool
    val greater : bigint * bigint -> bool
    val neg : bigint -> bigint
    val gcd : bigint * bigint -> bigint
    val showBig : bigint -> string
    val division_mod : bigint * bigint -> bigint
    val break_into_lists : string -> string list
    val subtraction : string list * string list * int -> string list
    val addition : string list * string list * int -> string list
    val list_into_string : string list -> string
    val is_Zero : bigint -> bool 
    val break_bigint : bigint -> string * string list 
    val make_bigint : string * string list -> bigint 
end

structure BigInt: BIGINT = struct
    type bigint = string * string list    
    exception DivisionByZero
    
    fun last(nil) = "0"           
  	 | last(hd::[]) = hd
  	 | last(_::tail) = last(tail);

    fun list_except_last(nil) = nil
        | list_except_last(hd::[]) = []
        | list_except_last(hd::tl) = hd::list_except_last(tl);
    
    fun break_into_lists (s : string) =
        let 
            val l = explode(s)
            fun map_char_to_str (nil) = nil
                | map_char_to_str(hd::tl) = String.str hd :: map_char_to_str(tl)
        in 
            map_char_to_str(l)
        end

    fun remove_zeroes (l : string list) =     (*this function removes 'extra' zeroes from the string list*)
        if (hd(l) = "0" andalso tl(l) <> nil) then remove_zeroes(tl(l))
        else if (hd(l) = "0" andalso tl(l) = nil) then ["0"]
        else l
    
    fun list_into_string(nil) = ""
        | list_into_string(x::y) = x ^ list_into_string(y)

    fun extractlength(l1,l2,list) = (* in this function what we do is that from l1 we extract the more significant list of length corresp to that of l2 *)
        let
            val n1 = length(list)
            val n2 = length(l2)
        in
            if n1 = n2 then (list,l1)
            else extractlength(tl(l1),l2,list@[hd(l1)])
        end;

    fun make_bigint (p : string, q : string list) = (p,q)

    fun break_bigint (x) = 
        let
            val (p,q) = x
        in
            (p,q)
        end 
 
    fun showBig(x) = 
        let
            val (sign,num) = x
        in
            sign ^ list_into_string(num)
        end;

    fun neg(x) = 
        let
            val (sign,num) = x
        in
            if sign = "+" then ("~",num)
            else ("~",num)
        end;

    fun lesswithoutsign (x : string list ,y : string list) =   (*checks if x < y or not *)
        let
            val l11 = remove_zeroes x
            val l21 = remove_zeroes y
            val n1 = length l11
            val n2 = length l21
            val hd11 = valOf(Int.fromString(hd(l11)))
            val hd21 = valOf(Int.fromString(hd(l21)))
        in
            if n1 < n2 then true
            else if n1 > n2 then false
            else
                if hd11 > hd21 then false
                else if hd11 < hd21 then true
                else 
                    if (tl(l11) <> nil andalso tl(l21) <> nil ) then lesswithoutsign(tl(l11), tl(l21))
                    else false
        end;

    fun less(x,y) = 
        let
            val (sign1,num1) = x
            val (sign2,num2) = y
            val l11 = remove_zeroes num1
            val l21 = remove_zeroes num2
            val hd11 = valOf(Int.fromString(hd(l11)))
            val hd21 = valOf(Int.fromString(hd(l21)))
        in
            if (sign1 = "+" andalso sign2 = "~") andalso not(hd11 = 0 andalso hd21 = 0) then false
            else if (sign1 = "~" andalso sign2 = "+") andalso not(hd11 = 0 andalso hd21 = 0) then true
            else if ((sign1 = "+" andalso sign2 = "~") orelse (sign1 = "~" andalso sign2 = "+")) andalso (hd11 = 0 andalso hd21 = 0) then false
            else if sign1 = "+" then lesswithoutsign(num1,num2)
            else not(lesswithoutsign(num1,num2))
        end;
    
    fun greater (x,y) = not(less(x,y));

    fun equal(x,y) =   (*checks if x = y or not *)
        let
            val (sign1 : string,num1) = x
            val (sign2 : string,num2) = y
            val l11 = remove_zeroes num1
            val l21 = remove_zeroes num2
            val n1 = length l11
            val n2 = length l21
            val hd11 = valOf(Int.fromString(hd(l11)))
            val hd21 = valOf(Int.fromString(hd(l21)))
        in
            if sign1 <> sign2 andalso not(hd11 = 0 andalso hd21 = 0) then false
            else if sign1 <> sign2 andalso (hd11 = 0 andalso hd21 = 0) then true
            else
                if n1 <> n2 then false
                else
                    if hd11 <> hd21 then false
                    else 
                        if (tl(l11) <> nil andalso tl(l21) <> nil ) then equal((sign1,tl(l11)), (sign2,tl(l21)))
                        else true
        end;

    fun is_Zero(x) = 
        if equal(x,("+",["0"])) then true else false 

    fun greater_equal(x : string list,y : string list) = (* checks if x >= y *)
        lesswithoutsign(y,x) orelse equal(("+",x),("+",y));

    fun addition (x: string list , y : string list, carry : int) = 
        let 
            val last_l1 = last(x)
            val last_l2 = last(y)
            val last_l11 = valOf(Int.fromString last_l1)
            val last_l21 = valOf(Int.fromString last_l2)
            val sum = last_l11 + last_l21 + carry
            val head1 = list_except_last(x)
            val head2 = list_except_last(y)
        in
            if (sum > 9 andalso head1 = nil andalso head2 = nil) then ["1"]@[Int.toString (sum mod 10)]
            else if (sum <= 9 andalso head1 = nil andalso head2 = nil) then [Int.toString sum]
            else 
                if sum <= 9 then addition(head1, head2, 0)@[Int.toString sum]
                else addition(head1, head2, 1)@[Int.toString (sum mod 10)]
        end;

    fun subtraction (x : string list, y : string list, borrow : int) =    (* l1 - l2 , assuming that subtracting smaller number from larger one *)
        let  
            fun subtract (a1 : int , a2 : int, borrow : int) = 
                if a1 - borrow - a2 < 0  then (a1 + 10 - a2 - borrow, 1)
                else (a1 - a2 - borrow, 0)

            val last_l1 = last(x)
            val last_l2 = last(y)
            val last_l11 = valOf(Int.fromString last_l1)
            val last_l21 = valOf(Int.fromString last_l2)
            val (sub1, new_borrow) = subtract(last_l11,last_l21, borrow)
            val head1 = list_except_last(x)
            val head2 = list_except_last(y)
        in
            if (head1 = nil andalso head2 = nil ) then [Int.toString sub1]
            else remove_zeroes(subtraction(head1, head2, new_borrow)@[Int.toString sub1])
        end;

    fun add(x,y) =
        let
            val (sign1,num1) = x
            val (sign2,num2) = y
        in
            if sign1 = sign2 then (sign1,addition(num1,num2,0))
            else if (sign1 = "+" andalso lesswithoutsign(num2,num1)) then ("+",subtraction(num1,num2,0)) 
            else if (sign1 = "+" andalso not(lesswithoutsign(num2,num1))) then ("~",subtraction(num2,num1,0)) 
            else if (sign1 = "~" andalso lesswithoutsign(num2,num1)) then ("~",subtraction(num1,num2,0)) 
            else ("+",subtraction(num2,num1,0)) 
        end;

    fun subtract(x,y) =
        let
            val (sign1,num1) = x
            val (sign2,num2) = y
        in
            if sign1 = "+" andalso sign2 = "~" then ("+",addition(num1,num2,0))
            else if sign1 = "~" andalso sign2 = "+" then ("~",addition(num1,num2,0))
            else if (sign1 = "+" andalso sign2 = "+") then
                if lesswithoutsign(num1,num2) then ("~",subtraction(num2,num1,0))
                else ("+",subtraction(num1,num2,0))
            else 
                if lesswithoutsign(num1,num2) then ("+",subtraction(num2,num1,0))
                else ("~",subtraction(num1,num2,0))
        end;

    fun multiplywithint(l1 : string list, num : int, carry : int) =
        let
            val last_l1 = last(l1)
            val last_l11 = valOf(Int.fromString last_l1)
            val head1 = list_except_last(l1)
            val mult = (last_l11 * num) + carry 
        in
            if head1 = nil then break_into_lists(Int.toString mult)
            else 
                if mult < 10 then multiplywithint(head1, num, 0)@[Int.toString mult]
                else multiplywithint(head1, num , (mult div 10)) @ [Int.toString (mult mod 10)]
        end;

    fun multiplywithoutsign(x,y,zero_list,running_sum) =
        let
            val last_l2 = last(y)
            val last_l21 = valOf(Int.fromString last_l2)
            val head2 = list_except_last(y)
            val product = multiplywithint(x,last_l21,0)@zero_list
        in
            if head2 = nil then addition(running_sum,product,0)
            else multiplywithoutsign(x,head2,zero_list@["0"],addition(running_sum,product,0))
        end;

    fun multiply(x,y) =
        let
            val (sign1 : string,num1) = x
            val (sign2 :string,num2) = y
        in
            if sign1 = sign2 then ("+",remove_zeroes(multiplywithoutsign(num1,num2,[],["0"])))
            else ("~",remove_zeroes(multiplywithoutsign(num1,num2,[],["0"])))
        end;

    fun digit_to_multiply (l1 : string list , l2 : string list, n : int) =   (* l1 : curr_dividend , l2 : curr_divisor *)
        let 
            val l4 = multiplywithint(l2, n, 0)
        in
            if greater_equal(l1, l4) then n
            else digit_to_multiply(l1, l2, n-1)
        end;

    fun divide1(l1 : string list,l2: string list,curr_rem  : string ,curr_quo : string,first : bool) =
        let
            val (curr_dividend,left) =  if length(l1) < length(l2) andalso first then (["0"],["0"])
                                        else if first then extractlength(l1,l2,[])
                                        else (break_into_lists(curr_rem ^ hd(l1)) ,tl(l1))
            val num = Int.toString(digit_to_multiply(curr_dividend,l2,9))
            val product = multiplywithoutsign(l2,[num],[],["0"])
            val new_rem = list_into_string(subtraction(curr_dividend,product,0))
        in
            if length(l1) < length(l2) andalso first then ["0"]
            else if left = nil then remove_zeroes(break_into_lists(curr_quo ^ num))
            else divide1(left,l2,new_rem,curr_quo ^ num, false)
        end;

    fun divide (x,y) = 
        let
            val (sign1 : string,num1) = x
            val (sign2  :string,num2) = y
        in
            if is_Zero(y) then raise DivisionByZero
            else if sign1 = sign2 then ("+",divide1(num1,num2,"0","0",true))
            else ("~",divide1(addition(num1,subtraction(num2,["1"],0),0),num2,"0","0",true))
        end

    fun division_mod(x,y) = 
        let
            fun divideformod(l1 : string list,l2: string list,curr_rem  : string ,curr_quo : string,first : bool) =
                let
                    val (curr_dividend,left) =  if length(l1) < length(l2) andalso first then (["0"],["0"])
                                                else if first then extractlength(l1,l2,[])
                                                else (break_into_lists(curr_rem ^ hd(l1)) ,tl(l1))
                    val num = Int.toString(digit_to_multiply(curr_dividend,l2,9))
                    val product = multiplywithoutsign(l2,[num],[],["0"])
                    val new_rem = list_into_string(subtraction(curr_dividend,product,0))
                in
                    if length(l1) < length(l2) andalso first then l1
                    else if left = nil then break_into_lists(new_rem)
                    else divideformod(left,l2,new_rem,curr_quo ^ num, false)
                end

            val (sign1  :string,num1) = x
            val (sign2  :string,num2) = y
        in
            if sign1 = sign2 then ("+",divideformod(num1,num2,"0","",true))
            else ("+",subtraction(num2,divideformod(num1,num2,"0","",true),0))
        end

    fun gcd(x,y) = 
        let
            val (sign1,num1) = x
            val (sign2,num2) = y
            val x1 = ("+",num1)
            val y1 = ("+",num2)
        in
            if equal(x1,("+",["0"])) then y1
            else if equal(y1,("+",["0"])) then x1
            else if equal(x1,y1) then x1 
            else if less(x1,y1) then gcd(x1,division_mod(y1,x1))
            else gcd(y1,division_mod(x1,y1))
        end;
end

functor Rational (BigInt : BIGINT) : 
    sig 
        type rational
        exception rat_error 

        val make_rat: BigInt.bigint * BigInt.bigint -> rational option
        val rat: BigInt.bigint -> rational option
        val reci: BigInt.bigint -> rational option
        val neg: rational -> rational
        val inverse : rational -> rational option
        val equal : rational * rational -> bool (* equality *)
        val less : rational * rational -> bool (* less than *)
        val add : rational * rational -> rational (* addition *)
        val subtract : rational * rational -> rational (* subtraction *)
        val multiply : rational * rational -> rational (* multiplication *)
        val divide : rational * rational -> rational option (* division *)
        val showRat : rational -> string
        val showDecimal : rational -> string
        val fromDecimal : string -> rational
        val toDecimal : rational -> string

    end
= 
    struct 
    open BigInt 


        type rational = BigInt.bigint * BigInt.bigint
        exception rat_error

        fun make_rat(x:BigInt.bigint, y:BigInt.bigint) = 
            let
                val (sign1 : string,num1 : string list) = BigInt.break_bigint(x)
                val (sign2 : string,num2  :string list) = BigInt.break_bigint(y)
                val sign = if sign1 = sign2 then "+"
                            else "~"
                val factor = BigInt.gcd(x,y)
                val x1 = BigInt.divide(BigInt.make_bigint(sign,num1),factor)
                val y1 = BigInt.divide(BigInt.make_bigint("+",num2),factor)
            in
                if BigInt.is_Zero(y) then NONE else SOME (x1,y1)
            end

        
        fun rat(x : BigInt.bigint) = SOME (x,BigInt.make_bigint("+",["1"]))

        fun inverse (x) =
            let
                val (p,q) = x
            in
                if BigInt.is_Zero(q) then NONE else make_rat(q,p)
            end

        
        fun reci(x : BigInt.bigint) = 
            let
                val (p,q) = BigInt.break_bigint(x)
            in
                if BigInt.is_Zero(x) then NONE else SOME (BigInt.make_bigint(p,["1"]),BigInt.make_bigint("+",q))
            end 

        fun neg(x) = 
            let
                val (p,q) = x
                val (signp,nump) =  BigInt.break_bigint(p)
                val (signq,numq) =  BigInt.break_bigint(q)
                val p1 = if signp = signq then BigInt.make_bigint("~",nump)
                                        else BigInt.make_bigint("+",nump)
            in
                if BigInt.is_Zero(q) then raise rat_error else (p1,BigInt.make_bigint("+",numq))
            end

        fun multiply(x,y) = 
            let
                val (p,q) = x
                val (r,s) = y
            in
                if BigInt.is_Zero(q) orelse BigInt.is_Zero(s) then raise rat_error else (BigInt.multiply(p,r),BigInt.multiply(q,s))
            end

        fun fraction_normal (x) = 
            let
                val (p,q) = x
                val t = BigInt.gcd(p,q)
                val p1 = BigInt.divide(p,t)
                val q1 = BigInt.divide(q,t)
            in
                (p1,q1)
            end;

        fun showRat(x) = 
            let
                val x1 = fraction_normal(x)
                val (p,q) = x1
                val (signp,nump) = BigInt.break_bigint(p)
                val (signq,numq) = BigInt.break_bigint(q)
            in
                if BigInt.is_Zero(q) then raise rat_error 
                else if signp = signq then "+" ^ BigInt.list_into_string(nump) ^ "/" ^ BigInt.list_into_string(numq)
                else "~" ^ BigInt.list_into_string(nump) ^ "/" ^ BigInt.list_into_string(numq)
            end;

        fun divide(x,y) = 
            let
                val (p,q) = x
                val (r,s) = y
            in
                if BigInt.is_Zero(r) orelse BigInt.is_Zero(q) orelse BigInt.is_Zero(s) then NONE
                else SOME (BigInt.multiply(p,s),BigInt.multiply(q,r))
            end

        fun equal(x,y) = 
            let
                val x1 = fraction_normal(x)
                val y1 = fraction_normal(y)
                val (p1,q1) = x1
                val (r1,s1) = y1
            in
                if BigInt.is_Zero(q1) orelse BigInt.is_Zero(s1) then raise rat_error
                else if BigInt.equal(p1,r1) andalso BigInt.equal(q1,s1) then true
                else false
            end

        fun less(x,y) = 
            let
                val (p,q) = x
                val (r,s) = y
                val x1 = BigInt.multiply(p,s)
                val y1 = BigInt.multiply(q,r)
            in
                if BigInt.is_Zero(q) orelse BigInt.is_Zero(s) then raise rat_error
                else if BigInt.less(x1,y1) then true
                else false
            end

        fun add(x,y) = 
            let
                val (p,q) = x
                val (r,s) = y 
                val x1 = BigInt.multiply(p,s)
                val y1 = BigInt.multiply(q,r)
                val deno = BigInt.multiply(q,s)
                val num = BigInt.add(x1,y1)
            in
                if BigInt.is_Zero(q) orelse BigInt.is_Zero(s) then raise rat_error else fraction_normal((num,deno))
            end

        fun subtract(x,y) = 
            let
                val (p,q) = x
                val (r,s) = y 
                val x1 = BigInt.multiply(p,s)
                val y1 = BigInt.multiply(q,r)
                val deno = BigInt.multiply(q,s)
                val num = BigInt.subtract(x1,y1)
            in
                if BigInt.is_Zero(q) orelse BigInt.is_Zero(s) then raise rat_error else fraction_normal((num,deno))
            end

        fun identify_sign(s : string list) = if hd(s) = "+" orelse hd(s) = "~" then hd(s) else "+";

        fun identify_I (s : string list, i_list : string list) =
            if hd(s) = "." then i_list
            else if hd(s) = "+" orelse hd(s) = "~" then identify_I (tl(s),i_list) 
            else identify_I(tl(s), i_list@[hd(s)]);

        fun identify_N (s : string list, n_list , start : bool) = 
            if hd(s) = "." then identify_N(tl(s), n_list, true)
            else if hd(s) = "(" then n_list
            else if start = true then identify_N(tl(s),n_list@[hd(s)],true)
            else identify_N(tl(s),n_list,start);

        fun identify_R (s : string list, r_list , start : bool) = 
            if hd(s) = "(" then identify_R(tl(s), r_list, true)
            else if hd(s) = ")" then r_list
            else if start = true then identify_R(tl(s),r_list@[hd(s)],true)
            else identify_R(tl(s),r_list,start);

        fun build_power_list(p,l : string list) = if p = 0 then l else build_power_list(p-1,l@["0"]);

        fun isdigit(s : string) =
            if s = "0" orelse s = "1" orelse s = "2" orelse s = "3" orelse s = "4" orelse s = "5" orelse s = "6" orelse s = "7" orelse s = "8" orelse s = "9" then true
            else false;

        fun pattern_matching(x : string list, first : bool, s_bool : bool , i_bool : bool , deci_bool : bool, n_bool : bool, r_paren_bool : bool, r_bool : bool) = 
            if x = nil then false 
            else if first = true andalso not (hd(x) = "." orelse hd(x) = "+" orelse hd(x) = "~" orelse isdigit(hd(x))) then false
            else 
                if first = true then
                    if hd(x) = "." then pattern_matching(tl(x), false, true, true, true, false, false, false)
                    else if hd(x) = "+" then pattern_matching(tl(x), false, true, false, false, false, false, false)
                    else if hd(x) = "~" then pattern_matching(tl(x), false, true, false, false, false, false, false )
                    else  pattern_matching(tl(x), false, true, true, false, false, false, false )
                else 
                    if i_bool = false andalso not(hd(x) = "." orelse isdigit(hd(x))) then false
                    else if i_bool = false andalso hd(x) = "." then pattern_matching(tl(x), false, true, true, true, false, false, false )
                    else if i_bool = false andalso isdigit(hd(x)) then pattern_matching(tl(x), false, true, true, false, false, false, false )
                    else if deci_bool = false andalso not(hd(x) = "." orelse isdigit(hd(x))) then false 
                    else if deci_bool = false andalso isdigit(hd(x)) then pattern_matching(tl(x), false, true, true, false, false, false, false )
                    else if deci_bool = false andalso hd(x) = "." then pattern_matching(tl(x), false, true, true, true, false, false, false )
                    else if n_bool = false andalso not(hd(x) = "(" orelse isdigit(hd(x))) then false
                    else if n_bool = false andalso hd(x) = "(" then pattern_matching(tl(x), false, true, true, true, true, true ,false )
                    else if n_bool = false andalso isdigit(hd(x)) then pattern_matching(tl(x), false, true, true, true, true, false ,false )
                    else if r_paren_bool = false andalso not(hd(x) = "(" orelse isdigit(hd(x))) then false 
                    else if r_paren_bool = false andalso hd(x) = "(" then pattern_matching(tl(x), false, true, true, true, true, true ,false )
                    else if r_paren_bool = false andalso isdigit(hd(x)) then pattern_matching(tl(x), false, true, true, true, true, false ,false )
                    else if r_bool = false andalso not(isdigit(hd(x))) then false
                    else if r_bool = false andalso isdigit(hd(x)) then pattern_matching(tl(x), false, true, true, true, true, true ,true)
                    else if hd(x) = ")" then true
                    else pattern_matching(tl(x), false, true, true, true, true, true ,true);


        fun fromDecimal1(s : string) = 
            let
                val s1 = BigInt.break_into_lists(s)
                val sign = identify_sign(s1)
                val i = identify_I(s1,[])
                val n = identify_N(s1,[],false)
                val r = identify_R(s1,[],false)
                val x1 = i @ n
                val x2 = i @ n @ r 
                val p1 = length(n) 
                val p2 = length(r) + length(n)
                val num = BigInt.subtraction(x2,x1,0)    (* check if you can use it cause this function not defined in the signature of bigint*)
                val deno = BigInt.subtraction(build_power_list(p2,["1"]),build_power_list(p1,["1"]),0)
            in
                valOf(make_rat(BigInt.make_bigint(sign,num),BigInt.make_bigint("+",deno)))
            end

        fun fromDecimal(s : string) =
            let 
                val correct = pattern_matching(BigInt.break_into_lists(s),true,false,false,false,false,false,false)
            in
                if correct then fromDecimal1(s)
                else raise rat_error
            end

        fun find(l : string list , x : string) =
            if l = nil then false 
            else if hd(l) = x then true
            else find(tl(l),x)

        fun find_index (l : string list, x : string, count) = if hd(l) = x then count else find_index(tl(l),x,count+1)

        fun decimal_part (p : string list, q : string list, r_list : string list, answer : string) = 
            let
                val quo = #2(BigInt.break_bigint(BigInt.divide(BigInt.multiply(BigInt.make_bigint("+",p),BigInt.make_bigint("+",["1","0"])),BigInt.make_bigint("+",q))))
                (* val var1 = print(list_into_string(quo))
                val var = print("\n") *)
                val rem = #2(BigInt.break_bigint(BigInt.division_mod(BigInt.multiply(BigInt.make_bigint("+",p),BigInt.make_bigint("+",["1","0"])),BigInt.make_bigint("+",q))))
                (* val var2 = print(list_into_string(rem))
                val var = print("\n") *)
                val found = if find(r_list,BigInt.list_into_string(rem)) then true
                            else false
                val index = if found then find_index(r_list,BigInt.list_into_string(rem),0) 
                            else 0 

            in
                if found then (answer ^ list_into_string(quo),index)
                else decimal_part(rem,q, r_list @ [BigInt.list_into_string(rem)], answer ^ BigInt.list_into_string(quo))
            end

        fun decimal_part2(ans : string list,index) =
            if index = 0 then "(" ^ BigInt.list_into_string(ans) ^ ")"
            else hd(ans) ^ decimal_part2(tl(ans),index-1)

        fun showDecimal(x) = 
            let
                val (p,q) = x
                val (ans,index) = decimal_part(#2(BigInt.break_bigint(BigInt.division_mod(p,q))),#2(BigInt.break_bigint(q)),[list_into_string(#2(BigInt.break_bigint(BigInt.division_mod(p,q))))],"")
                (* val var = print(list_into_string(#2(BigInt.break_bigint(BigInt.division_mod(p,q))))) *)
                (* val var = print(ans) *)
                val decimal = decimal_part2(BigInt.break_into_lists(ans),index)
                val integer = BigInt.divide(p,q)
                val integer1 = BigInt.showBig(integer)
            in
                if BigInt.is_Zero(q) then raise rat_error else integer1 ^ "." ^ decimal
            end

        fun toDecimal(x) = showDecimal(x);

    end 

structure Rational = Rational(BigInt);