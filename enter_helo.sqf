// Extract the parameter
params ["_helo"];

// _helo = _helo select 0;

// Log for debugging
diag_log format ["Debug: _helo = %1, type = %2", _helo, typeName _helo];

// Verify it's not null and is actually a helicopter
if (!isNull _helo && {vehicle _helo == _helo}) then {
    // Do stuff with _helo
	hint name _helo;
} else {
    diag_log "Invalid parameter passed to enter_helo.sqf";
};


_group = group player;  // replace with the desired group if needed

{
    // Add each crew member to the group
    [_x] joinSilent _group;
} forEach (crew _helo);




//if (player in this) then {
    // Create firing event
  //  myHelicopter fire "missile";  // Replace "missile" with the actual weapon class you want to fire
    
    // For multiple shots, you can use loops or `sleep` function for delays
  //  sleep 1;
 //   myHelicopter fire "missile";
    
    // You can add additional logic, like exiting the player from the helicopter after firing
    // player action ["Eject", myHelicopter];
//};