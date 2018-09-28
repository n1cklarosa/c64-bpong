
!cpu 6502
!to "build/apong.prg",cbm

; load external binaries

address_sprites = $2000	  ;loading address for my sprite
address_sprite1 = $2040	  ;loading address for my sprite 1
address_sprite2 = $2080	  ;loading address for my sprite 2

 	
* = $0801                               ; BASIC start address (#2049)
!byte $0d,$08,$dc,$07,$9e,$20,$34,$39   ; BASIC loader to start at $c000...
!byte $31,$35,$32,$00,$00,$00           ; puts BASIC line 2012 SYS 49152

* = $c000     ; start_address were all the assembled 
			  ; code will be consecutively written to



;helpful labels
clear = $E544
GETIN  =  $FFE4
SCNKEY =  $FF9F

ENTER	= $C202
MOVE	= $C203
;sprite 0 setup
sprite0 = $7F8
sprite1 = $7F9
sprite2 = $7FA
color0  = $D027
color1  = $D028
color2  = $D029
SP0X	= $D000
SP0Y	= $D001
SP1X	= $D002
SP1Y	= $D003
SP2X	= $D004
SP2Y	= $D005
MSBX	= $D010
SP0VAL	= $0340


ONE = $C008 ; one test
YDIR = $C009 ; one test
TWO = $C00A ; one test
XDIR = $C006 ; one test

P1 = $C00B
P2 = $C00D

enable  = $D015
YEXPAND	= $D017
XEXPAND	= $D01D


screen_ram      = $0400     ; location of screen ram
delay_counter   = $90       ; used to time color switch in the border
pra             = $dc00     ; CIA#1 (Port Register A)
prb             = $dc01     ; CIA#1 (Port Register B)
ddra            = $dc02     ; CIA#1 (Data Direction Register A)
ddrb            = $dc03     ; CIA#1 (Data Direction Register B)



						jsr clear

						lda #$30
						sta ONE

						lda #$30
						sta TWO

						lda #$01
						sta YDIR

						ldx #$01
						stx XDIR 

						;lda #$04 ; setup collision detection interupt
						;sta $D01A


						lda #$86 ; set background color
						sta $D021

						lda #$80 ; set border color
						sta $D020

						jsr clear

						lda #$01 ; trying to change text color
						sta $0287


init_text   			ldx #$00         ; init X register with $00
loop_text1  			lda line1,x    ; read characters from line1 table of text...
           				sta $0400,x      ; ...and store in screen ram near the center;

            			inx 
            			cpx #$28         ; finished when all 40 cols of a line are processed
            			bne loop_text1    ; loop if we are not done yet


						lda ONE
						sta $0409
						ldx TWO
						stx $0426

!source "sprites/sprite_setup.asm" 

						sei 


loop 					lda #$fb ;wait for vertical retrace
loop2					cmp $d012 ; until it reaches 125 raster line ($fb)
						bne loop2 ; which is out of the inner screen area
 						jsr check_y
 						;jmp move_ball_right
nextloop				jsr check_x
joystick_loop			jsr joystick
joystick_loop1			jsr joystick_p2
middle					jsr check_collision
raster					lda $d012
loop3   				cmp $d012 ; the next raster line so next time we
        				beq loop3 ; should catch the same line next frame
        				jmp loop
						brk
check_collision
						ldy $D01E
						cpy #%00000101
						beq jump_to_move_ball_right2
						cpy #%00000110
						beq jump_to_move_ball_left2
						jmp raster

jump_to_move_ball_left2
	jmp move_ball_left2
jump_to_move_ball_right2
	jmp move_ball_right2


center_ball				lda #%00000010
						sta MSBX
						lda #$83  
						sta SP2X  ; Set X coordinate for sprite12  
						lda #$64
						sta SP2Y
						jmp middle

check_x ;  X AXIS BALL TEST
					    lda SP2X
						cmp #$FF
						beq jump_test_direction_going_across_boarder
					    lda SP2X
						cmp #$46
						beq jump_to_test_rebound
rebound_finished 		lda SP2X
						cmp #$00
						beq jump_test_direction_going_across_boarder
						ldx SP2X
						cpx #$0B
						beq jump_to_test_left_to_right
finish_screen			lda #$00
						cmp XDIR
						beq jump_to_move_ball_left   
						lda #$01
						cmp XDIR
						beq move_ball_right
					    jmp middle

jump_to_test_left_to_right
	jmp test_left_to_right

jump_to_jump_to_move_ball_left
	jmp jump_to_move_ball_left
jump_to_test_rebound
	jmp test_rebound
	
jump_test_direction_going_across_boarder
	jmp test_direction_going_across_boarder
jump_to_move_ball_left
	jmp move_ball_left

joystick
up      				lda #$01 ; mask joystick up movement 
				        bit $dc01      ; bitwise AND with address 56320
				        bne down       ; zero flag is not set -> skip to down
				        lda #$3C
				        cmp SP0Y
				        bcs jump_to_joystick_loop1
				        dec SP0Y      ; decrement p1 y axis
				        dec SP0Y      ; border color + 1

down   					lda #$02 ; mask joystick down movement 
				        bit $dc01      ; bitwise AND with address 56320
				        bne jump_to_joystick_loop1       ; zero flag is not set -> skip to left
				        lda #$BE
				        cmp SP0Y
				        bcc jump_to_joystick_loop1
						inc SP0Y      ; incremente y axis
						inc SP0Y      ; incremente y axis
						rts

jump_to_joystick_loop1
	jmp joystick_loop1

joystick_p2
up2      				lda #$01 ; mask joystick up movement 
				        bit $dc00      ; bitwise AND with address 56320
				        bne down2       ; zero flag is not set -> skip to down
				        lda #$3C
				        cmp SP1Y
				        bcs jump_to_middle
				        dec SP1Y      ; decrement p1 y axis
				        dec SP1Y      ; border color + 1

down2   				lda #$02 ; mask joystick down movement 
				        bit $dc00      ; bitwise AND with address 56320
				        bne jump_to_middle       ; zero flag is not set -> skip to left
				        lda #$BE
				        cmp SP1Y
				        bcc jump_to_middle
						inc SP1Y      ; incremente y axis
						inc SP1Y      ; incremente y axis
						rts

jump_to_middle
	jmp middle

move_ball_left2 
						ldx #$00
						stx XDIR
						jmp move_ball_left	

move_ball_right2
						ldx #$01
						stx XDIR
						jmp move_ball_right	
move_ball_right 
						inc SP2X
						inc SP2X
						jmp joystick_loop

test_rebound
						lda #$06
						cmp MSBX
						beq test_rebound_2
						jmp test_rebound_3

test_direction_going_across_boarder
						lda #$00
						cmp XDIR
						beq cross_right_to_left 
						lda #$01
						cmp XDIR
						beq cross_left_to_right 
						jmp finish_screen


test_left_to_right
						lda #$06
						cmp MSBX
						beq test_left_to_right_2 
						jmp test_left_to_right_3

move_ball_left
						inc SP2X
						jmp joystick_loop

test_rebound_2 ; if on right side of screen
						lda #$01
						cmp XDIR
						beq score_for_player_1 
						jmp move_ball_right2

score_for_player_1
	inc ONE
	lda ONE
	sta $0409
	jmp center_ball

test_rebound_3 ; if on left side of screen
						lda #$00
						cmp XDIR
						beq move_ball_left2 
						jmp move_ball_right2

test_left_to_right_2
						lda #$00
						cmp XDIR
						beq move_ball_left2 
						jmp move_ball_right2
test_left_to_right_3
						lda #$01
						cmp XDIR
						beq move_ball_left2 
						inc TWO
						lda TWO
						sta $0426
						jmp center_ball
cross_right_to_left
						lda #$02
						sta MSBX
						lda #$FF
						sta SP2X
						jmp move_ball_left2

cross_left_to_right
						lda #$06
						sta MSBX
						lda #$00
						sta SP2X
						jmp move_ball_right2

check_y  ;  Y AXIS BALL TEST
					    ldy SP2Y
						cpy #$E6
						beq move_ball_up2
			 			ldy SP2Y
						cpy #$3C
						beq move_ball_down2
						lda #$00
						cmp YDIR
						beq move_ball_up
						lda #$01
						cmp YDIR
						beq move_ball_down
						jmp nextloop 
move_ball_down  
						inc SP2Y
						inc SP2Y
						;sty SP1Y ; to keep player 2 alive
						jmp nextloop 

move_ball_down2
						lda #$01
						sta YDIR
						jmp move_ball_down 
	

move_ball_up  
						dec SP2Y
						dec SP2Y
						;sty SP1Y
						jmp nextloop 

move_ball_up2
						lda #$00
						sta YDIR
						jmp move_ball_up 

loop_text 				txa
				        jsr $FFD2
				        inx
				        cpx #$5B
				        bne loop_text
				        rts

load_sprite
						lda sprite_1,x
						sta address_sprites,x
						inx
						cpx #$40
						bne load_sprite
						rts

load_sprite1
						lda sprite_1,x
						sta address_sprite1,x
						inx
						cpx #$40
						bne load_sprite1
						rts


load_sprite2
						lda sprite_2,x
						sta address_sprite2,x
						inx
						cpx #$40
						bne load_sprite2
						rts




line1            !scr "player 1                     player 2    "

sprite_1
	!byte $fc,$00,$00,$fc,$00,$00,$fc,$00
	!byte $00,$fc,$00,$00,$fc,$00,$00,$fc
	!byte $00,$00,$fc,$00,$00,$fc,$00,$00
	!byte $fc,$00,$00,$fc,$00,$00,$fc,$00
	!byte $00,$fc,$00,$00,$fc,$00,$00,$fc
	!byte $00,$00,$fc,$00,$00,$fc,$00,$00
	!byte $fc,$00,$00,$fc,$00,$00,$fc,$00
	!byte $00,$fc,$00,$00,$fc,$00,$00,$04

sprite_2
	!byte $00,$00,$00,$00,$00,$00,$00,$00
	!byte $00,$00,$00,$00,$00,$18,$00,$00
	!byte $7e,$00,$00,$ff,$00,$01,$ff,$80
	!byte $01,$ff,$80,$03,$ff,$c0,$03,$ff
	!byte $c0,$01,$ff,$80,$01,$ff,$80,$00
	!byte $ff,$00,$00,$7e,$00,$00,$18,$00
	!byte $00,$00,$00,$00,$00,$00,$00,$00
	!byte $00,$00,$00,$00,$00,$00,$00,$01