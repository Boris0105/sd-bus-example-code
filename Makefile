# Define the compiler
CC = gcc

# Define compiler flags
CFLAGS = -Wall -Wextra -O2

# Define the libraries to link against
LIBS = -lsystemd

# Define the source files
SRCS = system-calculator-service.c system-calculator-client.c bus-service.c bus-client.c

# Define the object files
OBJS = $(SRCS:.c=.o)

# Define the executable files
TARGETS = system-calculator-service system-calculator-client bus-service bus-client

# Default target to build all executables
all: $(TARGETS)

# Rule to link the executables
system-calculator-service: system-calculator-service.o
	$(CC) $(CFLAGS) -o system-calculator-service system-calculator-service.o $(LIBS)

system-calculator-client: system-calculator-client.o
	$(CC) $(CFLAGS) -o system-calculator-client system-calculator-client.o $(LIBS)

bus-service: bus-service.o
	$(CC) $(CFLAGS) -o bus-service bus-service.o $(LIBS)

bus-client: bus-client.o
	$(CC) $(CFLAGS) -o bus-client bus-client.o $(LIBS)

# Rule to compile source files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up the build files
clean:
	rm -f $(OBJS) $(TARGETS)

# Phony targets
.PHONY: all clean

