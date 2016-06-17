/*
null = [_interval] spawn compile preprocessFileLineNumbers "setClean.sqf";

NSA_hp_setClean = compile preprocessFileLineNumbers "setClean.sqf";
[_interval] spawn NSA_hp_setClean;

	������� ������� ���� ��� �� �������� �� �����.
*/

private["_interval"];

_interval = _this select 0;

// ������� ���� �������� ���������� �� �����
[] spawn { 
	NSA_toDelete = [];
	{
		NSA_toDelete = NSA_toDelete + allMissionObjects (_x);
	} forEach ["GroundWeaponHolder", "WeaponHolderSimulated", "ACE_Explosive_Object", "ACE_M86PDM_Object", "ACE_BreachObject", "Default"];
	{
		deleteVehicle _x;
	} forEach NSA_toDelete;	
};