/*
		null = [] spawn compile preprocessFileLineNumbers "main_loop.sqf";
		NSA_hp_main_loop = compile preprocessFileLineNumbers "main_loop.sqf";



[NSA_param_gamePrepareTime, NSA_param_roundTime, NSA_param_respawnWave] spawn NSA_hp_main_loop;

*/



while {(NSA_hp_GameState != -1)} do {
	sleep 2;
	
	[(_this select 0), (_this select 1), (_this select 2)] spawn NSA_hp_init_newRound;
	
	waitUntil {
		sleep 1.04;
		
		(NSA_hp_roundTime > 0)
	};
	
	
			/*
				Для каждой стороны создается свой цикл обновления волн респавна. 
				Они независимы и пока раунд не окончен - волны сменяют одна другую
			*/
	{
		if (_x) then {
			[_forEachIndex, (_this select 2)] spawn {
				private ["_sindex","_rNum","_cside"];
				
				waitUntil {
					sleep 1.04;
					
					_sindex = _this select 0;
					_rNum = NSA_hp_RoundsCount;
					_cside = [east,west,resistance] select _sindex;
					(NSA_hp_RespawnWave select _sindex) set [1, ["hp_respWaveTime_" + str _cside, "getTime"] call NSA_Timer ];
					
					if (((NSA_hp_RespawnWave select _sindex) select 1) <= 0) then {
						publicVariable "NSA_hp_RespawnWave";
						["hp_respWaveTime_" + str _cside, "delete"] call NSA_Timer;
						
						sleep 5;
						waitUntil {sleep 0.2; (["hp_respWaveTime_" + str _cside, "getTime"] call NSA_Timer) < 0 };
						
						if ( (NSA_hp_roundTime > 0) && (_rNum == NSA_hp_RoundsCount) ) then {
							[(_this select 1), _cside] call NSA_hp_init_respawnWave;
						};
					};
					
					(NSA_hp_roundTime <= 0) || (_rNum != NSA_hp_RoundsCount)
				};
			};
		};
	} forEach NSA_hp_PlayingSides;
	
	waitUntil {
		sleep 1.04;
		
		NSA_hp_roundTime  = ["hp_roundTime", "getTime"] call NSA_Timer;
		
		// hint format ["wave:\n%1\n%2",NSA_hp_RespawnWave, ["hp_respWaveTime", "getTime"] call NSA_Timer];		
		
		(NSA_hp_roundTime <= 0)
	};
	
};





