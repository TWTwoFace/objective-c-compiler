%{
#include <iostream>
#include <string>

void print_operator(const char* text) {
    std::cout << "Operator: " << text << '\n';
}

void print_keyword(const char* text) {
    std::cout << "Keyword: " << text << '\n';
}
%}

%option noyywrap
%option never-interactive

%%
"+"                     { print_operator(yytext); }
"-"                     { print_operator(yytext); }
"*"                     { print_operator(yytext); }
"/"                     { print_operator(yytext); }
"%"                     { print_operator(yytext); }
"++"                    { print_operator(yytext); }
"--"                    { print_operator(yytext); }

"=="                    { print_operator(yytext); }
"!="                    { print_operator(yytext); }
"<"                     { print_operator(yytext); }
">"                     { print_operator(yytext); }
"<="                    { print_operator(yytext); }
">="                    { print_operator(yytext); }

"&&"                    { print_operator(yytext); }
"||"                    { print_operator(yytext); }
"!"                     { print_operator(yytext); }

"&"                     { print_operator(yytext); }
"|"                     { print_operator(yytext); }
"^"                     { print_operator(yytext); }
"~"                     { print_operator(yytext); }
"<<"                    { print_operator(yytext); }
">>"                    { print_operator(yytext); }

"="                     { print_operator(yytext); }
"+="                    { print_operator(yytext); }
"-="                    { print_operator(yytext); }
"*="                    { print_operator(yytext); }
"/="                    { print_operator(yytext); }
"%="                    { print_operator(yytext); }
"&="                    { print_operator(yytext); }
"|="                    { print_operator(yytext); }
"^="                    { print_operator(yytext); }
"<<="                   { print_operator(yytext); }
">>="                   { print_operator(yytext); }

"."                     { print_operator(yytext); }
"->"                    { print_operator(yytext); }

"?"                     { print_operator(yytext); }
":"                     { print_operator(yytext); }

[0-9]*\.[0-9]+[Dd]?     { std::cout << "Double literal: " << std::stod(yytext) << '\n'; }
[0-9]*\.[0-9]+[lL]      { std::cout << "Long double literal: " << std::stold(yytext) << '\n'; }
[0-9]*\.[0-9]+[fF]      { std::cout << "Float literal: " << std::stof(yytext) << '\n'; }

"id"                    {std::cout << "Identifier: " << yytext << '\n'; }
"Class"                 {std::cout << "Identifier: " << yytext << '\n'; }
"SEL"                   {std::cout << "Identifier: " << yytext << '\n'; }
"IMP"                   {std::cout << "Identifier: " << yytext << '\n'; }
"BOOL"                  {std::cout << "Identifier: " << yytext << '\n'; }

"self"                  {std::cout << "Object constant: " << yytext << '\n'; }
"super"                 {std::cout << "Object constant: " << yytext << '\n'; }
"nil"                   {std::cout << "Object constant: " << yytext << '\n'; }
"Nil"                   {std::cout << "Object constant: " << yytext << '\n'; }

"YES"                   {std::cout << "Boolean literal: " << yytext << '\n'; }
"NO"                    {std::cout << "Boolean literal: " << yytext << '\n'; }

"oneway"                {std::cout << "Qualifier: " << yytext << '\n'; }
"in"                    {std::cout << "Qualifier: " << yytext << '\n'; }
"out"                   {std::cout << "Qualifier: " << yytext << '\n'; }
"inout"                 {std::cout << "Qualifier: " << yytext << '\n'; }
"bycopy"                {std::cout << "Qualifier: " << yytext << '\n'; }
"byref"                 {std::cout << "Qualifier: " << yytext << '\n'; }

"auto"                  { std::cout << "Keyword: "     << yytext << '\n'; }
"break"                 { std::cout << "Keyword: "     << yytext << '\n'; }
"case"                  { std::cout << "Keyword: "     << yytext << '\n'; }
"char"                  { std::cout << "Keyword: "     << yytext << '\n'; }
"const"                 { std::cout << "Keyword: "     << yytext << '\n'; }
"continue"              { std::cout << "Keyword: "     << yytext << '\n'; }
"default"               { std::cout << "Keyword: "     << yytext << '\n'; }
"do"                    { std::cout << "Keyword: "     << yytext << '\n'; }
"double"                { std::cout << "Keyword: "     << yytext << '\n'; }
"else"                  { std::cout << "Keyword: "     << yytext << '\n'; }
"enum"                  { std::cout << "Keyword: "     << yytext << '\n'; }
"extern"                { std::cout << "Keyword: "     << yytext << '\n'; }
"float"                 { std::cout << "Keyword: "     << yytext << '\n'; }
"for"                   { std::cout << "Keyword: "     << yytext << '\n'; }
"goto"                  { std::cout << "Keyword: "     << yytext << '\n'; }
"if"                    { std::cout << "Keyword: "     << yytext << '\n'; }
"inline"                { std::cout << "Keyword: "     << yytext << '\n'; }
"int"                   { std::cout << "Keyword: "     << yytext << '\n'; }
"long"                  { std::cout << "Keyword: "     << yytext << '\n'; }
"register"              { std::cout << "Keyword: "     << yytext << '\n'; }
"return"                { std::cout << "Keyword: "     << yytext << '\n'; }
"short"                 { std::cout << "Keyword: "     << yytext << '\n'; }
"signed"                { std::cout << "Keyword: "     << yytext << '\n'; }
"sizeof"                { std::cout << "Keyword: "     << yytext << '\n'; }
"static"                { std::cout << "Keyword: "     << yytext << '\n'; }
"struct"                { std::cout << "Keyword: "     << yytext << '\n'; }
"switch"                { std::cout << "Keyword: "     << yytext << '\n'; }
"typedef"               { std::cout << "Keyword: "     << yytext << '\n'; }
"union"                 { std::cout << "Keyword: "     << yytext << '\n'; }
"unsigned"              { std::cout << "Keyword: "     << yytext << '\n'; }
"void"                  { std::cout << "Keyword: "     << yytext << '\n'; }
"volatile"              { std::cout << "Keyword: "     << yytext << '\n'; }
"while"                 { std::cout << "Keyword: "     << yytext << '\n'; }

";"                     { std::cout << "Semicolon: " << yytext << '\n'; }
0|[1-9][0-9]*           { std::cout << "Literal digit: " << yytext << '\n'; }
[A-Za-z_][A-Za-z0-9_]*  { std::cout << "Name: " << std::stoi(yytext) << '\n'; }
[ \t\n\r]+              { /* ignored*/ }

%%
/* --- СЕКЦИЯ 3: ПОЛЬЗОВАТЕЛЬСКИЙ КОД (MAIN) --- */
int main() {
    /* yyin - это специальная переменная flex, откуда он читает текст */
    extern FILE* yyin; 

    /* Открываем наш файл test.cs и кладем его в yyin */
    yyin = fopen("code.m", "r"); 

    if (!yyin) {
        std::cout << "Не удалось открыть файл code.m!\n";
        return 1;
    }

    /* Запускаем главную функцию анализатора, которую для нас сгенерирует flex */
    yylex(); 

    /* Закрываем файл */
    fclose(yyin);
    return 0;
}