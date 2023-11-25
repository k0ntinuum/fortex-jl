function demo_print_symbol(i)
 
    
    demo_alph = "O|\u2594"
    #demo_alph = "O|\u0393"
    #demo_alph = "O|X"
    h = rand(0:255)
    print(gray(h))
    #print(rgb(0,rand(0:255),0))
    print(demo_alph[i+1])
end

function demo_print_key(f)
    #cls()
    for i in eachindex(f)
        for j in eachindex(f[i])
            cursor_to(i+2,2(10 - i + j))
            demo_print_symbol(f[i][j])
            if rand(0:99) > 50 
                sleep(0.001)
            end
        end
        
    end
end


function demo_encode(p,f,B) 
    #cls()
    c = zeros(Int64, length(p))
    for i in eachindex(p)
        c[i] = (mod_sum_of_center_column(f,B) + p[i])%B
        lift(f, p[i] + 1)
        spin(f, p[i] + 1)
        demo_print_key(f)
        #cursor_to(length(f) + 4, 7 + i)
        #demo_print_symbol(p[i])
        #cursor_to(length(f) + 5, 7 + i)
        #demo_print_symbol(c[i])
        #sleep(0.07)
    end
    
    c
end

function demo_decode(c,f,B)
    p = zeros(Int64, length(c))
    for i in eachindex(p)
        p[i] = (B + c[i] - mod_sum_of_center_column(f, B) )%B
        lift(f, p[i] + 1)
        spin(f, p[i] + 1)
    end
    p
end

function encoding_demo()
    B = 3
    N = 9
    f = key(N,B)
    hide_cursor()
    cls()
    for i in 1:1000 
        demo_encode(rand(0:2,25),f,B) 
    end
end
    