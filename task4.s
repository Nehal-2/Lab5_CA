.data
n: .word 5

.text
main:
    lw a0, n # Initialize a0 
    jal ra, factorial # Call the printArray procedure
    mv a1, a0 # Move the result to a1 to be printed
    jal ra, print_value
    li a0, 10 # load a value 10 into a0 register to exit the program
    ecall # Exit program
factorial:
    addi sp, sp, -8 # Allocate space on the stack
    sw ra, 4(sp) # Save return address
    sw a0, 0(sp) # Save argument n
    
    # if (n <= 1) return 1
    li t0, 1 # Load 1 into t0
    bge t0, a0, base_case
    
    # else return n * factorial(n - 1)
    # Recursive case
    addi a0, a0, -1 # a0 = n - 1
    jal ra, factorial
    lw t1, 0(sp) # Restore n from stack
    mul a0, t1, a0 # a0 = n * factorial(n - 1)
    j end_factorial
base_case:
    li a0, 1 # Return 1
end_factorial:
    lw ra, 4(sp) # Restore return address
    addi sp, sp, 8 # Deallocate stack space
    jr ra # Return to caller
    
    # Procedure to print the value in a1
print_value:
    li a0, 1 # Syscall for print integer
    ecall
    jr ra # Return to caller
