publicVariable "playerHelo";

params ["_unit", "_role", "_vehicle", "_turret"];

playerHelo = _vehicle;

_index = _vehicle addEventHandler ["IncomingMissile", {
	params ["_target", "_ammo", "_vehicle", "_instigator", "_missile"];

	[_target, _ammo, _vehicle, _instigator, _missile] execVM "Helicopters\incoming_missile_handler.sqf"
}];

_vehicle setVariable ["IncomingMissileEventIndex", _index];

[_vehicle] spawn {
	params ["_vehicle"];

	sleep 2; // give time for MP modules to initialise then unlock helo...
	_vehicle lock false;
};