CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -g
TARGET = preprocessor
SOURCES = main.c preprocessor.c

$(TARGET): $(SOURCES)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCES)

clean:
	rm -f $(TARGET)

.PHONY: clean
