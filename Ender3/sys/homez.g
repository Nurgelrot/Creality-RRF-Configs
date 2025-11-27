; homez.g
; called to home the Z axis
;
G91               ; relative positioning
G1 H2 Z5 F6000    ; lift Z relative to current position
G90  			  ; absolute positioning

G1 X105 Y105 F1800 ; go to first probe point
G30               ; home Z by probing the bed
M402			  ; Stow the probe
