    .global asm_blink
    
asm_blink:
    LDI     r30, 0

blink_forever:
    XOR     r30, r30, 0xff  
    .newblock
    LDI32   r0, 49999999
$1:     
    SUB     r0, r0, 1
    QBNE    $1, r0, 0         
    JMP     blink_forever

