%{
#include <iostream>

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

[0-9]*\.[0-9]+[Dd]?     { std::cout << "Double literal: " << yytext << '\n'; }
[0-9]*\.[0-9]+[lL]      { std::cout << "Long double literal: " << yytext << '\n'; }
[0-9]*\.[0-9]+f         { std::cout << "Float literal: " << yytext << '\n'; }

"while"                 { std::cout << "Keyword: " << yytext << '\n'; }
"int"                   { std::cout << "Data type: " << yytext << '\n'; }
";"                     { std::cout << "Keyword: " << yytext << '\n'; }
[0-9]+                  { std::cout << "Literal digit: " << yytext << '\n'; }
[A-Za-z_][A-Za-z0-9_]*  { std::cout << "Name: " << yytext << '\n'; }
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