
function key(n)
    max_width = 13
    num_discs = 9 
    k = []
    c = map( i -> i + 1, Random.randperm(max_width)[begin:num_discs])
    for i in 1:num_discs push!(k, rand(0:n-1,c[i])) end
    k
end


function str(v)
    #out_alph = "abcdefghijklmnopqrstuvwxyz" * string('\u2586')    
    #out_alph = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"     out_alph = "0|23456789"
    out_alph = "O|@*" * string('\u25A0')
    #out_alph = "0" * string('\u2590')
    join(map(i -> out_alph[i+1:i+1],v ))
end

function rgb(r,g,b)
    "\e[38;2;$(r);$(g);$(b)m"
end

function red()
    rgb(255,0,0)
end

function yellow()
    rgb(255,255,0)
end

function white()
    rgb(255,255,255)
end

function gray(h)
    rgb(h,h,h)
end

function move_cursor(r,c)
    print("\e[$(r);$(c)H")
end
void cursor_to(int r, int c) {
    printf("\x1b[%d;%dH",r,c);
}


function print_key(f)
    for i in eachindex(f) 
        print(str(f[i]),"\n")
    end
end

function print_vec(v)
    print(str(v),"\n")
end

function stack(f)
    s = 0
    for i in eachindex(f) s += f[i][begin] end
    s
end

function twist!(f,a,n)
    for i in eachindex(f) f[i][1] = mod(f[i][1] + a,n) end
end

function roll!(f, a)
    for i in eachindex(f) f[i] = circshift(f[i],f[mod1(i-1,length(f))][1] + a + 1) end
end


function encode(p,f,n)
    c = Int64[]
    for i in eachindex(p)
        push!(c, mod( stack(f) + p[i], n))
        twist!(f,c[i],n)
        roll!(f, p[i])
    end
    c
end

function decode(c,f,n)
    p = Int64[]
    for i in eachindex(c)
        push!(p, mod( c[i] - stack(f), n))
        twist!(f,c[i],n)
        roll!(f, p[i])  
    end
    p
end

function spin!(f, k, n)
    p = deepcopy(f[k])
    for i in eachindex(p)
        twist!(f, stack(f) + p[i], n)
        roll!(f,p[i])  
    end
end


function encrypt(p,q,n)
    l = length(q)
    for i in 1:l
        f = deepcopy(q)
        spin!(f,i,n)
        p = encode(p,f,n)
        p = reverse(p)
    end
    p
end
function decrypt(c,q,n)
    l = length(q)
    for i in 1:l
        f = deepcopy(q)
        spin!(f,l + 1 - i,n)
        c = reverse(c)
        c = decode(c,f,n)
        
    end
    c
end



    

function demo(n)
    f = key(n)
    l = 32
    println()
    print_key(f)
    println()
    for i in 1:3
        p = rand(0:n-1,l)
        print(red())
        print_vec(p)
        c = encrypt(p,f,n)
        print(yellow())
        print_vec(c)
        d = decrypt(c,f,n)
        println()
        d = decrypt(c,f,n)
        if p != d print("\nERROR\n") end
    end
end