; bed.g
; Bed file for Ender 5 Plus with probe offset of -45 -7 (creality default)
;
;
M290 R0 S0    						; Clear baby stepping
M561 								; Clear any bed transform
G29 S2								; Clear bed height map
M400          						; Flush move queue
;
; Probe 2-point

if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  echo "not all axes homed, homing axes first"
  G28
  
  
while true
  if iterations = 5
    abort "Auto calibration repeated attempts ended, final deviation", move.calibration.final.deviation ^ "mm"
  G30 P0 X28 Y183 Z-99999 ; probe near LEFT leadscrew
  if result != 0
    continue
  G30 P1 X323 Y183 Z-99999 S2 ; probe near RIGHT leadscrew
  if result != 0
    continue
  if move.calibration.initial.deviation <= 0.01
    break
  echo "Repeating calibration because deviation is too high (" ^ move.calibration.initial.deviation ^ "mm)"
; end loop
echo "Auto calibration successful, deviation", move.calibration.final.deviation ^ "mm"
G0 X210 Y183 Z10 F9000
; rehome Z as the absolute height of the z plane may have shifted
G28 Z
