5 rem version 0.9
10 print chr$(147)
20 rem print "generated with spritemate"
30 poke 53280,0:poke 53281,0
31 p1=0:p2=0:mx=180:my=200
32 up=5:do=-5
35 v=53248:xp = 180:yp = 200:xd = up:yd = 5:xo = 0:ly = 80:ry=80
36 poke v+16,0
40 poke 53285,8: rem multicolor 1
50 poke 53286,6: rem multicolor 2
60 poke 53269,255 : rem set all 8 sprites visible
70 for x=12800 to 12800+63: read y: poke x,y: next x: rem 0 sprite generation
75 for x=12864 to 12864+63: read y: poke x,y: next x: rem 1 sprite generation
76 for x=12928 to 12928+63: read y: poke x,y: next x: rem 2 sprite generation
80 :: rem sprite 0
90 poke 53287,1: rem color = 1
100 poke 2040,200: rem pointer
110 poke 53248, xp: rem x pos
120 poke 53249, yp: rem y pos
130 poke 53276, 0: rem multicolor
140 poke 53277, 0: rem width
150 poke 53271, 0: rem height

160 poke v+16,4

189 poke 2041,201: rem pointer left paddle
190 poke 53288, 6: rem color = 2
110 poke 53250, 16: rem x pos
120 poke 53251, ly: rem y pos


210 rem poke v+16,4
289 poke 2042,202: rem pointer right paddle
290 poke 53289, 8: rem color = 2
210 poke 53252, 72: rem x pos
220 poke 53253, ry: rem y pos


280 print chr$(147);chr$(158);chr$(17);"player 1:";p1;"          player 2:";p2
281 print"":for c = 0 to 39: print chr$(197);: next c
282 for c = 0 to 8: printchr$(13): next c
283 for c = 0 to 39: print chr$(197);: next c


290 xp = xp + xd:yp = yp + yd
291 ce=yp+10

300 j=peek(56320):k=peek(56321): rem if j=127 then 300
305 print peek(56321)" "k
301 rem if j=123 then print"hello1";
302 rem if j=119 then print"hello2";
303 if j=125 then 700; rem down
304 if j=118 then 750; rem up
305 if k=253 then 800; rem down
306 if k=254 then 850; rem up
307 rem if j=111 then print"hello6";
308 rem if j=123 then print"hello7";

310 rem finished joystick p1

356 rem print xp
357 rem print yp


358 rem nothing
360 yb=ly+21:
361 rem 
365 if (xp>68 and xo=1 and xd>0) then 600;
366 rem
367 if xp>=254 and xd>0 and xo=0 then 610;
368 if xp<0 and xd<1 and xo=1 then 620;
369 rem print " xp"xp" xo"xo" ly"ly" ce"ce" yb"yb

370 if xp<17 and xo=0 and ly<=ce and yb >=ce then 500;
374 if xp<9 and xo=0 then 910;


377 rem nothing
378 if yp<66 then 550;
379 if yp>215 then 650;
380 rem nothing 
390 poke 53248, xp
395 poke 53249, yp
396 poke 53251, ly: poke 53253, ry: rem move paddle
400 goto 290

500 xd = up
501 xp = xp + xd
502 rem print "here"
505 goto 358

600 xd = do
601 xp = xp + xd
602 rem print"400"
605 goto 366

610 poke v+16,5
611 xp=0
612 xo=1
613 rem print"410"
615 goto 377

620 poke v+16,4
621 xp=254
622 xo=0
623 rem print"420"
625 goto 377

550 yd = up
551 yp = yp + yd
555 goto 358

650 yd = do
651 yp = yp + yd
655 goto 358


700 ly = ly + (up*2)
701 if ly>208 then 706;
705 goto 310
706 ly = 208: goto 310


750 ly = ly + (do*2)
751 if ly<76 then 756;
755 goto 310
756 ly = 76:goto 310


800 ry = ry + (up*2)
801 if ry>208 then 806;
805 goto 310
806 ry = 208: goto 310


850 ry = ry + (do*2)
851 if ry<76 then 856;
855 goto 310
856 ry = 76:goto 310

900 print "hello"

910 p2=p2+1
911 xp=mx:yp=my
912 poke 53280,1:poke 53281,1
913 poke 53280,0:poke 53281,0
915 goto 280

1000 :: rem sprite 1 / singlecolor / color: 2
1010 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
1020 data 0,0,0,0,0,0,24,0,0,126,0,0,126,0,0,255
1030 data 0,0,255,0,0,126,0,0,126,0,0,24,0,0,0,0
1040 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1

2010 data 0,255,0,0,255,0,0,255,0,0,255,0,0,255,0,0
2020 data 255,0,0,255,0,0,255,0,0,255,0,0,255,0,0,255
2030 data 0,0,255,0,0,255,0,0,255,0,0,255,0,0,255,0
2040 data 0,255,0,0,255,0,0,255,0,0,255,0,0,255,0,1


3010 data 0,255,0,0,255,0,0,255,0,0,255,0,0,255,0,0
3020 data 255,0,0,255,0,0,255,0,0,255,0,0,255,0,0,255
3030 data 0,0,255,0,0,255,0,0,255,0,0,255,0,0,255,0
3040 data 0,255,0,0,255,0,0,255,0,0,255,0,0,255,0,1