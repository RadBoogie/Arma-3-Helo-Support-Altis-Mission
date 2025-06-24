//TODO: Spawn player...

diag_log "*** Respawning Player!";

params ["_unit", "_corpse"];

diag_log format [ "   Parms - _unit: %1, _corpse: %2", _unit, _corpse];

diag_log format [ "   Previous player info - Name: %1, Group: %3", name previousPlayer, group previousPlayer];

_newUnit = group previousPlayer createUnit ["B_HeliPilot_F", getMarkerPos "player_respawn", [], 0, "FORM"];

_deathLocation = getPos previousPlayer;

diag_log format [ "   Death Location: %1, Respawn Location: %2", _deathLocation, getMarkerPos "player_respawn"];

//player setDamage 0;
//player setPos [getMarkerPos "player_respawn" select 0, getMarkerPos "player_respawn" select 1, 0];

diag_log "   Setting as player...";

 selectPlayer _newUnit; // Reckon this prevents the mission end in SP.

//[_deathLocation] spawn{
 //   params ["_deathLocation"];

    // Create a new camera
 /*   private _camera = "camera" camCreate [(_deathLocation select 0) + 10, (_deathLocation select 1) + 10, (_deathLocation select 2) + 10];

    // Set camera parameters
    _camera cameraEffect ["internal", "BACK"];
    _camera camCommit 0;

    // Set camera position and orientation
    _camera camPrepareTarget _deathLocation;
    //_camera camPreparePos [(_deathLocation select 0) + 10, (_deathLocation select 1) + 10, (_deathLocation select 2) + 10];
    _camera camPrepareFOV 0.700;
    _camera camCommit 2;

    // Delay, let the camera run for 10 seconds
    sleep 10;

    // Reset to player view
    "camera" camCreate [0,0,0];
    _camera cameraEffect ["terminate","BACK"];
    camDestroy _camera;*/
    
//}; 



/* This is a bodge for SP. When we die, this script gets called, when we re-spawn we end
up dying again. The previous player character gets zombied and we have no way of identifying
them so we can delete them. The only way seems to be to spawn a specific type of unit class 
i.e. Helo Pilot, and only delete helo pilots that are on our side, that are not the player
and are not in a vehicle. We also only delete matching entities within 3m of the spawn point.
Make sure we don't use helo pilots out in the open if they are likely to get within 3m of the 
spawnpoint, instead use helo crew if we want ambient NPCs. */
{ 
    deleteVehicle _x;
} forEach (allUnits select 
    {
        side _x == west && 
        typeOf _x == "B_HeliPilot_F" && 
        !isPlayer _x && 
        vehicle _x == _x &&
        (_x distance getMarkerPos "player_respawn") < 10 
    });


// But SUPPORT respawn causes the player to later respawn as another character
diag_log format [ "   New player info - Name: %1, Group: %3", name _newUnit, group _newUnit];

previousPlayer = _newUnit;

player assignCurator zeus;

//BIS_DeathBlur ppEffectAdjust [0.0];
//BIS_DeathBlur ppEffectCommit 0.0;

execVM "Player\init_player.sqf";

