H-Shifter to Sequential Adapter
==============

This is an AutoHotkey script to emulate the output of an H-shifter to that of a sequential shifter. This can be used to play video games that do not natively support H-shifter controllers.

About
--------------
This script monitors the position of the shifter and fires in-game upshift and downshift key strokes. For example, shifting from 4th to 2nd gear will fire two downshift key strokes.

Rudimentary use of the clutch pedal is also supported. The user can choose to have to press the clutch pedal in order to shift gears.

This script should work for any driving game which has a manual transmission mode. Tested with a Logitech G27 racing wheel controller.

This is not a perfect solution to this problem and there are flaws that cannot be eliminated. The in-game gear and the position of your shifter can become desynced through any situation where your vehicle is reset.

Features
--------------
- H-shifter to sequential shifter output conversion.
- Basic clutch support.
- Set the top gear of your vehicle in real time to avoid gear desync through shifting to gears non-existent in the game.
- Increase and decrease the delay between upshift / downshift key strokes in real time for optimal performance.
- Store your settings easily in a separate .ini file.

How To Use
--------------
- Open the .ini file and configure the settings. Refer to the Logitech Profiler to find the numbers assigned to your controller's keys. These should be written in "Joy#" format in the settings.
- Run either the .exe file OR the .ahk file from the same directory as the .ini file. To run the .ahk file AutoHotkey must be installed.
- Run the game.
- Exit from the script by right-clicking on the icon in the notification of the toolbar.