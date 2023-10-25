; -----------------------------------------------------------------------------
; 64-bit functions to communicate with openGL.
;
;  GLFWwindow *openWindow( void );
;
; No arguments.
; Return value is in rax.
;
;  void mainLoop( GLFWwindow *window);
;
; Window is in rdi.
; No return value
; -----------------------------------------------------------------------------
			global	openWindow
			global	mainLoop

			extern  puts
			extern  glfwInit
			extern	glfwWindowHint
			extern	glfwCreateWindow
			extern	glfwMakeContextCurrent
			extern	glfwInit

			extern	glClearColor
			; extern	glfwWindowShouldClose
			extern	glfwGetKey
			extern  glClear
			extern  glfwSwapBuffers
			extern  glfwPollEvents
			extern	glfwTerminate

            section .text
openWindow:
			push   rbp
			mov    rbp,rsp
			sub    rsp,0x10	; for init to work ?
			call	glfwInit wrt ..plt
			test	eax, eax
			jnz		.hints
			mov		rdi, glfwInitFailure
			call	puts wrt ..plt
			jmp		.restore_stack
.hints:
			mov		esi, 3
			mov		rdi, 0x00022002
			call	glfwWindowHint wrt ..plt	; GLFW_CONTEXT_VERSION_MAJOR, 3
			mov		esi, 2
			mov		rdi, 0x00022003
			call	glfwWindowHint wrt ..plt	; GLFW_CONTEXT_VERSION_MINOR, 2
			mov		esi, 1
			mov		rdi, 0x00022007
			call	glfwWindowHint wrt ..plt	; GLFW_OPENGL_DEBUG_CONTEXT, GLFW_TRUE
			mov		esi, 0x00032001
			mov		rdi, 0x00022008
			call	glfwWindowHint wrt ..plt	; GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE
			mov		esi, 1
			mov		rdi, 0x00022006
			call	glfwWindowHint wrt ..plt	; GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE
			mov		esi, 1
			mov		rdi, 0x00020003
			call	glfwWindowHint wrt ..plt	; GLFW_RESIZABLE, GL_TRUE
			mov		esi, 1
			mov		rdi, 0x00020009
			call	glfwWindowHint wrt ..plt	; GLFW_CENTER_CURSOR, GL_TRUE
.createWindow:
			mov		r8d, 0
			mov		ecx, 0
			mov		rdx, windowTitle
			mov		esi, 500
			mov		edi, 500
			call	glfwCreateWindow wrt ..plt
			test	rax, rax
			jnz		.activateContext
			mov		rdi, glfwCreateWindowFailure
			call	puts wrt ..plt
			jmp		.restore_stack
.activateContext:
			push	rax
			mov		rdi, rax
			; call	glfwMakeContextCurrent wrt ..plt
			; mov		byte [rip+0x2bde], 0x1 ; glfwExperimental ..
			call	glfwInit wrt ..plt
			pop		rax
.restore_stack:
			mov		rsp, rbp
			pop		rbp
			ret
mainLoop:
			push	rbp
			mov		rbp, rsp
			sub		rsp, 16		; 8 for *window, 8 for pollevents ?
			mov		qword [rsp], rdi
			; movaps	xmm3, 1065353216
			; pxor	xmm2, xmm2
			; pxor	xmm1, xmm1
			; pxor	xmm0, xmm0
			; call	glClearColor wrt ..plt
.loop:
			; mov		rdi, qword [rsp]
			; call	glfwWindowShouldClose wrt ..plt
			; test	eax, eax
			; jnz		.terminate
			mov		esi, 0x100	; GLFW_KEY_ESCAPE
			mov		rdi, qword [rsp]
			call	glfwGetKey wrt ..plt
			cmp		eax, 1
			je		.terminate
			mov		edi, 0x4000
			call	glClear wrt ..plt
			mov		rdi, qword [rsp]
			call	glfwSwapBuffers wrt ..plt
			call	glfwPollEvents wrt ..plt
			jmp		.loop
.terminate:
			call	glfwTerminate wrt ..plt
			mov		rsp, rbp
			pop		rbp
			ret

			section	.data
glfwInitFailure:	db	"glfwInit failure", 10, 0
windowTitle:		db	"mineGraphed", 0
glfwCreateWindowFailure:	db	"Failed to create GLFW window", 10, 0
