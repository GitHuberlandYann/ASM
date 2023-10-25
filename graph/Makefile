NAME        = graph
CNAME		= cgraph

SRCS_DIR    = Sources
OBJS_DIR    = Objs

FILES       = main render

SRCS        = $(addprefix $(SRCS_DIR)/, $(addsuffix .s, $(FILES)))
OBJS        = $(addprefix $(OBJS_DIR)/, $(addsuffix .o, $(FILES)))

CSRCS_DIR   = CSources
COBJS_DIR   = Objs/C

CFILES      = main render shader

CSRCS       = $(addprefix $(CSRCS_DIR)/, $(addsuffix .c, $(CFILES)))
COBJS       = $(addprefix $(COBJS_DIR)/, $(addsuffix .o, $(CFILES)))

# ===---===---===---===---===---===---===---===---===---===---===---===---

CC			= gcc
FLAGS		= -g
CFLAGS      = #-Wextra -Werror -Wall
ASM         = nasm
ASMFLAGS    = -f elf64 -g

SAN         = #-fsanitize=address -g3
INCLUDES	= -I Includes -I glm

LINKS		= -L Libs `pkg-config --static --libs glfw3 glew` -lGL -lX11 -lpthread -lXrandr -lXi -ldl

# ===---===---===---===---===---===---===---===---===---===---===---===---

all: $(OBJS_DIR) $(NAME)

$(OBJS_DIR):
	@mkdir -p $(OBJS_DIR)

$(NAME): $(OBJS)
	$(CC) $(FLAGS) -o $(NAME) $(OBJS) $(LINKS)

$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.s
	$(ASM) $(ASMFLAGS) $< -o $@

call: $(COBJS_DIR) $(CNAME)

$(COBJS_DIR):
	@mkdir -p $(COBJS_DIR)

$(CNAME): $(COBJS)
	$(CC) $(FLAGS) $(CFLAGS) $(SAN) -o $(CNAME) $(COBJS) $(LINKS)

$(COBJS_DIR)/%.o: $(CSRCS_DIR)/%.c
	$(CC) $(FLAGS) $(CFLAGS) $(SAN) $(INCLUDES) -c $< -o $@

clean:
	rm -rf $(OBJS_DIR) $(COBJS_DIR)

fclean: clean
	rm -f $(NAME) $(CNAME)

re: fclean all

run: all
	@./$(NAME)

rer: re
	@./$(NAME)

crun: call
	@./$(CNAME)

crer: fclean call
	@./$(CNAME)

.PHONY: all call clean fclean re run rer crun crer
