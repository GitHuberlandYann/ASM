#include <stddef.h>
#include <stdio.h>

static int ft_strlen( char *str )
{
    int res = 0;
    while (str[res]) {
        ++res;
    }
    return (res);
}

static int ft_isspace( char c )
{
    return ((c >= '\t' && c <= '\r') || c == ' '); // \t is 9, \r is 13, ' ' is 32
}

static char *ft_strchr( const char *str, char c )
{
    int i = 0;
    while (str[i]) {
        if (str[i] == c) {
            return ((char *)str + i);
        }
        ++i;
    }
    return (NULL);
}

static int invalid_base( char *str )
{
    if (ft_strlen(str) < 2) {
        return (1);
    }
    int i = 0;
    while (str[i]) {
        if (str[i] == '+' || str[i] == '-' || ft_isspace(str[i]) || ft_strchr(str + i + 1, str[i])) {
            return (1);
        }
        ++i;
    }
    return (0);
}

int ft_atoi_base( char *str, char *base )
{
    if (!str || !base || invalid_base(base)) {
        return (0);
    }
    int i = 0, res = 0, sign = 1, size = ft_strlen(base);
    while (ft_isspace(str[i])) {
        ++i;
    }
    while (str[i] == '+' || str[i] == '-') {
        if (str[i] == '-') {
            sign *= -1;
        }
        ++i;
    }
    char *search = ft_strchr(base, str[i]);
    while (search) {
        int bindex = search - base;
        res = res * size + bindex;
        ++i;
        search = ft_strchr(base, str[i]);
    }
    return (res * sign);
}

int main( int ac, char **av )
{
    if (ac != 3) {
        printf("Error: format is ./a.out str base\n");
        return (1);
    }
    printf("%s in base %s is %d\n", av[1], av[2], ft_atoi_base(av[1], av[2]));
    return (0);
}
