
// Mechanic 1
// "a3\dubbing_f_bootcamp\boot_m03\105_earthquake\boot_m03_105_earthquake_bsa_1.ogg" // Blaming CSAT

// diag_log "repair_boss_chatter.sql start";

private _sounds = [
	"a3\dubbing_f_bootcamp\boot_m03\105_earthquake\boot_m03_105_earthquake_bsa_0.ogg",
	"a3\dubbing_f_bootcamp\boot_m03\105_earthquake\boot_m03_105_earthquake_bsa_1.ogg"
];

while {true} do {
	_random = random [15, 22, 30];
	sleep _random;

	_soundIndex = random 1;

	playSound3D [
		_sounds select _soundIndex, 
		helo_pad_1_mechanic_3, 
		false, 
		getPosASL helo_pad_1_mechanic_3, 
		1, // Volume
		1, // Pitch
		0, // Distance 0 = unlimited
		0  // Offset
	];
};
