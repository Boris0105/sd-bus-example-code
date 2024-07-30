# Define the compiler
CC = gcc

# Define compiler flags
CFLAGS = -Wall -Wextra -O2

# Define the libraries to link against
LIBS = -lsystemd

# Define the source and object files
SRCS = bus-client.c
OBJS = $(SRCS:.c=.o)

# Define the executable file
TARGET = bus-client

# Default target
all: $(TARGET)

# Rule to link the executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS) $(LIBS)

# Rule to compile source files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up the build files
clean:
	rm -f $(OBJS) $(TARGET)

# Phony targets
.PHONY: all clean

