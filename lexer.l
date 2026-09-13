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

%x STRING_C

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

[A-Za-z_][A-Za-z0-9_]*  { std::cout << "Name: " << yytext << '\n'; }

[0-9]*\.[0-9]+[Dd]?     { 
    try {
        std::cout << "Double literal: " << std::stod(yytext) << '\n';
    } catch (const std::invalid_argument& e) {
        std::cerr << "error: invalid double literal" << '\n';
    }
}
[0-9]*\.[0-9]+[lL]      { 
    try {
        std::cout << "Long double literal: " << std::stold(yytext) << '\n'; 
    } catch (const std::invalid_argument& e) {
        std::cerr << "error: invalid long double literal" << '\n';
    }
}
[0-9]*\.[0-9]+[fF]      { 
    try {
        std::cout << "Float literal: " << std::stof(yytext) << '\n'; 
    } catch (const std::invalid_argument& e) {
        std::cerr << "error: invalid float literal" << '\n';
    }
}
0|[1-9][0-9]*           { 
    // it can be long long | short | other digit literals ?
    try { 
        std::cout << "Literal digit: " << std::stoi(yytext) << '\n'; 
    } catch (const std::invalid_argument& e) {
        std::cerr << "error: invalid integer literal" << '\n';
    }
}

[ \t\n\r]+              { /* ignored*/ }

%%
int main(int argc, char* argv[]) {
    extern FILE* yyin; 

    if (argc < 2)
    {
        std::cerr << "Missing command line argument (source file path)" << '\n';
        return 1;
    } 
    
    yyin = fopen(argv[1], "r"); 

    if (!yyin) {
        std::cout << "File was not found!\n";
        return 1;
    }

    yylex(); 

    fclose(yyin);
    return 0;
}