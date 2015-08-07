FLASH_TICK=40
	REM ------------------------------------
	REM             STATE INIT 
	REM ------------------------------------
menu_state_init:	PROCEDURE
	GOSUB menu_state_prerender
	END

menu_state_prerender:	PROCEDURE
	GOSUB render_menu
	END

	REM ------------------------------------
	REM           RENDER METHODS
	REM ------------------------------------

render_menu:	PROCEDURE
	PRINT AT 20 COLOR 3, "--------------------"
	PRINT AT 40 COLOR 3, "    IntelliBullet   "
	PRINT AT 60 COLOR 3, "     by shalmezad   "
	PRINT AT 200 COLOR 3, "--------------------"
	END

render_flash_text:	PROCEDURE
	FLASH_TICK = FLASH_TICK - 1
	IF FLASH_TICK <= 0 THEN FLASH_TICK = 40
	IF FLASH_TICK > 20 THEN PRINT AT 100 COLOR 3, "                    "
	IF FLASH_TICK <=20 THEN PRINT AT 100 COLOR 3, "    Press Button    "
	IF cont1.button THEN CURRENT_STATE=PRE_GAME_STATE
	END

