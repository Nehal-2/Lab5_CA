.text
# Main function
main:
    li a1, 1 # Load the value 1 into a1
    jal print_value # Call the print_value procedure
    li a1, 2 # Load the value 2 into a1
    jal print_value # Call the print_value procedure
    li a0, 10 # Exit syscall
    ecall
# Procedure to print the value in a1
print_value:
    li a0, 1 # Syscall for print integer
    ecall
    jr ra # Return to caller