﻿; The top gear of the car
global TopGear
IniRead, TopGear, settings.ini, settings, TopGear
; How far the clutch needs to be pressed in order to shift gears
global ClutchBitePoint
IniRead, ClutchBitePoint, settings.ini, settings, ClutchBitePoint
; The delay between key presses in milliseconds
global Delay
IniRead, Delay, settings.ini, settings, Delay
; The gear the car starts in when spawned
global DefaultGear
IniRead, DefaultGear, settings.ini, settings, DefaultGear
; Whether or not the car can be set to neutral
global NeutralSkip
IniRead, NeutralSkip, settings.ini, settings, NeutralSkip
; Tool tip flag
global ToolTipOn
IniRead, ToolTipOn, settings.ini, settings, ToolTipOn

; Shift up key
global ShiftUpKey
IniRead, ShiftUpKey, settings.ini, keys, ShiftUpKey
; Shift down key
global ShiftDownKey
IniRead, ShiftDownKey, settings.ini, keys, ShiftDownKey
; Top gear set key
IniRead, TopGearSetKey, settings.ini, keys, TopGearSetKey
Hotkey, %TopGearSetKey%, SetTopGear
; Gear sync key
IniRead, GearSyncKey, settings.ini, keys, GearSyncKey
Hotkey, %GearSyncKey%, SyncGears
; Delay increase key
IniRead, DelayIncreaseKey, settings.ini, keys, DelayIncreaseKey
Hotkey, %DelayIncreaseKey%, DelayIncrease
; Delay decrease key
IniRead, DelayDecreaseKey, settings.ini, keys, DelayDecreaseKey
Hotkey, %DelayDecreaseKey%, DelayDecrease

; The gear the car is in
global Gear = DefaultGear
; Neutral flags for resetting the car into neutral after a race
global CarIsInNeutralFlag1 = 1
global CarIsInNeutralFlag2 = 1

DisplayToolTip()

#Persistent
SetTimer, WatchAxis, 5
if(DefaultGear == 0)
	SetTimer, ResetToNeutral, 1000
return

; Updates clutch position
WatchAxis:
GetKeyState, Clutch, JoyU
return

; Resets gears to neutral
ResetToNeutral:
CarIsInNeutralCheck()
if (CarIsInNeutralFlag1 == 1) && (CarIsInNeutralFlag2 == 1) && (Gear != 0) {
	Shift(0, 0)
	;SoundBeep, 750, 200
}
CarIsInNeutralFlag2 := CarIsInNeutralFlag1
return

; Set top gear
SetTopGear:
if GetKeyState("Joy9") 
	TopGear = 1
if GetKeyState("Joy10") 
	TopGear = 2
if GetKeyState("Joy11") 
	TopGear = 3
if GetKeyState("Joy12") 
	TopGear = 4
if GetKeyState("Joy13") 
	TopGear = 5
if GetKeyState("Joy14") 
	TopGear = 6
DisplayToolTip()
return

; Sync internal gear and in-game gear
SyncGears:
Loop {
	Press(ShiftUpKey)
	if (Gear < TopGear)
		Gear++
	if (A_Index == TopGear) {
		DisplayToolTip()
		break
	}
}
if GetKeyState("Joy9")
	Shift(1, 0)
else if GetKeyState("Joy10")
	Shift(2, 0)
else if GetKeyState("Joy11")
	Shift(3, 0)
else if GetKeyState("Joy12")
	Shift(4, 0)
else if GetKeyState("Joy13")
	Shift(5, 0)
else if GetKeyState("Joy14")
	Shift(6, 0)
else if GetKeyState("Joy15")
	Shift(-1, 0)
else
	Shift(0, 0)
return

; Increase the delay between key presses
DelayIncrease:
Delay += 5
DisplayToolTip()
return

; Increase the delay between key presses
DelayDecrease:
Delay -= 5
DisplayToolTip()
return

; 1st gear
Joy9::
Shift(1, Clutch)
return

; 2nd gear
Joy10::
Shift(2, Clutch)
return

; 3rd gear
Joy11::
Shift(3, Clutch)
return

; 4th gear
Joy12::
Shift(4, Clutch)
return

; 5th gear
Joy13::
Shift(5, Clutch)
return

; 6th gear
Joy14::
Shift(6, Clutch)
return

; Reverse gear
Joy15::
Shift(-1, Clutch)
return

; Shift function
Shift(n, Clutch){
	if (Clutch < ClutchBitePoint) && (n <= TopGear) {
		n := n - Gear
		; If shifting up
		if (n > 0) {
			; Shift up n times
			Loop {
				Press(ShiftUpKey)
				Gear++
				if (A_Index == n) {
					DisplayToolTip()
					break
				}
			}
		} 
		; If shifting down
		else if (n < 0)	{
			; Shift down n times
			Loop {
				Press(ShiftDownKey)
				Gear--
				if (A_Index == -n) {
					DisplayToolTip()
					break
				}
			}
		}
	}
	return
}

; Press button function
Press(button){
	SendInput, {%button% down}
	Sleep %Delay%
	SendInput, {%button% up}
	Sleep %Delay%
	return
}

; Display debug tool tip function
DisplayToolTip(){
	if ToolTipOn
		ToolTip, Gear: %Gear%`nTop Gear: %TopGear%`nDelay: %Delay%ms`nClutchBitePoint: %ClutchBitePoint%`nShiftUpKey: %ShiftUpKey%`nShiftDownKey: %ShiftDownKey%`nDefaultGear: %DefaultGear%
}

; Neutral check function
CarIsInNeutralCheck(){
	if GetKeyState("Joy9") || GetKeyState("Joy10") || GetKeyState("Joy11") || GetKeyState("Joy12") || GetKeyState("Joy13") || GetKeyState("Joy14") || GetKeyState("Joy15")
		CarIsInNeutralFlag1 = 0
	else
		CarIsInNeutralFlag1 = 1
}