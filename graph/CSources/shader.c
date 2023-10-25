# define GLEW_STATIC
# include <GL/glew.h> // must be before glfw
# include "GLFW/glfw3.h"

# include <stdio.h>
# include <stdlib.h>

static void check_glstate( char *str )
{
	GLenum error_check = glGetError();	
	if (error_check) {
		printf("glGetError set to %d, quitting now\n", error_check);
		exit(1);
	}
	if (str == "NO") {
		return ;
	}
	printf("%s\n", str);
}

static void compile_shader( GLuint ptrShader, char *name )
{
	glCompileShader(ptrShader);

    GLint status;
    glGetShaderiv(ptrShader, GL_COMPILE_STATUS, &status);
	if (status) {
		printf("%s shader compiled successfully\n", name);
	} else {
		char buffer[512];
		glGetShaderInfoLog(ptrShader, 512, NULL, buffer);

		printf("%s shader did not compile, error log:\n%s\n", name, buffer);
		exit(1);
	}
}

GLuint createShader( void )
{
	const char *vStr = "#version 150 core\nin vec2 position;\nvoid main()\n{\ngl_Position = vec4(position, 1.0, 1.0);\n}";

	GLuint vShader = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vShader, 1, &vStr, NULL);
	compile_shader(vShader, "vertex");

	const char *fStr = "#version 150 core\nout vec4 outColor;\nvoid main()\n{\noutColor = vec4(1.0, 1.0, 1.0, 1.0);\n}";
	GLuint fShader = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fShader, 1, &fStr, NULL);
	compile_shader(fShader, "fragment");

	GLint sProgram = glCreateProgram();
	glAttachShader(sProgram, vShader);
	glAttachShader(sProgram, fShader);

	glBindFragDataLocation(sProgram, 0, "outColor");
	glBindAttribLocation(sProgram, 0, "position");

	glLinkProgram(sProgram);
	glUseProgram(sProgram);

	glDeleteShader(fShader);
	glDeleteShader(vShader);

	check_glstate("shaderProgram compile successfully");

	return (sProgram);
}

void setVertices( GLuint sProgram )
{
	GLfloat vertices[6] = {0.0f, 0.5f, -0.5f, -0.5f, 0.5f, -0.5f};

	GLuint vao, vbo;

	glGenVertexArrays(1, &vao);
	glGenBuffers(1, &vbo);

	glBindVertexArray(vao);
	glBindBuffer(GL_ARRAY_BUFFER, vbo);

	glBufferData(GL_ARRAY_BUFFER, 6 * sizeof(GLfloat), vertices, GL_STATIC_DRAW);

	glEnableVertexAttribArray(0);
	glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(GLfloat), 0);
	check_glstate("comm with shader successfully set");
}
