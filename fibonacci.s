# This function computes the n-th Fibonacci number. 
# frame size: 0 (callee leaf-function does not need a frame)
# arguments: a0 <-> target
# return value: a0 <-> fib
# register convention: t0 <-> a, t1 <-> b, fib <-> t2, n <-> t3
    .equ TARGET, 10
    .text
    .globl fibonacci_number
fibonacci_number:
        addi t0, zero, 1
        addi t1, zero, 1
        add  t2, zero, a0
        addi t3, zero, 3
        j    F1
L1:     add  t2, t1, t0
        add  t0, zero, t1
        add  t1, zero, t2
        addi t3, t3, 1
F1:     ble  t3, a0, L1
        add  a0, zero, t2
        jr   ra

# main function
# frame size: 32 bytes
#    - 4 words to back ra and fp up
#    - 4 words to store local variables
# register convention: Use as few temporal registers as possible
    .text
	.globl	main
main:
        addi    sp, sp, -32         # updates the stack's top
        sw      ra, 32(sp)          # backs ra up
        sw      fp, 28(sp)          # backs fp up
        addi    fp, sp, 32          # updates fp to point the frame's bottom
        addi    a0, zero, TARGET    # Computes function's argument
        jal     fibonacci_number    # Call function
        sw      a0, -16(fp)          # Saves returned value in F
#   return 0    
        addi    a0, zero, 0
        lw      ra, 32(sp)          # restores ra
        lw      fp, 28(sp)          # restores fp
        addi    sp, sp, 32          # frees main's frame
        jr      ra                  # returns control to OS