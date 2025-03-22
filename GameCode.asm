;Chand Ali, 22L-6945, COAL PROJECT
[org 0x0100]
jmp Start
Score : db 'SCORE : *'
Time : db 'TIME  : *'
Head : db 'TETRIS GAME *'
Made : db 'POWERED BY C/A*'
Startt : db 'PRESS 1 TO START GAME *'
Over : db 'GAME OVER !!!*'
Game : db 'GAME*'
Upcoming : db 'UPCOMING SHAPE*'
bool : db 1
boolGameEnd : db 0
ScoreVar: db 00
TimeVar: db 0
TimeVar1: db 0
Variable1 : db 1
ClearScreen:
mov ax,0xb800
mov es,ax
mov di,0
MyLoop:
mov word[es:di],  0x7000
add di,2
cmp di,4000
jnz MyLoop

ret
;------------------------------
Clr:
mov ax,0xb800
mov es,ax
mov di,0
Clean:
mov word[es:di],0x0000
add di,2
cmp di,4000
jnz Clean

ret

;------------------------------------------------------
PrintMessage:


push bp
mov bp,sp
push si

mov ax,0xb800
mov es,ax
mov si,[bp+4]
mov ah,0x30
Print:
mov al,[si]
mov [es:di],ax
add di,2
inc si
cmp byte[si],'*'
jne Print

pop si
pop bp
ret 2
;----------------------------------------------
PrintMessagee:


push bp
mov bp,sp
push si

mov ax,0xb800
mov es,ax
mov si,[bp+4]
; mov ah,0x79
mov ah,0x70
; mov ah,0x7C
Printt:
mov al,[si]
mov [es:di],ax
call delayy
add di,2
inc si
cmp byte[si],'*'
jne Printt

pop si
pop bp
ret 2

;----------------------------------------------------------------------

ScreenEnd:

push ax
push di
push cx

mov ah, 0x97  
; mov al,'*'
mov di, 160
mov cx, 0
mov word[es:0], ax
mov word[es:2], ax
;Left
BoundaryLoop1:
mov word[es:di], ax
mov word[es:di+2], ax
add di, 160  
inc cx
cmp cx, 24   
jnz BoundaryLoop1


sub di, 160
mov cx, 0
;Bottom boundary
BoundaryLoop3:
mov word[es:di], ax
add di, 2 
inc cx
cmp cx, 50 
jnz BoundaryLoop3

mov di, 260
mov cx, 0

;Right boundary 
BoundaryLoop2:
mov word[es:di], ax
mov word[es:di+2], ax
add di, 160  
inc cx
cmp cx, 24   
jnz BoundaryLoop2


mov di,3306
push Upcoming
call PrintMessagee

pop cx
pop di
pop ax

ret
;----------------------------------------------- 
PrintScoreTimeLives:

; mov ax,Score
; push ax
; mov di,450
; call PrintMessage	
; mov al, [ScoreVar]
; mov ah,0x00
; push ax
; call printNum


mov ax,Time
push ax
mov di,770
call PrintMessage	
mov al,[TimeVar]
mov ah,0x00
push ax
call printNum
; add al,0x30	
; mov ah,0x3A
; mov [es:di],ax

ret
;-----------------------------------------------------------
printNum:
    push bp 
    mov bp, sp 
    push es 
    push ax 
    push bx 
    push cx 
    push dx 
    mov ax, [bp+4]    ; load number in ax 
    mov bx, 10        ; use base 10 for division 
    mov cx, 0         ; initialize count of digits 
    nextdigit:
      mov dx, 0       ; zero upper half of dividend 
      div bx          ; divide by 10 
      add dl, 0x30    ; convert digit into ascii value 
      push dx         ; save ascii value on stack 
      inc cx          ; increment count of values 
      cmp ax, 0       ; is the quotient zero 
    jnz nextdigit     ; if no divide it again 
    nextpos:
      pop dx          ; remove a digit from the stack 
      mov dh, 0x70    ; use normal attribute 
      mov [es:di], dx ; print char on screen 
      add di, 2       ; move to next screen location 
      loop nextpos    ; repeat for all digits on stack
     pop dx 
     pop cx 
     pop bx 
     pop ax 
     pop es 
     pop bp 
     ret 2 
;-----------------------------------------------------------
UpdateTime:
push ax
mov byte[TimeVar1],0
inc byte[TimeVar]
mov al,[TimeVar]
mov ah,0x00
mov di,786
push ax
call printNum
pop ax
ret
; UpdateScore:
;     mov ax,Score
;     push ax
;     mov di,450
;     call PrintMessage	
;     mov al, [ScoreVar]
;     mov ah,0x00
;     push ax
;     call printNum
; ret
;-----------------------------------------------------------
;Chand Ali, 22L-6945, COAL PROJECT
delay:
mov cx, 0xffff
delaying
add bx, 1
loop delaying
call delayy
call delayy
call delayy
inc byte[TimeVar1]
cmp byte[TimeVar1],10
je UpdateTime
ret
delayy:
mov cx, 0xdddd
delayingg
add bx, 1
; call UpdateTime
loop delayingg

ret
;-----------------------------------------------------------

HorizentalLine:
mov ax,0xb800
mov es,ax

mov di,si
mov ah,0x70
mov al,0x00
mov [es:di-160],ax
mov [es:di-158],ax
mov [es:di-156],ax
mov [es:di-154],ax
mov [es:di-152],ax
mov [es:di-150],ax
mov [es:di-148],ax


Next1:

mov ah,0x24
mov al,0x00
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2


sub di,14

in al,0x60
cmp al,0x1E
jne Nextt
mov ax,[es:di-2]
cmp ah,0x97
je Nextt
mov ah,0x70
mov al,0x00
mov [es:di+12],ax
mov ah,0x24
mov al,0x00
mov [es:di-2],ax
sub di,2

Nextt:
in al,0x60
cmp al,0x20
jne Next11
mov ax,[es:di+14]
cmp ah,0x97
je Nextt
mov ah,0x70
mov al,0x00
mov [es:di],ax
mov ah,0x24
mov al,0x00
mov [es:di+14],ax
add di,2

Next11:




add di,160


mov ax,[es:di]
cmp ah,0x70
jne NoMore
mov ax,[es:di+2]
cmp ah,0x70
jne NoMore
mov ax,[es:di+4]
cmp ah,0x70
jne NoMore
mov ax,[es:di+6]
cmp ah,0x70
jne NoMore
mov ax,[es:di+8]
cmp ah,0x70
jne NoMore
mov ax,[es:di+10]
cmp ah,0x70
jne NoMore
mov ax,[es:di+12]
cmp ah,0x70
jne NoMore

mov byte[bool],1
jmp Continue

NoMore:
mov byte[bool],0

Continue:
mov si,di
ret
;-------------------------------------------------------------
Verticalline:
mov ax,0xb800
mov es,ax
mov ah,0x70
mov al,0x00

mov di,si
mov [es:di-160],ax
mov [es:di-158],ax


mov ah,0xC0
mov [es:di],ax
mov [es:di+2],ax
add di,160
mov [es:di],ax
mov [es:di+2],ax
add di,160
mov [es:di],ax
mov [es:di+2],ax


in al,0x60
cmp al,0x1E ;Left
jne Next6
mov ax,[es:di-2]
cmp ah,0x97 
je Next6
mov ah,0x70
mov al,0x00
mov [es:di+2],ax
mov [es:di+2-160],ax
mov [es:di+2-320],ax
sub di,2
mov ah,0xC0
mov [es:di],ax
mov [es:di-160],ax
mov [es:di-320],ax

Next6:
in al,0x60
cmp al,0x20 ;Right
jne Next125
mov ax,[es:di+2]
cmp ah,0x97
je Next125
mov ah,0x70
mov al,0x00
mov [es:di],ax
mov [es:di-160],ax
mov [es:di-320],ax
add di,2
mov ah,0xC0
mov [es:di+2],ax
mov [es:di+2-160],ax
mov [es:di+2-320],ax

Next125:
    

add di,160

mov ax,[es:di]
cmp ah,0x70
jne NoMoree
mov ax,[es:di+2]
cmp ah,0x70
jne NoMoree
; mov ax,[es:di+4]
; cmp ah,0x70
; jne NoMoree

mov byte[bool],1
jmp Continuee


NoMoree:
mov byte[bool],0

Continuee:
sub di,320
mov si,di

ret
;----------------------------------------------------------
;----------------------------------------------------------



Verticalline2:
    mov ax,0xb800
    mov es,ax
    mov ah,0x70
    mov al,0x00
    
    mov di,si
    mov [es:di-160],ax
 
    
    mov ah,0x0A
    mov [es:di],ax
    add di,160
    mov [es:di],ax
    add di,160
    mov [es:di],ax
    

    in al,0x60
    cmp al,0x1E ;Left
    jne Next9
    mov ax,[es:di-2]
    cmp ah,0x97 
    je Next9
    mov ah,0x70
    mov al,0x00
    mov [es:di],ax
    mov [es:di-160],ax
    mov [es:di-320],ax
    sub di,2
    mov ah,0x0A
    mov [es:di],ax
    mov [es:di-160],ax
    mov [es:di-320],ax
    
    Next9:
    in al,0x60
    cmp al,0x20 ;Right
    jne Next1256
    mov ax,[es:di+2]
    cmp ah,0x97
    je Next1256
    mov ah,0x70
    mov al,0x00
    mov [es:di],ax
    mov [es:di-160],ax
    mov [es:di-320],ax
    add di,2
    mov ah,0x0A
    mov [es:di],ax
    mov [es:di-160],ax
    mov [es:di-320],ax
    
    Next1256:
        
    
    add di,160
    
    mov ax,[es:di]
    cmp ah,0x70
    jne NoMoree9
    
    mov byte[bool],1
    jmp Continuee9
    
    
    NoMoree9:
    mov byte[bool],0
    
    Continuee9:
    
    sub di,320
    mov si,di
    
    ret



;---------------------------------------------------------------------
;=--------------------------------------------------------------------

Cube:
mov ax,0xb800
mov es,ax
   
mov ah,0x70
mov al,0x00

mov di,si
mov [es:di-160],ax
mov [es:di-158],ax
mov [es:di-156],ax


mov ah,0x30
mov [es:di],ax
mov [es:di+2],ax
mov [es:di+4],ax
add di,160
mov [es:di],ax
mov [es:di+2],ax
mov [es:di+4],ax
add di,160
mov [es:di],ax
mov [es:di+2],ax
mov [es:di+4],ax


in al,0x60
cmp al,0x1E
jne Next2
mov ax,[es:di]
; mov ax,[es:di-4]
cmp ah,0x97 ;Left
je Next2
mov ah,0x70
mov al,0x00
mov [es:di+4],ax
mov [es:di+4-160],ax
mov [es:di+4-320],ax
sub di,2
mov ah,0x30
mov [es:di],ax
mov [es:di-160],ax
mov [es:di-320],ax

Next2:
in al,0x60
cmp al,0x20 ;Right
jne Next12
mov ax,[es:di+6]
cmp ah,0x97
je Next2
mov ah,0x70
mov al,0x00
mov [es:di],ax
mov [es:di-160],ax
mov [es:di-320],ax
add di,2
mov ah,0x30
mov [es:di+4],ax
mov [es:di+4-160],ax
mov [es:di+4-320],ax

Next12:

add di,160

mov ax,[es:di]
cmp ah,0x70
jne NoMoreee
mov ax,[es:di+2]
cmp ah,0x70
jne NoMoreee
mov ax,[es:di+4]
cmp ah,0x70
jne NoMoreee

mov byte[bool],1
jmp Continueee


NoMoreee:
mov byte[bool],0

Continueee:

sub di,320
mov si,di
ret
;------------------------------------------------------------
LShape:

mov ax,0xb800
mov es,ax
mov ah,0x70
mov al,0x00

mov di,si
mov [es:di-160],ax
mov [es:di-158],ax
mov [es:di+160],ax
mov [es:di+162],ax
mov [es:di+164],ax
mov [es:di+166],ax




mov ah,0xD0
; mov ah,0x32
mov [es:di],ax
mov [es:di+2],ax
add di,160
mov [es:di],ax
mov [es:di+2],ax
add di,160
mov [es:di],ax
mov [es:di+2],ax
mov [es:di+4],ax
mov [es:di+6],ax

in al,0x60
cmp al,0x1E
jne Next3
mov ax,[es:di-2]
cmp ah,0x97 ;Left
je Next3
mov ah,0x70
mov al,0x00
mov [es:di+6],ax
mov [es:di+2-160],ax
mov [es:di+2-320],ax
sub di,2
mov ah,0xD0
mov [es:di],ax
mov [es:di-160],ax
mov [es:di-320],ax

Next3:
in al,0x60
cmp al,0x20 ;Right
jne Next123
mov ax,[es:di+8]
cmp ah,0x97
je Next123
mov ah,0x70
mov al,0x00
mov [es:di],ax
mov [es:di-160],ax
mov [es:di-320],ax
add di,2
mov ah,0xD0
mov [es:di+2-160],ax
mov [es:di+2-320],ax
mov [es:di+6],ax

Next123:
  
add di,160

mov ax,[es:di]
cmp ah,0x70
jne NoMore1
mov ax,[es:di+2]
cmp ah,0x70
jne NoMore1
mov ax,[es:di+4]
cmp ah,0x70
jne NoMore1
mov ax,[es:di+6]
cmp ah,0x70
jne NoMore1

mov byte[bool],1
jmp Continue1


NoMore1:
mov byte[bool],0

Continue1:

sub di,320
mov si,di

ret
;------------------------------------------------------------
Jshape:
mov ax,0xb800
mov es,ax
mov ah,0x70
mov al,0x00

mov di,si
mov [es:di-160],ax
mov [es:di-158],ax
mov [es:di+160],ax
mov [es:di+162],ax
mov [es:di+158],ax
mov [es:di+156],ax




mov ah,0x0E
mov [es:di],ax
mov [es:di+2],ax
add di,160
mov [es:di],ax
mov [es:di+2],ax
add di,160
mov [es:di],ax
mov [es:di+2],ax
mov [es:di-2],ax
mov [es:di-4],ax



in al,0x60
cmp al,0x1E
jne Next4
mov ax,[es:di-6]
cmp ah,0x97 ;Left
je Next4
mov ah,0x70
mov al,0x00
mov [es:di+2],ax
mov [es:di+2-160],ax
mov [es:di+2-320],ax
sub di,2
mov ah,0x0E
mov [es:di-160],ax
mov [es:di-320],ax
mov [es:di-4],ax

Next4:
in al,0x60
cmp al,0x20 ;Right
jne Next1234
mov ax,[es:di+8]
cmp ah,0x97
je Next1234
mov ah,0x70
mov al,0x00
mov [es:di-4],ax
mov [es:di-160],ax
mov [es:di-320],ax
add di,2
mov ah,0x0E
mov [es:di+2],ax
mov [es:di+2-160],ax
mov [es:di+2-320],ax

Next1234:




    
add di,160

mov ax,[es:di]
cmp ah,0x70
jne NoMore2
mov ax,[es:di+2]
cmp ah,0x70
jne NoMore2
mov ax,[es:di-2]
cmp ah,0x70
jne NoMore2
mov ax,[es:di-4]
cmp ah,0x70
jne NoMore2

mov byte[bool],1
jmp Continue2


NoMore2:
mov byte[bool],0

Continue2:

sub di,320
mov si,di

ret


;------------------------------------------------------------


Tshape:
mov ax,0xb800
mov es,ax
mov ah,0x70
mov al,0x00

mov di,si
mov [es:di-160],ax
mov [es:di-158],ax
mov [es:di+160],ax
mov [es:di+162],ax
mov [es:di+164],ax
mov [es:di+166],ax
mov [es:di+158],ax
mov [es:di+156],ax



mov ah,0x60 ;-->Orange
; mov ah,0x50 -->pink
; mov ah,0x30 -->Sky blue
mov [es:di],ax
mov [es:di+2],ax
add di,160
mov [es:di],ax
mov [es:di+2],ax
add di,160
mov [es:di],ax
mov [es:di+2],ax
mov [es:di+4],ax
mov [es:di+6],ax
mov [es:di-2],ax
mov [es:di-4],ax



in al,0x60
cmp al,0x1E
jne Next5
mov ax,[es:di-6]
cmp ah,0x97 ;Left
je Next5
mov ah,0x70
mov al,0x00
mov [es:di+6],ax
mov [es:di+2-160],ax
mov [es:di+2-320],ax
sub di,2
mov ah,0x60
mov [es:di-160],ax
mov [es:di-320],ax
mov [es:di-4],ax

Next5:
in al,0x60
cmp al,0x20 ;Right
jne Next12345
mov ax,[es:di+8]
cmp ah,0x97
je Next12345
mov ah,0x70
mov al,0x00
mov [es:di-4],ax
mov [es:di-160],ax
mov [es:di-320],ax
add di,2
mov ah,0x60
mov [es:di+6],ax
mov [es:di+2-160],ax
mov [es:di+2-320],ax

Next12345:




add di,160

mov ax,[es:di]
cmp ah,0x70
jne NoMore3
mov ax,[es:di+2]
cmp ah,0x70
jne NoMore3
mov ax,[es:di-2]
cmp ah,0x70
jne NoMore3
mov ax,[es:di-4]
cmp ah,0x70
jne NoMore3
mov ax,[es:di+4]
cmp ah,0x70
jne NoMore3
mov ax,[es:di+6]
cmp ah,0x70
jne NoMore3

mov byte[bool],1
jmp Continue3


NoMore3:
mov byte[bool],0

Continue3:

sub di,320
mov si,di

ret
;-------------------------------------------------------------
AboveChecking:
mov di,4
mov cx,48

ExitGame:
mov ax,[es:di]
add di,2
cmp ah,0x70
jne UpdateExitBool
loop ExitGame
ret
UpdateExitBool:
mov byte[boolGameEnd],1
ret
;--------------------------------------------------------------
PauseGame:
    pusha
    in al,0x60
    cmp al,0x19 ;for pause
    je PauseLoop
    jmp ReturnBack
    PauseLoop:
    in al,0x60
    cmp al,0x2E ;for continue
    jne PauseLoop

ReturnBack:
    popa
    ret
;-------------------------------------------------------------
TimerEnd:
    cmp byte[TimeVar],180
    je EndTheGame
    ret
    EndTheGame:
        jmp End
    ret
;--------------------------------------------------------------
PrintShapes:

    mov ah,0x70
    mov al,0x00
    mov di,3020
    mov cx,5
    Loop50: ;Previous shape
    mov [es:di],ax
    mov [es:di+2],ax
    mov [es:di+4],ax
    mov [es:di+6],ax
    mov [es:di+8],ax
    mov [es:di+10],ax
    mov [es:di+12],ax
    mov [es:di-2],ax
    mov [es:di-4],ax
    mov [es:di-6],ax
    add di,160
    loop Loop50


    mov di,3340
    cmp byte[Variable1],1
    je First
    cmp byte[Variable1],2
    je Second
    cmp byte[Variable1],3
    je Third
    cmp byte[Variable1],4
    je ItisForthShape
    jmp fifthshapeCheck
    ItisForthShape:
    jmp Forth 
    jmp End2
    fifthshapeCheck:
    cmp byte[Variable1],5
    je Gotofifth
    jmp sixthshapeCheck
    Gotofifth:
    jmp Fifth
    jmp End2
    sixthshapeCheck:
    cmp byte[Variable1],6
    je OKK
    jmp SthShape
    OKK:
    jmp Sixth
    jmp End2
    SthShape:
    cmp byte[Variable1],7
    je OK
    OK:
    jmp Seventh
    jmp End2
First:
    call secondd
    mov si,60
    HorizentalLoop:
    call PauseGame
    call delay
    call HorizentalLine
    call TimerEnd
    cmp byte[bool],1
    je HorizentalLoop
    jmp End2
Second:
    call thirdd
    mov si,80
    CubeLoop:
    call PauseGame
    call Cube
    call TimerEnd
    call delay 
    cmp byte[bool],1
    je CubeLoop
    jmp End2
Third:
    call forthh
    mov si,50
    LLoop:
    call PauseGame
    call LShape
    call TimerEnd
    call delay
    cmp byte[bool],1
    je LLoop
    jmp End2
Forth:
    call fifthh
    mov si,50
    JLoop:
    call PauseGame
    call Jshape
    call TimerEnd
    call delay 
    cmp byte[bool],1
    je JLoop
    jmp End2
Fifth:
    call sixthh
    mov si,10
    TLoop:
    call PauseGame
    call Tshape
    call TimerEnd
    call delay
    cmp byte[bool],1
    je TLoop
    jmp End2
Sixth:
    call seventhh
    mov si,40
    VerticalLoop:
    call PauseGame
    call Verticalline
    call TimerEnd
    call delay
    cmp byte[bool],1
    je VerticalLoop
    jmp End2
Seventh:
    call firstt
    mov si,40
    VerticalLoop1:
    call PauseGame
    call Verticalline2
    call TimerEnd
    call delay
    cmp byte[bool],1
    je VerticalLoop1
    jmp End2
End2:



    mov di,3684
    mov cx,48 ;Try 49 and 50 -->Pro

    CheckFull:
    mov ax,[es:di]
    add di,2
    cmp ah,0x70
    je NoRemove
    cmp ah,0x97
    je Endd
    dec cx
    jnz CheckFull


    call ScrollDown
    call ScreenEnd

    mov di,0
    mov cx,80
    mov ah,0x70
    mov al,0x00
    MylastLoop:
    mov [es:di],ax
    add di,2
    loop MylastLoop
    ; mov di,3684
    ; mov cx,48
    ; mov ah,0x70
    ; mov al,0x00
    ; Clean1:
    ; mov [es:di],ax
    ; add di,2
    ; loop Clean1

    Endd:
    ;     call ClearScreen
    ;     call delay
    ;     call delay
    ;     call delay
    ;     call delay
    ;     call ClearScreen
    ; mov cx,80
    ; mov di,3840
    ; mov ah,0x70
    ; mov al,0x00
    ; Remove:
    ; mov [es:di],ax
    ; add di,2
    ; dec cx
    ; jnz Remove

NoRemove:
    ret 
ScrollDown:
push di
push ax
push cx
push ds

add byte[ScoreVar],10

mov si, di
mov ax, 0xb800
mov ds, ax
sub si,160


RepeatInScroll:
push si
push di
mov cx,25
std 
rep movsw 
cld
pop di
pop si
sub si,160
sub di,160
cmp si,40
ja RepeatInScroll


mov di,40
mov ax,0x7020
mov cx,25
rep stosw
exitScroll:

pop ds
pop cx
pop ax
pop di
ret

firstt:  
    mov ah,0x24
    mov al,0x00
    mov [es:di],ax
    mov [es:di+2],ax
    mov [es:di+4],ax
    mov [es:di+6],ax
    mov [es:di+8],ax
    mov [es:di+10],ax
    mov [es:di+12],ax
    ret
secondd:

    mov ah,0x30
    mov al,0x00
    mov [es:di],ax
    mov [es:di+2],ax
    mov [es:di+4],ax
    mov [es:di+160],ax
    mov [es:di+2+160],ax
    mov [es:di+4+160],ax
    mov [es:di+320],ax
    mov [es:di+2+320],ax
    mov [es:di+4+320],ax
        ret
thirdd:

    mov ah,0xD0
    mov al,0x00
    mov [es:di],ax
    mov [es:di+2],ax
    mov [es:di+160],ax
    mov [es:di+2+160],ax
    mov [es:di+320],ax
    mov [es:di+2+320],ax
    mov [es:di+4+320],ax
    mov [es:di+6+320],ax
        ret
forthh:

    mov ah,0x0E
    mov al,0x00
    mov [es:di],ax
    mov [es:di+2],ax
    mov [es:di+160],ax
    mov [es:di+2+160],ax
    add di,320
    mov [es:di],ax
    mov [es:di+2],ax
    mov [es:di-2],ax
    mov [es:di-4],ax
        ret
fifthh:

    mov ah,0x60 
    mov al,0x00
    mov [es:di],ax
    mov [es:di+2],ax
    add di,160
    mov [es:di],ax
    mov [es:di+2],ax
    add di,160
    mov [es:di],ax
    mov [es:di+2],ax
    mov [es:di+4],ax
    mov [es:di+6],ax
    mov [es:di-2],ax
    mov [es:di-4],ax
    ret
sixthh:
    
    mov ah,0xC0
    mov al,0x00
    mov [es:di],ax
    mov [es:di+2],ax
    mov [es:di+160],ax
    mov [es:di+2+160],ax
    mov [es:di+320],ax
    mov [es:di+2+320],ax
    ret
seventhh:

    mov ah,0x0A
    mov al,0x00
    mov [es:di],ax
    mov [es:di+160],ax
    mov [es:di+320],ax
        ret
    
Start:
mov ax,0xb800
mov es,ax

call Clr

mov ah,0xA0
mov al,0x00
mov dx,8
mov di,500
L1:
mov [es:di],ax
add di,2
dec dx
jnz L1
call delayy
call delayy


mov dx,4
mov di,666
L2:
mov [es:di],ax
mov [es:di+2],ax
add di,160
dec dx
jnz L2
call delayy
call delayy

; ; ;-----------------------------------------------------------------
mov ah,0xC0



mov dx,8
mov di,518
L3:
mov [es:di],ax
add di,2
dec dx
jnz L3

call delayy
call delayy

mov dx,5
mov di,518
L4:
mov [es:di],ax
mov [es:di+2],ax
add di,160
dec dx
jnz L4

call delayy
call delayy

mov dx,5
mov di,1160
L5:
mov [es:di],ax
mov [es:di+2],ax
add di,2
dec dx
jnz L5

call delayy
call delayy


mov dx,6
mov di,838
L6:
mov [es:di],ax
mov [es:di+2],ax
add di,2
dec dx
jnz L6

call delayy
call delayy


; ; ;------------------------------------------------
mov ah,0x90
; mov [es:530],ax

mov dx,8
mov di,532
L7:
mov [es:di],ax
add di,2
dec dx
jnz L7
call delayy
call delayy
 

mov dx,4
mov di,698
L8:
mov [es:di],ax
mov [es:di+2],ax
add di,160
dec dx
jnz L8

call delayy
call delayy

; ;-------------------------------------------
mov ah,0x70
 


mov [es:550],ax
mov [es:552],ax
mov [es:554],ax
mov [es:556],ax
mov [es:558],ax
mov [es:560],ax
mov [es:562],ax
mov [es:564],ax
    call delayy
    call delayy

mov [es:724],ax
mov [es:722],ax
mov [es:884],ax
mov [es:882],ax
    call delayy
    call delayy

mov [es:1044],ax
mov [es:1042],ax
mov [es:1204],ax
mov [es:1202],ax
    call delayy
    call delayy

mov [es:880],ax
mov [es:878],ax
mov [es:876],ax
mov [es:874],ax
mov [es:872],ax
    call delayy
    call delayy

mov [es:552],ax
mov [es:550],ax
mov [es:712],ax
mov [es:710],ax
mov [es:872],ax
mov [es:870],ax
mov [es:1032],ax
mov [es:1030],ax
mov [es:1190],ax
mov [es:1192],ax
call delayy
call delayy

; ;-------------------------------------------
mov ah,0x60
mov [es:568],ax
mov [es:570],ax
mov [es:728],ax
mov [es:730],ax
mov [es:888],ax
mov [es:890],ax
mov [es:1048],ax
mov [es:1050],ax
mov [es:1208],ax
mov [es:1210],ax
call delayy
call delayy

;----------------------------------------
mov ah,0x50
mov [es:574],ax
mov [es:576],ax
mov [es:578],ax
mov [es:580],ax
mov [es:582],ax
mov [es:584],ax
    call delayy
    call delayy

mov [es:572+160+2],ax
mov [es:572+160+4],ax
mov [es:572+320+2],ax
mov [es:572+320+4],ax
    call delayy
    call delayy

mov [es:572+320+4+2],ax
mov [es:572+320+4+2+2],ax
mov [es:572+320+4+2+2+2],ax
mov [es:572+320+4+2+2+2+2],ax
mov [es:572+320+4+2+2+2+160],ax
mov [es:572+320+4+2+2+2+160+2],ax
mov [es:572+320+4+2+2+2+2+160+160],ax
mov [es:572+320+4+2+2+2+2+160+160-2],ax
mov [es:572+320+4+2+2+2+2+160+160-2-2],ax
mov [es:572+320+4+2+2+2+2+160+160-2-2-2],ax
mov [es:572+320+4+2+2+2+2+160+160-2-2-2-2],ax
mov [es:572+320+4+2+2+2+2+160+160-2-2-2-2-2],ax
    call delayy
    call delayy

    mov di,1232
    mov si,Game
    mov ah,0x0A
    Printtt9:
    mov al,[si]
    mov [es:di],ax
    call delayy
    add di,2
    inc si
    cmp byte[si],'*'
    jne Printtt9

mov di,1980
mov si,Made
mov ah,0x04
Printtt:
mov al,[si]
mov [es:di],ax
call delayy
add di,2
inc si
cmp byte[si],'*'
jne Printtt


mov di,2620
mov si,Startt
mov ah,0x97
Printttt:
mov al,[si]
mov [es:di],ax
call delayy
add di,2
inc si
cmp byte[si],'*'
jne Printttt

mov ah,0
int 0x16
cmp al,0x31
jne End
;********************************************************************************************************
call ClearScreen
call ScreenEnd ;Borders
call PrintScoreTimeLives
;********************************************************************************************************

InLoop:
call PrintShapes
call AboveChecking
cmp byte[boolGameEnd],1
je End

add byte[Variable1],1
cmp byte[Variable1],8
jne InLoop

mov byte[Variable1],1
jmp InLoop

;**********************************************************************************************************
End:
call Clr
mov di,850
mov si,Over
mov ah,0x04
Printtt1:
mov al,[si]
mov [es:di],ax
call delayy
add di,2
inc si
cmp byte[si],'*'
jne Printtt1

mov di,1170
mov si,Score
mov ah,0x97
Printtt2:
mov al,[si]
mov [es:di],ax
call delayy
add di,2
inc si
cmp byte[si],'*'
jne Printtt2

mov al,[ScoreVar]
mov ah,0x00
push ax
call printNum

mov ax,0x4c00
mov ah,0x1
int 0x21