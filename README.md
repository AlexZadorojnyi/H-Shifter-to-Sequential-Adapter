H-Shifter to Sequential Adapter
==============

This is an AutoHotkey script to adapt an H-shifter for use in games that do not support it natively by emulating sequential shifting input.

About
--------------
This script translates the change in the position of the H-shifter into the appropriate number of upshift and downshift key strokes.

The clutch, or the combination of the clutch and the throttle, can also be used when shifting. This will require the user to press the clutch when changing gears or in the latter case to press the clutch and release the gas pedal.

This script is designed to work with any racing game that has a manual sequential transmission mode and was tested using a Logitech G27 racing wheel peripherals.

A few flaws are unavoidable with this solution. Namely the desynchronization of the H-shifter position and the in-game gear, and lost key strokes due to the game’s key polling rate. Both of these problems are addressed though the script’s features listed below.

Features
--------------
-	Translation of H-shifter position changes to sequential shifter key strokes.
-	Clutch and clutch + throttle shifting supported.
-	Limit the top gear of your vehicle without exiting the game. (Done to avoid gear desynchronization.)
-	Change the delay between sequential shifter key strokes without exiting the game. (Done to accommodate a game’s key polling rate.)
-	Settings are stored externally in an .ini file.

How to Use
--------------
-	Open the .ini file and configure the settings. Refer to the Logitech Profiler to find the numbers assigned to your controller's keys. Their names should be written in "Joy#" format in the settings.
-	Run either the .exe file OR the .ahk file from the same directory as the .ini file. (To run the .ahk file AutoHotkey must be installed.)
-	Launch and play the game.
-	To exit terminate the script right-click the icon in the notification area of the toolbar.
