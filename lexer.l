%{
#include <iostream>   /* std::cout, std::cerr */
#include <string>     
#include <cstdlib>    /* std::strtoul, std::strtoll, std::strtoull */
#include <cstdio>     /* FILE, fopen, fclose */
#include <cerrno>     /* errno, ERANGE */
#include <optional>   /* std::optional */
#include "parser.tab.h" 

static std::string file_name;
static void append_utf8(std::string &str, unsigned int code);
static std::optional<int> handle_integer(std::string text, int line);
static void error(const std::string &str, int line);
static void warning(const std::string &str, int line);

%}

/* Макросы */
EXPONENT ([eE][+-]?[0-9]+)
FLOATING_NUM (([0-9]+\.[0-9]*{EXPONENT}?)|([0-9]*\.[0-9]+{EXPONENT}?))|([0-9]+{EXPONENT})
INTEGER_NUM (0[0-7]*)|([1-9][0-9]*)|((0x|0X)[0-9A-Fa-f]+)

/* Состояния */
%x STRING_C
%x CHAR_C
%x STRING_NS
%x MULTILINE_COMMENT

%option noyywrap
%option never-interactive

/* Секция правил */
%%
%{
    int line = 1;
    std::string string_buffer;
%}


"["                     { return '['; }
"]"                     { return ']'; }
"{"                     { return '{'; }
"}"                     { return '}'; }
"("                     { return '('; }
")"                     { return ')'; }

","                     { return ','; }
":"                     { return ':'; }
";"                     { return ';'; }


"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"%"                     { return '%'; }
"++"                    { return INC; }
"--"                    { return DEC; }

"=="                    { return EQ; }
"!="                    { return NEQ; }
"<"                     { return '<'; }
">"                     { return '>'; }
"<="                    { return LEQ; }
">="                    { return GEQ; }

"&&"                    { return AND; }
"||"                    { return OR; }
"!"                     { return '!'; }

"&"                     { return '&'; }
"|"                     { return '|'; }
"^"                     { return '^'; }
"~"                     { return '~'; }
"<<"                    { return SHL; }
">>"                    { return SHR; }

"+="                    { return ADD_ASSIGN; }
"="                     { return '='; }
"-="                    { return SUB_ASSIGN; }
"*="                    { return MUL_ASSIGN; }
"/="                    { return DIV_ASSIGN; }
"%="                    { return MOD_ASSIGN; }
"&="                    { return AND_ASSIGN; }
"|="                    { return OR_ASSIGN; }
"^="                    { return XOR_ASSIGN; }
"<<="                   { return SHL_ASSIGN; }
">>="                   { return SHR_ASSIGN; }

"."                     { return '.'; }
"->"                    { return ARROW; }

"?"                     { return '?'; }


"self"                  { return SELF; }
"super"                 { return SUPER; }
"nil"                   { return NIL; }
"Nil"                   { return NIL_CAP; }

"YES"                   { return YES; }
"NO"                    { return NO; }


"oneway"                { return ONEWAY; }
"in"                    { return IN; }
"out"                   { return OUT; }
"inout"                 { return INOUT; }
"bycopy"                { return BYCOPY; }
"byref"                 { return BYREF; }


"auto"                  { return AUTO; }
"break"                 { return BREAK; }
"case"                  { return CASE; }
"const"                 { return CONST; }
"continue"              { return CONTINUE; }
"default"               { return DEFAULT; }
"do"                    { return DO; }
"else"                  { return ELSE; }
"extern"                { return EXTERN; }
"for"                   { return FOR; }
"goto"                  { return GOTO; }
"if"                    { return IF; }
"inline"                { return INLINE; }
"register"              { return REGISTER; }
"return"                { return RETURN; }
"signed"                { return SIGNED; }
"sizeof"                { return SIZEOF; }
"static"                { return STATIC; }
"switch"                { return SWITCH; }
"typedef"               { return TYPEDEF; }
"unsigned"              { return UNSIGNED; }
"void"                  { return VOID; }
"volatile"              { return VOLATILE; }
"while"                 { return WHILE; }
"enum"                  { return ENUM; }


"char"                  { return CHAR; }
"double"                { return DOUBLE; }
"float"                 { return FLOAT; }
"int"                   { return INT; }
"long"                  { return LONG; }
"short"                 { return SHORT; }
"BOOL"                  { return BOOL_TYPE; }
"struct"                { return STRUCT; }
"union"                 { return UNION; }
"id"                    { return ID_TYPE; }
"Class"                 { return CLASS; }
"SEL"                   { return SEL; }
"IMP"                   { return IMP; }


"@interface"            { return AT_INTERFACE; }
"@implementation"       { return AT_IMPLEMENTATION; }
"@protocol"             { return AT_PROTOCOL; }
"@end"                  { return AT_END; }
"@class"                { return AT_CLASS; }
"@public"               { return AT_PUBLIC; }
"@protected"            { return AT_PROTECTED; }
"@private"              { return AT_PRIVATE; }
"@package"              { return AT_PACKAGE; }
"@property"             { return AT_PROPERTY; }
"@synthesize"           { return AT_SYNTHESIZE; }
"@dynamic"              { return AT_DYNAMIC; }
"@selector"             { return AT_SELECTOR; }
"@encode"               { return AT_ENCODE; }
"@try"                  { return AT_TRY; }
"@catch"                { return AT_CATCH; }
"@finally"              { return AT_FINALLY; }
"@throw"                { return AT_THROW; }
"@optional"             { return AT_OPTIONAL; }
"@required"             { return AT_REQUIRED; }
"@synchronized"         { return AT_SYNCHRONIZED; }
"@autoreleasepool"      { return AT_AUTORELEASEPOOL; }
"@import"               { return AT_IMPORT; }
"@"                     { return AT; }

[A-Za-z_][A-Za-z0-9_]*  { 
    yylval.sval = new std::string(yytext);
    return ID; 
}


{FLOATING_NUM}[lL]      { 

    long double value = 0;

    try {
        value = std::stold(yytext);
    } catch (const std::out_of_range& e) {
        warning("magnitude of floating-point constant too large for type 'long double'", line);
    }

    yylval.dval = value;
    return FLOAT_LITERAL;
}

{FLOATING_NUM}[fF]      { 

    float value = 0;

    try {
        value = std::stof(yytext);
    } catch (const std::out_of_range& e) {
        warning("magnitude of floating-point constant too large for type 'float'", line);
    }

    yylval.dval = value;
    return FLOAT_LITERAL;
}

{FLOATING_NUM}         {

    double value = 0;

    try {
        value = std::stod(yytext);
    } catch (const std::out_of_range& e) {
        warning("magnitude of floating-point constant too large for type 'double'", line);
    }

    yylval.dval = value;
    return FLOAT_LITERAL;
}

{INTEGER_NUM}([uU][lL]{2}|[lL]{2}[uU])     { 
    errno = 0;

    auto val = std::strtoull(yytext, nullptr, 0);

    if (errno == ERANGE) {
        error("integer literal is too large to be represented in any integer type", line);
    } else {
        yylval.ival = val;
        return INT_LITERAL; 
    }
}


{INTEGER_NUM}([uU][lL]|[lL][uU])      { 
    errno = 0;

    auto val = std::strtoul(yytext, nullptr, 0);

    if (errno == ERANGE) {
        error("integer literal is too large to be represented in 'unsigned long' integer type", line);
    } else {
        yylval.ival = val;
        return INT_LITERAL; 
    }
}

{INTEGER_NUM}[lL][lL]       { 
    errno = 0;

    auto val = std::strtoll(yytext, nullptr, 0);
    
    if (errno == ERANGE) {
        error("integer literal is too large to be represented in 'long long' integer type", line);
    } else {
        yylval.ival = val;
        return INT_LITERAL;  
    }
}

{INTEGER_NUM}[lL]       { 
    errno = 0;

    auto val = std::strtol(yytext, nullptr, 0);
    
    if (errno == ERANGE) {
        error("integer literal is too large to be represented in 'long' integer type", line);
    } else {
        yylval.ival = val;
        return INT_LITERAL;  
    }
}

{INTEGER_NUM}[uU]       { 
    errno = 0;

    auto val = std::strtoul(yytext, nullptr, 0);

    if (errno == ERANGE) {
        error("integer literal is too large to be represented in 'unsigned int' integer type", line);
    } else {
        yylval.ival = val;
        return INT_LITERAL;  
    }
}

{INTEGER_NUM}          { 
    yylval.ival = handle_integer(yytext, line).value_or(0);
    return INT_LITERAL;
}

0[0-7]*[89][0-9]*       { 
    error("invalid digit in octal constant", line); 
}

(0[xX][0-9A-Fa-f]*[G-Zg-z][0-9A-Fa-f]*)|0[xX] {
    error("invalid digit in hex constant", line); 
}

\"                    {
    // "
    BEGIN(STRING_C);
    string_buffer.clear();
}

\@\"                   {
    // @"
    BEGIN(STRING_NS);
    string_buffer.clear();
}

\'                    {
    BEGIN(CHAR_C);
    string_buffer.clear();
}

<STRING_C,STRING_NS>[^\\\"\n]+  {
    string_buffer += yytext;
}

<CHAR_C>[^\\\'\n] { 
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
<STRING_C,CHAR_C,STRING_NS>\\\"        { 
    // \"
    string_buffer += '"'; 
}
<STRING_C,CHAR_C,STRING_NS>\\\'        { 
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

<STRING_C,CHAR_C,STRING_NS>\\.           { 
    std::string warning_str = "unknown escape sequence \\";
    warning_str += yytext[1];
    warning("unknown escape sequence \\" + yytext[1], line);
    string_buffer += yytext[1];
}

<STRING_C,CHAR_C,STRING_NS>\n            { 
    error("EOL in string", line); 
    line++;
    BEGIN(INITIAL);
}

<STRING_C,STRING_NS>\"          {
    // "
    yylval.sval = new std::string(string_buffer);
    BEGIN(INITIAL);
    return STRING_LITERAL;
}

<CHAR_C>\'            {
    if (string_buffer.size() > 1) {
        warning("multi-character character constant", line);
    }
 
    yylval.ival = string_buffer.empty() ? 0 : string_buffer[0];
    BEGIN(INITIAL);
    return CHAR_LITERAL;
}

<STRING_C,CHAR_C,STRING_NS><<EOF>>       {
    error("unclosed quote in string", line);
    BEGIN(INITIAL);
}

\/\*  { BEGIN(MULTILINE_COMMENT); }
<MULTILINE_COMMENT>\*+\/       { BEGIN(INITIAL); }
<MULTILINE_COMMENT>[^*\n]+     { /* ignored */ }
<MULTILINE_COMMENT>\*+[^*/]+   { /* ignored */ }
<MULTILINE_COMMENT>\*+         { /* ignored */ }
<MULTILINE_COMMENT><<EOF>> { 
    error("multiline comment was not closed", line); 
    BEGIN(INITIAL);
}

\/{2}.*         { /* ignored*/ }

<*>\n           { line++; }          
<*>[ \t\r]+     { /* ignored*/ }

%%
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

static std::optional<int> handle_integer(std::string text, int line) {

    auto try_parse = [&](auto parse_fn, const char* type_name) -> std::optional<int> {
        try {
            auto value = parse_fn(text);
            std::cout << "Literal " << type_name << ": " << value << '\n';
            return value;
        } catch (const std::out_of_range&) {
            return std::nullopt;
        }
    };

    if (auto r = try_parse([](const std::string& str) { return std::stoi(str, nullptr, 0); }, "integer"))
        return r;

    if (auto r = try_parse([](const std::string& str) { return std::stol(str, nullptr, 0); }, "long integer"))
        return r;

    if (auto r = try_parse([](const std::string& str) { return std::stoll(str, nullptr, 0); }, "long long integer"))
        return r;

    error("integer literal is too large to be represented in any signed integer type", line);
    return std::nullopt;
}

static void error(const std::string &str, int line) {
    std::cerr << file_name << ":" << line << ":" << " error: " << str << '\0';
}

static void warning(const std::string &str, int line) {
    std::cerr << file_name << ":" << line << ":" << " warning: " << str << '\0';
}
