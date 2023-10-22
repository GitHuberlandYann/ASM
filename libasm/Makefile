NAME        = libasm.a
NAME_BONUS  = libasmb.a
SRCS_DIR    = Sources
BONUS_DIR   = Bonus
OBJS_DIR    = Objs
TESTFILE    = Mains/hello

FILES       = ft_debug ft_strlen ft_strcpy ft_strcmp ft_write ft_read ft_strdup

SRCS        = $(addprefix $(SRCS_DIR)/, $(addsuffix .s, $(FILES)))
OBJS        = $(addprefix $(OBJS_DIR)/, $(addsuffix .o, $(FILES)))

FILES_BONUS = ft_list_add_front ft_list_push_front ft_list_size

SRCS_BONUS  = $(addprefix $(BONUS_DIR)/, $(addsuffix .s, $(FILES_BONUS)))
OBJS_BONUS  = $(addprefix $(OBJS_DIR)/, $(addsuffix .o, $(FILES_BONUS)))

# ===---===---===---===---===---===---===---===---===---===---===---===---

ASM         = nasm
ifeq ($(shell uname), Linux)
ASMFLAGS    = -f elf64
else
ASMFLAGS    = -f macho64
endif 

# ===---===---===---===---===---===---===---===---===---===---===---===---

all: $(OBJS_DIR) $(NAME)

$(OBJS_DIR):
	@mkdir -p $(OBJS_DIR)

$(NAME): $(OBJS)
	ar -rcs $(NAME) $(OBJS)

$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.s
	$(ASM) $(ASMFLAGS) $< -o $@

bonus: $(OBJS_DIR) $(NAME_BONUS)

$(NAME_BONUS): $(OBJS) $(OBJS_BONUS)
	ar -rcs $(NAME_BONUS) $(OBJS) $(OBJS_BONUS)

$(OBJS_DIR)/%.o: $(BONUS_DIR)/%.s
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -rf $(OBJS_DIR)

fclean: clean
	rm -f $(NAME) $(NAME_BONUS) a.out

re: fclean all

test:
	$(ASM) $(ASMFLAGS) $(TESTFILE).s && gcc $(TESTFILE).o && rm $(TESTFILE).o && ./a.out

debug: bonus
	clang++ Mains/main.cpp $(OBJS) $(OBJS_BONUS)
	@./a.out < Makefile

cebug: bonus
	gcc Mains/main.c $(OBJS) $(OBJS_BONUS)
	@./a.out < Makefile

.PHONY: all bonus clean fclean re test debug cebug
