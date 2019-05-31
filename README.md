# miniC

My simple `miniC` language `lex`, `yacc` files

## Build

```code
sudo apt install flex bison

lex minic.l
yacc -d minic.y

gcc -o minicc y.tab.c lex.yy.c
```
