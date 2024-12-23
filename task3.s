.data
array: .word 7, 3, 2, 9, 5, 1, 4, 6, 8 # Array elements

.text
main:
    la s0, array # Load base address of the array into a0
    li s1, 9 # loading value 9 ( size of array in a1 register)
    jal ra, sortArray # Call the printArray procedure
    li t0, 0 # Initialize t0 for printing
    jal ra, printArray
    li a0, 10 # load a value 10 into a0 register to exit the program
    ecall # Exit program
sortArray:
    addi sp, sp, -16 # Allocate space on the stack
    sw ra, 12(sp) # Save return address
    sw s0, 8(sp) # Save s0
    sw s1, 4(sp) # Save s1
    li t0, 0 # Initialize index i = 0
outer_loop:
    sub t1, s1, t0 # t1 = size - i
    addi t1, t1, -1 # t1 = size - i - 1
    li t2, 0 # Initialize index j = 0
inner_loop:
    bge t2, t1, next_outer # If j >= size - 1 - i, exit loop
    slli t3, t2, 2 # t3 = j * 4 (word size)
    add t4, s0, t3 # t4 = address of arr[j]
    lw a1, 0(t4) # Load arr[j] into a1
    lw a2, 4(t4) # Load arr[j+1] into a2
    bge a2, a1, skip_swap # If arr[j] <= arr[j+1], skip swapping
    # If arr[j] > arr[j+1], swap
    sw a2, 0(t4) # arr[j] = arr[j+1]
    sw a1, 4(t4) # arr[j+1] = temp
skip_swap:
    addi t2, t2, 1 # j++
    j inner_loop # Go back to inner loop
next_outer:
    addi t0, t0, 1 # i++
    blt t0, s1, outer_loop # If i < size, go back to outer loop
    lw ra, 12(sp) # Restore return address
    lw s0, 8(sp) # Restore s0
    lw s1, 4(sp) # Restore s1
    addi sp, sp, 16 # Deallocate stack space
    jr ra # Return to caller
    
printArray:
    bge t0, s1, printEnd # If i >= size, end printing
    slli t1, t0, 2 # t1 = i * 4 (word size)
    add t2, s0, t1 # t2 = address of arr[i]
    lw a1, 0(t2) # Load arr[i] into a1
    jal ra, print_value
    addi t0, t0, 1 # i++
    j printArray
printEnd:
    jr ra # Return to caller
print_value:
    li a0, 1 # Syscall for print integer
    ecall
    # Add spaces
    li a0, 11 # Syscall for print character
    li a1, 32 # ASCII for [space]
    ecall
    jr ra # Return to caller
