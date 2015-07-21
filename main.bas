	REM
	REM Intellivision bullet hell
	REM Create by Shalmezad
	REM

	Y = 1
	GOSUB render_score

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
	IF cont1.up THEN IF Y>1 THEN Y=Y-1
	IF cont.down THEN IF Y<11 THEN Y=Y+1
	END

	REM ------------------------------------
	REM           UPDATE METHODS
	REM ------------------------------------

render:	PROCEDURE
	GOSUB clear_screen
	GOSUB render_player
	GOSUB render_score
	END

clear_screen:	PROCEDURE
	REM Let's see, 20x12 is...
	REM 240
	PRINT AT 0,"                                                                                                                                                                                                                                                "
	END

render_score:	PROCEDURE
	PRINT AT 0,"Score: 0"
	END

render_player:	PROCEDURE
	REM Think I'm starting to get the hang of this
	REM It's 20 characters wide, 12 tall
	PRINT AT 20*Y COLOR 5,">"
	END
