# Define the compiler
CC = gcc

# Define compiler flags
CFLAGS = -Wall -Wextra -O2

# Define the libraries to link against
LIBS = -lsystemd

# Define the source files
SRCS_CLIENT = bus-client.c system-calculator-client.c
SRCS_SERVICE = system-calculator-service.c

# Define the object files
OBJS_CLIENT = $(SRCS_CLIENT:.c=.o)
OBJS_SERVICE = $(SRCS_SERVICE:.c=.o)

# Define the executable files
TARGET_CLIENT = bus-client system-calculator-client
TARGET_SERVICE = system-calculator-service

# Default target to build all executables
all: $(TARGET_CLIENT) $(TARGET_SERVICE)

# Rule to link the bus-client executable
bus-client: bus-client.o
	$(CC) $(CFLAGS) -o bus-client bus-client.o $(LIBS)

# Rule to link the system-calculator-client executable
system-calculator-client: system-calculator-client.o
	$(CC) $(CFLAGS) -o system-calculator-client system-calculator-client.o $(LIBS)

# Rule to link the system-calculator-service executable
system-calculator-service: system-calculator-service.o
	$(CC) $(CFLAGS) -o system-calculator-service system-calculator-service.o $(LIBS)

# Rule to compile source files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up the build files
clean:
	rm -f $(OBJS_CLIENT) $(OBJS_SERVICE) $(TARGET_CLIENT) $(TARGET_SERVICE)

# Phony targets
.PHONY: all clean

