#include <stdlib.h>
#include <string.h>

char *ft_strdup( const char *s )
{
	if (!s) {
		return (NULL);
	}
	char *res = malloc(strlen(s) + 1);
	if (!res) {
		return (NULL);
	}
	strcpy(res, s);
	return (res);
}

int main( void )
{
	return (0);
}
