function sym(i)
    alph = "O|2"
    alph[i+1:i+1]
end

function print_results(p,c,f)
    x = 1
    print(white())
    cursor_to(1,0)
    print("f = ")
    for i in eachindex(f)
        cursor_to(1,5 + i)
        print(sym(f[i]))
    end

    for i in 1:sum(p)+length(p)
        cursor_to(4,i)
        #print(str_from_vec(p[i:i],""))
        @printf("%s", sym(f[mod1(i, length(f))]))
    end
    for i in eachindex(p)
        cursor_to(3,x)
        #print(str_from_vec(p[i:i],""))
        print(red())
        @printf("%s", sym(p[i]))
        cursor_to(5,x)
        print(yellow())
        @printf("%s", sym(c[i]))
        x = x + p[i] + 1
    end

end


function space_demo()
    cls()
    key_base = 3
    key_length = 16
    text_length = 36
    f = key(key_base,key_length)
    #f = map(i -> i - 1, randperm(27))
    p = rand(0:key_base-1,text_length )
    c = encode(p, f, 1,key_base)
    print_results(p,c,f)

    
    #     print(white(),"c  ==  ",yellow(), str_from_vec(c,""),"\n")
    #     e = map(i -> (key_base + c[i] - p[i])%key_base, collect(1:text_length)) 
    #     print(white(),"       ", gray(100),str_from_vec(e,""),"\n\n")
    #     d = decrypt(c,f,key_base)
    #     if p != d print("\nERROR\n") end
    # end
    # print(white())
end
