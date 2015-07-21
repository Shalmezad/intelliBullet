	REM
	REM Intellivision bullet hell
	REM Create by Shalmezad
	REM

	Y = 1
	GOSUB render_score

loop:	WAIT
	REM if FRAME AND 1 THEN GOSUB update
	GOTO loop

	REM ------------------------------------
	REM           UPDATE METHODS
	REM ------------------------------------
update:	PROCEDURE
	REM GOSUB update_player
	END

	REM update_player:	PROCEDURE
	REM Now the fun part....
	REM If up, and we're not at the top, go up:
	REM END

	REM ------------------------------------
	REM           UPDATE METHODS
	REM ------------------------------------
render_score:	PROCEDURE
	print AT 0,"Score: 0"
	END

