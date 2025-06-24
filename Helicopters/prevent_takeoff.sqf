/* Set the global heloDisableTakeoff to true and call this.
It will prevent the helo from moving until heloDisableTakeoff
is set false again. */

params ["_helo"];

_helo setVelocity [0, 0, 0];
_heloPos = getPos _helo;
_heloDir = getDir _helo;
_heloVectorDir = vectorDir _helo;

[_helo, _heloPos, _heloDir, _heloVectorDir] spawn {
	params ["_helo", "_heloPos", "_heloDir", "_heloVectorDir"];

    //_mass = getMass _helo;
	//_helo setMass 100000;

	while {heloDisableTakeoff} do {

		//_helo engineOn false;

		_helo setVelocity [0, 0, 0];
		//_helo setAngularVelocity [0, 0, 0]; 
		_helo setPos _heloPos;
	//	_helo setDir _heloDir;
		_helo setVectorDir _heloVectorDir;

		//sleep 0.05;
	};

	//_helo setMass _mass;
};