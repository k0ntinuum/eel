using Random
function key(b,n)
    rand(0:b-1,n)
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

function str_from_vec(v,c)
    alph = "O|@*"
    #alph = "O|23456789"
    #alph = "abcdefghijklmnopqrstuvwxyz_"
    #alph = "ABCDEFGHIJKLMNOPQRSTUVWXYZ_"
    join(map(i -> alph[i+1:i+1]*c, v))
end

function encode(p,q,x, key_base)
    f = deepcopy(q)
    n = size(q)[begin]
    c = Int64[]
    for i in eachindex(p)
        push!(c,(f[x] + p[i])%key_base)
        #f[x] = c[i]
        x = mod1(x + p[i] + 1, length(f))
    end
    c
end

function decode(c,q,x, key_base)
    f = deepcopy(q)
    n = size(q)[begin]
    p = Int64[]
    for i in eachindex(c)
        push!(p, (key_base + c[i] - f[x] )%key_base  )
        #f[x] = c[i]
        x = mod1(x + p[i] + 1, length(f))
    end
    p
end

function encrypt(p, q, key_base)
    f = deepcopy(q)
    n = size(f)[begin]
    for i in 1:n
        p = encode(p,f,i, key_base)
        p = reverse(p)
    end
    p
end


function decrypt(p, q,key_base)
    f = deepcopy(q)
    n = size(f)[begin]
    for i in 1:n
        p = reverse(p)
        p = decode(p, f , n + 1 - i ,key_base)
    end
    p
end

function demo()
    key_base = 4
    key_length = 16
    text_length = 54
    f = key(key_base,key_length)
    #f = map(i -> i - 1, randperm(27))
    print(white(),"f  ==  ", gray(255),str_from_vec(f,""),"\n\n")
    for i in 1:7
        p = rand(0:key_base-1,text_length )
        print(white(),"p  ==  ",red(), str_from_vec(p,""),"\n")
        c = encrypt(p, f, key_base)
        print(white(),"c  ==  ",yellow(), str_from_vec(c,""),"\n")
        e = map(i -> (key_base + c[i] - p[i])%key_base, collect(1:text_length)) 
        print(white(),"       ", gray(100),str_from_vec(e,""),"\n\n")
        d = decrypt(c,f,key_base)
        if p != d print("\nERROR\n") end
    end
    print(white())
end







