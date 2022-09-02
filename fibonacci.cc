#define TARGET 10

unsigned fibonacci_number(unsigned target)
{
    unsigned int a = 1, b = 1, fib = target;
    for(unsigned n = 3; n <= target; n++)
    {
        fib = a + b;
        a = b;
        b = fib;
    }
    return fib;
}

int main()
{
    unsigned F = fibonacci_number(TARGET);
    return 0;
}