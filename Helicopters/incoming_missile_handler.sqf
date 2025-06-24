params ["_target", "_ammo", "_vehicle", "_instigator", "_missile"];

[_target, "CMFlareLauncher"] call BIS_fnc_fire;

playSound "BOOG_RWR";