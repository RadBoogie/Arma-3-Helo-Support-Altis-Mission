params ["_unitClassName", "_spawnPosition", "_waitPosition", "_ambientAnimationName"];

_group = createGroup west;
_crew = _group createUnit [_unitClassName, _spawnPosition, [], 0, "NONE"];

removeHeadgear _crew;
_crew unassignItem "NVGoggles";

_group setBehaviourStrong "CARELESS";

 _crew doMove _waitPosition;

_startTime = time;
_timeout = 10;
waitUntil {	
	sleep 0.2;
	(moveToCompleted _crew) || (time > _startTime + _timeout);
 };

if (_unitClassName == "B_HeliPilot_F") then {
	// Get commander to face crew members as if chatting.
	// Rather not do this here, prefer to have the code external to this, but
	// has to be done before setting ambient anim.
	_crew setDir 324;	
};

[_crew, _ambientAnimationName, "FULL"] call BIS_fnc_ambientAnim;	

_crew;