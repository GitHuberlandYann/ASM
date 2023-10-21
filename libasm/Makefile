NAME       = libasm.a
SRCS_DIR   = Sources
OBJS_DIR   = Objs
TESTFILE   = Mains/hello

FILES      = ft_strlen

SRCS       = $(addprefix $(SRCS_DIR)/, $(addsuffix .s, $(FILES)))
OBJS       = $(addprefix $(OBJS_DIR)/, $(addsuffix .o, $(FILES)))

# ===---===---===---===---===---===---===---===---===---===---===---===---

ASM         = nasm
ifeq ($(shell uname), Linux)
ASMFLAGS      = -f elf64
else
ASMFLAGS      = -f macho64
endif 

# ===---===---===---===---===---===---===---===---===---===---===---===---

all: $(OBJS_DIR) $(NAME)

$(OBJS_DIR):
	@mkdir -p $(OBJS_DIR)

$(NAME): $(OBJS)
	ar -rcs $(NAME) $(OBJS)

$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.s
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -rf $(OBJS_DIR)

fclean: clean
	rm -f $(NAME)

re: fclean all

test:
	$(ASM) $(ASMFLAGS) $(TESTFILE).s && gcc $(TESTFILE).o && rm $(TESTFILE).o && ./a.out

debug: all
	clang++ Mains/main.cpp $(OBJS)

cebug: all
	gcc Mains/main.c $(OBJS)

.PHONY: all clean fclean re test debug cebug
