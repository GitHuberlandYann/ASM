#include <stddef.h>

size_t ft_strlen( const char *s )
{
	if (!s) {
		return (0);
	}
	size_t res = 0;
	while (s[res])
		++res;
	return (res);
}

int main( void )
{
	return (0);
}
