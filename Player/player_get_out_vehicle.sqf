params ["_unit", "_role", "_vehicle", "_turret", "_isEject"];

diag_log format["*** Player get out of vehicle Unit: %1", name _unit ];

_heloIncomingMissileEventIndex = _vehicle getVariable "IncomingMissileEventIndex";
_vehicle removeEventHandler ["IncomingMissile", _heloIncomingMissileEventIndex];