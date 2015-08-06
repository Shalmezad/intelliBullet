	REM
	REM Intellivision bullet hell
	REM Create by Shalmezad
	REM

	REM ------------------------------------
	REM           GLOBAL VARIABLES 
	REM ------------------------------------
	REM Player position
	Y = 2
	REM Score
	#SCORE=0
	REM Bullet lines:
	REM So, the screen is 20x12
	REM We're going to limit to 8 rows
	REM That way, we can use a single 8-bit variable to store the lines:
	REM May consider using 16-bit if I have time for more bullet types
	REM Temporarily using preset values to test parsing
	DIM LINES(19)
	FOR A=0 TO 18
		LINES(A)=&00000000
	NEXT A

	REM ------------------------------------
	REM            PRE RENDER
	REM ------------------------------------
	GOSUB render_borders
	GOSUB render_bullets
	GOSUB render_first_col
	GOSUB render_score
  
	REM ------------------------------------
	REM            GAME LOOP 
	REM ------------------------------------

loop:	WAIT
	IF FRAME AND 2 THEN GOSUB update_player
	IF FRAME % 8 = 0 THEN GOSUB update_bullets
	GOTO loop

	REM ------------------------------------
	REM           UPDATE METHODS
	REM ------------------------------------

update_player:	PROCEDURE
	REM Now the fun part....
	REM If up, and we're not at the top, go up:
	IF cont1.up THEN IF Y>2 THEN Y=Y-1
	IF cont1.down THEN IF Y<9 THEN Y=Y+1
	GOSUB render_first_col
	END

update_bullets:	PROCEDURE
	FOR A=0 TO 17
		LINES(A)=LINES(A+1)
	NEXT A
	LINES(18) = RAND
	#SCORE = #SCORE + 1
	
	GOSUB render_first_col
	GOSUB render_bullets
	GOSUB render_score
	END

	REM ------------------------------------
	REM           RENDER METHODS
	REM ------------------------------------

render_borders:	PROCEDURE
	PRINT AT 20 COLOR 7, "--------------------"
	PRINT AT 200 COLOR 7, "--------------------"
	END

render_bullets:	PROCEDURE
	FOR A=1 TO 18
	  IF (LINES(A) AND &10000000)>0 THEN PRINT AT 40+20*0 + A COLOR 2, "*" ELSE PRINT AT 40+20*0+A, " "
	  IF (LINES(A) AND &01000000)>0 THEN PRINT AT 40+20*1 + A COLOR 2, "*" ELSE PRINT AT 40+20*1+A, " "
	  IF (LINES(A) AND &00100000)>0 THEN PRINT AT 40+20*2 + A COLOR 2, "*" ELSE PRINT AT 40+20*2+A, " "
	  IF (LINES(A) AND &00010000)>0 THEN PRINT AT 40+20*3 + A COLOR 2, "*" ELSE PRINT AT 40+20*3+A, " "
	  IF (LINES(A) AND &00001000)>0 THEN PRINT AT 40+20*4 + A COLOR 2, "*" ELSE PRINT AT 40+20*4+A, " "
	  IF (LINES(A) AND &00000100)>0 THEN PRINT AT 40+20*5 + A COLOR 2, "*" ELSE PRINT AT 40+20*5+A, " "
	  IF (LINES(A) AND &00000010)>0 THEN PRINT AT 40+20*6 + A COLOR 2, "*" ELSE PRINT AT 40+20*6+A, " "
	  IF (LINES(A) AND &00000001)>0 THEN PRINT AT 40+20*7 + A COLOR 2, "*" ELSE PRINT AT 40+20*7+A, " "
	NEXT A
	END

render_score:	PROCEDURE
	PRINT AT 0 COLOR 7,"Score: "
  FOR A=0 TO 5
    #PLACE=1
    B=0
    ' Had for B=0 TO A, but it always ran at least once. 
    WHILE B< A
      #PLACE = #PLACE * 10
      B=B+1
    WEND
    ' So apparently, if you try printing a number, it prints based on a character chart. 
    ' Hence the +16)*8+6. Makes more sense now.
    PRINT AT 15-A, (#SCORE/#PLACE%10+16)*8+6
  NEXT A
	END

render_first_col:	PROCEDURE
	IF (LINES(0) AND &10000000)>0 THEN PRINT AT 40+20*0 COLOR 2, "*" ELSE PRINT AT 40+20*0 , " "
	IF (LINES(0) AND &01000000)>0 THEN PRINT AT 40+20*1 COLOR 2, "*" ELSE PRINT AT 40+20*1 , " "
	IF (LINES(0) AND &00100000)>0 THEN PRINT AT 40+20*2 COLOR 2, "*" ELSE PRINT AT 40+20*2 , " "
	IF (LINES(0) AND &00010000)>0 THEN PRINT AT 40+20*3 COLOR 2, "*" ELSE PRINT AT 40+20*3 , " "
	IF (LINES(0) AND &00001000)>0 THEN PRINT AT 40+20*4 COLOR 2, "*" ELSE PRINT AT 40+20*4 , " "
	IF (LINES(0) AND &00000100)>0 THEN PRINT AT 40+20*5 COLOR 2, "*" ELSE PRINT AT 40+20*5 , " "
	IF (LINES(0) AND &00000010)>0 THEN PRINT AT 40+20*6 COLOR 2, "*" ELSE PRINT AT 40+20*6 , " "
	IF (LINES(0) AND &00000001)>0 THEN PRINT AT 40+20*7 COLOR 2, "*" ELSE PRINT AT 40+20*7 , " "
	PRINT AT 20*(Y-1) COLOR 5, "\97"
	PRINT AT 20*Y     COLOR 6, ">"
	PRINT AT 20*(Y+1) COLOR 5, "\99"
	END
