East base no evac sinks defined...



Vehicle stuck at 5% loading:

Possibly delete bis_fnc_modulespawnai_garbagecollectorset and re-try loading or bis_unstuckpos var.

Cancel and re-try loading.

Also noted that while trying to re-try loading, an enemy AI appeared and I shot him. After that 
could load vehicle.

When vehicle RTB my crew went rogue and started shooting vehicle or possiby repair mechanic.

_list = nearestObjects[ player, ["Car", "Tank"], 20];


diag_log format ["List %1", _list];

_vehicle = _list select 0;

//_vehicle setDamage 0;


{

    diag_log format ["Crew %1", name _x];

} forEach crew _vehicle;


diag_log format ["Vehicle damage: %1", damage _vehicle];

diag_log format ["Vehicle fuel: %1", fuel _vehicle];

diag_log format ["Vehicle alive: %1", alive _vehicle];

diag_log format ["Vehicle group: %1", groupId group _vehicle];

diag_log format ["Vehicle side: %1", side _vehicle];

diag_log format ["Vehicle vars: %1", allVariables _vehicle];

_vehicle setVariable["bis_fnc_modulespawnai_garbagecollectorset", nil];


diag_log format ["Vehicle unstuckpos: %1, Vehicle Pos: %2", _vehicle getVariable["bis_unstuckpos", "fubar"], getPos _vehicle];



diag_log format ["Vehicle bis_fnc_modulespawnai_garbagecollectorset: %1, Vehicle Pos: %2", _vehicle getVariable["bis_fnc_modulespawnai_garbagecollectorset", "fubar"], getPos _vehicle];