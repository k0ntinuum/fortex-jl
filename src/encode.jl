
function encode(p,f,B)
    c = zeros(Int64, length(p))
    for i in eachindex(p)
        c[i] = (mod_sum_of_center_column(f,B) + p[i])%B
        lift(f, p[i] + 1)
        spin(f, p[i] + 1)
    end
    c
end

function decode(c,f,B)
    p = zeros(Int64, length(c))
    for i in eachindex(p)
        p[i] = (B + c[i] - mod_sum_of_center_column(f, B) )%B
        lift(f, p[i] + 1)
        spin(f, p[i] + 1)
    end
    p
end

