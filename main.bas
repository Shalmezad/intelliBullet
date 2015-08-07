	REM
	REM Intellivision bullet hell
	REM Create by Shalmezad
	REM

	REM Set up state variables
PRE_MENU_STATE=0
MENU_STATE=1
PRE_GAME_STATE=2
GAME_STATE=3
CURRENT_STATE=PRE_MENU_STATE
  
	REM ------------------------------------
	REM            GAME LOOP 
	REM ------------------------------------

loop:	WAIT
	'Pre menu state
	IF (CURRENT_STATE=PRE_MENU_STATE) THEN GOSUB menu_state_init
	IF (CURRENT_STATE=PRE_MENU_STATE) THEN CURRENT_STATE=MENU_STATE
	'Menu state
	IF (CURRENT_STATE=MENU_STATE) THEN GOSUB render_flash_text
	'Pre game state
	IF (CURRENT_STATE=PRE_GAME_STATE) THEN GOSUB game_state_init
	IF (CURRENT_STATE=PRE_GAME_STATE) THEN CURRENT_STATE=GAME_STATE
	'Game state
	IF (CURRENT_STATE=GAME_STATE) AND (FRAME AND 2) AND LIVES>0 THEN GOSUB update_player
	IF (CURRENT_STATE=GAME_STATE) AND FRAME % 18 = 0 THEN GOSUB update_bullets
	GOTO loop


INCLUDE menu_state.bas
INCLUDE game_state.bas
