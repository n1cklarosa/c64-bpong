
# Commodore 64 Pong in basic

I recently decided I would learn how to write basic scripts for my c64, with the ultimate goal of learning how assembler works. I figured a pong clone might be a good way to start and would be something other beginners might be interested in. I am completely new to coding for the C64 and welcome any feedback you have. You can find me on twitter [@commodorenow](https://twitter.com/commodore_now/) 

### Loading

Open the .d64 file in your chosen emulator or a real C64 using a real floppy, an SD2IEC or similar device.

From basic, type the following
```
load"*",8
```

or

```
load"bpong",8
```

### Version Info

1.1 Fixed Joystick bug (was using up-right rather than directly up). Tweaked my take on collision detection

1.0 Second player works

0.9 It is currently very crude and runs quite slow in basic. Im sure the code could be more efficient.

### todos

- [ ] Learn about Sprite collision and determine if it would work for his project
- [ ] Clean code and write up description of what I am trying to do
- [ ] Build an intro screen
- [ ] Allow for single or multiplayer
- [x] Enable 2nd player death
- [ ] move to assembler code