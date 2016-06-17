/*
null = [_interval] spawn compile preprocessFileLineNumbers "setClean.sqf";

NSA_hp_setClean = compile preprocessFileLineNumbers "setClean.sqf";
[_interval] spawn NSA_hp_setClean;

	Функция очищает поле боя от объектов на земле.
*/

private["_interval"];

_interval = _this select 0;

// Очистка всех объектов валяющихся на земле
[] spawn { 
	NSA_toDelete = [];
	{
		NSA_toDelete = NSA_toDelete + allMissionObjects (_x);
	} forEach ["GroundWeaponHolder", "WeaponHolderSimulated", "ACE_Explosive_Object", "ACE_M86PDM_Object", "ACE_BreachObject", "Default"];
	{
		deleteVehicle _x;
	} forEach NSA_toDelete;	
};