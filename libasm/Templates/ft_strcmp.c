#include <stddef.h>

int strcmp( const char *s1, const char *s2 )
{
	if (!s1 || !s2) {
		return (0);
	}
	size_t index = 0;

	while (s1[index] && s1[index] == s2[index]) {
		++index;
	}
	return (s1[index] - s2[index]);
}

int main( void )
{
	return (0);
}
