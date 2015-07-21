	REM
	REM Intellivision bullet hell
	REM Create by Shalmezad
	REM

	REM ------------------------------------
	REM           GLOBAL VARIABLES 
	REM ------------------------------------
	REM Player position
	Y = 2
	REM Bullet lines:
	REM So, the screen is 20x12
	REM We're going to limit to 8 rows
	REM That way, we can use a single 8-bit variable to store the lines:
	REM May consider using 16-bit if I have time for more bullet types
	REM Temporarily using preset values to test parsing
	DIM LINES(19)
	FOR A=8 TO 18
		LINES(A)=&10010011
	NEXT A
	LINES(0)=&11111111
	LINES(1)=&00000000
	LINES(2)=&10101010
	LINES(3)=&01010101
	LINES(4)=&10011001
	LINES(5)=&00111100
	LINES(6)=&01111110
	LINES(7)=&11100111
  
	REM ------------------------------------
	REM            GAME LOOP 
	REM ------------------------------------

loop:	WAIT
	IF FRAME AND 2 THEN GOSUB update
	GOSUB render
	GOTO loop

	REM ------------------------------------
	REM           UPDATE METHODS
	REM ------------------------------------
update:	PROCEDURE
	GOSUB update_player
	END

update_player:	PROCEDURE
	REM Now the fun part....
	REM If up, and we're not at the top, go up:
	IF cont1.up THEN IF Y>2 THEN Y=Y-1
	IF cont1.down THEN IF Y<9 THEN Y=Y+1
	END

	REM ------------------------------------
	REM           RENDER METHODS
	REM ------------------------------------

render:	PROCEDURE
	CLS
	GOSUB render_borders
	GOSUB render_bullets
	GOSUB render_player
	GOSUB render_score
	END

render_borders:	PROCEDURE
	PRINT AT 20, "--------------------"
	PRINT AT 200, "--------------------"
	END

render_bullets:	PROCEDURE
	FOR A=0 TO 18
	  IF (LINES(A) AND &10000000) THEN PRINT AT 40+20*0 + A + 1, "*"
	  IF (LINES(A) AND &01000000) THEN PRINT AT 40+20*1 + A + 1, "*"
	  IF (LINES(A) AND &00100000) THEN PRINT AT 40+20*2 + A + 1, "*"
	  IF (LINES(A) AND &00010000) THEN PRINT AT 40+20*3 + A + 1, "*"
	  IF (LINES(A) AND &00001000) THEN PRINT AT 40+20*4 + A + 1, "*"
	  IF (LINES(A) AND &00000100) THEN PRINT AT 40+20*5 + A + 1, "*"
	  IF (LINES(A) AND &00000010) THEN PRINT AT 40+20*6 + A + 1, "*"
	  IF (LINES(A) AND &00000001) THEN PRINT AT 40+20*7 + A + 1, "*"
	NEXT A
	END

render_score:	PROCEDURE
	PRINT AT 0,"Score: 0"
	END

render_player:	PROCEDURE
	REM Think I'm starting to get the hang of this
	REM It's 20 characters wide, 12 tall
	PRINT AT 20*Y COLOR 5,">"
	END
