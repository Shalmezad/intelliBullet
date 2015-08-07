	REM
	REM Intellivision bullet hell
	REM Create by Shalmezad
	REM

GOSUB game_state_init
  
	REM ------------------------------------
	REM            GAME LOOP 
	REM ------------------------------------

loop:	WAIT
	IF (FRAME AND 2) AND LIVES>0 THEN GOSUB update_player
	IF FRAME % 18 = 0 THEN GOSUB update_bullets
	GOTO loop


INCLUDE menu_state.bas
INCLUDE game_state.bas
