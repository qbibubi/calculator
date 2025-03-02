section .rodata
	welcome_message db "Welcome to simple x86_64 assembly calculator", 0Ah, 0h
	info_message db "This calculator supports simple mathematical operations ONLY on two operands", 0Ah, 0h
	first_input db "First variable: ", 0h
	second_input db "Second variable: ", 0h

section .bss
	first:	resb 32
	second:	resb 32
	result:	resb 64

section .text
	global _start
	global strlen
	global print
	global input

_start:
	and rsp, -0x10
	mov rbp, rsp
	
	mov rdi, welcome_message
	call print

	mov rdi, info_message
	call print

	mov rdi, first_input
	call print

	call input

	mov rdi, second_input
	call print

	call input

	mov rax, 0x3c
	xor rdi, rdi
	syscall


print:
	push rbp
	mov rbp, rsp

	push rdi
	call strlen	

	mov rdx, rax
	mov rsi, rdi
	mov rdi, 0x1
	mov rax, 0x1
	syscall
	
	mov rsp, rbp
	pop rbp
	ret

input:
	push rbp
	mov rbp, rsp,

	push rdi

	mov rdx, 0
	mov rsi, 0 
	mov rdi, 0x1
	mov rax, 0x0
	syscall

	pop rbp
	retn


strlen:
	push rbx
	push rcx
	mov rcx, 0

.strlen_loop:
	movzx rbx, byte [rdi+rcx]
	test rbx, rbx
	jz .strlen_loop_end
	inc rcx 
	jmp .strlen_loop

.strlen_loop_end:
	mov rax, rcx
	pop rcx
	pop rbx
	ret
	
