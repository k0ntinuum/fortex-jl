function encrypt(p,q,B)
    n = length(q)
    c = deepcopy(p)
    for i in 1:n
        f = deepcopy(q)
        c = encode(c,f,B)
        #reverse!(c)
    end
    c
end

function decrypt(c,q,B)
    n = length(q)
    p = deepcopy(c)
    for i in 1:n
        f = deepcopy(q)
        #reverse!(p)
        p = decode(p,f,B)
    end
    p
end

    