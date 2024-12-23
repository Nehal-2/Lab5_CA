.data
array: .word 1, 2, 3, 4, 5 # Array elements

.text
main:
    la a0, array # Load base address of the array into a0
    li a1, 5 # loading value 5 ( size of array in a1 register)
    jal printArray # Call the printArray procedure
    li a0, 10 # load a value 10 into a0 register to exit the program
    ecall # Exit program
printArray:
    addi sp, sp, -16 # Allocate space on the stack
    sw ra, 12(sp) # Save return address
    sw s0, 8(sp) # Save s0
    sw s1, 4(sp) # Save s1
    mv s0, a0 # Save array base address in s0
    mv s1, a1 # Save size in s1
    li t0, 0 # Initialize index i = 0
print_loop:
    bge t0, s1, end_loop # If i >= size, exit loop
    slli t1, t0, 2 # t1 = i * 4 (word size)
    add t2, s0, t1 # t2 = address of arr[i]
    lw a1, 0(t2) # Load arr[i] into a1
    li a0, 1 # Load 1 into a0 to print it
    ecall # Print arr[i]
    addi t0, t0, 1 # i++
    j print_loop # Repeat loop
end_loop:
    lw ra, 12(sp) # Restore return address
    lw s0, 8(sp) # Restore s0
    lw s1, 4(sp) # Restore s1
    addi sp, sp, 16 # Deallocate stack space
    jr ra # Return to caller