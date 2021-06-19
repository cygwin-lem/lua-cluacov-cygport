LUA_VERSION?=$(basename $(word 2,$(shell lua -v)))

SRC_DIR=src/cluacov/
OUT_DIR=$(LUA_VERSION)/cluacov/

SRC_LIST=deepactivelines.c hook.c

SRCS=$(addprefix $(SRC_DIR),$(SRC_LIST))

LUA_CFLAGS=-I/usr/include/lua${LUA_VERSION}
LUA_LIBS?=-llua${LUA_VERSION}
SOBJS=$(patsubst %.c,$(OUT_DIR)%.so, $(SRC_LIST))

all: $(SOBJS)

$(OUT_DIR):
	mkdir -p $@

$(SOBJS): $(OUT_DIR)

$(OUT_DIR)%.so: $(SRC_DIR)%.c
	$(CC) --shared -o $@ $(CFLAGS) -fPIC $(LUA_CFLAGS) $(CPPFLAGS) $< $(LUA_LIBS)

clean:
	rm -rf $(OUT_DIR)
