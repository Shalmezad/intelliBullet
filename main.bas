	REM
	REM Intellivision bullet hell
	REM Create by Shalmezad
	REM
 
	REM ------------------------------------
	REM            GAME CONFIGURATION 
	REM ------------------------------------
	REM Adjust these to change the game:

	REM How many frames until the bullets move
	REM NOTE: If I add difficulty, this will no longer be a constant
CONST BULLET_UPDATE_DELAY=18 



	REM Set up state variables
CONST PRE_MENU_STATE=0
CONST MENU_STATE=1
CONST PRE_GAME_STATE=2
CONST GAME_STATE=3
CURRENT_STATE=PRE_MENU_STATE
  
	REM ------------------------------------
	REM            GAME LOOP 
	REM ------------------------------------

loop:	WAIT
	'Pre menu state
	IF (CURRENT_STATE=PRE_MENU_STATE) THEN
		GOSUB menu_state_init
		CURRENT_STATE=MENU_STATE
	END IF
	'Menu state
	IF (CURRENT_STATE=MENU_STATE) THEN 
		GOSUB render_flash_text
	END IF
	'Pre game state
	IF (CURRENT_STATE=PRE_GAME_STATE) THEN 
		GOSUB game_state_init
		CURRENT_STATE=GAME_STATE
	END IF
	'Game state
	IF (CURRENT_STATE=GAME_STATE) THEN
		IF (FRAME AND 2) AND LIVES > 0 THEN
			GOSUB update_player
		END IF
		IF (FRAME % BULLET_UPDATE_DELAY = 0) THEN
			GOSUB update_bullets
		END IF
		IF (LIVES=0) AND cont1.button THEN
			CURRENT_STATE=PRE_MENU_STATE
		END IF
	END IF
	GOTO loop


INCLUDE menu_state.bas
INCLUDE game_state.bas
