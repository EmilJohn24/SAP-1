MOVA $Multiplicand
STA $Q;
MVI C, 0x08;
LDA $M
MOV B, A

CHECK:
LDA $Q;
ANI 0x01;
JZ Q0_ZERO:

Q0_ONE:
;11
JC INC_COUNT;
;10
SUB B;
JMP INC_COUNT;

Q0_ZERO:
;00
JNC INC_COUNT;
;01
ADD B;

INC_COUNT:
DEC C;

SHIFT:
LDA $A;
ANI 0x80;
RRC;
JNZ SIGN_1

SIGN_0:
ANI 0x7F;
JMP SHIFT_Q;

SIGN_1:
ORI 0x80;

SHIFT_Q:
STA $A;
LDA $Q;
JC A0_ONE;


A0_ONE:
RRC;
ORI 0x80;
JMP CHECK_COUNT;

A0_ZERO:
RRC;
ANI 0x7F;

CHECK_COUNT:
STA $Q;
MOV A,C;
ANI 0xFF;
JNZ CHECK;
HLT;
;00001111
;11010101
