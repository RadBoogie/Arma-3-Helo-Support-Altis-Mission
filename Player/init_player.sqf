diag_log "Starting init_player.sqf";

previousPlayers pushBack player;

/* The MP respawn code creates all kinds of zombied players. This code 
cleans up the list of previous players. This prevents the scenario where
after you re-spawn you have to wait a minute for your death to be 
announced before you can get back in a helo. */
{
   if (_x != player) then {
      deleteVehicle _x;
    };

} forEach previousPlayers;

player addEventHandler ["Killed", {
	params ["_unit", "_corpse"];
	[_unit, _corpse] execVM "Player\player_sp_respawn.sqf"
}];

player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	[_unit, _role, _vehicle, _turret] execVM "Player\player_get_in_vehicle.sqf"
}];

player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret", "_isEject"];
	[_unit, _role, _vehicle, _turret, _isEject] execVM "Player\player_get_out_vehicle.sqf"
}];

player addAction [
	"Base Pop Smoke", 
	{
		_smoke = "SmokeShellRed" createVehicle position heli_pad_repair;
		_smoke = "SmokeShellBlue" createVehicle position heli_pad_medical;
		_smoke = "SmokeShellYellow" createVehicle position vehicleRepairPad;
	},	[], 0, false];


cutRsc ["BOOG_ScoreHud", "PLAIN"];
