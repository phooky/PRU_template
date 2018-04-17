#include <stdint.h>
#include "resource_table.h"

#define PRU0

volatile register uint32_t __R30;
volatile register uint32_t __R31;

extern void asm_blink();

void main(void)
{
    // Call asm main blinker code
    asm_blink();
}

