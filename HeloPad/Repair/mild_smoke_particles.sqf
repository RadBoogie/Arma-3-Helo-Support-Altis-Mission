_position = (_this select 0);
[_position] spawn {     
		_position = (_this select 0);
		private _ps1 = "#particlesource" createVehicleLocal _position;

		_ps1 setParticleParams [
			[
				"\A3\Data_F\ParticleEffects\Universal\Universal", // path and name of file
				16, // How many rows there are in the texture. For example Universal is 16x16, so particleFSNtieth is 16. Default: 1
				7, // Row index 0 based, so particleFSIndex 12 will mean 13th row from the top. Default: 0
				16, // How many frames from the start of the chosen row to animate (particleFSFrameCount 8 means animate frames 1,2,3,4,5,6 and 7 in sequence). Default: 1
				1   // Whether or not to repeat from the beginning when all frames got played (0 - false, 1 - true). If particleFSLoop is 0 animation sequence is played only once. Default: 1
			], 
			"", // Deprecated (Animation name)
			"Billboard", // type of animation (Billboard (2D), Spaceobject (3D))
			1, // interval of timer (how often is called script defined in parameter onTimerScript)
			6, // life time of particle in seconds
			[0, 0, 0], // Position [x,y,z]
			[0, 0, 1.5], // Move Velocity [x,y,z]
			0, // Rotations per second
			10, // weight of particle (kg)
			7.9, // volume of particle (m3)
			0.066,  // how much is particle affected by wind/air resistance
			[0.2, 1, 3], // size of particle during the life
			[[0, 0, 0, 0], [0.05, 0.05, 0.05, .3], [0.05, 0.05, 0.05, .3], [0.05, 0.05, 0.05, .3], [0.1, 0.1, 0.1, 0.1], [0.125, 0.125, 0.125, 0]], // color of particle during the life (r,g,b,a)
			[0.25], // phase of the animation in time. In other words, the play speed of the selected frames for the Number of Frames to Play above. The higher the number, the faster it plays through the animation frames. Note that if the Number of Frames to Play above is set to 1, this will have no visible effect.
			1, // interval of random speed change
			0, // intensity of random speed change
			"", // script triggered by timer (in variable "this" is stored position of particle)
			"", // script triggered before destroying of particle (in variable "this" is stored position of particle)
			_ps1, // Object - If this parameter isn't objNull, the particle source will be attached to the object. The source will stop to generate its particles when the distahce between the object and the source is further than Object View Distance.
			0, // Angle - Number - (Optional, default 0) determines the particle's starting angle in radian. pi = 180°.
			false, // onSurface - Boolean - (Optional, default false) Bounce the particles when hit the surface if true. If circleRadius > 0, placing of particle on (water) surface on start of its existence. Circle radius is defined by command setParticleCircle.
			-1 // bounceOnSurface - Number - (Optional, default -1) coef of bounce in collision with ground, 0..1 for collisions, -1 to disable collision. Should be used soberly as it has a significant impact on performance.
			// vectorDir
		];

		_ps1 setParticleRandom [
			0, // lifeTimes
			[0.25, 0.25, 0], // position
			[0.2, 0.2, 0], // moveVelocity
			0, // rotationVelocity
			0.25, // size
			[0, 0, 0, 0.1], // color
			0, // directionPeriod
			0 // directionIntensity
		];

		_ps1 setDropInterval 0.03;

		//sleep 0.4;

		//deletevehicle _ps1;
     };