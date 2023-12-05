function cls() print("\e[2J") end

function start_reverse_text()
    print("\e[7m")
end

function stop_reverse_text()
    print("\e[27m")
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

function cursor_to(r,c)
    print("\e[$(r);$(c)H")
end

function hide_cursor()
    print("\e[?25l]")
end

function show_cursor()
    print("\e[?25h]")
end


function str_from_vec(v,c)
    alph = "O|@*"
    #alph = "O|23456789"
    #alph = "abcdefghijklmnopqrstuvwxyz_"
    #alph = "ABCDEFGHIJKLMNOPQRSTUVWXYZ_"
    join(map(i -> alph[i+1:i+1]*c, v))
end