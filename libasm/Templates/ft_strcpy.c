#include <stddef.h>

char *strcpy( char *dest, const char *src )
{
	if (!dest || !src) {
		return (NULL);
	}
	size_t index = 0;

	while (src[index]) {
		dest[index] = src[index];
		++index;
	}
	dest[index] = '\0';
	return (dest);
}


int main( void )
{
	return (0);
}
