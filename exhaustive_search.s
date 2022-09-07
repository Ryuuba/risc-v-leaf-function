# This function returns the index of an array corresponding a given key
# Frame size: 0 bytes (this is a leaf function)
# arguments: a0 <-> array's base address
#            a1 <-> array size
#            a2 <-> key
# return value: a0 <-> key index
# register convention: s1 <-> index, s2 <-> i
    .text
    .globl exhaustive_search
exhaustive_search:
        addi s1, zero, -1               # index = -1
        addi s2, zero, 0                # i = 0
        j    F1                         # jumps to assert loop condition
L3:     slli t0, s2, 2                  # 4*i
        add  t0, a0, t0                 # base + 4*i
        lw   t0, 0(t0)                  # loads a[i] into t0
        bne  t0, a2, L1                 # branches to L1 if a[i] != key
        add  s1, zero, s2               # moves i to index
        j    L2                         # breaks for loop
L1:     addi s2, s2, 1                  # increments i
F1:     blt  s2, a1, L3                 # branches to L3 if i < size
        # return index
L2:     add  a0, zero, s1               # moves index to a0 
        jr   ra                         # returns to caller function

# Main function
# Frame size:   16 bytes to back both sp and fp up
#               64 bytes to save local variables
# register convention: Use as few temporal registers as possible
    .text
    .globl main
main:
        addi sp, sp, -80                # Reserves 80 bytes to store the frame
        sw   ra, 80(sp)                 # backs ra up
        sw   fp, 76(sp)                 # backs fp up
        addi fp, sp, 80                 # Updates fp to point the bottom's frame
        # int a[10] = {4, 5, 2, 2, 5, 9, 1, 0, -9, 3};
        addi t0, fp, -52                # Computes the array's base address
        addi t1, zero, 4                # t1 gets 4
        sw   t1, 0(t0)                  # saves t1 in a[0]
        addi t1, zero, 5                # t1 gets 5
        sw   t1, 4(t0)                  # saves t1 in a[1]
        addi t1, zero, 2                # t1 gets 2
        sw   t1, 8(t0)                  # saves t1 in a[2]
        addi t1, zero, 2                # t1 gets 2
        sw   t1, 12(t0)                 # saves t1 in a[3]
        addi t1, zero, 5                # t1 gets 5
        sw   t1, 16(t0)                 # saves t1 in a[4]
        addi t1, zero, 9                # t1 gets 9
        sw   t1, 20(t0)                 # saves t1 in a[5]
        addi t1, zero, 1                # t1 gets 1
        sw   t1, 24(t0)                 # saves t1 in a[6]
        addi t1, zero, 0                # t1 gets 0
        sw   t1, 28(t0)                 # saves t1 in a[7]
        addi t1, zero, -9               # t1 gets -9
        sw   t1, 32(t0)                 # saves t1 in a[8]
        addi t1, zero, 3                # t1 gets 3
        sw   t1, 36(t0)                 # saves t1 in a[9]
        # int key = 3;
        addi t0, zero, 3              # t0 gets 3
        sw   t0, -56(fp)                # key gets 3
        # int index = exhaustive_search(a, 10, key);
        lw   a2, -56(fp)                # a2 <- M[fp - 56]
        addi a1, zero, 10               # a1 gets 10
        addi a0, fp, -52                # a0 gets array's base address
        jal  exhaustive_search          # calls exhaustive_search
        sw   a0, -60(fp)                # M[fp - 60] <- a0
        #  bool is_key_found = (index > -1) ? true : false;
        lw   t0, -60(fp)                # t0 gets M[fp - 60]
        xori t0, t0, -1                 # not index
        srli t0, t0, 31                 # gets the sign
        sb   t0, -64(fp)                # M[fp - 64] <- t0
        # return 0
        addi    a0, zero, 0             # a0 gets zero
        lw      ra, 80(sp)              # restores ra
        lw      fp, 76(sp)              # restores fp
        addi    sp, sp, 80              # frees main's frame
        jr      ra                      # returns control to OS
