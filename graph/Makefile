NAME        = graph

SRCS_DIR    = Sources
OBJS_DIR    = Objs

FILES       = main

SRCS        = $(addprefix $(SRCS_DIR)/, $(addsuffix .s, $(FILES)))
OBJS        = $(addprefix $(OBJS_DIR)/, $(addsuffix .o, $(FILES)))

# ===---===---===---===---===---===---===---===---===---===---===---===---

CC			= gcc
FLAGS		= -g
ASM         = nasm
ASMFLAGS    = -f elf64 -g

LINKS		= -L Libs `pkg-config --static --libs glfw3 glew` -lGL -lX11 -lpthread -lXrandr -lXi -ldl

# ===---===---===---===---===---===---===---===---===---===---===---===---

all: $(OBJS_DIR) $(NAME)

$(OBJS_DIR):
	@mkdir -p $(OBJS_DIR)

$(NAME): $(OBJS)
	$(CC) $(FLAGS) -o $(NAME) $(OBJS) $(LINKS)

$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.s
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -rf $(OBJS_DIR)

fclean: clean
	rm -f $(NAME)

re: fclean all

run: all
	@./$(NAME)

rer: re
	@./$(NAME)

.PHONY: all clean fclean re run rer
