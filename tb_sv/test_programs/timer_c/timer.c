
#define _STDIO_H 
#include <stdint.h>
#include <stdarg.h>
#include <stdint.h>

// Memory addresses
#define TIMER_BASE   0xA10
#define LED_BASE     0x890
#define HEX2HEX_BASE 0x8B0
#define LEDR_BASE    0x880

// Assuming you have a putchar function
void putchar(char c) {
    // Replace with your actual character output mechanism
    *((volatile char *)LED_BASE) = c;
}
 
// Helper function to print a number
void print_number(int num) {
    if (num < 0) {
        putchar('-');
        num = -num;
    }
    
    // Handle 0 explicitly
    if (num == 0) {
        putchar('0');
        return;
    }
    
    // Extract digits and store them (we print in reverse order)
    char digits[10]; // Enough for 32-bit integers
    int count = 0;
    
    while (num > 0) {
        digits[count++] = '0' + (num % 10);
        num /= 10;
    }
    
    // Print digits in reverse order
    while (count > 0) {
        putchar(digits[--count]);
    }
}
 
int printf(const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    int count = 0;
    
    while (*fmt) {
        if (*fmt == '%') {
            fmt++; // Move past '%'
            switch (*fmt) {
                case 'c': {
                    char c = va_arg(args, int);
                    putchar(c);
                    count++;
                    break;
                }
                case 's': {
                    char *s = va_arg(args, char *);
                    while (*s) {
                        putchar(*s++);
                        count++;
                    }
                    break;
                }
                case 'd': {
                    int num = va_arg(args, int);
                    print_number(num);
                    // Count digits (simplified - we could calculate exactly)
                    if (num == 0) {
                        count++;
                    } else {
                        if (num < 0) {
                            count++; // For the '-' sign
                            num = -num;
                        }
                        while (num > 0) {
                            count++;
                            num /= 10;
                        }
                    }
                    break;
                }
                case '%': {
                    putchar('%');
                    count++;
                    break;
                }
                default: {
                    putchar('%');
                    putchar(*fmt);
                    count += 2;
                    break;
                }
            }
        } else {
            putchar(*fmt);
            count++;
        }
        fmt++;
    }
    
    va_end(args);
    return count;
}

// Timer registers
#define TIMER_CURRENT   (*((volatile uint32_t*)(TIMER_BASE + 0x00)))
#define TIMER_PRESCALER (*((volatile uint32_t*)(TIMER_BASE + 0x04)))
#define TIMER_CONTROL   (*((volatile uint32_t*)(TIMER_BASE + 0x08)))
#define TIMER_STATUS    (*((volatile uint32_t*)(TIMER_BASE + 0x0C)))
#define TIMER_VAL       (*((volatile uint32_t*)(TIMER_BASE + 0x10)))

// LED control
#define LED0_ON  0x01
#define LED1_ON  0x02

int main(void) __attribute__((used));
int main(void) {
    // Setup timer for 1ms (adjust value based on your clock)
    TIMER_PRESCALER = 0;
    TIMER_CURRENT = 50000;  // Assuming 50MHz clock
    
    // Light LED0 when timer starts
    *((volatile uint32_t*)LED_BASE) = LED0_ON;
    
    // Start timer
    TIMER_CONTROL = 1;
    
    // Wait for completion
    while (TIMER_STATUS == 0) {
        *((volatile uint32_t*)HEX2HEX_BASE) = TIMER_VAL;
    }
    
    // Clear status and stop timer
    TIMER_STATUS = 0;
    TIMER_CONTROL = 0;
    
    // Light LED1 when timer done
    *((volatile uint32_t*)LED_BASE) = LED1_ON;

    printf("Done: %d", TIMER_CURRENT);

    while(1);
    
    return 0;
}
