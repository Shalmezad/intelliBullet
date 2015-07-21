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
	DIM LINES(19)
  LINES(1)=&10010011

	REM ------------------------------------
	REM            GAME LOOP 
	REM ------------------------------------

loop:	WAIT
	IF FRAME AND 1 THEN GOSUB update
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
	GOSUB clear_screen
	GOSUB render_borders
	GOSUB render_bullets
	GOSUB render_player
	GOSUB render_score
	END

clear_screen:	PROCEDURE
	REM Let's see, 20x12 is...
	REM 240
	PRINT AT 0,"                                                                                                                                                                                                                                                "
	END

render_borders:	PROCEDURE
	PRINT AT 20, "--------------------"
	PRINT AT 200, "--------------------"
	END

render_bullets:	PROCEDURE
  IF (LINES(1) AND &10000000) THEN PRINT AT 41, "*"
	END

render_score:	PROCEDURE
	PRINT AT 0,"Score: 0"
	END

render_player:	PROCEDURE
	REM Think I'm starting to get the hang of this
	REM It's 20 characters wide, 12 tall
	PRINT AT 20*Y COLOR 5,">"
	END
