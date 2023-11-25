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

function spin(f,a)
    for i in 1:a
        spin(f)
    end
end

function lift(f)
    t = f[1][1]
    for i in 2:length(f)
        f[i-1][i-1] = f[i][i]
    end
    f[length(f)][length(f)] = t 
end

function lift(f,a)
    for i in 1:a
        lift(f)
    end
end
    

function print_key_symbol(i)
    key_alph = "O|_"
    print(rgb(0,rand(0:255),0))
    print(key_alph[i+1])
end



function print_key(f)
    #cls()
    for i in eachindex(f)
        for j in eachindex(f[i])
            cursor_to(i+2,2(10 - i + j))
            print_key_symbol(f[i][j])
        end
    end
end

function mod_sum_of_center_column(f,B)
    sum([f[i][i] for i in 2:length(f)])%B
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



