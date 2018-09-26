
# Commodore 64 Pong in basic

I have been teaching myself to code for the c64. To begin with I have created a pong clone game in basic, and have recently started moving it over to assembler. I am completely new to coding for the C64 and welcome any feedback you have. You can find me on twitter [@commodore_now](https://twitter.com/commodore_now/) 

### Loading

To run the basic version. 

Option 1. simply paste the .bas file contents into the VICE emulator. I will update this readme with instructions for a real C64 when I have overcome and issue with saving .d64 files to git. (the .d64 file in the git will work on vice, but an SD2IEC PM me for a link that works)

Option 2. Mount the pongdisk.d64 file in vice, and load with the following command
```
load"bpong.prg",8,1
```
then type run when presented with "READY" 

To run the assbmler version. 

Option 1. To compile the assembler version, use the [ACME compiler](https://github.com/meonwax/acme) on apong.asm, it will create apong.prg in the build folder. Or load apong.prg from the repo.

Option 2. Mount the pongdisk.d64 file in vice, and load with the following
```
load"bpong.prg",8,1
```
then type run when presented with "READY" 



### Version Info

#### Basic 

1.1 Fixed Joystick bug (was using up-right rather than directly up). Tweaked my take on collision detection

1.0 Second player works

0.9 It is currently very crude and runs quite slow in basic. Im sure the code could be more efficient.

#### Assembler

0.1 First version ! Lots of bugs to go yet. 

### todos

- [x] Learn about Sprite collision and determine if it would work for his project
- [ ] Clean code and write up description of what I am trying to do
- [ ] Build an intro screen
- [x] Allow for single or multiplayer
- [x] Enable 2nd player death
- [x] move to assembler code
- [ ] improve assembler code