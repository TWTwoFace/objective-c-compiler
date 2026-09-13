%{
#include <iostream>
#include <cstring>
#include <string>
#include <cstdlib>
#include <stdio.h>

static void append_utf8(std::string &str, unsigned int code) {
    if (code < 0x80) {
        str += static_cast<char>(code);
    } else if (code < 0x800) {
        str += static_cast<char>(0xC0 | (code >> 6));
        str += static_cast<char>(0x80 | (code & 0x3F));
    } else {
        str += static_cast<char>(0xE0 | (code >> 12));
        str += static_cast<char>(0x80 | ((code >> 6) & 0x3F));
        str += static_cast<char>(0x80 | (code & 0x3F));
    }
}

std::string string_buffer;

%}

%x STRING_C
%x CHAR_C
%x STRING_NS
%x MULTILINE_COMMENT

%option noyywrap
%option never-interactive

%%

"+"                     { std::cout << "Operator (arithmetic): " << yytext << '\n'; }
"-"                     { std::cout << "Operator (arithmetic): " << yytext << '\n'; }
"*"                     { std::cout << "Operator (arithmetic): " << yytext << '\n'; }
"/"                     { std::cout << "Operator (arithmetic): " << yytext << '\n'; }
"%"                     { std::cout << "Operator (arithmetic): " << yytext << '\n'; }
"++"                    { std::cout << "Operator (arithmetic): " << yytext << '\n'; }
"--"                    { std::cout << "Operator (arithmetic): " << yytext << '\n'; }

"=="                    { std::cout << "Operator (comparison): " << yytext << '\n'; }
"!="                    { std::cout << "Operator (comparison): " << yytext << '\n'; }
"<"                     { std::cout << "Operator (comparison): " << yytext << '\n'; }
">"                     { std::cout << "Operator (comparison): " << yytext << '\n'; }
"<="                    { std::cout << "Operator (comparison): " << yytext << '\n'; }
">="                    { std::cout << "Operator (comparison): " << yytext << '\n'; }

"&&"                    { std::cout << "Operator (logical): " << yytext << '\n'; }
"||"                    { std::cout << "Operator (logical): " << yytext << '\n'; }
"!"                     { std::cout << "Operator (logical): " << yytext << '\n'; }

"&"                     { std::cout << "Operator (bitwise): " << yytext << '\n'; }
"|"                     { std::cout << "Operator (bitwise): " << yytext << '\n'; }
"^"                     { std::cout << "Operator (bitwise): " << yytext << '\n'; }
"~"                     { std::cout << "Operator (bitwise): " << yytext << '\n'; }
"<<"                    { std::cout << "Operator (bitwise): " << yytext << '\n'; }
">>"                    { std::cout << "Operator (bitwise): " << yytext << '\n'; }

"+="                    { std::cout << "Operator (assignment): " << yytext << '\n'; }
"="                     { std::cout << "Operator (assignment): " << yytext << '\n'; }
"-="                    { std::cout << "Operator (assignment): " << yytext << '\n'; }
"*="                    { std::cout << "Operator (assignment): " << yytext << '\n'; }
"/="                    { std::cout << "Operator (assignment): " << yytext << '\n'; }
"%="                    { std::cout << "Operator (assignment): " << yytext << '\n'; }
"&="                    { std::cout << "Operator (assignment): " << yytext << '\n'; }
"|="                    { std::cout << "Operator (assignment): " << yytext << '\n'; }
"^="                    { std::cout << "Operator (assignment): " << yytext << '\n'; }
"<<="                   { std::cout << "Operator (assignment): " << yytext << '\n'; }
">>="                   { std::cout << "Operator (assignment): " << yytext << '\n'; }

"."                     { std::cout << "Operator (member): " << yytext << '\n'; }
"->"                    { std::cout << "Operator (member): " << yytext << '\n'; }

"?"                     { std::cout << "Operator: " << yytext << '\n'; }
":"                     { std::cout << "Operator: " << yytext << '\n'; }

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
        std::cerr << "error: invalid double literal\n";
    }
}
[0-9]*\.[0-9]+[lL]      { 
    try {
        std::cout << "Long double literal: " << std::stold(yytext) << '\n'; 
    } catch (const std::invalid_argument& e) {
        std::cerr << "error: invalid long double literal\n";
    }
}
[0-9]*\.[0-9]+[fF]      { 
    try {
        std::cout << "Float literal: " << std::stof(yytext) << '\n'; 
    } catch (const std::invalid_argument& e) {
        std::cerr << "error: invalid float literal\n";
    }
}
0|[1-9][0-9]*           { 
    // it can be long long | short | other digit literals ?
    try { 
        std::cout << "Literal digit: " << std::stoi(yytext) << '\n'; 
    } catch (const std::invalid_argument& e) {
        std::cerr << "error: invalid integer literal\n";
    }
}

\x22                    {
    //"
    BEGIN(STRING_C);
    string_buffer.clear();
}

\@\x22                   {
    // @"
    BEGIN(STRING_NS);
    string_buffer.clear();
}

\x27                    {
    BEGIN(CHAR_C);
    string_buffer.clear();
}

<STRING_C,STRING_NS>[^\\\x22\n]+  {
    string_buffer += yytext;
}

<CHAR_C>[^\\\x27\n] { 
    string_buffer += yytext;
}

<STRING_C,CHAR_C,STRING_NS>\\n           { string_buffer += '\n'; }
<STRING_C,CHAR_C,STRING_NS>\\v           { string_buffer += '\v'; }
<STRING_C,CHAR_C,STRING_NS>\\f           { string_buffer += '\f'; }
<STRING_C,CHAR_C,STRING_NS>\\b           { string_buffer += '\b'; }
<STRING_C,CHAR_C,STRING_NS>\\a           { string_buffer += '\a'; }
<STRING_C,CHAR_C,STRING_NS>\\0           { string_buffer += '\0'; }
<STRING_C,CHAR_C,STRING_NS>\\?           { string_buffer += '\?'; }
<STRING_C,CHAR_C,STRING_NS>\\t           { string_buffer += '\t'; }
<STRING_C,CHAR_C,STRING_NS>\\r           { string_buffer += '\r'; }
<STRING_C,CHAR_C,STRING_NS>\\\\          { string_buffer += '\\'; }
<STRING_C,CHAR_C,STRING_NS>\\\x22        { 
    // \"
    string_buffer += '"'; 
}
<STRING_C,CHAR_C,STRING_NS>\\\x27        { 
    // \'
    string_buffer += '\''; 
}

<STRING_C,STRING_NS>\\u[A-Fa-f0-9]{4} {
    unsigned int code;
    sscanf(yytext + 2, "%4x", &code);
    append_utf8(string_buffer, code);
}

<STRING_C,STRING_NS>\\U[A-Fa-f0-9]{8} {
    unsigned int code;
    sscanf(yytext + 2, "%8x", &code);
    append_utf8(string_buffer, code);
}
<STRING_C,CHAR_C,STRING_NS>\\x[0-9A-Fa-f]{2} {
    unsigned int code;
    sscanf(yytext + 2, "%2x", &code);
    string_buffer += static_cast<char>(code);
}

<STRING_C,CHAR_C,STRING_NS>\\[0-7]{1,3}  { 
    long code = strtol(yytext + 1, nullptr, 8);
    string_buffer += static_cast<char>(code);
}

<STRING_C,CHAR_C,STRING_NS>\\\n          { /* ignored */ }

<STRING_C,CHAR_C,STRING_NS>\n            { 
    std::cerr << "error: EOL in string"; 
    BEGIN(INITIAL);
}

<STRING_C,STRING_NS>\x22          {
    // "
    if (YY_START == STRING_C) {
        std::cout << ">>> CString literal:\n" << string_buffer << '\n';
        std::cout << "<<< CString ended" << '\n';
    }
    else {
        std::cout << ">>> NSString literal:\n" << string_buffer << '\n';
        std::cout << "<<< NSString ended" << '\n';
    }
    
    BEGIN(INITIAL);
}

<CHAR_C>\x27            {
    if (string_buffer.size() > 1) {
        std::cerr << "error: char size could be less than 1\n";
    }
    else {
        std::cout << "CChar literal: " << string_buffer << '\n';
    }
    BEGIN(INITIAL);
}

<STRING_C,CHAR_C,STRING_NS><<EOF>>       {
    std::cerr << "error: unclosed quote in string\n";
    BEGIN(INITIAL);
}

\/\* { BEGIN(MULTILINE_COMMENT); }
<MULTILINE_COMMENT>\*\/ { BEGIN(INITIAL); }
<MULTILINE_COMMENT>.* { /* ignored */ }

\/{2}.* { /* ignored*/ }

<*>[ \t\n\r]+              { /* ignored*/ }

%%
int main(int argc, char* argv[]) {
    extern FILE* yyin; 

    if (argc < 2)
    {
        std::cerr << "Missing command line argument (source file path)\n";
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