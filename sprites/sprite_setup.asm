



lda #$80 ; sprite 0 pointer
sta sprite0

lda #$81 ; sprite 1 pointer
sta sprite1

lda #$82 ; sprite 2 pointer
sta sprite2

lda #$07     ; enable Sprite#0 + 1
sta enable

lda #$1e  
sta SP0X  ; Set X coordinate for sprite0   
 
lda #$78
sta SP0Y   ; Set Y coordinate for sprite0



lda #$02 ; set sprite 1 to far right - x bit register
sta $D010


lda #$46  
sta SP1X  ; Set X coordinate for sprite1   
 
lda #$4d
sta SP1Y   ; Set Y coordinate for sprite1



lda #$BE  
sta SP2X  ; Set X coordinate for sprite12  
 
lda #$64
sta SP2Y   ; Set Y coordinate for sprite2



lda #$00     ; Sprite#0 has priority over background
sta $d01b


lda #$03 ; double sprite height for paddles
sta $D017



ldx #$00   ; SET X=0
jsr load_sprite

ldx #$00   ; SET X=0
jsr load_sprite1

ldx #$00   ; SET X=0
jsr load_sprite2




lda #$01     ; enable color
sta color0


lda #$01     ; enable color
sta color1


lda #$01     ; enable color
sta color2

