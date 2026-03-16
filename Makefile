# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bbazagli <bbazagli@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/12 15:11:18 by bbazagli          #+#    #+#              #
#    Updated: 2024/01/25 13:12:30 by bbazagli         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = cc
CFLAGS = -Wextra -Wall -Werror
INCLUDE = -I ./include -I ./LIBFT/include
LIBFT = ./LIBFT/libft.a
LIBFT_DIR = ./LIBFT

SRC_C = mandatory/client.c
SRC_S = mandatory/server.c
BONUS_SRC_C = bonus/client_bonus.c
BONUS_SRC_S = bonus/server_bonus.c

OBJ_DIR = obj

SRCOBJ_C = $(SRC_C:%.c=${OBJ_DIR}/%.o)
SRCOBJ_S = $(SRC_S:%.c=${OBJ_DIR}/%.o)
SRCOBJ_BONUS_C = $(BONUS_SRC_C:%.c=${OBJ_DIR}/%.o)
SRCOBJ_BONUS_S = $(BONUS_SRC_S:%.c=${OBJ_DIR}/%.o)

all: $(LIBFT) client server

# 실행 파일이 $(LIBFT)라는 '파일'에 의존하도록 설정
client: $(SRCOBJ_C) $(LIBFT)
	@$(CC) $(CFLAGS) $(SRCOBJ_C) $(LIBFT) -o client
	@echo "Linking client..."

server: $(SRCOBJ_S) $(LIBFT)
	@$(CC) $(CFLAGS) $(SRCOBJ_S) $(LIBFT) -o server
	@echo "Linking server..."

bonus: $(LIBFT) client_bonus server_bonus

client_bonus: $(SRCOBJ_BONUS_C) $(LIBFT)
	@$(CC) $(CFLAGS) $(SRCOBJ_BONUS_C) $(LIBFT) -o client_bonus
	@echo "Linking client_bonus..."

server_bonus: $(SRCOBJ_BONUS_S) $(LIBFT)
	@$(CC) $(CFLAGS) $(SRCOBJ_BONUS_S) $(LIBFT) -o server_bonus
	@echo "Linking server_bonus..."

$(LIBFT):
	@make -C $(LIBFT_DIR) all

${OBJ_DIR}/%.o : %.c
	@mkdir -p $(dir $@) 
	@$(CC) $(CFLAGS) -c $< -o $@ $(INCLUDE)
	@printf "Compiling: $(notdir $<)\n"

clean:
	@make -C $(LIBFT_DIR) clean
	@rm -rf $(OBJ_DIR)
	@echo "Cleaned object files."

fclean: clean
	@make -C $(LIBFT_DIR) fclean
	@rm -rf client server client_bonus server_bonus
	@echo "Cleaned everything."

re: fclean all

.PHONY: all clean fclean re bonus
