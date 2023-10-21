#include <stdlib.h>

size_t ft_strlen( const char *s )
{
	size_t res = 0;
	while (s[res])
		++res;
	return (res);
}

int main()
{
}
