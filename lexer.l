%{
#include <iostream>
%}

%option noyywrap
%option never-interactive

%%
"int"         { std::cout << "Data type: " << yytext << '\n'; }


%%
/* --- СЕКЦИЯ 3: ПОЛЬЗОВАТЕЛЬСКИЙ КОД (MAIN) --- */
int main() {
    /* yyin - это специальная переменная flex, откуда он читает текст */
    extern FILE* yyin; 

    /* Открываем наш файл test.cs и кладем его в yyin */
    yyin = fopen("code.m", "r"); 

    std::cout << "AAAA";

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