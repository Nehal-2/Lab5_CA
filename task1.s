.data
array: .word 1, 2, 3, 4, 5, 6, 7, 8, 9 # Array elements

.text
main:
    li a0, 0 # Initialize a0 
    la s0, array # Load base address of the array into a0
    li a1, 9 # loading value 9 ( size of array in a1 register)
    jal ra, sumArray # Call the printArray procedure
    li a0, 10 # load a value 10 into a0 register to exit the program
    ecall # Exit program
sumArray:
    addi sp, sp, -16 # Allocate space on the stack
    sw ra, 12(sp) # Save return address
    sw s0, 8(sp) # Save s0
    sw s1, 4(sp) # Save s1
    mv s1, a1 # Save size in s1
    li t0, 0 # Initialize index i = 0
sum_loop:
    bge t0, s1, end_loop # If i >= size, exit loop
    slli t1, t0, 2 # t1 = i * 4 (word size)
    add t2, s0, t1 # t2 = address of arr[i]
    lw a1, 0(t2) # Load arr[i] into a1
    add a0, a0, a1 # sum = sum + arr[i]
    addi t0, t0, 1 # i++
    j sum_loop # Repeat loop
end_loop:
    mv a1, a0 # Move the sum result to a1 to be printed
    jal print_value # Call the print_value procedure
    li a0, 10 # Exit syscall
    ecall
    lw ra, 12(sp) # Restore return address
    lw s0, 8(sp) # Restore s0
    lw s1, 4(sp) # Restore s1
    addi sp, sp, 16 # Deallocate stack space
    jr ra # Return to caller
# Procedure to print the value in a1
print_value:
    li a0, 1 # Syscall for print integer
    ecall
    jr ra # Return to caller