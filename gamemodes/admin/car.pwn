CMD:rac(playerid, params[]) return cmd_respawnallcars(playerid, params);
CMD:respawnallcars(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	for(new i = 1, j = GetVehiclePoolSize(); i <= j; i++)
	{
	    if (IsValidVehicle(i))
	   	{
	        if (!IsVehicleOccupied(i)) SetVehicleToRespawn(i);
    	}
	}
	
	SendClientMessage(playerid, COLOR_GREY, "SERVER: Kullan�lmayan b�t�n ara�lar� spawnlad�n.");
	adminWarn(1, sprintf("%s isimli y�netici kullan�lmayan b�t�n ara�lar� respawnlad�.", ReturnName(playerid, 1)));
	return 1;
}

CMD:aekle(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if(sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/aekle [birlik/kiralik]");
		return 1;
	}

	if(!strcmp(type, "birlik", true))
	{
		new factionid, model[32], color[2], siren;
		if(sscanf(string, "is[32]I(-1)I(-1)I(0)", factionid, model, color[0], color[1], siren)) 
			return SendUsageMessage(playerid, "/aekle birlik [birlik ID] [model ad�/ID] [renk1] [renk2] [siren(0/1)]");

		if(!Iter_Contains(Factions, factionid)) return SendErrorMessage(playerid, "Hatal� birlik ID girdin.");
		if((model[0] = GetVehicleModelByName(model)) == 0) return SendErrorMessage(playerid, "Hatal� model ID girdiniz.");
		
		if(color[0] == -1) color[0] = random(255);
		if(color[1] == -1) color[1] = random(255);

		new 
			Float: x, 
			Float: y, 
			Float: z, 
			Float: a;

		GetPlayerPos(playerid, x, y, z); 
		GetPlayerFacingAngle(playerid, a);	

		new dbid;
		new vehicleid = CreateVehicle(model[0], x, y, z, a, color[0], color[1], -1, siren);
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
		LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
		//PutPlayerInVehicle(playerid, vehicleid, 0);

		new Cache: cache = mysql_query(m_Handle, "INSERT INTO vehicles (RentalID) VALUES (0)");
		if(vehicleid != INVALID_VEHICLE_ID)
		{
			CarData[vehicleid][carID] = cache_insert_id();
			dbid = CarData[vehicleid][carID];
			CarData[vehicleid][carModel] = GetVehicleModel(vehicleid);
			CarData[vehicleid][carOwnerID] = 0;
			CarData[vehicleid][carFaction] = factionid;
			CarData[vehicleid][carRental] = 0;
			CarData[vehicleid][carRentalPrice] = 0;
			CarData[vehicleid][carRentedBy] = 0;

			format(CarData[vehicleid][carPlates], 20, "%s", FactionData[factionid][FactionAbbrev]);
			SetVehicleNumberPlate(vehicleid, CarData[vehicleid][carPlates]);

			format(CarData[vehicleid][carName], 35, ReturnVehicleModelName(GetVehicleModel(vehicleid)));
			format(CarData[vehicleid][carSign], 45, "%s", FactionData[factionid][FactionAbbrev]);

			if(IsValidDynamic3DTextLabel(CarData[vehicleid][carSign3D])) DestroyDynamic3DTextLabel(CarData[vehicleid][carSign3D]);

			CarData[vehicleid][carPos][0] = x;
			CarData[vehicleid][carPos][1] = y;
			CarData[vehicleid][carPos][2] = z;
			CarData[vehicleid][carPos][3] = a;

			CarData[vehicleid][carInterior] = GetPlayerInterior(playerid);
			CarData[vehicleid][carWorld] = GetPlayerVirtualWorld(playerid);

			CarData[vehicleid][carColor1] = color[0];
			CarData[vehicleid][carColor2] = color[1];

			CarData[vehicleid][carXMR] = false;
			CarData[vehicleid][carXMROn] = false;
			format(CarData[vehicleid][carXMRUrl], 128, "-");

			CarData[vehicleid][carSiren] = false;
			CarData[vehicleid][carSirenOn] = false;

			if(IsValidDynamicObject(CarData[vehicleid][carSirenObject])) 
				DestroyDynamicObject(CarData[vehicleid][carSirenObject]);

			CarData[vehicleid][carLocked] = false;
			CarData[vehicleid][carImpounded] = -1;

			CarData[vehicleid][carFuel] = 100.0;
			CarData[vehicleid][carMileage] = CarData[vehicleid][carArmour] = 0.0;
			CarData[vehicleid][carBattery] = GetVehicleCondition(vehicleid, 2);
			CarData[vehicleid][carEngine] = GetVehicleCondition(vehicleid, 1);
			
			CarData[vehicleid][carLock] = 0;
			CarData[vehicleid][carAlarm] = 0;
			CarData[vehicleid][carImmob] = 0;
			CarData[vehicleid][carInsurance] = 0;
			CarData[vehicleid][carInsuranceTime] = 0;
			CarData[vehicleid][carInsurancePrice] = 0;
			CarData[vehicleid][carTimeDestroyed] = 0;

			CarData[vehicleid][carPaintjob] = -1;
			for(new m; m < 14; m++) CarData[vehicleid][carMods][m] = -1;
			for(new d; d < 4; d++) CarData[vehicleid][carDoors][d] = 0, CarData[vehicleid][carWindows][d] = 1;

			CarData[vehicleid][carlastDriver] = 0;
			CarData[vehicleid][carlastPassenger] = 0;

			CarData[vehicleid][carLastHealth] = GetVehicleCondition(vehicleid, 0);
			SetVehicleHealth(vehicleid, CarData[vehicleid][carLastHealth]);

			CarData[vehicleid][carPanelStatus] = CarData[vehicleid][carDoorsStatus] = 0;
			CarData[vehicleid][carLightsStatus] = CarData[vehicleid][carTiresStatus] = 0;

			CarData[vehicleid][carExists] = true;
			CarData[vehicleid][carTweak] = false;
			CarData[vehicleid][carRev] = 0;

			Car_Save(vehicleid);
		}

		cache_delete(cache);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n tipi birlik olarak ayarland�. (%s)", vehicleid, FactionData[factionid][FactionAbbrev]);
		Vehicle_DefaultValues(vehicleid);
		DestroyVehicle(vehicleid);

		new query[55];
		mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM vehicles WHERE id = %i", dbid);
		mysql_tquery(m_Handle, query, "SQL_LoadVehicles");
		return 1;
	} 
	else if(!strcmp(type, "kiralik", true))
	{
		new model[32], color[2];
		if(sscanf(string, "s[32]I(-1)I(-1)", model, color[0], color[1])) 
			return SendUsageMessage(playerid, "/aekle kiralik [model ad�/ID] [renk1] [renk2]");

		if((model[0] = GetVehicleModelByName(model)) == 0) return SendErrorMessage(playerid, "Hatal� model ID girdiniz.");
		
		if(color[0] == -1) color[0] = random(255);
		if(color[1] == -1) color[1] = random(255);

		new 
			Float: x, 
			Float: y, 
			Float: z, 
			Float: a;

		GetPlayerPos(playerid, x, y, z); 
		GetPlayerFacingAngle(playerid, a);	

		new dbid;
		new vehicleid = CreateVehicle(model[0], x, y, z, a, color[0], color[1], -1, false);
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
		LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
		//PutPlayerInVehicle(playerid, vehicleid, 0);

		new Cache: cache = mysql_query(m_Handle, "INSERT INTO vehicles (RentalID) VALUES (1)");
		if(vehicleid != INVALID_VEHICLE_ID)
		{
			CarData[vehicleid][carID] = cache_insert_id();
			dbid = CarData[vehicleid][carID];
			CarData[vehicleid][carModel] = GetVehicleModel(vehicleid);
			CarData[vehicleid][carOwnerID] = 0;
			CarData[vehicleid][carFaction] = -1;
			CarData[vehicleid][carRental] = 1;
			CarData[vehicleid][carRentalPrice] = 2500;
			CarData[vehicleid][carRentedBy] = 0;

			format(CarData[vehicleid][carPlates], 20, "KIRALIK");
			SetVehicleNumberPlate(vehicleid, CarData[vehicleid][carPlates]);

			format(CarData[vehicleid][carName], 35, ReturnVehicleModelName(GetVehicleModel(vehicleid)));
			format(CarData[vehicleid][carSign], 45, "-");

			if(IsValidDynamic3DTextLabel(CarData[vehicleid][carSign3D])) DestroyDynamic3DTextLabel(CarData[vehicleid][carSign3D]);

			CarData[vehicleid][carPos][0] = x;
			CarData[vehicleid][carPos][1] = y;
			CarData[vehicleid][carPos][2] = z;
			CarData[vehicleid][carPos][3] = a;

			CarData[vehicleid][carInterior] = GetPlayerInterior(playerid);
			CarData[vehicleid][carWorld] = GetPlayerVirtualWorld(playerid);

			CarData[vehicleid][carColor1] = color[0];
			CarData[vehicleid][carColor2] = color[1];

			CarData[vehicleid][carXMR] = false;
			CarData[vehicleid][carXMROn] = false;
			format(CarData[vehicleid][carXMRUrl], 128, "-");

			CarData[vehicleid][carSiren] = false;
			CarData[vehicleid][carSirenOn] = false;

			if(IsValidDynamicObject(CarData[vehicleid][carSirenObject])) 
				DestroyDynamicObject(CarData[vehicleid][carSirenObject]);

			CarData[vehicleid][carLocked] = false;
			CarData[vehicleid][carImpounded] = -1;

			CarData[vehicleid][carFuel] = 100.0;
			CarData[vehicleid][carMileage] = CarData[vehicleid][carArmour] = 0.0;
			CarData[vehicleid][carBattery] = GetVehicleCondition(vehicleid, 2);
			CarData[vehicleid][carEngine] = GetVehicleCondition(vehicleid, 1);
			
			CarData[vehicleid][carLock] = 0;
			CarData[vehicleid][carAlarm] = 0;
			CarData[vehicleid][carImmob] = 0;
			CarData[vehicleid][carInsurance] = 0;
			CarData[vehicleid][carInsuranceTime] = 0;
			CarData[vehicleid][carInsurancePrice] = 0;
			CarData[vehicleid][carTimeDestroyed] = 0;

			CarData[vehicleid][carPaintjob] = -1;
			for(new m; m < 14; m++) CarData[vehicleid][carMods][m] = -1;
			for(new d; d < 4; d++) CarData[vehicleid][carDoors][d] = 0, CarData[vehicleid][carWindows][d] = 1;

			CarData[vehicleid][carlastDriver] = 0;
			CarData[vehicleid][carlastPassenger] = 0;

			CarData[vehicleid][carLastHealth] = GetVehicleCondition(vehicleid, 0);
			SetVehicleHealth(vehicleid, CarData[vehicleid][carLastHealth]);

			CarData[vehicleid][carPanelStatus] = CarData[vehicleid][carDoorsStatus] = 0;
			CarData[vehicleid][carLightsStatus] = CarData[vehicleid][carTiresStatus] = 0;

			CarData[vehicleid][carExists] = true;
			CarData[vehicleid][carTweak] = false;
			CarData[vehicleid][carRev] = 0;
			Car_Save(vehicleid);
		}

		cache_delete(cache);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n tipi kiral�k olarak ayarland�.", vehicleid);
		Vehicle_DefaultValues(vehicleid);
		DestroyVehicle(vehicleid);

		new query[55];
		mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM vehicles WHERE id = %i", dbid);
		mysql_tquery(m_Handle, query, "SQL_LoadVehicles");
		return 1;
	} 
	else SendUsageMessage(playerid, "/aekle [birlik/kiralik]");
	return 1;
}

CMD:asil(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);
	
	new vehicleid;
	if(IsPlayerInAnyVehicle(playerid)) 
	{
		vehicleid = GetPlayerVehicleID(playerid);
	} else {
		if(sscanf(params, "i", vehicleid)) return SendUsageMessage(playerid, "/asil [ara� ID]");
		if(!IsValidVehicle(vehicleid)) return SendErrorMessage(playerid, "Hatal� ara� ID girdin.");
	}

	if(IsValidCar(vehicleid) && !IsValidPlayerCar(vehicleid))
	{
		if(IsValidRentalCar(vehicleid)) adminWarn(4, sprintf("%s isimli y�netici %i numaral� kiral�k arac� sildi.", ReturnName(playerid), vehicleid));
		else if(IsValidFactionCar(vehicleid)) adminWarn(4, sprintf("%s isimli y�netici %i numaral� birlik arac�n� sildi.", ReturnName(playerid), vehicleid));

		new query[55], dbid = CarData[vehicleid][carID];
		mysql_format(m_Handle, query, sizeof(query), "DELETE FROM vehicles WHERE id = %i", dbid);
		mysql_tquery(m_Handle, query);

		Vehicle_DefaultValues(vehicleid);
		DestroyVehicle(vehicleid);
		return 1;
	} 
	else SendErrorMessage(playerid, "Bu ara� silinemez.");
	return 1;
}

CMD:atamir(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);
	
	new vehicleid, Float: angle;
	if(IsPlayerInAnyVehicle(playerid)) 
	{
		vehicleid = GetPlayerVehicleID(playerid);
	} else {
		if(sscanf(params, "i", vehicleid)) return SendUsageMessage(playerid, "/atamir [ara� ID]");
		if(!IsValidVehicle(vehicleid)) return SendErrorMessage(playerid, "Hatal� ara� ID girdin.");
	}

	RepairVehicle(vehicleid);
	SetVehicleHealth(vehicleid, CarData[vehicleid][carLastHealth]);
	GetVehicleZAngle(vehicleid, angle); SetVehicleZAngle(vehicleid, angle);
	adminWarn(4, sprintf("%s isimli y�netici %i numaral� arac� tamir etti.", ReturnName(playerid, 1), GetPlayerVehicleID(playerid)));
	return 1;
}

CMD:apark(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	new 
		vehicleid, ownerid;

	if(IsPlayerInAnyVehicle(playerid)) 
	{
		vehicleid = GetPlayerVehicleID(playerid);
		if(!IsValidPlayerCar(vehicleid)) return SendErrorMessage(playerid, "Park etmek istedi�iniz ara� bir ki�iye ait de�il.");
		ownerid = CarData[vehicleid][carOwnerID];
	} 
	else 
	{
		if(sscanf(params, "i", vehicleid)) return SendUsageMessage(playerid, "/apark [ara� ID]");
		if(!IsValidVehicle(vehicleid)) return SendErrorMessage(playerid, "Hatal� ara� ID girdin.");
		if(!IsValidPlayerCar(vehicleid)) return SendErrorMessage(playerid, "Park etmek istedi�iniz ara� bir ki�iye ait de�il.");
		ownerid = CarData[vehicleid][carOwnerID];
	}

	foreach (new i : Player)
	{
		if(strfind(ReturnName(i, 1), ReturnSQLName(ownerid), true) != -1)
		{
			_has_vehicle_spawned[i] = false;
			_has_spawned_vehicleid[i] = INVALID_VEHICLE_ID;
			SendClientMessageEx(i, COLOR_ADM, "SERVER: %s model arac�n %s isimli y�netici taraf�ndan parkedildi.", ReturnVehicleName(vehicleid), ReturnName(playerid, 1));
		}
		else
		{
			new query[66];
			mysql_format(m_Handle, query, sizeof(query), "UPDATE players SET HasCarSpawned = 0 WHERE id = %i", ownerid);
			mysql_tquery(m_Handle, query);
		}
	}

	Car_Save(vehicleid);
	adminWarn(1, sprintf("%s isimli y�netici %s isimli oyuncunun %s model arac�n� park etti.", ReturnName(playerid), ReturnSQLName(ownerid), ReturnVehicleName(vehicleid)));
	//LogVehicleAction(vehicleid, sprintf("%s taraf�ndan park edildi.", ReturnName(playerid)));
	Vehicle_DefaultValues(vehicleid);
	DestroyVehicle(vehicleid);
	return 1;
}

CMD:abilgi(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);
	
	new vehicleid;
	if(IsPlayerInAnyVehicle(playerid)) 
	{
		vehicleid = GetPlayerVehicleID(playerid);
	} else {
		if(sscanf(params, "i", vehicleid)) return SendUsageMessage(playerid, "/abilgi [ara� ID]");
		if(!IsValidVehicle(vehicleid)) return SendErrorMessage(playerid, "Hatal� ara� ID girdin.");
	}

	SendClientMessage(playerid, COLOR_DARKGREEN, "__________________________________________");

	if(IsValidCar(vehicleid))
	{
		if(IsValidPlayerCar(vehicleid)) SendClientMessageEx(playerid, COLOR_GRAD1, "Tip:[�ahsi] Sahip:[%s (Kullan�c� DBID:%i)]", ReturnSQLName(CarData[vehicleid][carOwnerID]), CarData[vehicleid][carOwnerID]);
		if(IsValidFactionCar(vehicleid)) SendClientMessageEx(playerid, COLOR_GRAD1, "Tip:[Birlik] Sahip:[%s (Birlik DBID: %i)]", Faction_GetName(CarData[vehicleid][carFaction]), CarData[vehicleid][carFaction]);
		if(IsValidRentalCar(vehicleid)) SendClientMessageEx(playerid, COLOR_GRAD1, "Tip:[Kiral�k] Kira Durumu:[%s] Kira �creti:[$%s] Kiralayan:[%s (Kullan�c� DBID: %i)]", CarData[vehicleid][carRentedBy] ? "Kiralanm��" : "Kiralanmam��", MoneyFormat(CarData[vehicleid][carRentalPrice]), ReturnSQLName(CarData[vehicleid][carRentedBy]), CarData[vehicleid][carRentedBy]);

		SendClientMessageEx(playerid, COLOR_GRAD2, "DBID:[%i] ModelID:[%i] Ara��sim:[%s] Renk1:[{%06x}%i{FFFFFF}] Renk2:[{%06x}%i{FFFFFF}] Paintjob:[%i]", CarData[vehicleid][carID], CarData[vehicleid][carModel], CarData[vehicleid][carName], VehicleColoursTableRGBA[CarData[vehicleid][carColor1]] >>> 8, CarData[vehicleid][carColor1], VehicleColoursTableRGBA[CarData[vehicleid][carColor2]] >>> 8, CarData[vehicleid][carColor2], CarData[vehicleid][carPaintjob]);
		SendClientMessageEx(playerid, COLOR_GRAD1, "XMR:[%s] �ekilme Durumu:[%s] Motor �mr�:[%.2f] Batarya �mr�:[%.2f] Kilit Seviyesi:[%i] Alarm Seviyesi:[%i]", CarData[vehicleid][carXMR] ? ("Var") : ("Yok"), CarData[vehicleid][carImpounded] != -1 ? ("�ekilmi�") : ("�ekilmemi�"), CarData[vehicleid][carEngine], CarData[vehicleid][carBattery], CarData[vehicleid][carLock], CarData[vehicleid][carAlarm]);
		SendClientMessageEx(playerid, COLOR_GRAD2, "Immobiliser Seviyesi:[%i] Sigorta:[%i] Patlama Say�s�:[%i] Plaka:[%s] Kilit Durumu:[%s] Yak�t:[%f]", CarData[vehicleid][carImmob], CarData[vehicleid][carInsurance], CarData[vehicleid][carTimeDestroyed], CarData[vehicleid][carPlates], CarData[vehicleid][carLocked] ? ("Kilitli") : ("De�il"), CarData[vehicleid][carFuel]);
		SendClientMessageEx(playerid, COLOR_GRAD2, "Son Binen �of�r:[%s] Son Binen Yolcu:[%s]", ReturnSQLName(CarData[vehicleid][carlastPassenger]), ReturnSQLName(CarData[vehicleid][carlastDriver]));
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GRAD1, "Tip:[Statik] ModelID:[%i] Ara��sim:[%s]", GetVehicleModel(vehicleid), ReturnVehicleName(vehicleid));
		SendClientMessageEx(playerid, COLOR_GRAD2, "Son Binen �of�r:[%s] Son Binen Yolcu:[%s]", ReturnSQLName(CarlastPassenger[vehicleid]), ReturnSQLName(CarlastDriver[vehicleid]));
	}

	SendClientMessage(playerid, COLOR_DARKGREEN, "__________________________________________");
	return 1;
}

CMD:aduzenle(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);
	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Ara� i�erisinde de�ilsin.");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "�of�r koltu�unda de�ilsin.");

	new 
		vehicleid = GetPlayerVehicleID(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/aduzenle [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}model, birlik, kiralayan, kiraucreti, plaka");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}aracisim, sign, pozisyon, renk, xmr, siren, kilit");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}yakit, km, zirh, motoromru, bataryaomru");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ks, as, is, sigorta, sigortasure, sigortaucret");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ps, paintjob");
		return 1;
	}

	if(!strcmp(type, "model", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new model[32], dbid = CarData[vehicleid][carID];
		if(sscanf(string, "s[32]", model)) return SendUsageMessage(playerid, "/aduzenle model [model ID/ad�]");
		if((model[0] = GetVehicleModelByName(model)) == 0) return SendErrorMessage(playerid, "Hatal� model ID girdiniz.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n modelini %s olarak g�ncelledin.", vehicleid, ReturnVehicleModelName(model[0]));
		format(CarData[vehicleid][carName], 35, ReturnVehicleModelName(GetVehicleModel(vehicleid)));
		CarData[vehicleid][carModel] = model[0];
		Car_Save(vehicleid);

		Vehicle_DefaultValues(vehicleid);
		DestroyVehicle(vehicleid);

		new query[55];
		mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM vehicles WHERE id = %i", dbid);
		mysql_tquery(m_Handle, query, "SQL_LoadVehicles");
		return 1;
	}
	else if(!strcmp(type, "pozisyon", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new dbid = CarData[vehicleid][carID];
		GetVehiclePos(vehicleid, CarData[vehicleid][carPos][0], CarData[vehicleid][carPos][1], CarData[vehicleid][carPos][2]); 
		GetVehicleZAngle(vehicleid, CarData[vehicleid][carPos][3]);

		CarData[vehicleid][carInterior] = GetPlayerInterior(playerid);
		CarData[vehicleid][carWorld] = GetPlayerVirtualWorld(playerid);

		RemovePlayerFromVehicle(playerid);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n pozisyonunu g�ncelledin.", vehicleid);
		Car_Save(vehicleid);

		Vehicle_DefaultValues(vehicleid);
		DestroyVehicle(vehicleid);

		new query[55];
		mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM vehicles WHERE id = %i", dbid);
		mysql_tquery(m_Handle, query, "SQL_LoadVehicles");
		return 1;
 	}
 	else if (!strcmp(type, "plaka", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece �zel ara�larda kullan�l�r.");

		new car_plate[20];
		if(sscanf(string, "s[20]", car_plate)) return SendUsageMessage(playerid, "/aduzenle plaka [yeni plaka]");
		if(strlen(car_plate) > 20) return SendErrorMessage(playerid, "Plaka en fazla 20 karakter olabilir.");

		format(CarData[vehicleid][carPlates], 20, car_plate);
		SetVehicleNumberPlate(vehicleid, CarData[vehicleid][carPlates]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n plakas�n� %s olarak g�ncelledin.", vehicleid, car_plate);
		
		SetVehicleToRespawn(vehicleid);
		PutPlayerInVehicle(playerid, vehicleid, 0);
		Car_Save(vehicleid);
		return 1;
	}
	else if(!strcmp(type, "sign", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece �zel ara�larda kullan�l�r.");

		new car_sign[45];
		if(sscanf(string, "s[45]", car_sign)) return SendUsageMessage(playerid, "/aduzenle sign [car-sign]");

		if(!strcmp(string, "kaldir", true))
		{
			format(CarData[vehicleid][carSign], 45, "-");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Carsign ba�ar�yla silindi.");
			if(IsValidDynamic3DTextLabel(CarData[vehicleid][carSign3D])) DestroyDynamic3DTextLabel(CarData[vehicleid][carSign3D]);
			Car_Save(vehicleid);
			return 1;
		}

		if(strlen(car_sign) > 45) return SendErrorMessage(playerid, "Car-sign en fazla 45 karakter olabilir.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n car-signi %s olarak g�ncelledin.", vehicleid, car_sign);
		format(CarData[vehicleid][carSign], 45, car_sign); 

		if(!IsValidDynamic3DTextLabel(CarData[vehicleid][carSign3D])) CarData[vehicleid][carSign3D] = CreateDynamic3DTextLabel(sprintf("%s", CarData[vehicleid][carSign]), COLOR_WHITE, -0.7, -1.9, -0.3, 10.0, INVALID_PLAYER_ID, vehicleid, 0, -1, -1, -1);
		else UpdateDynamic3DTextLabelText(CarData[vehicleid][carSign3D], COLOR_WHITE, sprintf("%s", CarData[vehicleid][carSign]));
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "yakit", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new Float: yakit;
		if(sscanf(string, "f", yakit)) return SendUsageMessage(playerid, "/aduzenle yakit [miktar(1-100)]");
		if(yakit < 1.0 || yakit > 100.0) return SendErrorMessage(playerid, "Yak�t miktar� en az 1 en fazla 100 olabilir.");

		CarData[vehicleid][carFuel] = yakit;
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n yak�t�n� %f olarak g�ncelledin.", vehicleid, yakit);
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "zirh", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new Float: arm;
		if(sscanf(string, "f", arm)) return SendUsageMessage(playerid, "/aduzenle zirh [miktar]");
		if(arm < 1.0 || arm > 250.0) return SendErrorMessage(playerid, "Z�rh miktar� en az 1 en fazla 250 olabilir.");

		CarData[vehicleid][carArmour] = arm;
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n z�rh�n� %f olarak g�ncelledin.", vehicleid, arm);
		SetVehicleToRespawn(vehicleid);
		PutPlayerInVehicle(playerid, vehicleid, 0);
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "motoromru", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new Float: arm;
		if(sscanf(string, "f", arm)) return SendUsageMessage(playerid, "/aduzenle motoromru [miktar]");
		if(arm < 1.0 || arm > 100.0) return SendErrorMessage(playerid, "Motor �mr� en az 1 en fazla 100 olabilir.");

		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n motor �mr�n� %f(�nceki: %f) olarak g�ncelledin.", vehicleid, arm, CarData[vehicleid][carEngine]);
		CarData[vehicleid][carEngine] = arm;
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "bataryaomru", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new Float: arm;
		if(sscanf(string, "f", arm)) return SendUsageMessage(playerid, "/aduzenle bataryaomru [miktar]");
		if(arm < 1.0 || arm > 100.0) return SendErrorMessage(playerid, "Motor �mr� en az 1 en fazla 100 olabilir.");

		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n batarya �mr�n� %f(�nceki: %f) olarak g�ncelledin.", vehicleid, arm, CarData[vehicleid][carBattery]);
		CarData[vehicleid][carBattery] = arm;
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "ps", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new ks;
		if(sscanf(string, "i", ks)) return SendUsageMessage(playerid, "/aduzenle ps [miktar]");
		if(ks < 0) return SendErrorMessage(playerid, "Patlama say�s� en az 0 olabilir.");

		CarData[vehicleid][carTimeDestroyed] = ks;
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n patlama say�s�n� %i olarak g�ncelledin.", vehicleid, ks);
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "paintjob", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new ks;
		if(sscanf(string, "i", ks)) return SendUsageMessage(playerid, "/aduzenle paintjob [paintjob tipi(-1 girersen silinir.)]");
		if(ks < -1 || ks > 3) return SendErrorMessage(playerid, "Paintjob tipi en az -1 en fazla 3 olabilir.");

		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n paintjob tipini %i(�nceki: %i) olarak g�ncelledin.", vehicleid, ks, CarData[vehicleid][carPaintjob]);
		CarData[vehicleid][carPaintjob] = ks;
		SetVehicleToRespawn(vehicleid);
		PutPlayerInVehicle(playerid, vehicleid, 0);
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "ks", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new ks;
		if(sscanf(string, "i", ks)) return SendUsageMessage(playerid, "/aduzenle ks [seviye]");
		if(ks < 0 || ks > 5) return SendErrorMessage(playerid, "Kilit seviyesi en az 0 en fazla 5 olabilir.");

		CarData[vehicleid][carLock] = ks;
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n kilit seviyesini %i olarak g�ncelledin.", vehicleid, ks);
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "as", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new ks;
		if(sscanf(string, "i", ks)) return SendUsageMessage(playerid, "/aduzenle as [seviye]");
		if(ks < 0 || ks > 5) return SendErrorMessage(playerid, "Alarm seviyesi en az 0 en fazla 5 olabilir.");

		CarData[vehicleid][carAlarm] = ks;
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n alarm seviyesini %i olarak g�ncelledin.", vehicleid, ks);
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "is", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new ks;
		if(sscanf(string, "i", ks)) return SendUsageMessage(playerid, "/aduzenle is [seviye]");
		if(ks < 0 || ks > 5) return SendErrorMessage(playerid, "Immob seviyesi en az 0 en fazla 5 olabilir.");

		CarData[vehicleid][carImmob] = ks;
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n immob seviyesini %i olarak g�ncelledin.", vehicleid, ks);
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "sigorta", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new ks;
		if(sscanf(string, "i", ks)) return SendUsageMessage(playerid, "/aduzenle sigorta [seviye]");
		if(ks < 0 || ks > 3) return SendErrorMessage(playerid, "Sigorta seviyesi en az 0 en fazla 3 olabilir.");

		CarData[vehicleid][carInsurance] = ks;
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n sigorta seviyesini %i olarak g�ncelledin.", vehicleid, ks);
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "sigortasure", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new ks;
		if(sscanf(string, "i", ks)) return SendUsageMessage(playerid, "/aduzenle sigortasure [s�re]");
		if(ks < 0) return SendErrorMessage(playerid, "Sigorta s�resi en az 0 olabilir.");

		CarData[vehicleid][carInsuranceTime] = ks;
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n sigorta s�resini %i olarak g�ncelledin.", vehicleid, ks);
		Car_Save(vehicleid);
		return 1;
	}

	else if (!strcmp(type, "sigortaucret", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new ks;
		if(sscanf(string, "i", ks)) return SendUsageMessage(playerid, "/aduzenle sigortaucret [miktar]");
		if(ks < 0) return SendErrorMessage(playerid, "Sigorta �creti en az 0 olabilir.");

		CarData[vehicleid][carInsuranceTime] = ks;
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n sigorta �cretini %i olarak g�ncelledin.", vehicleid, ks);
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "km", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new Float: km;
		if(sscanf(string, "f", km)) return SendUsageMessage(playerid, "/aduzenle km [km]");
		if(km < 1.0) return SendErrorMessage(playerid, "KM en az 1 olabilir.");

		CarData[vehicleid][carMileage] = km;
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n kilometresini %f olarak g�ncelledin.", vehicleid, km);
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "renk", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new renk1, renk2;
		if(sscanf(string, "ii", renk1, renk2)) return SendUsageMessage(playerid, "/aduzenle renk [0-255] [0-255]");
		if(renk1 < 0 || renk1 > 255) return SendErrorMessage(playerid, "Birincil renk de�eri en az 0 en fazla 255 olabilir.");
		if(renk2 < 0 || renk2 > 255) return SendErrorMessage(playerid, "Birincil renk de�eri en az 0 en fazla 255 olabilir.");

		CarData[vehicleid][carColor1] = renk1, CarData[vehicleid][carColor2] = renk2;
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n rengini %i, %i olarak g�ncelledin.", vehicleid, renk1, renk2);
		SetVehicleToRespawn(vehicleid);
		PutPlayerInVehicle(playerid, vehicleid, 0);
		Car_Save(vehicleid);
		return 1;
	}
	else if(!strcmp(type, "kilit", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new locked;
		if(sscanf(string, "i", locked)) return SendUsageMessage(playerid, "/aduzenle kilit [0/1]");
		if(locked < 0 || locked > 1) return SendErrorMessage(playerid, "Hatal� kilit durumu girdin. (0/1)");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n kap�lar�n� %s olarak g�ncelledin.", vehicleid, !locked ? ("kilitli de�il") : ("kilitli"));
		CarData[vehicleid][carLocked] = bool:locked;
		ToggleVehicleLock(vehicleid, bool:locked);
		Car_Save(vehicleid);
		return 1;
	}
	else if(!strcmp(type, "xmr", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece sisteme kay�tl� ara�larda kullan�l�r.");

		new locked;
		if(sscanf(string, "i", locked)) return SendUsageMessage(playerid, "/aduzenle xmr [0/1]");
		if(locked < 0 || locked > 1) return SendErrorMessage(playerid, "Hatal� XMR durumu girdin. (0/1)");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n XMR durumunu %s olarak g�ncelledin.", vehicleid, !locked ? ("pasif") : ("aktif"));
		CarData[vehicleid][carXMR] = bool:locked;
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "aracisim", true))
	{
		if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece �ahsi ara�larda kullan�l�r.");

		new vehicle_name[35];
		if(sscanf(string, "s[35]", vehicle_name)) return SendUsageMessage(playerid, "/aduzenle aracisim [�zel isim]");
		if(strlen(vehicle_name) > 35) return SendErrorMessage(playerid, "Ara� ismi en fazla 35 karakter olabilir.");

		format(CarData[vehicleid][carName], 35, vehicle_name);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n �zel ismini %s olarak g�ncelledin.", vehicleid, vehicle_name);
		Car_Save(vehicleid);
		return 1;
	}
	else if(!strcmp(type, "birlik", true))
	{
		if(!IsValidFactionCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece birli�e kay�tl� ara�larda kullan�l�r.");

		new faction;
		if(sscanf(string, "i", faction)) return SendUsageMessage(playerid, "/aduzenle birlik [birlik ID]");
		if(!Iter_Contains(Factions, faction)) return SendErrorMessage(playerid, "Hatal� birlik ID girdin.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n birli�ini %s(%i) olarak g�ncelledin.", vehicleid, FactionData[faction][FactionName], faction);
		CarData[vehicleid][carFaction] = faction;
		Car_Save(vehicleid);
		return 1;
	}
	else if(!strcmp(type, "siren", true))
	{
		if(!IsValidFactionCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece birli�e kay�tl� ara�larda kullan�l�r.");

		new locked, dbid = CarData[vehicleid][carID];
		if(sscanf(string, "i", locked)) return SendUsageMessage(playerid, "/aduzenle siren [0/1]");
		if(locked < 0 || locked > 1) return SendErrorMessage(playerid, "Hatal� siren durumu girdin. (0/1)");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n siren durumunu %s olarak g�ncelledi.", vehicleid, !locked ? ("pasif") : ("aktif"));
		CarData[vehicleid][carSiren] = bool:locked;
		Car_Save(vehicleid);

		Vehicle_DefaultValues(vehicleid);
		DestroyVehicle(vehicleid);

		new query[55];
		mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM vehicles WHERE id = %i", dbid);
		mysql_tquery(m_Handle, query, "SQL_LoadVehicles");
		return 1;
	}
	else if (!strcmp(type, "kiraucreti", true))
	{
		if(!IsValidRentalCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece kiral�k ara�larda kullan�l�r.");

		new kira;
		if(sscanf(string, "i", kira)) return SendUsageMessage(playerid, "/aduzenle kiraucreti [miktar(1-5000)]");
		if(kira < 1 || kira > 5000) return SendErrorMessage(playerid, "Kira miktar� en az 1 en fazla 5000 olabilir.");

		CarData[vehicleid][carRentalPrice] = kira;
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n kira �cretini $%s olarak g�ncelledin.", vehicleid, MoneyFormat(kira));
		Car_Save(vehicleid);
		return 1;
	}
	else if (!strcmp(type, "kiralayan", true))
	{
		if(!IsValidRentalCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece kiral�k ara�larda kullan�l�r.");

		new kiralayan;
		if(sscanf(string, "I(-1)", kiralayan)) 
		{
			SendUsageMessage(playerid, "/aduzenle kiralayan [oyuncu ID/ad�]");
			SendInfoMessage(playerid, "ID k�sm�n� bo� b�rak�rsan�z ara� kiras� d��er.");
			return 1;
		}

		if(kiralayan != -1)
		{
			if(!IsPlayerConnected(kiralayan)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
			if(!pLoggedIn[kiralayan]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
			if(PlayerData[kiralayan][pRentCarKey]) return SendErrorMessage(playerid, "Belirtti�iniz ki�inin kiral�k arac� bulunuyor.");
			
			CarData[vehicleid][carRentedBy] = PlayerData[kiralayan][pSQLID];
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n kirac�s�n� %s olarak g�ncelledin.", vehicleid, ReturnSQLName(CarData[vehicleid][carRentedBy]));
			PlayerData[kiralayan][pRentCarKey] = CarData[vehicleid][carID];
		} else {
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� arac�n kirac�s�n� s�f�rlad�n.", vehicleid);
			foreach(new i : Player) if(PlayerData[i][pRentCarKey] == CarData[vehicleid][carID]) PlayerData[i][pRentCarKey] = 0;
			CarData[vehicleid][carRentedBy] = 0;
		}

		Car_Save(vehicleid);
		return 1;
	}
 	return 1;
}

Car_Save(vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID) return 0;

	new 
		query[354];

	GetVehicleHealth(vehicleid, CarData[vehicleid][carLastHealth]);
	GetVehicleDamageStatus(vehicleid, CarData[vehicleid][carPanelStatus], CarData[vehicleid][carDoorsStatus], CarData[vehicleid][carLightsStatus], CarData[vehicleid][carTiresStatus]);
	GetVehicleParamsCarWindows(vehicleid, CarData[vehicleid][carWindows][0], CarData[vehicleid][carWindows][1], CarData[vehicleid][carWindows][2], CarData[vehicleid][carWindows][3]);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE vehicles SET ModelID = %i, OwnerID = %i, FactionID = %i, RentalID = %i, RentalPrice = %i, RentedBy = %i WHERE id = %i", 
		CarData[vehicleid][carModel], 
		CarData[vehicleid][carOwnerID],
		CarData[vehicleid][carFaction], 
		CarData[vehicleid][carRental],
		CarData[vehicleid][carRentalPrice],
		CarData[vehicleid][carRentedBy],
		CarData[vehicleid][carID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE vehicles SET Plate = '%e', VehicleName = '%e', CarSign = '%e' WHERE id = %i", 
		CarData[vehicleid][carPlates], 
		CarData[vehicleid][carName],
		CarData[vehicleid][carSign],
		CarData[vehicleid][carID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE vehicles SET PosX = %f, PosY = %f, PosZ = %f, PosA = %f, Interior = %i, World = %i, Color1 = %i, Color2 = %i WHERE id = %i", 
		CarData[vehicleid][carPos][0], 
		CarData[vehicleid][carPos][1], 
		CarData[vehicleid][carPos][2], 
		CarData[vehicleid][carPos][3], 
		CarData[vehicleid][carInterior], 
		CarData[vehicleid][carWorld],
		CarData[vehicleid][carColor1], 
		CarData[vehicleid][carColor2],
		CarData[vehicleid][carID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE vehicles SET XMR = %i, Siren = %i, Locked = %i, Impounded = %i, Fuel = %f, Mileage = %f, Armour = %f, EngineLife = %f, BatteryLife = %f WHERE id = %i", 
		CarData[vehicleid][carXMR], 
		CarData[vehicleid][carSiren], 
		CarData[vehicleid][carLocked], 
		CarData[vehicleid][carImpounded], 
		CarData[vehicleid][carFuel], 
		CarData[vehicleid][carMileage],
		CarData[vehicleid][carArmour], 
		CarData[vehicleid][carEngine],
		CarData[vehicleid][carBattery],
		CarData[vehicleid][carID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE vehicles SET LockLevel = %i, AlarmLevel = %i, ImmobLevel = %i, Insurance = %i, InsuranceTime = %i, InsurancePrice = %i, TimesDestroyed = %i, Paintjob = %i WHERE id = %i", 
		CarData[vehicleid][carLock], 
		CarData[vehicleid][carAlarm], 
		CarData[vehicleid][carImmob], 
		CarData[vehicleid][carInsurance], 
		CarData[vehicleid][carInsuranceTime], 
		CarData[vehicleid][carInsurancePrice],
		CarData[vehicleid][carTimeDestroyed], 
		CarData[vehicleid][carPaintjob],
		CarData[vehicleid][carID]
	);
	mysql_tquery(m_Handle, query);

	for(new m; m < 14; m++)
	{
		mysql_format(m_Handle, query, sizeof(query), "UPDATE vehicles SET CarMods%i = %i WHERE id = %i", 
			m+1, 
			CarData[vehicleid][carMods][m], 
			CarData[vehicleid][carID]
		);
		mysql_tquery(m_Handle, query);

		if(m < 4)
		{
			mysql_format(m_Handle, query, sizeof(query), "UPDATE vehicles SET CarDoors%i = %i, CarWindows%i = %i WHERE id = %i", 
				m+1, 
				CarData[vehicleid][carDoors][m],
				m+1,
				CarData[vehicleid][carWindows][m],
				CarData[vehicleid][carID]
			);
			mysql_tquery(m_Handle, query);
		}
	}

	mysql_format(m_Handle, query, sizeof(query), "UPDATE vehicles SET LastDriver = %i, LastPassenger = %i, LastHealth = %f, Panels = %i, Doors = %i, Lights = %i, Tires = %i WHERE id = %i", 
		CarData[vehicleid][carlastDriver], 
		CarData[vehicleid][carlastPassenger],
		CarData[vehicleid][carLastHealth],
		CarData[vehicleid][carPanelStatus],
		CarData[vehicleid][carDoorsStatus],
		CarData[vehicleid][carLightsStatus],
		CarData[vehicleid][carTiresStatus],
		CarData[vehicleid][carID]
	);
	mysql_tquery(m_Handle, query);

	for(new i = 1; i < MAX_PACK_SLOT; ++i)
	{
		if(!vehicle_drug_data[vehicleid][i][is_exist]) continue;

		mysql_format(m_Handle, query, sizeof(query), "UPDATE vehicle_drugs SET drug_name = '%e', drug_type = %i, drug_amount = %f, drug_quality = %i, drug_size = %i WHERE id = %i", 
			vehicle_drug_data[vehicleid][i][veh_drug_name],
			vehicle_drug_data[vehicleid][i][veh_drug_id],
			vehicle_drug_data[vehicleid][i][veh_drug_amount],
			vehicle_drug_data[vehicleid][i][veh_drug_quality],
			vehicle_drug_data[vehicleid][i][veh_drug_size],
			vehicle_drug_data[vehicleid][i][data_id]
		);
		mysql_tquery(m_Handle, query);
	}
	return 1;
}