Config { font = "xft:terminus:size=9"
       , bgColor = "black"
       , fgColor = "grey"
       , position = Top
       , lowerOnStart = True
       , commands = [ Run Weather "LLSD" ["-t","<station>: <tempC>C","-L","18","-H","25","--normal","green","--high","red","--low","lightblue"] 36000
                    , Run Network "enp7s0" ["-L","0","-H","32","--normal","green","--high","red"] 10
                    , Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 10
                    , Run Memory ["-t","Mem: <usedratio>%"] 10
                    , Run Swap [] 10
                    , Run Com "uname" ["-s","-r"] "" 36000
                    , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%cpu% | %memory% * %swap% | %enp7s0% }{ <fc=#ee9a00>%date%</fc>| %LLSD% | %uname%"
       }