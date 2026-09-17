?
.
->
:

int x = 42;
float y = 3.14f;
double z = 1.5e10;
char c = '\n';
NSString *s = @"hello";
unsigned long long big = 0xFFFFFFFFFFFFFFFFull;

'a'extra         // char + name
123abc           // integer + name (нет пробела)
0x1G             // hex error
0x               // hex без цифр
08               // octal error
1.5.5            // double + . + integer?
1..5             // ?
..5              // ?
1e               // 1 + name 'e'?
1e+              // 1 + name 'e' + '+'?
0x1.5            // hex + . + integer?
""extra          // C-string + name
@"a"@"b"         // две NSString подряд
'\n'             // escape в char
'\x41'           // hex escape в char
'\101'           // octal escape в char