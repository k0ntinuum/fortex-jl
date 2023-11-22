function key(n,b)
    f = []
    for i in 0:n-1
        push!(f, rand(0:b-1, 2i+1))
    end
    f
end

function spin(f)
    for i in eachindex(f)
        circshift!(f[i],isodd(i) ? 1 : -1 )
    end
end

function lift(f)
    t = f[1][1]
    for i in 2:length(f)
        f[i-1][i-1] = f[i][i]
    end
    f[length(f)][length(f)] = t 
end

void spin_central_column_exclude_apex(u32 f[N][L], u32 a) {
    u32 t[N] = {0};
    for (u32 i = 0; i < N-1; i++) t[i] = f[1 + ((i + a)%(N-1)) ][len[1 + ((i + a)%(N-1))]/2];
    for (u32 i = 0; i < N-1; i++) f[i+1][len[i+1]/2] = t[i];
}
function print_key_symbol(i)
    key_alph = "O|"
    print(rgb(0,rand(0:255),0))
    print(key_alph[i+1])
end



function print_key(f)
    cls()
    alph = "O|"
    for i in eachindex(f)
        for j in eachindex(f[i])
            cursor_to(i+2,2(10 - i + j))
            print_key_symbol(f[i][j])
        end
    end
end

function flicker(f)
    hide_cursor()
    for i in 1:10000
        spin(f)
        lift(f)
        print_key(f)
        sleep(0.10)
    end
end



