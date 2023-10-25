# include <stdio.h>
# include "GLFW/glfw3.h"

GLFWwindow *openWindow( void );
GLuint createShader( void );
void setVertices( GLuint sProgram );
void mainLoop( GLFWwindow *window );

int main( int ac, char **av )
{
	(void)av;
	if (ac != 1) {
		puts("Expected format: ./graph\n");
		return (1);
	}

	puts("\n ---- Hello ----\n");

	GLFWwindow *window = openWindow();
	if (!window) {
		return (1);
	}
	GLuint sProgram = createShader();
	setVertices(sProgram);
	mainLoop(window);

	puts("\n ---- Goodbye ----\n");
	return (0);
}
