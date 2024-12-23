.data
n: .word 5

.text
main:
    li a0, 1 # Initialize a0 
    jal ra, factorial # Call the printArray procedure
    li a0, 10 # load a value 10 into a0 register to exit the program
    ecall # Exit program
factorial:
    addi sp, sp, -4 # Allocate space on the stack
    sw ra, 4(sp) # Save return address
    lw t0, n # Initialize index i = 0
factorial_loop:
    beq x0, t0, end_loop # If i >= size, exit loop
    mul a0, t0, a0
    addi t0, t0, -1
    j factorial_loop # Repeat loop
end_loop:
    mv a1, a0 # Move the sum result to a1 to be printed
    jal print_value # Call the print_value procedure
    li a0, 10 # Exit syscall
    ecall
    lw ra, 4(sp) # Restore return address
    addi sp, sp, 4 # Deallocate stack space
    jr ra # Return to caller
# Procedure to print the value in a1
print_value:
    li a0, 1 # Syscall for print integer
    ecall
    jr ra # Return to caller