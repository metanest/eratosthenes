%define WKSIZE 500

%macro era 0
  %ifndef er%[ix1]
    %assign ip0 (ix1 << 1)+3
    pri
    %assign ix2 ix1+ip0
    %rep WKSIZE/ip0
      er2
      %assign ix2 ix2+ip0
    %endrep
  %endif
%endmacro

%macro er2 0
  %define er%[ix2] 0
%endmacro

%macro pri 0
  itoa ip0
  %if pos > 71
    DB 10
    %assign pos 0
  %else
    DB ' '
    %assign pos pos+1
  %endif
%endmacro

%macro itoa 1
  %push
  %assign %$r -1
  %push

  %if %1 < 0
    %assign %$r -(%1)
    DB '-'
    %assign pos pos+1
  %else
    %assign %$r %1
  %endif

  %rep 100
    %push
    %assign %$r %$$r/10
    %if %$r == 0
      %exitrep
    %endif
  %endrep

  %pop

  %rep 100
    %assign %$r '0'+(%$r % 10)
    DB %$r
    %assign pos pos+1
    %pop
    %if %$r < 0
      %exitrep
    %endif
  %endrep

  %pop
%endmacro

	extern write, _exit

	SECTION .rodata
msg:
	%assign ix1 0
	%assign pos 0
	%assign ip0 2
	pri
	%rep WKSIZE
	  era
	  %assign ix1 ix1+1
	%endrep
	db 10
len:	equ $-msg

	SECTION .text
	global primes
primes:	mov	edi,1
	mov	esi,msg
	mov	edx,len
	call	write
	xor	edi,edi
	call	_exit

; dummy
	global main
main:
