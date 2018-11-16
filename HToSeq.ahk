; The top gear of the car
global TopGear
IniRead, TopGear, Settings.ini, Settings, TopGear
; The gear the car starts in when spawned
global DefaultGear
IniRead, DefaultGear, Settings.ini, Settings, DefaultGear
; How far the clutch needs to be pressed in order to shift gears
global ClutchBitePoint
IniRead, ClutchBitePoint, Settings.ini, Settings, ClutchBitePoint
; How much the throttle needs to be released in order to shift gears
global ThrottleBitePoint
IniRead, ThrottleBitePoint, Settings.ini, Settings, ThrottleBitePoint
; The delay between key presses in milliseconds
global Delay
IniRead, Delay, Settings.ini, Settings, Delay
; Whether or not the car can be set to neutral
global NeutralSkip
IniRead, NeutralSkip, Settings.ini, Settings, NeutralSkip
; Tool tip flag
global ToolTipOn
IniRead, ToolTipOn, Settings.ini, Settings, ToolTipOn

; ValidateSettings()

; Shift up key
global ShiftUpKey
IniRead, ShiftUpKey, Settings.ini, Keys, ShiftUpKey
; Shift down key
global ShiftDownKey
IniRead, ShiftDownKey, Settings.ini, Keys, ShiftDownKey
; Top gear set key
IniRead, TopGearSetKey, Settings.ini, Keys, TopGearSetKey
Hotkey, %TopGearSetKey%, SetTopGear
; Gear sync key
IniRead, GearSyncKey, Settings.ini, Keys, GearSyncKey
Hotkey, %GearSyncKey%, SyncGears
; Delay increase key
IniRead, DelayIncreaseKey, Settings.ini, Keys, DelayIncreaseKey
Hotkey, %DelayIncreaseKey%, DelayIncrease
; Delay decrease key
IniRead, DelayDecreaseKey, Settings.ini, Keys, DelayDecreaseKey
Hotkey, %DelayDecreaseKey%, DelayDecrease
; Delay decrease key
IniRead, SaveSettingsKey, Settings.ini, Keys, SaveSettingsKey
Hotkey, %SaveSettingsKey%, SaveSettings

; The gear the car is in
global Gear = DefaultGear
; Neutral flags for resetting the car into neutral after a race
global CarIsInNeutralFlag1 = 1
global CarIsInNeutralFlag2 = 1
; Clutch flag to monitor that the clutch was released between shifts
global ClutchWasReleased = 1

DisplayToolTip()

#Persistent
SetTimer, WatchAxis, 5
if (DefaultGear == 0)
	SetTimer, ResetToNeutral, 1000
return

; Updates clutch and throttle position
WatchAxis:
GetKeyState, Clutch, JoyU
if (ClutchWasReleased == 0) && (Clutch > ClutchBitePoint)
	ClutchWasReleased = 1
GetKeyState, Throttle, JoyZ
return

; Resets gears to neutral
ResetToNeutral:
CarIsInNeutralCheck()
if (CarIsInNeutralFlag1 == 1) && (CarIsInNeutralFlag2 == 1) && (Gear != 0) {
	Shift(0, 0, 100)
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
	Shift(1, 0, 100)
else if GetKeyState("Joy10")
	Shift(2, 0, 100)
else if GetKeyState("Joy11")
	Shift(3, 0, 100)
else if GetKeyState("Joy12")
	Shift(4, 0, 100)
else if GetKeyState("Joy13")
	Shift(5, 0, 100)
else if GetKeyState("Joy14")
	Shift(6, 0, 100)
else if GetKeyState("Joy15")
	Shift(-1, 0, 100)
else
	Shift(0, 0, 100)
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

; Saves the setting that can be changed through the script
SaveSettings:
IniWrite, %TopGear%, Settings.ini, Settings, TopGear
IniWrite, %Delay%, Settings.ini, Settings, Delay
return

; 1st gear
Joy9::
Shift(1, Clutch, Throttle)
return

; 2nd gear
Joy10::
Shift(2, Clutch, Throttle)
return

; 3rd gear
Joy11::
Shift(3, Clutch, Throttle)
return

; 4th gear
Joy12::
Shift(4, Clutch, Throttle)
return

; 5th gear
Joy13::
Shift(5, Clutch, Throttle)
return

; 6th gear
Joy14::
Shift(6, Clutch, Throttle)
return

; Reverse gear
Joy15::
Shift(-1, Clutch, Throttle)
return

; Shift function
Shift(n, Clutch, Throttle){
	if (ClutchWasReleased == 1) && (n <= TopGear) && (Clutch <= ClutchBitePoint) && (Throttle >= ThrottleBitePoint) {
		if (ClutchBitePoint != 100) 
			ClutchWasReleased = 0
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
		ToolTip, Gear: %Gear%`nTop Gear: %TopGear%`nDelay: %Delay%ms`nClutchBitePoint: %ClutchBitePoint%`nThrottleBitePoint: %ThrottleBitePoint%`nShiftUpKey: %ShiftUpKey%`nShiftDownKey: %ShiftDownKey%`nDefaultGear: %DefaultGear%
	return
}

; Neutral check function
CarIsInNeutralCheck(){
	if GetKeyState("Joy9") || GetKeyState("Joy10") || GetKeyState("Joy11") || GetKeyState("Joy12") || GetKeyState("Joy13") || GetKeyState("Joy14") || GetKeyState("Joy15")
		CarIsInNeutralFlag1 = 0
	else
		CarIsInNeutralFlag1 = 1
	return
}

; Checks that the settings are within acceptable value ranges
ValidateSettings(){
	if (TopGear > 6) || (TopGear < -1) 
		TopGear = 6
	if (DefaultGear > 6) || (DefaultGear < -1) 
		DefaultGear = 0
	if (ClutchBitePoint > 100) || (ClutchBitePoint < 0)
		ClutchBitePoint = 25
	if (ThrottleBitePoint > 100) || (ThrottleBitePoint < 0)
		ThrottleBitePoint = 75
	if (Delay < 0) 
		Delay = 0
	if (NeutralSkip != 0) && (NeutralSkip != 1)
		NeutralSkip = 0
	if (ToolTipOn != 0) && (ToolTipOn != 1)
		ToolTipOn = 0
	return
}