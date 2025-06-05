CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -g
TARGET = simulator
SOURCES = main.c cpu.c

$(TARGET): $(SOURCES)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCES)

clean:
	rm -f $(TARGET)

.PHONY: clean
