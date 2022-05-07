/*CMD:oyuncuduzenle(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	new id, opt[90], value;
	if(sscanf(params, "us[90]I(-1)", id, opt, value))
	{
		SendUsageMessage(playerid, "/oyuncuduzenle [oyuncu ID/isim] [düzenlenecek alan]");

	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[seviye][exp][banka][mevduat][intworld]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[complexlink][seviye][fiyat][seviye][kirafiyat][kilit]");

		SendClientMessage(playerid, COLOR_GRAD2, "|level, exp, bank, paycheck, radio, bmx, timeplayed, driverlicense, weaponslicense|");
		SendClientMessage(playerid, COLOR_GRAD1, "|phone, burnerphone, carspawned, carspawnedid|");
		return 1;
	}

	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");

	if(!strcmp(opt, "seviye", true))
	{
		if(value == -1) return SendUsageMessage(playerid, "/oyuncuduzenle [oyuncu ID/isim] seviye [deðer]");
		if(value < 1) SendErrorMessage(playerid, "Belirtilen oyuncu seviyesi en az 1 olabilir.")
		SendClientMessage(playerid, COLOR_ADM, "SERVER: %s isimli oyuncunun seviyesini %i olarak ayarladýn.", ReturnName(id, 1), value);
		SaveSQLInt(PlayerData[id][pSQLID], "players", "Level", value);
		PlayerData[id][pLevel] = value;
		SetPlayerScore(id, value);
		return 1;
	}
	else if(!strcmp(opt, "exp", true))
	{
		if(value == -1) return SendUsageMessage(playerid, "/oyuncuduzenle [oyuncu ID/isim] exp [deðer]");
		SendClientMessage(playerid, COLOR_ADM, "SERVER: %s isimli oyuncunun deneyim puanýný %i olarak ayarladýn.", ReturnName(id, 1), value);
		SaveSQLInt(PlayerData[id][pSQLID], "players", "Exp", value);
		PlayerData[id][pExp] = value;
		return 1;
	}
	else if(!strcmp(opt, "banka", true))
	{
		if(value == -1) return SendUsageMessage(playerid, "/oyuncuduzenle [oyuncu ID/isim] banka [deðer]");
		adminWarn(4, sprintf("%s isimli yönetici %s isimli oyuncunun bankadaki parasýný $%s olarak ayarladý.", ReturnName(playerid, 1), ReturnName(id, 1), MoneyFormat(value)));
		SendClientMessage(playerid, COLOR_ADM, "SERVER: %s isimli oyuncunun bankadaki parasýný $%s olarak ayarladýn.", ReturnName(id, 1), MoneyFormat(value));
		SaveSQLInt(PlayerData[id][pSQLID], "players", "Bank", value);
		PlayerData[id][pBank] = value;
		return 1;
	}
	else if(!strcmp(opt, "mevduat", true))
	{
		if(value == -1) return SendUsageMessage(playerid, "/oyuncuduzenle [oyuncu ID/isim] mevduat [deðer]");
		adminWarn(4, sprintf("%s isimli yönetici %s isimli oyuncunun mevduatýný $%s olarak ayarladý.", ReturnName(playerid, 1), ReturnName(id, 1), MoneyFormat(value)));
		SendClientMessage(playerid, COLOR_ADM, "SERVER: %s isimli oyuncunun mevduatýný $%s olarak ayarladýn.", ReturnName(id, 1), MoneyFormat(value));
		SaveSQLInt(PlayerData[id][pSQLID], "players", "Savings", value);
		PlayerData[id][pSavings] = value;
		return 1;
	}
	else if(strmatch(opt, "paycheck")){
		if(value == -1)return SendClientMessage(playerid, COLOR_ADM, "KULLANIM:{FFFFFF} /setstats [playerid OR name] paycheck [value]");

		PlayerData[playerb][pPaycheck] = value;
		SaveSQLInt(saveid, "players", "Paycheck", PlayerData[playerb][pPaycheck]);

		format(string, sizeof(string), "SERVER: You set %s's paycheck to $%s", ReturnName(playerb, 1), MoneyFormat(value));
		SendClientMessage(playerid, COLOR_YELLOW, string);

		format(string, sizeof(string), "%s set %s's paycheck money to $%s", ReturnName(playerid, 1), ReturnName(playerb, 1), MoneyFormat(value));
		adminWarn(4, string);

		//WriteLog("admin_logs/setstats_log.txt", "[%s] %s set %s's PAYCHECK to %d", ReturnDate(), ReturnName(playerid, 1), ReturnName(playerb, 1), value);
	}
	else if(strmatch(opt, "radio"))
	{
		if(value == -1)return SendClientMessage(playerid, COLOR_ADM, "KULLANIM:{FFFFFF} /setstats [playerid OR name] radio [value]");

		PlayerData[playerb][pHasRadio] = value;
		SaveSQLInt(saveid, "players", "HasRadio", PlayerData[playerb][pHasRadio]);

		if(value == 0){
			format(string, sizeof(string), "SERVER: You took %s's radio.", ReturnName(playerid, 1));
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		else{
			format(string, sizeof(string), "SERVER: You gave %s a radio.", ReturnName(playerb, 1));
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}

		//WriteLog("admin_logs/setstats_log.txt", "[%s] %s set %s's Radio to %d", ReturnDate(), ReturnName(playerid, 1), ReturnName(playerb, 1), value);
	}
	else if(strmatch(opt, "timeplayed")){
		if(value == -1)return SendClientMessage(playerid, COLOR_ADM, "KULLANIM:{FFFFFF} /setstats [playerid OR name] timeplayed [value]");

		PlayerData[playerb][pOnlineTime] = value;
		SaveSQLInt(saveid, "players", "OnlineTime", PlayerData[playerid][pOnlineTime]);

		format(string, sizeof(string), "SERVER: You set %s's time played to %d", ReturnName(playerb, 1), value);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		//WriteLog("admin_logs/setstats_log.txt", "[%s] %s set %s's Time Played to %d", ReturnDate(), ReturnName(playerid, 1), ReturnName(playerb, 1), value);
	}
	else if(strmatch(opt, "driverlicense")){
		if(value == -1)return SendClientMessage(playerid, COLOR_ADM, "KULLANIM:{FFFFFF} /setstats [playerid OR name] driverlicense [value]");

		PlayerData[playerb][pDriversLicense] = value;
		SaveSQLInt(saveid, "players", "DriversLicense", PlayerData[playerid][pDriversLicense]);

		if(value >= 1)
			format(string, sizeof(string), "SERVER: You gave %s a driver's license", ReturnName(playerb, 1));
		else
			format(string, sizeof(string), "SERVER: You took %s's driver's license", ReturnName(playerb, 1));

		SendClientMessage(playerid, COLOR_YELLOW, string);

		//WriteLog("admin_logs/setstats_log.txt", "[%s] %s set %s's DriversLicense to %d", ReturnDate(), ReturnName(playerid, 1), ReturnName(playerb, 1), value);
	}
	else if(strmatch(opt, "weaponslicense")){
		if(value == -1)return SendClientMessage(playerid, COLOR_ADM, "KULLANIM:{FFFFFF} /setstats [playerid OR name] weaponslicense [value]");

		PlayerData[playerb][pWeaponsLicense] = value;
		SaveSQLInt(saveid, "players", "WeaponsLicense", PlayerData[playerid][pWeaponsLicense]);

		if(value >= 1)
			format(string, sizeof(string), "SERVER: You gave %s a weapon's license", ReturnName(playerb, 1));
		else
			format(string, sizeof(string), "SERVER: You took %s's weapon's license", ReturnName(playerb, 1));

		SendClientMessage(playerid, COLOR_YELLOW, string);

		//WriteLog("admin_logs/setstats_log.txt", "[%s] %s set %s's WeaponsLicense to %d", ReturnDate(), ReturnName(playerid, 1), ReturnName(playerb, 1), value);
	}
	else if(strmatch(opt, "phone")){
		if(value == -1)return SendClientMessage(playerid, COLOR_ADM, "KULLANIM: /setstats [oyuncuID/isim] phone [new phone]");

		if(value == 911 || value == MECHANIC_NUMBER || value == TAXI_NUMBER)
			return SendClientMessage(playerid, COLOR_ADM, "Not allowed.");

		new query[128];

		mysql_format(m_Handle, query, sizeof(query), "SELECT id FROM players WHERE Phone = %i", value);
		mysql_tquery(m_Handle, query, "IfPhoneExists", "iii", playerid, playerb, value);
	}
	else if(strmatch(opt, "burnerphone")){
		if(value == -1)return SendClientMessage(playerid, COLOR_ADM, "KULLANIM: /setstats [oyuncuID/isim] burnerphone [new phone]");

		if(value == 911 || value == MECHANIC_NUMBER || value == TAXI_NUMBER)
			return SendClientMessage(playerid, COLOR_ADM, "Not allowed.");

		new query[128];

		mysql_format(m_Handle, query, sizeof(query), "SELECT id FROM players WHERE BurnerPhoneNumber = %i", value);
		mysql_tquery(m_Handle, query, "IfBPhoneExists", "iii", playerid, playerb, value);
	}
	else if(strmatch(opt, "carspawned")){
		if(value == -1)
		{
			SendClientMessage(playerid, COLOR_ADM, "KULLANIM: /setstats [oyuncuID/isim] hascarspawned [0/1]");
			SendClientMessageEx(playerid, COLOR_ADM, "%s %s", ReturnName(playerb), (_has_vehicle_spawned[playerb] != 1) ? ("does not have a vehicle spawned.") : ("has a vehicle spawned right now."));
			return 1;
		}

		if(value < 0 || value > 1)return SendClientMessage(playerid, COLOR_ADM, "Value has to be 0-1. 1 is true, 0 is false");

		_has_vehicle_spawned[playerb] = value;

		format(string, sizeof(string), "%s set %s's HasVehicleSpawned var to %s", ReturnName(playerid), ReturnName(playerb), (value != 1) ? ("false") : ("true"));
		adminWarn(4, string);
	}
	else if(strmatch(opt, "carspawnedid")){
		if(value == -1)
			return SendClientMessage(playerid, COLOR_ADM, "KULLANIM: /setstats [oyuncuID/isim] carspawnedid [vehicleid]");

		if(!IsValidVehicle(value))
			return SendClientMessage(playerid, COLOR_ADM, "HATA: That isn't a valid vehicle.");

		_has_spawned_vehicleid[playerb] = value;

		format(string, sizeof(string), "%s set %s's VehicleSpawnedID var to %d", ReturnName(playerid), ReturnName(playerb), value);
		adminWarn(4, string);
	}
	else return SendClientMessage(playerid, COLOR_ADM, "SERVER: Geçersiz Parametre.");
	return true;
}*/