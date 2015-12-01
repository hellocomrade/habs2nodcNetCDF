PROG_NAME=obs2nc
CC=gcc
NETCDF_INCLUDE_PATH=/usr/local/include/
NETCDF_LIB_PATH=/usr/local/lib64/
LIB_FLAG=-lnetcdf -llua
CPPFLAGS:=-I${NETCDF_INCLUDE_PATH}
PLATFORM=-m64
CFLAGS:=${PLATFORM} -Wall -O3 #-g
LDFLAGS:=-L${NETCDF_LIB_PATH} ${LIB_FLAG}
objs:=$(patsubst %.c,%.o,$(wildcard *.c))

.PHONY:all clean ${PROG_NAME}

all:${PROG_NAME}

${PROG_NAME}:${objs}
	${CC} -o $@ ${CPPFLAGS} ${CFLAGS} ${PROG_NAME}.o ${LDFLAGS}
%.o:%.c
	${CC} -c ${CPPFLAGS} ${CFLAGS} $< -o $@
clean:
	@echo "remove all object files and main target"
	rm ./*.o ./${PROG_NAME}

