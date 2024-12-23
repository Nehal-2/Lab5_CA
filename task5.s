.data
n: .word 10

.text
main:
    lw a0, n # Initialize a0 
    jal ra, fibonacci # Call the fibonacci procedure
    mv a1, a0 # Move the result to a1 to be printed
    jal ra, print_value
    li a0, 10 # load a value 10 into a0 register to exit the program
    ecall # Exit program
fibonacci:
    addi sp, sp, -8 # Allocate space on the stack
    sw ra, 4(sp) # Save return address
    sw a0, 0(sp) # Save argument n
    
    # if (n <= 1) return n
    li t0, 1 # Load 1 into t0
    ble a0, t0, base_case
    
    # else return fibonacci(n-1) + fibonacci(n-2)
    # Recursive case
    addi a0, a0, -1 # a0 = n - 1
    jal ra, fibonacci
#     sw a0, 0(sp)
    mv t1, a0 # Save result of fibonacci(n-1)
    
    lw a0, 0(sp) # Restore n from stack
    addi a0, a0, -2 # a0 = n - 2
    jal ra, fibonacci
    add a0, t1, a0 # a0 = fibonacci(n-1) + fibonacci(n-2)
#     lw t1, 0(sp) # Restore n from stack
    j end_fibonacci
base_case:
#     lw a0, n # Return n
    j end_fibonacci
end_fibonacci:
    lw ra, 4(sp) # Restore return address
    lw a0, 0(sp) # Restore n from stack
    addi sp, sp, 8 # Deallocate stack space
    jr ra # Return to caller
    
    # Procedure to print the value in a1
print_value:
    li a0, 1 # Syscall for print integer
    ecall
    jr ra # Return to caller
