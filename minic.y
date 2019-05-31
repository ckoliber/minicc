%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

char finalSource[16384];
%}

%define parse.error verbose

%token <source> IDENTIFIER CONSTANT STRING_LITERAL
%token LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP

%token VOID CHAR INT FLOAT DOUBLE

%token IF ELSE WHILE DO FOR

%union {
    char source[4096];
}

%start start

%%

start
    : translation_unit

translation_unit
	: external_declaration
	| translation_unit external_declaration
	;

external_declaration
    : declaration
    | function_definition
	;


declaration
	: declaration_specifier ';'
	;
declaration_specifier
    : type_specifier init_declarator
    ;

type_specifier
	: VOID
	| CHAR
	| INT
	| FLOAT
	| DOUBLE
	;

init_declarator
	: declarator
	| declarator '=' initializer
	;

declarator
	: IDENTIFIER
	;

initializer
	: assignment_expression
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	;

assignment_expression
	: conditional_expression
	;
conditional_expression
	: logical_or_expression
	| logical_or_expression '?' expression ':' conditional_expression
	;
logical_or_expression
	: logical_and_expression
	| logical_or_expression OR_OP logical_and_expression
	;
logical_and_expression
	: inclusive_or_expression
	| logical_and_expression AND_OP inclusive_or_expression
	;
inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression
	;
exclusive_or_expression
	: and_expression
	| exclusive_or_expression '^' and_expression
	;
and_expression
	: equality_expression
	| and_expression '&' equality_expression
	;
equality_expression
	: relational_expression
	| equality_expression EQ_OP relational_expression
	| equality_expression NE_OP relational_expression
	;
relational_expression
	: shift_expression
	| relational_expression '<' shift_expression
	| relational_expression '>' shift_expression
	| relational_expression LE_OP shift_expression
	| relational_expression GE_OP shift_expression
	;
shift_expression
	: additive_expression
	;
additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression
	| additive_expression '-' multiplicative_expression
	;
multiplicative_expression
	: cast_expression
	| multiplicative_expression '*' cast_expression
	| multiplicative_expression '/' cast_expression
	| multiplicative_expression '%' cast_expression
	;
cast_expression
	: unary_expression
	;
unary_expression
	: postfix_expression
	;
postfix_expression
	: primary_expression
	| postfix_expression '[' expression ']'
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')'
	;
primary_expression
	: IDENTIFIER
	| CONSTANT
	| STRING_LITERAL
	| '(' expression ')'
	;
argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;




function_definition
    : declaration_specifier declaration_list compound_statement
	;
declaration_list
	: declaration_specifier
	| declaration_list ',' declaration_specifier
	;

statement
	: compound_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	;
compound_statement
	: '{' '}'
	| '{' statement_list '}'
	;
statement_list
	: statement
	| statement_list statement
	;
expression_statement
	: ';'
	| expression ';'
	;
selection_statement
	: IF '(' expression ')' statement
	| IF '(' expression ')' statement ELSE statement
	;
iteration_statement
	: WHILE '(' expression ')' statement
	| DO statement WHILE '(' expression ')' ';'
	| FOR '(' expression_statement expression_statement ')' statement
	| FOR '(' expression_statement expression_statement expression ')' statement
	;

%%

int main (void) {
	int result = yyparse();

    printf("%s", finalSource);

    return result;
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 