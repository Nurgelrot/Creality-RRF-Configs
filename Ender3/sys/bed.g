; beg.g
M290 R0 S0              ;clear baby stepping
M561                    ;reset all bed adjustments
M400                    ;flush move queue

; Home if not already
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
   echo "not all axes homed, homing axes first"
   G28

G30 P0 X17 Y110 Z-9999 		; Front Left
G30 P1 X197 Y110 Z-9999 S2	; Front Right

echo "Current rough pass deviation: " ^ move.calibration.initial.deviation

while move.calibration.initial.deviation >= 0.007
   if iterations >= 5
      echo "Error: Max attemps failed. Deviation: " ^ move.calibration.initial.deviation
      abort
   echo "Deviation over threshold. Executing pass" , iterations+2, "deviation", move.calibration.initial.deviation
   G30 P0 X17 Y110 Z-9999 		; Front Left
   G30 P1 X197 Y110 Z-9999 S2	; Front Right
   echo "Current deviation: " ^ move.calibration.initial.deviation
   continue
echo "Final deviation: " ^ move.calibration.initial.deviation

G28 Z   ; reset Z=0 as it has likely moved.