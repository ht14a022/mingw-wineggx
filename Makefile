CC		= g++
MODE	= 3
OUTPUT	= 0
CFLAGS	= -g -MMD -MP -std=c++11 -O3 -mtune=native -march=native -w --param=max-vartrack-size=600000000
LDFLAGS = -L./build/wineggx.o -L'C:\Program Files (x86)\Windows Kits\10\Lib\10.0.17134.0\um\x64' -lgdi32 -lkernel32 -luser32
LIBS	= 
INCLUDE = -I ./wineggx/include
SRC_DIR = ./wineggx/src
OBJ_DIR = ./wineggx/build
SOURCES = $(shell ls $(SRC_DIR)/*.cpp) 
OBJS    = $(subst $(SRC_DIR),$(OBJ_DIR), $(SOURCES:.cpp=.o))
TARGET	= texample1 texample2 example1 example2
DEPENDS = $(OBJS:.o=.d)

all: $(TARGET)

%: $(OBJ_DIR)/%.o $(OBJ_DIR)/wineggx.o $(LIBS)
	$(CC) -o $@ $(OBJ_DIR)/$@.o $(OBJ_DIR)/wineggx.o $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp 
	@if [ ! -d $(OBJ_DIR) ]; \
		then echo "mkdir -p $(OBJ_DIR)"; mkdir -p $(OBJ_DIR); \
		fi
	$(CC) $(CFLAGS) $(INCLUDE) -o $@ -c $< -DMODE=$(MODE) -DOUTPUT=$(OUTPUT)

clean:
	$(RM) $(OBJS) $(TARGET) $(DEPENDS)

-include $(DEPENDS)

.PHONY: all clean