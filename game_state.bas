DEF FN bulletPos(x,y)=(40+20*y+x)
	REM ------------------------------------
	REM             STATE INIT 
	REM ------------------------------------
game_state_init:	PROCEDURE
	REM Player position
	X = 2
	Y = 2
	REM Player's last position
	REM Necessary for rerendering where they were:
	OLD_X = 2
	OLD_Y = 2
	REM Fake ship position
	REM This is a variable to help guarantee a path for the player:
	FAKE_Y = 2
	REM Score
	#SCORE=0
	REM Movement lock
	REM Turns to 1 after rendering press
	REM Turns to 0 if no press
	REM Will lock movement until user releases both buttons:
	MOVEMENT_LOCK=0

	REM Bullet lines:
	REM So, the screen is 20x12
	REM We're going to limit to 8 rows
	REM That way, we can use a single 8-bit variable to store the lines:
	REM May consider using 16-bit if I have time for more bullet types
	REM Temporarily using preset values to test parsing
	DIM LINES(19)
	FOR A=0 TO 19
		LINES(A)=&00000000
	NEXT A
	REM # of lives
	LIVES=3

	GOSUB game_state_prerender
	END

game_state_prerender:	PROCEDURE
	GOSUB render_borders
	GOSUB render_bullets
	'Rendering bullets renders the line the player's on. No need to call render_player_col
	GOSUB render_score
	GOSUB render_lives
	END

	REM ------------------------------------
	REM           UPDATE METHODS
	REM ------------------------------------

REM Checks collision between the main bullet line and the player
check_collision:	PROCEDURE
	COLLISION=0
	BITMASK = &10000000
	FOR B=2 TO 9
		IF Y = B THEN COLLISION=(LINES(X) AND BITMASK)
		BITMASK = BITMASK / 2
	NEXT B
	IF ((COLLISION > 0) AND (LIVES > 0)) THEN GOSUB kill_player
	END

REM Player was hit, take a life
kill_player:	PROCEDURE
	LIVES = LIVES - 1
	FOR A=0 TO 19
		LINES(A)=&00000000
	NEXT A

	GOSUB render_bullets
	GOSUB render_lives

	END

update_player:	PROCEDURE
	REM Now the fun part....
	OLD_Y = Y
	REM If up, and we're not at the top, go up:
	IF cont1.up AND (NOT MOVEMENT_LOCK) THEN IF Y>2 THEN Y=Y-1
	REM If down, and we're not at the bottom, go down:
	IF cont1.down AND (NOT MOVEMENT_LOCK) THEN IF Y<9 THEN Y=Y+1
	REM If left, and we're not at the left-most, go left:
	IF cont1.left AND (NOT MOVEMENT_LOCK) THEN IF X > 0 THEN X=X-1
	REM If right, and we're not at the right-most, go right:
	IF cont1.right AND (NOT MOVEMENT_LOCK) THEN IF X < 17 THEN X=X+1

	REM Adjust the movement lock based on input:
	MOVEMENT_LOCK = cont1.up OR cont1.down OR cont1.left OR cont1.right
	IF NOT (Y = OLD_Y) THEN GOSUB check_collision
	IF NOT (Y = OLD_Y) THEN GOSUB render_player_col
	END

update_bullets:	PROCEDURE
	REM Shift all the lines
	FOR A=0 TO 18
		LINES(A)=LINES(A+1)
	NEXT A
	REM Generate a new line
	' LINES(19) = RAND AND (RAND XOR LINES(16))
	LINES(19) = RAND AND (NOT LINES(16))
	REM Add 1 to the score
	IF LIVES > 0 THEN #SCORE = #SCORE + 1
	REM Make our fake player position empty:
	BITMASK=&10000000
	FOR B=2 TO 9
		IF FAKE_Y = B THEN LINES(19)=(LINES(19) AND (NOT BITMASK))
		BITMASK = BITMASK / 2
	NEXT B

	REM Adjust our fake player (necessary to guarantee path)
	FAKE_SHIFT = RAND
	IF (FAKE_SHIFT AND &10000000)>0 THEN IF FAKE_Y > 2 THEN FAKE_Y=FAKE_Y-1
	IF (FAKE_SHIFT AND &01000000)>0 THEN IF FAKE_Y < 9 THEN FAKE_Y=FAKE_Y+1
	REM Make our fake player position empty:
	BITMASK=&10000000
	FOR B=2 TO 9
		IF FAKE_Y = B THEN LINES(19)=(LINES(19) AND (NOT BITMASK))
		BITMASK = BITMASK / 2
	NEXT B
	GOSUB check_collision
	GOSUB render_bullets 
	'Rendering bullets will also render the line the player's on. No need to check that
	GOSUB render_score
	END

	REM ------------------------------------
	REM           RENDER METHODS
	REM ------------------------------------
render_lives:	PROCEDURE
	PRINT AT 221 COLOR 3, "LIVES:           "
	FOR A=1 TO LIVES
		PRINT AT 227+A COLOR 3, ">"
	NEXT A
	IF LIVES=0 THEN PRINT AT 221 COLOR 3, "GAME OVER        "
	END

render_borders:	PROCEDURE
	PRINT AT 20 COLOR 3, "--------------------"
	PRINT AT 200 COLOR 3, "--------------------"
	END

render_bullets:	PROCEDURE
	FOR A=1 TO 19
		RENDER_LINE_PARAM_X = A
		GOSUB render_line
	NEXT A

	PRINT AT 19+20*FAKE_Y     COLOR 6, "<"
	END

render_score:	PROCEDURE
	PRINT AT 0 COLOR 3,"Score: "
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

REM NOTE: Set "RENDER_LINE_PARAM_X" before calling!
REM This method draws everything for a single line. Bullets, player, etc
render_line: PROCEDURE
	BITMASK=&10000000
	FOR B=0 TO 7
		IF (LINES(RENDER_LINE_PARAM_X) AND BITMASK)>0 THEN PRINT AT bulletPos(RENDER_LINE_PARAM_X,B) COLOR 2, "*" ELSE PRINT AT bulletPos(RENDER_LINE_PARAM_X,B) , " "
		BITMASK = BITMASK / 2
	NEXT B
	'PRINT AT 20*(Y-1) COLOR 5, "\97"
	IF (X=RENDER_LINE_PARAM_X) AND (LIVES > 0) THEN PRINT AT 20*Y+RENDER_LINE_PARAM_X     COLOR 6, ">"

	END

render_player_col:	PROCEDURE
	RENDER_LINE_PARAM_X = X
	GOSUB render_line
	END
