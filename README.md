# miniC

My simple `miniC` language `lex`, `yacc` files

## Build

```code
sudo apt install flex bison

lex minic.l
yacc -d minic.y

gcc y.tab.c lex.yy.c -lfl -ly -o minicc

./minicc < example.mc > example.c
gcc example.c -o example
./example
```

[![asciicast](https://asciinema.org/a/lAWFSxNOglwjm86Ng7Em7Sv06.svg)](https://asciinema.org/a/lAWFSxNOglwjm86Ng7Em7Sv06)
