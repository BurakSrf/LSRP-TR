stock IsIllegalFaction(playerid)
{
	if(PlayerData[playerid][pFaction] == -1)
		return 0;

	new Factionid = PlayerData[playerid][pFaction];

	if(!FactionData[Factionid][FactionCopPerms] && !FactionData[Factionid][FactionMedPerms])
		return 1;

	return 0;
}

IsPoliceFaction(playerid)
{
	if(PlayerData[playerid][pFaction] == -1)
		return 0;

	new Factionid = PlayerData[playerid][pFaction];

	if (FactionData[Factionid][FactionCopPerms])
		return 1;

	return 0;
}

IsMedicFaction(playerid)
{
	if(PlayerData[playerid][pFaction] == -1)
		return 0;

	new Factionid = PlayerData[playerid][pFaction];

	if (FactionData[Factionid][FactionMedPerms])
		return 1;

	return 0;
}

IsLAWFaction(playerid)
{
	if(PlayerData[playerid][pFaction] == -1)
		return 0;

	new Factionid = PlayerData[playerid][pFaction];
	if (FactionData[Factionid][FactionMedPerms] || FactionData[Factionid][FactionCopPerms])
		return 1;

	return 0;
}

CMD:apb(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	
	APB_RouteCommands(playerid, params);
	return 1;
}

APB_RouteCommands(playerid, cmdtext[])
{
    new command[8], parameters[128];
    sscanf(cmdtext, "s[8]s[128]", command, parameters);

	if(strlen(command) == 0) {
		SendClientMessage(playerid, COLOR_GREY, "KULLANIM: /apb [komut]");
		SendClientMessage(playerid, COLOR_GREY, "Ýpucu: '/apb yardim' yazarak tüm listeyi görebilirsin.");
		return 1;
	}

    if(strcmp("yarat", command) == 0) APBCMD_Create(playerid, parameters);
    else if(strcmp("sil", command) == 0) APBCMD_Delete(playerid, parameters);
    else if(strcmp("duzenle", command) == 0) APBCMD_Edit(playerid, parameters);
    else if(strcmp("detay", command) == 0) APBCMD_Info(playerid, parameters);
	else if(strcmp("liste", command) == 0) APBCMD_List(playerid);
 	else if(strcmp("yardim", command) == 0) APBCMD_Help(playerid);
	return 1;
}

APBCMD_Create(const playerid, const parameters[]) {
	new apb_text[128];

	if(sscanf(parameters, "s[128]", apb_text)) {
		SendUsageMessage(playerid, "/apb yarat [içerik]");
		return 1;
	}

	if(strlen(apb_text) < 10 || strlen(apb_text) > 128) {
		SendErrorMessage(playerid, "APB içeriði en az 10 karakter en fazla 128 karakter olmalýdýr.");
		return 1;
	}

	new id = Iter_Free(Bullettins);
	if(id == -1) {
		SendErrorMessage(playerid, "Listede çok fazla APB bulunuyor, ekleyebilmek için listeden bir kaçýný temizlemen gerekiyor.");
		return 1;
	}

	new query[454];
	mysql_format(m_Handle, query, sizeof(query), "INSERT INTO bulletins (BulletinDetails, BullettinBy, BulletinDate) VALUES('%e', %i, %i)", apb_text, PlayerData[playerid][pSQLID], Time());
	new Cache:cache = mysql_query(m_Handle, query);
	
	APBData[id][BulletinID] = cache_insert_id();
	format(APBData[id][BulletinDetails], 128, "%s", apb_text);
	APBData[id][BulletinBy] = PlayerData[playerid][pSQLID];
	APBData[id][BulletinDate] = Time();
	
	Iter_Add(Bullettins, id);
	SendLawMessage(COLOR_ADM, sprintf("%s %s yeni bir APB kaydý ekledi. (/apb detay %i)", Player_GetFactionRank(playerid), ReturnName(playerid, 0), id+1));
	
	cache_delete(cache);
    return 1;
}

APBCMD_Delete(const playerid, const parameters[]) {
	new id;

	if(sscanf(parameters, "i", id)) {
		SendUsageMessage(playerid, "/apb sil [apb ID]");
		return 1;
	}

	if(!Iter_Contains(Bullettins, (id-1))) {
		SendErrorMessage(playerid, "Belirttiðin APB kayýdý bulunamadý.");
		return 1;
	}

	Iter_Remove(Bullettins, id-1);
	SendLawMessage(COLOR_ADM, sprintf("%s %s %d numaralý APB kaydýný temizledi!", Player_GetFactionRank(playerid), ReturnName(playerid, 0), id));

	new query[60];
	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM bullettins WHERE id = %i", APBData[id-1][BulletinID]);
	mysql_tquery(m_Handle, query);
	return 1;
}

APBCMD_Edit(const playerid, const parameters[]) {
	new id, apb_text[128];

	if(sscanf(parameters, "is[128]", id, apb_text)) {
		SendUsageMessage(playerid, "/apb duzenle [apb ID] [içerik]");
		return 1;
	}

	if(!Iter_Contains(Bullettins, (id-1))) {
		SendErrorMessage(playerid, "Belirttiðin APB kayýdý bulunamadý.");
		return 1;
	}

	if(strlen(apb_text) < 10 || strlen(apb_text) > 128) {
		SendErrorMessage(playerid, "APB içeriði en az 10 karakter en fazla 128 karakter olmalýdýr.");
		return 1;
	}

	SendLawMessage(COLOR_ADM, sprintf("%s %s %d numaralý APB kaydýný düzenledi!", Player_GetFactionRank(playerid), ReturnName(playerid, 0), id));
	format(APBData[id-1][BulletinDetails], 128, "%s", apb_text);
	APBData[id-1][BulletinBy] = PlayerData[playerid][pSQLID];
	APBData[id-1][BulletinDate] = Time();

	new query[255];
	mysql_format(m_Handle, query, sizeof(query), "UPDATE bullettins SET BullettinDetails = '%e', BullettinBy = %i, BullettinDate = %i WHERE id = %i", APBData[id-1][BulletinDetails], APBData[id-1][BulletinBy], APBData[id-1][BulletinDate], APBData[id-1][BulletinID]);
	mysql_tquery(m_Handle, query);
	return 1;
}

APBCMD_Info(const playerid, const parameters[]) {
	new id;

	if(sscanf(parameters, "i", id)) {
		SendUsageMessage(playerid, "/apb detay [apb ID]");
		return 1;
	}

	if(!Iter_Contains(Bullettins, (id-1))) {
		SendErrorMessage(playerid, "Belirttiðin APB kayýdý bulunamadý.");
		return 1;
	}

	SendClientMessageEx(playerid, COLOR_ADM, "___________All Point Bulletin(%i)_________", id);
	SendClientMessageEx(playerid, COLOR_ADM, "Ýçerik: %s", APBData[id-1][BulletinDetails]);
	SendClientMessageEx(playerid, COLOR_ADM, "Ekleyen: %s", ReturnSQLName(APBData[id-1][BulletinBy]));
	SendClientMessageEx(playerid, COLOR_ADM, "Tarih: %s", GetFullTime(APBData[id-1][BulletinDate]));
	SendClientMessage(playerid, COLOR_ADM, "_______________________________________");
	return 1;
}

APBCMD_List(const playerid) 
{
	SendClientMessageEx(playerid, COLOR_ADM, "___________All Point Bulletins(%i)_________", Iter_Count(Bullettins));
	foreach(new i : Bullettins) SendClientMessageEx(playerid, COLOR_ADM, "%i. APB: %s", (i+1), APBData[i][BulletinDetails]);
	SendClientMessage(playerid, COLOR_ADM, "_______________________________________");
	return 1;
}

APBCMD_Help(const playerid) {
	SendClientMessage(playerid, COLOR_ORANGE, "APB Sistemi:");
	SendClientMessage(playerid, COLOR_ORANGE, "/apb yarat - [þüpheli]//[suçlar] (John Doe, Kýrmýzý Sentinel // Cinayet)");
	SendClientMessage(playerid, COLOR_ORANGE, "/apb sil - Belirtilen APB kaydýný kalýcý olarak siler.");
	SendClientMessage(playerid, COLOR_ORANGE, "/apb detay - Belirtilen APB kaydýnýn detaylarýný gösterir.");
	SendClientMessage(playerid, COLOR_ORANGE, "/apb duzenle - Belirtilen APB kaydýný düzenler.");
	SendClientMessage(playerid, COLOR_ORANGE, "/apb liste - Tüm APB kayýtlarýný listeler.");
	return 1;
}

CMD:uyustest(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	
	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/uyustest [oyuncu ID/isim]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, id, 4.5)) return SendErrorMessage(playerid, "Belirttiðin kiþiye yakýn deðilsin.");
	SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s sobriety test cihazýný %s üzerinde kullanýr.", ReturnName(playerid, 0), ReturnName(id, 0));
	Drug_ReturnData(playerid, id);
	return 1;
}

CMD:engel(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty] && !PlayerData[playerid][pMEDduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

	Roadblock_RouteCommands(playerid, params);
	return 1;
}

Roadblock_RouteCommands(playerid, cmdtext[])
{
    new command[6];
    sscanf(cmdtext, "s[8]", command);

	if(strlen(command) == 0) {
		SendClientMessage(playerid, COLOR_GREY, "KULLANIM: /engel [komut]");
		SendClientMessage(playerid, COLOR_GREY, "Ýpucu: '/engel yardim' yazarak tüm listeyi görebilirsin.");
		return 1;
	}

    if(strcmp("ekle", command) == 0) RoadblockCMD_Create(playerid);
    else if(strcmp("kaldir", command) == 0) RoadblockCMD_Delete(playerid);
    else if(strcmp("duzenle", command) == 0) RoadblockCMD_Edit(playerid);
	else if(strcmp("liste", command) == 0) RoadblockCMD_List(playerid);
 	else if(strcmp("yardim", command) == 0) RoadblockCMD_Help(playerid);
	return 1;
}

RoadblockCMD_Create(const playerid)
{
	if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");
	Roadblock_List(playerid);
    return 1;
}

RoadblockCMD_Edit(const playerid)
{
	if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

	new id = -1;
	if((id = Roadblock_Nearest(playerid)) != -1)
	{
		EditingID[playerid] = id;
		EditingObject[playerid] = 6;
		EditDynamicObject(playerid, RoadblockData[id][RoadblockObject]);
	}
	else SendErrorMessage(playerid, "Yakýnýnda engel bulunmuyor.");
    return 1;
}

RoadblockCMD_Delete(const playerid)
{
	if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

	new
		id = -1;

	if((id = Roadblock_Nearest(playerid)) != -1)
	{
		ConfirmDialog(playerid, "Onay", sprintf("Yakýnýndaki '{ADC3E7}%s{FFFFFF}' isimli engeli kaldýrmak konusunda emin misin?", RoadblockData[id][RoadblockName]), "OnRoadblockDisband", id);
	}
	else SendErrorMessage(playerid, "Yakýnýnda engel bulunmuyor.");
    return 1;
}

Server:OnRoadblockDisband(playerid, response, id)
{
	if(response)
	{
	    if(IsValidDynamicObject(RoadblockData[id][RoadblockObject])) DestroyDynamicObject(RoadblockData[id][RoadblockObject]);
		if(IsValidDynamicArea(RoadblockData[id][RoadblockAreaID])) {
	    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, RoadblockData[id][RoadblockAreaID], E_STREAMER_PLAYER_ID, id);
		    DestroyDynamicArea(RoadblockData[id][RoadblockAreaID]);
		}
		
		RoadblockData[id][RoadblockSpikes] = false;
		Iter_Remove(Roadblocks, id);
	}
	return 1;
}

Roadblock_Nearest(playerid)
{
	return GetPVarInt(playerid, "AtSpike");
}

Roadblock_Create(playerid, modelid, block_name[])
{
	new id = Iter_Free(Roadblocks);
	if(id == -1) return SendErrorMessage(playerid, "Þu anda daha fazla engel eklenemiyor.");

    RoadblockData[id][RoadblockModelID] = modelid;
	if(modelid == 2892 || modelid == 2899) RoadblockData[id][RoadblockSpikes] = true;
	GetPlayerPos(playerid, RoadblockData[id][RoadblockPos][0], RoadblockData[id][RoadblockPos][1], RoadblockData[id][RoadblockPos][2]);
	GetXYInFrontOfPlayer(playerid, RoadblockData[id][RoadblockPos][0], RoadblockData[id][RoadblockPos][1], 1.0); 
	RoadblockData[id][RoadblockPos][3] = RoadblockData[id][RoadblockPos][4] = RoadblockData[id][RoadblockPos][5] = 0.0;
    RoadblockData[id][RoadblockInterior] = GetPlayerInterior(playerid);
    RoadblockData[id][RoadblockWorld] = GetPlayerVirtualWorld(playerid);

	format(RoadblockData[id][RoadblockName], 25, "%s", block_name);
	format(RoadblockData[id][RoadblockPlacedBy], 25, "%s", ReturnName(playerid));
   	format(RoadblockData[id][RoadblockLocation], 40, "%s", Player_GetLocation(playerid));
	Iter_Add(Roadblocks, id);

	EditingID[playerid] = id;
	EditingObject[playerid] = 6;
	RoadblockData[id][RoadblockObject] = CreateDynamicObject(RoadblockData[id][RoadblockModelID], RoadblockData[id][RoadblockPos][0], RoadblockData[id][RoadblockPos][1], RoadblockData[id][RoadblockPos][2], RoadblockData[id][RoadblockPos][3], RoadblockData[id][RoadblockPos][4], RoadblockData[id][RoadblockPos][5], RoadblockData[id][RoadblockWorld], RoadblockData[id][RoadblockInterior]);
	EditDynamicObject(playerid, RoadblockData[id][RoadblockObject]);

	new array[2]; array[0] = 23; array[1] = id;
	RoadblockData[id][RoadblockAreaID] = CreateDynamicSphere(RoadblockData[id][RoadblockPos][0], RoadblockData[id][RoadblockPos][1], RoadblockData[id][RoadblockPos][2], 3.5, RoadblockData[id][RoadblockWorld], RoadblockData[id][RoadblockInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, RoadblockData[id][RoadblockAreaID], E_STREAMER_EXTRA_ID, array, 2);

	SendClientMessageEx(playerid, -1, "SERVER: {ADC3E7}%s {FFFFFF}tipinde engel ekliyorsun. Duracaðý noktayý ayarlayýp kaydet.", RoadblockData[id][RoadblockName]);
	return 1;
}

Roadblock_Refresh(id)
{
    if(IsValidDynamicObject(RoadblockData[id][RoadblockObject])) DestroyDynamicObject(RoadblockData[id][RoadblockObject]);
	if(IsValidDynamicArea(RoadblockData[id][RoadblockAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, RoadblockData[id][RoadblockAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(RoadblockData[id][RoadblockAreaID]);
	}

	RoadblockData[id][RoadblockObject] = CreateDynamicObject(RoadblockData[id][RoadblockModelID], RoadblockData[id][RoadblockPos][0], RoadblockData[id][RoadblockPos][1], RoadblockData[id][RoadblockPos][2], RoadblockData[id][RoadblockPos][3], RoadblockData[id][RoadblockPos][4], RoadblockData[id][RoadblockPos][5], RoadblockData[id][RoadblockWorld], RoadblockData[id][RoadblockInterior]);
	new array[2]; array[0] = 23; array[1] = id;
	RoadblockData[id][RoadblockAreaID] = CreateDynamicSphere(RoadblockData[id][RoadblockPos][0], RoadblockData[id][RoadblockPos][1], RoadblockData[id][RoadblockPos][2], 3.5, RoadblockData[id][RoadblockWorld], RoadblockData[id][RoadblockInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, RoadblockData[id][RoadblockAreaID], E_STREAMER_EXTRA_ID, array, 2);
	return 1;
}

RoadblockCMD_List(const playerid) 
{
	new 
		primary[600], sub[100], count = 0;

    foreach(new i : Roadblocks)
	{
		format(sub, sizeof(sub), "%s {AFAFAF}[%s - %s]\n", RoadblockData[i][RoadblockName], RoadblockData[i][RoadblockPlacedBy], RoadblockData[i][RoadblockLocation]);
		strcat(primary, sub);
		count++;
	}

	if(!count) return SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}Hiç engel bulunamadý.");
	else ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_LIST, "Aktif Engel Listesi", primary, "Tamam", "<<");
	return 1;
}

RoadblockCMD_Help(const playerid) 
{
	SendClientMessage(playerid, COLOR_ORANGE, "Engel Sistemi:");
	SendClientMessage(playerid, COLOR_ORANGE, "/engel ekle - Yakýnýnýza engeli eklemeyi saðlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/engel kaldir - Yakýnýnýzdaki engeli kaldýrmayý saðlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/engel duzenle - Yakýnýnýzdaki engeli düzenlemenizi saðlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/engel liste - Eklenmiþ engelleri görmenizi saðlar.");
	return 1;
}

CMD:rozet(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	
	new playerb;
	if (sscanf(params, "u", playerb)) return SendUsageMessage(playerid, "/rozet [oyuncu ID/isim]");
	if(!IsPlayerConnected(playerb)) return SendServerMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[playerb]) return SendServerMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, playerb, 4.5)) return SendServerMessage(playerid, "Belirttiðin kiþiye yakýn deðilsin.");

	if (playerb == playerid)
 		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s kendi rozetine bakýnýr.", ReturnName(playerid, 0));
	else
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s, %s adlý kiþiye rozetini gösterir.", ReturnName(playerid, 0), ReturnName(playerb, 0));

	SendClientMessage(playerb, COLOR_COP, "______________________________________");
	SendClientMessageEx(playerb, COLOR_GRAD2, "  Ýsim: %s", ReturnNameLetter(playerid));
	SendClientMessageEx(playerb, COLOR_GRAD2, "  Rütbe: %s", Player_GetFactionRank(playerid));
	SendClientMessageEx(playerb, COLOR_GRAD2, "  Birlik: %s", Faction_GetName(PlayerData[playerid][pFaction]));
	SendClientMessageEx(playerb, COLOR_GRAD2, "  Rozet Numarasý: #%i", ReturnBadgeNumber(playerid));
	SendClientMessage(playerb, COLOR_COP, "______________________________________");
	return 1;
}

CMD:cctv(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	
	if(CCTVID[playerid] == -1) {
		if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Herhangi bir araç içerisinde deðilsin.");
		if(GetPlayerVehicleSeat(playerid) > 1) return SendErrorMessage(playerid, "Arka koltukta CCTV kullanamazsýn.");
	
		new
			vehicleid = GetPlayerVehicleID(playerid);
		if(!FactionData[CarData[vehicleid][carFaction]][FactionMedPerms]) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Bu araçta CCTV kullanamazsýn.");
	}

	Camera_List(playerid);
	return 1;
}

CMD:siren(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Herhangi bir araç içerisinde deðilsin.");

	new vehicleid = GetPlayerVehicleID(playerid);
	if(CarData[vehicleid][carFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlik aracý içerisinde deðilsin.");
	
	if(CarData[vehicleid][carSirenOn])
	{
	    CarData[vehicleid][carSirenOn] = false;
		DestroyDynamicObject(CarData[vehicleid][carSirenObject]);
		cmd_ame(playerid, "araçtan taþýnabilir sireni söker.");
	}
	else {
		static
    		Float:fSize[3],
    		Float:fSeat[3];

	    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]);
		GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONTSEAT, fSeat[0], fSeat[1], fSeat[2]);

        CarData[vehicleid][carSirenOn] = true;
		CarData[vehicleid][carSirenObject] = CreateDynamicObject(18646, 0.0, 0.0, 1000.0, 0.0, 0.0, 0.0);
	    AttachDynamicObjectToVehicle(CarData[vehicleid][carSirenObject], vehicleid, -fSeat[0], fSeat[1], fSize[2] / 2.0, 0.0, 0.0, 0.0);
		cmd_ame(playerid, "araca taþýnabilir siren baðlar.");
	}
	return 1;
}

CMD:pfver(playerid, params[])
{
	if(!IsPoliceFaction(playerid))
		return SendErrorMessage(playerid, "Bu komutu sadece PD kullanabilir.");

	if(!PlayerData[playerid][pLAWduty])
		return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

	new playerb;
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/pfver [oyuncu ID/isim]");

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[playerb])
		return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, playerb, 4.5))
		return SendErrorMessage(playerid, "Belirttiðin kiþiye yakýn deðilsin.");
	if(PlayerData[playerb][pWeaponsLicense])
		return SendErrorMessage(playerid, "Belirttiðiniz kiþinin silah lisansý bulunuyor.");

	PlayerData[playerb][pWeaponsLicense] = true;
	SendClientMessageEx(playerb, COLOR_YELLOW, "-> %s %s sana silah lisansý verdi.", Player_GetFactionRank(playerid), ReturnName(playerid, 1));
	SendLawMessage(COLOR_COP, sprintf("** HQ Duyurusu: %s %s, %s adlý kiþiye silah lisansý verdi! **", Player_GetFactionRank(playerid), ReturnName(playerid, 1), ReturnName(playerb, 1)));
	adminWarn(4, sprintf("%s, %s adlý kiþiye PF lisansý verdi.", ReturnName(playerid, 1), ReturnName(playerb, 1)));
	return true;
}

CMD:mdver(playerid, params[])
{
	if(!IsMedicFaction(playerid))
		return SendErrorMessage(playerid, "Bu komutu sadece FD kullanabilir.");

	if(!PlayerData[playerid][pMEDduty])
		return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
		
	new playerb;
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/mdver [oyuncu ID/isim]");

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[playerb])
		return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, playerb, 4.5))
		return SendErrorMessage(playerid, "Belirttiðin kiþiye yakýn deðilsin.");
	if(PlayerData[playerb][pMedicalLicense])
		return SendErrorMessage(playerid, "Belirttiðiniz kiþinin medikal lisansý bulunuyor.");

	PlayerData[playerb][pMedicalLicense] = true;
	SendClientMessageEx(playerb, COLOR_YELLOW, "-> %s %s sana medikal lisansý verdi.", Player_GetFactionRank(playerid), ReturnName(playerid, 1));
	SendLawMessage(COLOR_EMT, sprintf("** HQ Duyurusu: %s %s, %s adlý kiþiye medikal lisansý verdi! **", Player_GetFactionRank(playerid), ReturnName(playerid, 1), ReturnName(playerb, 1)));
	return true;
}

CMD:cezakes(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

	static playerb, amount, reason[128];
	
	if(sscanf(params, "uds[128]", playerb, amount, reason)) return SendUsageMessage(playerid, "/cezakes [oyuncu ID/isim] [miktar] [sebep]");
	//if(playerb == playerid) return SendServerMessage(playerid, "Bu komutu kendi üzerinde kullanamazsýn.");
	if(!IsPlayerConnected(playerb)) return SendServerMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[playerb]) return SendServerMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, playerb, 4.5)) return SendServerMessage(playerid, "Belirttiðiniz kiþiye yakýn deðilsin.");
	if(strlen(reason) < 3) return SendServerMessage(playerid, "Geçerli bir sebep giriniz.");
	if(amount < 1 || amount > 99999) return SendServerMessage(playerid, "Geçerli bir miktar giriniz.");

	static id = -1;
	for (new i = 0; i < MAX_FINES; i++)
	{
		if(Fines[playerb][i][fine_id]) continue;

		id = i;
		break;
	}

	if(id == -1) return SendErrorMessage(playerid, "Belirttiðin kiþinin çok fazla ödenmemiþ	 cezasý bulunuyor.");
		
	new query[256];
	mysql_format(m_Handle, query, sizeof(query), "INSERT INTO player_fines (player_dbid, issuer_name, fine_amount, fine_Faction, fine_reason, fine_date) VALUES(%i, '%e', %i, %i, '%e', %i)", PlayerData[playerb][pSQLID], ReturnName(playerid, 1), amount, PlayerData[playerid][pFaction], reason, Time());
	new Cache:cache = mysql_query(m_Handle, query);
	
	Fines[playerb][id][fine_id] = cache_insert_id();
	Fines[playerb][id][fine_amount] = amount;
	format(Fines[playerb][id][fine_issuer], 24, "%s", ReturnName(playerid, 1));
	format(Fines[playerb][id][fine_reason], 128, "%s", reason);
	Fines[playerb][id][fine_faction] = PlayerData[playerid][pFaction];
	Fines[playerb][id][fine_date] = Time();
	cache_delete(cache);

	cmd_me(playerid, sprintf("%s adlý kiþiye %s sebebinden $%s deðerinde ceza keser.", ReturnName(playerb, 0), reason, MoneyFormat(amount)));
	SendClientMessage(playerb, COLOR_ADM, sprintf("[!] %s tarafýndan sana ceza kesildi. Sebep: %s", ReturnName(playerid, 0), MoneyFormat(amount)));
	return 1;
}

CMD:acezakes(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	
	static targetid, amount, reason[128];
	if(sscanf(params, "iis[128]", targetid, amount, reason)) return SendUsageMessage(playerid, "/acezakes [araç ID] [miktar] [sebep] (araç ID görebilmek için /dl)");
	if(!IsValidVehicle(targetid)) return SendErrorMessage(playerid, "Belirttiðiniz araç oyunda yok.");

	new
		Float:x,
		Float:y,
		Float:z;

	GetVehiclePos(targetid, x, y, z);
	if(!IsPlayerInRangeOfPoint(playerid, 6.0, x, y, z)) return SendErrorMessage(playerid, "Belirttiðin aracýn yakýnýnda deðilsin.");
	if(!IsValidPlayerCar(targetid)) return SendErrorMessage(playerid, "Belirttiðin araca ceza kesemezsin.");
	if(strlen(reason) < 3) return SendErrorMessage(playerid, "Geçerli bir sebep giriniz.");
	if(amount < 1) return SendErrorMessage(playerid, "Geçerli bir miktar giriniz.");

	new id = -1;
	for(new i = 0; i < 30; i++)
	{
		if(VehicleFines[targetid][i][fine_id]) continue;

		id = i;
		break;
	}

	if(id == -1) return SendErrorMessage(playerid, "Belirttiðin aracýn çok fazla fazla cezasý bulunuyor.");

	new query[256];
	mysql_format(m_Handle, query, sizeof(query), "INSERT INTO vehicle_fines (vehicle_dbid, vehicle_x, vehicle_y, vehicle_z, issuer_name, fine_amount, fine_Faction, fine_reason, fine_date) VALUES(%i, %f, %f, %f, '%e', %i, %i, '%e', %i)", CarData[targetid][carID], x, y, z, ReturnName(playerid), amount, PlayerData[playerid][pFaction], reason, Time());
	new Cache:cache = mysql_query(m_Handle, query);
	
	VehicleFines[targetid][id][fine_id] = cache_insert_id();
	VehicleFines[targetid][id][fine_amount] = amount;
	VehicleFines[targetid][id][fine_x] = x;
	VehicleFines[targetid][id][fine_y] = y;
	VehicleFines[targetid][id][fine_z] = z;
	format(VehicleFines[targetid][id][fine_issuer], 24, "%s", ReturnName(playerid, 1));
	format(VehicleFines[targetid][id][fine_reason], 128, "%s", reason);
	VehicleFines[targetid][id][fine_faction] = PlayerData[playerid][pFaction];
	VehicleFines[targetid][id][fine_date] = Time();
	
	cache_delete(cache);
	cmd_me(playerid, sprintf("%s model araca %s sebebinden $%s deðerinde ceza keser.", ReturnVehicleName(targetid), reason, MoneyFormat(amount)));
	return 1;
}

CMD:hapis(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

	new id = -1;
	if((id = IsPlayerInProperty(playerid)) == -1) return SendErrorMessage(playerid, "Bu komutu birliðine ait binalarda kullanabilirsin.");
	if(PropertyData[id][PropertyFaction] == -1) return SendErrorMessage(playerid, "Bu bina hiçbir birliðe ait deðil.");
	if(PlayerData[playerid][pFaction] != PropertyData[id][PropertyFaction]) return SendErrorMessage(playerid, "Bu bina senin birliðine ait deðil.");
	if(!FactionData[PropertyData[id][PropertyFaction]][FactionCopPerms]) return SendErrorMessage(playerid, "Birliðinin polis komutlarýný kullanma yetkisi yok.");

	static playerb, time;
	if(sscanf(params, "ui", playerb, time)) return SendUsageMessage(playerid, "/hapis [oyuncu ID/isim] [süre]");
	if(playerb == playerid) return SendServerMessage(playerid, "Bu komutu kendi üzerinde kullanamazsýn.");
	if(!IsPlayerConnected(playerb)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[playerb]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, playerb, 5.0)) return SendErrorMessage(playerid, "Belirttiðiniz kiþiye yakýn deðilsin.");
	if(PlayerData[playerb][pICJailed]) return SendErrorMessage(playerid, "Bu kiþi zaten hapiste atýlmýþ.");

	PlayerData[playerb][pPhoneOff] = true;
	PlayerData[playerb][pICJailTime] = time * 60;
	PlayerData[playerb][pICJailed] = 1;
	
	if(PlayerData[playerb][pActiveListing]) PlayerData[playerb][pActiveListing] = 0;
	
	PlayerData[playerb][pJailTimes]++;

	new jail_str[90];

	TotalJailees++;
	format(jail_str, 90, "A%03d", TotalJailees);
	PlayerData[playerb][pICJail3D] = CreateDynamic3DTextLabel(jail_str, COLOR_LGREEN, 0.0, 0.0, -0.10, 20.0, playerb);
	
	SendLawMessage(COLOR_ADM, sprintf("[Hapis] %s %s, %s isimli kiþiyi hapise gönderdi.", Player_GetFactionRank(playerid), ReturnName(playerid), ReturnName(playerb)));
	SendClientMessageEx(playerb, COLOR_ADM, "[ ! ] Uyarý: Hapise girdiðin için telefonun otomatik olarak kapatýldý. Hapisten çýkýnca telefonunu açmayý unutma.", ReturnName(playerid), time);
	

	// color_green ile atana hangi cell yazdýðý gelcek
	Player_Save(playerb);
	return 1;
}

CMD:kapikir(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
    if(PlayerData[playerid][pKickDoor]) return SendErrorMessage(playerid, "Bu komutu tekrar kullanmak için bekle.");

	if(GetPVarInt(playerid, "AtGarage") != -1)
	{
		new g = GetPVarInt(playerid, "AtGarage");
		if(IsPlayerInRangeOfPoint(playerid, 3.0, GarageData[g][GaragePos][0], GarageData[g][GaragePos][1], GarageData[g][GaragePos][2]))
		{
            if (!GarageData[g][GarageLocked]) return SendErrorMessage(playerid, "Bu garaj zaten kilitli deðil.");

		    ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 0, 0, 0, 0, 0);
			SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "** %s garajýn kapýsýný kýrmaya çalýþýr.", ReturnName(playerid, 0));
		    SetTimerEx("KickGarage", 1500, false, "dd", playerid, g);
		    PlayerData[playerid][pKickDoor] = true;
		    return 1;
		}
 	}

	new h = -1;
	if((h = IsPlayerNearProperty(playerid)) != -1)
	{
	    if(!PropertyData[h][PropertyLocked]) return SendErrorMessage(playerid, "Bu kýrmaya çalýþtýðýn kapý kilitli deðil.");
		SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "** %s evin kapýsýný kýrmaya çalýþýr.", ReturnName(playerid, 0));
	  	ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 0, 0, 0, 0, 0);
	    SetTimerEx("KickHouse", 1500, false, "ii", playerid, h);
	    PlayerData[playerid][pKickDoor] = true;
	    return 1;
	}

	h = -1;
	if((h = IsPlayerNearBusiness(playerid)) != -1)
	{
		if(!BusinessData[h][BusinessLocked]) return SendErrorMessage(playerid, "Bu kýrmaya çalýþtýðýn kapý kilitli deðil.");
		SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "** %s iþyerinin kapýsýný kýrmaya çalýþr.", ReturnName(playerid, 0));
	    ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 0, 0, 0, 0, 0);
	    SetTimerEx("KickBusiness", 1500, false, "ii", playerid, h);
	    PlayerData[playerid][pKickDoor] = true;
		return 1;
	}

	SendErrorMessage(playerid, "Etrafýnda kýrabileceðin bir kapý yok.");
	return 1;
}

Server:KickHouse(playerid, id)
{
	switch (random(6))
	{
	    case 0..2:
	    {
	        SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "** %s evin kapýsýný kýramaz.", ReturnName(playerid, 0));
		}
		default:
		{
		    PropertyData[id][PropertyLocked] = false;
		    SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "** %s evin kapýsýný baþarýyla kýrar.", ReturnName(playerid, 0));
		}
	}

	PlayerData[playerid][pKickDoor] = false;
	return 1;
}

Server:KickBusiness(playerid, id)
{
	switch (random(6))
	{
	    case 0..2:
	    {
	        SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "** %s iþyerinin kapýsýný kýramaz.", ReturnName(playerid, 0));
		}
		default:
		{
		    BusinessData[id][BusinessLocked] = false;
		    SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "** %s iþyerinin kapýsýný baþarýyla kýrar.", ReturnName(playerid, 0));
		}
	}
	
	PlayerData[playerid][pKickDoor] = false;
	return 1;
}

Server:KickGarage(playerid, id)
{
	switch (random(6))
	{
	    case 0..2:
	    {
	        SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "** %s garajýn kapýsýný kýramaz.", ReturnName(playerid, 0));
		}
		default:
		{
		    GarageData[id][GarageLocked] = false;
		    SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "** %s garajýn kapýsýný baþarýyla kýrar.", ReturnName(playerid, 0));
		}
	}
	
	PlayerData[playerid][pKickDoor] = false;
	return 1;
}

CMD:m(playerid, params[]) return cmd_megafon(playerid, params);
CMD:megafon(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	if(isnull(params)) return SendUsageMessage(playerid, "/megafon [yazý]");

	if(strlen(params) > 84)
	{
	    SendNearbyMessage(playerid, 40.0, COLOR_YELLOW, "[ %s:o< %.84s", ReturnName(playerid, 0), params);
	    SendNearbyMessage(playerid, 40.0, COLOR_YELLOW, "...%s ]", params[84]);
	}
	else SendNearbyMessage(playerid, 40.0, COLOR_YELLOW, "[ %s:o< %s ]", ReturnName(playerid, 0), params);
	return 1;
}

CMD:depayarla(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty] && !PlayerData[playerid][pMEDduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

	PlayerData[playerid][pDep] = 0;
	new dep[10];
	if(sscanf(params, "s[10]", dep)) return SendUsageMessage(playerid, "/depayarla [HEPSI / LS(SD) / LS(PD) / LS(FD) / SA(DCR) / SA(GOV) / FBI / COURTS / SERVICES]");
	
	if(!strcmp(dep, "HEPSI"))
	{
		SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Þu anda bütün departmanlara baðlý olarak konuþuyorsun.");
		PlayerData[playerid][pDep] = 0;
		return 1;
	}
	else if(!strcmp(dep, "LSSD") || !strcmp(dep, "SD"))
	{
		SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Þu anda LSSD departmanýna baðlý olarak konuþuyorsun.");
		PlayerData[playerid][pDep] = 1;
		return 1;
	}
	else if(!strcmp(dep, "LSPD") || !strcmp(dep, "PD"))
	{
		SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Þu anda LSPD departmanýna baðlý olarak konuþuyorsun.");
		PlayerData[playerid][pDep] = 2;
		return 1;
	}
	else if(!strcmp(dep, "LSFD") || !strcmp(dep, "LSFD"))
	{
		SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Þu anda LSFD departmanýna baðlý olarak konuþuyorsun.");
		PlayerData[playerid][pDep] = 3;
		return 1;
	}
	else if(!strcmp(dep, "SADCR") || !strcmp(dep, "DCR"))
	{
		SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Þu anda SADCR departmanýna baðlý olarak konuþuyorsun.");
		PlayerData[playerid][pDep] = 4;
		return 1;
	}
	else if(!strcmp(dep, "SAGOV") || !strcmp(dep, "GOV"))
	{
		SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Þu anda SAGOV departmanýna baðlý olarak konuþuyorsun.");
		PlayerData[playerid][pDep] = 5;
		return 1;
	} 
	else SendErrorMessage(playerid, "Hatalý parametre girdiniz.");
	return 1;
}

CMD:dep(playerid, params[])return cmd_departman(playerid, params);
CMD:departman(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty] && !PlayerData[playerid][pMEDduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	if (isnull(params)) return SendUsageMessage(playerid, "/departman [yazý]");

	new Float: posx, Float: posy, Float: posz;
	GetPlayerPos(playerid, posx, posy, posz);

	switch(PlayerData[playerid][pDep])
	{
		case 0:
		{
			foreach(new i : Player)
			{
				new f = PlayerData[i][pFaction];
				if(f == -1) continue;

				if(FactionData[f][FactionCopPerms] || FactionData[f][FactionMedPerms] || FactionData[f][FactionSheriffPerms])
				{
					if(strlen(params) > 80)
					{
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>HEPSI] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>HEPSI] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
					}
					else SendClientMessageEx(i, COLOR_DEPT, "** [%s>HEPSI] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				}
			}
			
			LocalChat(playerid, 20.0, sprintf("%s (radyo): %s", ReturnName(playerid, 0), params), COLOR_FADE1);
		}
		case 1:
		{
			if(strlen(params) > 80)
			{
				SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>SHERIFF] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>SHERIFF] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
			}
			else SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>SHERIFF] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);

			foreach(new i : Player)
			{
				new f = PlayerData[i][pFaction];
				if(f == -1) continue;
				if(i == playerid) continue;

				if(FactionData[f][FactionSheriffPerms])
				{
					if(strlen(params) > 80)
					{
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>SHERIFF] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>SHERIFF] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
					}
					else SendClientMessageEx(i, COLOR_DEPT, "** [%s>SHERIFF] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				}
			}

			LocalChat(playerid, 20.0, sprintf("%s (radyo): %s", ReturnName(playerid, 0), params), COLOR_FADE1);
		}
		case 2:
		{
			if(strlen(params) > 80)
			{
				SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>POLICE] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>POLICE] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
			}
			else SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>POLICE] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);

			foreach(new i : Player)
			{
				new f = PlayerData[i][pFaction];
				if(f == -1) continue;
				if(i == playerid) continue;

				if(FactionData[f][FactionCopPerms])
				{
					if(strlen(params) > 80)
					{
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>POLICE] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>POLICE] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
					}
					else SendClientMessageEx(i, COLOR_DEPT, "** [%s>POLICE] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				}
			}

			LocalChat(playerid, 20.0, sprintf("%s (radyo): %s", ReturnName(playerid, 0), params), COLOR_FADE1);
		}
		case 3:
		{
			if(strlen(params) > 80)
			{
				SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>FIRE] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>FIRE] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
			}
			else SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>FIRE] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);

			foreach(new i : Player)
			{
				new f = PlayerData[i][pFaction];
				if(f == -1) continue;
				if(i == playerid) continue;

				if(FactionData[f][FactionMedPerms])
				{
					if(strlen(params) > 80)
					{
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>FIRE] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>FIRE] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
					}
					else SendClientMessageEx(i, COLOR_DEPT, "** [%s>FIRE] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				}
			}

			LocalChat(playerid, 20.0, sprintf("%s (radyo): %s", ReturnName(playerid, 0), params), COLOR_FADE1);
		}
	}
	return 1;
}

CMD:deplow(playerid, params[])return cmd_departmanlow(playerid, params);
CMD:departmanlow(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty] && !PlayerData[playerid][pMEDduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	if (isnull(params)) return SendUsageMessage(playerid, "/departmanlow [yazý]");

	new Float: posx, Float: posy, Float: posz;
	GetPlayerPos(playerid, posx, posy, posz);

	switch(PlayerData[playerid][pDep])
	{
		case 0:
		{
			foreach(new i : Player)
			{
				new f = PlayerData[i][pFaction];
				if(f == -1) continue;

				if(FactionData[f][FactionCopPerms] || FactionData[f][FactionMedPerms] || FactionData[f][FactionSheriffPerms])
				{
					if(strlen(params) > 80)
					{
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>HEPSI] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>HEPSI] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
					}
					else SendClientMessageEx(i, COLOR_DEPT, "** [%s>HEPSI] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				}
			}

			LocalChat(playerid, 5.0, sprintf("%s (radyo): %s", ReturnName(playerid, 0), params), COLOR_FADE1);
		}
		case 1:
		{
			if(strlen(params) > 80)
			{
				SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>SHERIFF] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>SHERIFF] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
			}
			else SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>SHERIFF] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);

			foreach(new i : Player)
			{
				new f = PlayerData[i][pFaction];
				if(f == -1) continue;
				if(i == playerid) continue;

				if(FactionData[f][FactionSheriffPerms])
				{
					if(strlen(params) > 80)
					{
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>SHERIFF] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>SHERIFF] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
					}
					else SendClientMessageEx(i, COLOR_DEPT, "** [%s>SHERIFF] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				}	
			}

			LocalChat(playerid, 5.0, sprintf("%s (radyo): %s", ReturnName(playerid, 0), params), COLOR_FADE1);
		}
		case 2:
		{
			if(strlen(params) > 80)
			{
				SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>POLICE] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>POLICE] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
			}
			else SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>POLICE] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);

			foreach(new i : Player)
			{
				new f = PlayerData[i][pFaction];
				if(f == -1) continue;
				if(i == playerid) continue;

				if(FactionData[f][FactionCopPerms])
				{
					if(strlen(params) > 80)
					{
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>POLICE] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>POLICE] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
					}
					else SendClientMessageEx(i, COLOR_DEPT, "** [%s>POLICE] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				}	
			}

			LocalChat(playerid, 5.0, sprintf("%s (radyo): %s", ReturnName(playerid, 0), params), COLOR_FADE1);
		}
		case 3:
		{
			if(strlen(params) > 80)
			{
				SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>FIRE] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>FIRE] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
			}
			else SendClientMessageEx(playerid, COLOR_DEPT, "** [%s>FIRE] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);

			foreach(new i : Player)
			{
				new f = PlayerData[i][pFaction];
				if(f == -1) continue;
				if(i == playerid) continue;
				
				if(FactionData[f][FactionMedPerms])
				{
					if(strlen(params) > 80)
					{
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>FIRE] %s %s: %.80s...", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
						SendClientMessageEx(i, COLOR_DEPT, "** [%s>FIRE] %s %s: ...%s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params[80]);
					}
					else SendClientMessageEx(i, COLOR_DEPT, "** [%s>FIRE] %s %s: %s", Player_GetFactionAbbrev(playerid), Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
				}
			}

			LocalChat(playerid, 5.0, sprintf("%s (radyo): %s", ReturnName(playerid, 0), params), COLOR_FADE1);
		}
	}
	return 1;
}

CMD:kelepce(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	
	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/kelepce [oyuncu ID/isim]");
	//if(playerb == playerid) return SendServerMessage(playerid, "Bu komutu kendi üzerinde kullanamazsýn.");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, id, 4.5)) return SendErrorMessage(playerid, "Belirttiðiniz kiþiye yakýn deðilsin.");
	if(PlayerData[id][pHandcuffed]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi zaten kelepçelenmiþ.");
	if(PlayerData[playerid][pHandcuffCount] < 1) return SendErrorMessage(playerid, "Hiç kelepçen kalmamýþ.");
	if(PlayerData[id][pHandcuffing]) return SendErrorMessage(playerid, "Belirttiðiniz kiþiyi zaten biri kelepçeliyor.");
	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s isimli oyuncuyu kelepçeliyorsun - bu 5 saniye sürebilir.", ReturnName(id, 0));
	SendClientMessageEx(id, COLOR_ADM, "[ ! ] {FFFFFF}%s seni kelepçeliyor - bu 5 saniye sürebilir.", ReturnName(playerid, 0));
	SetTimerEx("Handcuffing", 5000, false, "ii", playerid, id);
	PlayerData[id][pHandcuffing] = true;
	return 1;
}

Server:Handcuffing(playerid, id)
{
	PlayerData[id][pHandcuffing] = false;
	PlayerData[playerid][pHandcuffCount] -= 1;
	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%i adet kelepçe setin kaldý.", PlayerData[playerid][pHandcuffCount]);
	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s isimli oyuncuyu kelepçeledin.", ReturnName(id, 0));
	SendClientMessageEx(id, COLOR_ADM, "[ ! ] {FFFFFF}%s seni kelepçeledi.", ReturnName(playerid, 0));
	ToggleHandcuffs(id, true);
	return 1;
}

CMD:kelepcecoz(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);

	new id;
	if(sscanf(params, "u", id)) return SendServerMessage(playerid, "/kelepcecoz [oyuncu ID/isim]");
	//if(playerb == playerid) return SendServerMessage(playerid, "Bu komutu kendi üzerinde kullanamazsýn.");
	if(!IsPlayerConnected(id)) return SendServerMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendServerMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, id, 4.5)) return SendServerMessage(playerid, "Belirttiðiniz kiþiye yakýn deðilsin.");
	if(!PlayerData[id][pHandcuffed]) return SendServerMessage(playerid, "Belirttiðiniz kiþi zaten kelepçelenmemiþ.");
	if(PlayerData[id][pHandcuffing]) return SendErrorMessage(playerid, "Belirttiðiniz kiþinin kelepçesini zaten biri çözüyor.");
	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s isimli oyuncunun kelepçesini çözüyorsun - bu 5 saniye sürebilir.", ReturnName(id, 0));
	SendClientMessageEx(id, COLOR_ADM, "[ ! ] {FFFFFF}%s senin kelepçeni çözüyor - bu 5 saniye sürebilir.", ReturnName(playerid, 0));
	SetTimerEx("Unhandcuffing", 5000, false, "ii", playerid, id);
	PlayerData[id][pHandcuffing] = true;
	return 1;
}

Server:Unhandcuffing(playerid, id)
{
	PlayerData[id][pHandcuffing] = false;
	PlayerData[playerid][pHandcuffCount] += 1;
	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%i adet kelepçe setin kaldý.", PlayerData[playerid][pHandcuffCount]);
	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s isimli oyuncunun kelepçesini çözdün.", ReturnName(id, 0));
	SendClientMessageEx(id, COLOR_ADM, "[ ! ] {FFFFFF}%s senin kelepçeni çözdü.", ReturnName(playerid, 0));
	ToggleHandcuffs(id, false);
	return 1;
}

CMD:ltl(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	if(!Player_HasWeapon(playerid, 33) && !PlayerData[playerid][pTaser]) return SendErrorMessage(playerid, "Üstünde rifle yok."); 

	if(!PlayerData[playerid][pLethalbullet])
	{
		PlayerData[playerid][pLethalbullet] = true;
		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Mermi türünü ZARARSIZ/PLASTÝK MERMÝ olarak ayarladýn.");
	}
	else
	{
		PlayerData[playerid][pLethalbullet] = false;
		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Mermi türünü ZARARLI/GERÇEK MERMÝ olarak ayarladýn.");
	}
	return 1;
}

CMD:plastikmermi(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	if(!Player_HasWeapon(playerid, 25) && !PlayerData[playerid][pTaser]) return SendErrorMessage(playerid, "Üstünde shotgun yok."); 

	if(!PlayerData[playerid][pRubberbullet])
	{
		PlayerData[playerid][pRubberbullet] = true;
		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Mermi türünü ZARARSIZ/PLASTÝK MERMÝ olarak ayarladýn.");
	}
	else
	{
		PlayerData[playerid][pRubberbullet] = false;
		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Mermi türünü ZARARLI/GERÇEK MERMÝ olarak ayarladýn.");
	}
	return 1;
}

CMD:taser(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	if(!Player_HasWeapon(playerid, 24) && !PlayerData[playerid][pTaser]) return SendErrorMessage(playerid, "Üstünde taser yok."); 

	if(!PlayerData[playerid][pTaser])
	{
		GetPlayerWeaponData(playerid, Weapon_GetSlotID(24), PlayerData[playerid][pWeapons][Weapon_GetSlotID(24)], playerTaserAmmo[playerid]); 
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s taserini teçhizat kemerinden kavrar.", ReturnName(playerid, 0));
		PlayerData[playerid][pTaser] = true;
		GivePlayerWeapon(playerid, 23, 5); 
	}
	else
	{
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s taserini teçhizat kemerine yerleþtirir.", ReturnName(playerid, 0));
		GivePlayerWeapon(playerid, 24, playerTaserAmmo[playerid]); 
		PlayerData[playerid][pTaser] = false;
	}
	return 1;
}

CMD:tackle(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

	if(!PlayerData[playerid][pTackle])
	{
		PlayerData[playerid][pTackle] = true;
		SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}Tackle modu aktif edildi.");
		SendClientMessage(playerid, COLOR_ADM, "Eðer birisini yumruklamayý denerseniz, yere düþürme giriþiminde bulunacaksýnýz.");
		SendClientMessage(playerid, COLOR_ADM, "Yere düþürme giriþiminde bulunduðunuz kiþiyi sistem yere düþürmeye çalýþtýðýnýz hakkýnda sistem bilgi mesajý verecektir.");
		SendClientMessage(playerid, COLOR_ADM, "Diðer oyuncularý bilgilendirmek adýna sistem otomatik bir emote verecektir.");
		SendClientMessage(playerid, COLOR_ADM, "Komut kullanmanýzý engellemek amacýyla sistem uygun bir animasyonu karakterinize oynatacaktýr.");
		SendClientMessage(playerid, COLOR_ADM, "Eðer yere düþürmeye çalýþtýðýnýz kiþi role uymuyorsa, oyun içi bir rapor oluþturun.");
	}
	else
	{
		PlayerData[playerid][pTackle] = false;
		SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}Tackle modu de-aktif edildi.");
	}
	return 1;
}

CMD:takip(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	
	new phone, playerb;
	if(sscanf(params, "d", phone)) return SendUsageMessage(playerid, "/takip [telefon numarasý]");
	if(PlayerData[playerid][pIsTracing]) return SendErrorMessage(playerid, "Yer tespit ediliyor, lütfen bekleyin.");

	playerb = IsValidNumber(phone);
	PlayerData[playerid][pTraceNum] = playerb;

	SendLawMessage(COLOR_COP, sprintf("** HQ: %s %s 555-%d numarasý üstünde takip baþlattý! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0), phone));

	PlayerTextDrawShow(playerid, Trace_PTD[playerid][0]);
	PlayerTextDrawSetString(playerid, Trace_PTD[playerid][0], "Takip_Basliyor");
	SetTimerEx("TracingSteps", 4000, false, "i", playerid);
	PlayerData[playerid][pIsTracing] = 1;
	return true;
}

CMD:ftakip(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	
	new phone, playerb;
	if(sscanf(params, "d", phone)) return SendUsageMessage(playerid, "/ftakip [telefon numarasý]");
	if(PlayerData[playerid][pIsTracing] == 2) return SendErrorMessage(playerid, "Yer tespit ediliyor, lütfen bekleyin.");

	playerb = IsValidNumber(phone);
	PlayerData[playerid][pTraceNum] = playerb;
	SendLawMessage(COLOR_COP, sprintf("** HQ: %s %s 555-%d numarasý üstüne geniþ bir takip baþlattý! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0), phone));
	PlayerTextDrawShow(playerid, Trace_PTD[playerid][0]);
	PlayerTextDrawSetString(playerid, Trace_PTD[playerid][0], "Takip_Basliyor");
	SetTimerEx("TracingSteps", 4000, false, "i", playerid);
	PlayerData[playerid][pIsTracing] = 2;
	return true;
}

CMD:callsign(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	if(isnull(params)) return SendUsageMessage(playerid, "/callsign [_callsign_ (Örnek: 2-ADAM-4]");

	if(!PlayerData[playerid][pLAWduty])
		SendClientMessageEx(playerid, COLOR_COP, "** HQ: %s %s þu anda %s birim kodu altýnda! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);

	SendLawMessage(COLOR_COP, sprintf("** HQ: %s %s þu anda %s birim kodu altýnda! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0), params));
	return 1;
}

CMD:swat(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	if(!IsNearFactionSpawn(playerid)) return SendErrorMessage(playerid, "Birlik spawn noktasý yakýnýnda deðilsin.");

	PlayerData[playerid][pSWATduty] = true;
	SendLawMessage(COLOR_COP, sprintf("** HQ: %s %s þu anda SWAT birim kodu altýnda! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0)));
	SetPlayerHealth(playerid, PlayerData[playerid][pMaxHealth]);
	SetPlayerArmour(playerid, 100);
	return 1;
}

CMD:hq(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	if(isnull(params)) return SendUsageMessage(playerid, "/hq [içerik]");

	new string[128];
	format(string, sizeof(string), "HQ: %s %s: %s", Player_GetFactionRank(playerid), ReturnName(playerid, 0), params);
	SendFactionMessageEx(playerid, COLOR_CYAN, string);
	return 1;
}

CMD:isbasi(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	if(!IsNearFactionSpawn(playerid)) return SendErrorMessage(playerid, "Birlik spawn noktasý yakýnýnda deðilsin.");

	if(IsPoliceFaction(playerid))
	{
		if(!PlayerData[playerid][pLAWduty])
		{
			PlayerData[playerid][pLAWduty] = true;
		
			if(isnull(PlayerData[playerid][pCallsign])) 
			{
				SendLawMessage(COLOR_COP, sprintf("** HQ: %s %s þu anda iþbaþýnda! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0)));
			}
			else 
			{
				SendLawMessage(COLOR_COP, sprintf("** HQ: %s %s þu anda %s kodu altýnda iþbaþýnda! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0), PlayerData[playerid][pCallsign]));
			}

			TakePlayerGuns(playerid);
			SetPlayerColor(playerid, PlayerData[playerid][pTesterDuty] ? (COLOR_TESTER) : (PlayerData[playerid][pAdminDuty] ? COLOR_ADMIN : COLOR_COP));
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s dolaptan ekipmanlarýný alýr.", ReturnName(playerid, 0));
			SetPlayerHealth(playerid, PlayerData[playerid][pMaxHealth]);
			PlayerData[playerid][pHandcuffCount] += 2;
			GivePlayerWeapon(playerid, 3, 1);
			GivePlayerWeapon(playerid, 41, 500);
			GivePlayerWeapon(playerid, 24, 50);
		} 
		else 
		{
			if(isnull(PlayerData[playerid][pCallsign]))
				SendLawMessage(COLOR_COP, sprintf("** HQ: %s %s þu anda iþbaþýndan çýktý! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0)));
			else
				SendLawMessage(COLOR_COP, sprintf("** HQ: %s %s þu anda %s kodu altýnda iþbaþýndan çýktý! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0), PlayerData[playerid][pCallsign]));

			format(PlayerData[playerid][pCallsign], 128, "");

			PlayerData[playerid][pLAWduty] = false;
			if(PlayerData[playerid][pSWATduty]) PlayerData[playerid][pSWATduty] = false;
			if(GetPlayerSkin(playerid) != PlayerData[playerid][pSkin]) SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
			SetPlayerColor(playerid, PlayerData[playerid][pTesterDuty] ? (COLOR_TESTER) : (PlayerData[playerid][pAdminDuty] ? COLOR_ADMIN : COLOR_WHITE));
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s ekipmanlarýný dolaba koyar.", ReturnName(playerid, 0));
			SetPlayerHealth(playerid, PlayerData[playerid][pMaxHealth]);
			PlayerData[playerid][pHandcuffCount] = 0;
			SetPlayerArmour(playerid, 0);
			TakePlayerGuns(playerid);
		}
	}
	else if(IsMedicFaction(playerid))
	{
	    if(!PlayerData[playerid][pMEDduty])
	    {
	    	PlayerData[playerid][pMEDduty] = true;
			SetPlayerColor(playerid, PlayerData[playerid][pTesterDuty] ? (COLOR_TESTER) : (PlayerData[playerid][pAdminDuty] ? COLOR_ADMIN : COLOR_EMT));
			SendFDMessage(COLOR_EMT, sprintf("** HQ: %s %s þu anda iþbaþýnda! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0)));
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s dolaptan ekipmanlarýný alýr.", ReturnName(playerid, 0));
			SetPlayerHealth(playerid, PlayerData[playerid][pMaxHealth]);
		}
		else
		{
			PlayerData[playerid][pMEDduty] = false;
			if(GetPlayerSkin(playerid) != PlayerData[playerid][pSkin]) SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
			SetPlayerColor(playerid, PlayerData[playerid][pTesterDuty] ? (COLOR_TESTER) : (PlayerData[playerid][pAdminDuty] ? COLOR_ADMIN : COLOR_WHITE));
			SendFDMessage(COLOR_EMT, sprintf("** HQ: %s %s þu anda iþbaþýndan çýktý! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0)));
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s ekipmanlarýný dolaba koyar.", ReturnName(playerid, 0));
			SetPlayerHealth(playerid, PlayerData[playerid][pMaxHealth]);
		}
	}
	return 1;
}

/*stock ShowFAttachmentList(playerid, type, page)
{
	new str[1250];
    str = PlayerData[playerid][pAdminDuty] ? ("Aksesuar ID\tAksesuar\tFiyat\n") : ("Aksesuar\tFiyat\n");

	PlayerUniformPage[playerid] = page;

	if(page == 1)
		format(str, sizeof(str), "%s{FFFF00}Sayfa 1\n", str);
	else
		format(str, sizeof(str), "%s{FFFF00}<< Sayfa %d\n", str, page-1);

	page--;

	new counter = 0;

	for(new i = 0; i < MAX_SKINS; i++) if (FAttData[i][f_is_exists] && FAttData[i][f_faction_id] == type)
	{
		counter++;
	}

	new bool:toSecondPage = false, countItems = 0;

	for(new i = page*MAX_CLOTHING_SHOW; i < counter; i++)
	{
		countItems++;

		if(countItems == MAX_CLOTHING_SHOW+1)
		{
			toSecondPage = true;
			break;
		}
		else
		{
		    if(PlayerData[playerid][pAdminDuty])
				format(str, sizeof(str), "%s{FFFFFF}%i\t%s\t$%i\n", str, FAttData[i][f_arr_id], FAttData[i][f_att_name], FAttData[i][f_att_price]);
			else
			    format(str, sizeof(str), "%s{FFFFFF}%s\t$%i\n", str, FAttData[i][f_att_name], FAttData[i][f_att_price]);
			
			UniformItemSelector[playerid][countItems-1] = i;
		}
	}

	if(toSecondPage) {
		format(str, sizeof(str), "%s{FFFF00}Sayfa %d >>\n", str, (page+1)+1);
	}

	new baslik[35];
	format(baslik, sizeof(baslik), "%s: Aksesuarlar", FactionData[PlayerData[playerid][pFaction]][FactionAbbrev]);
	ShowPlayerDialog(playerid, DIALOG_ATTACHMENTS, DIALOG_STYLE_TABLIST_HEADERS, baslik, str, "Satýnal", "<<<");
	return 1;
}*/

CMD:carsign(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Herhangi bir araç içerisinde deðilsin.");
	if(GetPlayerVehicleSeat(playerid) > 1) return SendErrorMessage(playerid, "Arka koltukta bu komutu kullanamazsýn.");
	if(!PlayerData[playerid][pLAWduty] && !PlayerData[playerid][pMEDduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

	new vehicleid = GetPlayerVehicleID(playerid);
	if(CarData[vehicleid][carFaction] == -1) return SendServerMessage(playerid, "Sadece birlik araçlarýna car-sign ekleyebilirsin.");
	if(isnull(params)) return SendUsageMessage(playerid, "/carsign [carsign yazýsý]");

	format(CarData[vehicleid][carSign], 45, "%s", params);
	SendClientMessage(playerid, COLOR_ADM, "KULLANIM: /carsign_sil - {FFFFFF}Ýþin bittiðinde silmek için kullanabilirsin.");
	if(!IsValidDynamic3DTextLabel(CarData[vehicleid][carSign3D])) CarData[vehicleid][carSign3D] = CreateDynamic3DTextLabel(sprintf("%s", CarData[vehicleid][carSign]), COLOR_WHITE, -0.7, -1.9, -0.3, 10.0, INVALID_PLAYER_ID, vehicleid, 0, -1, -1, -1);
	else UpdateDynamic3DTextLabelText(CarData[vehicleid][carSign3D], COLOR_WHITE, sprintf("%s", CarData[vehicleid][carSign]));
	return 1;
}

CMD:carsign_sil(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Herhangi bir araç içerisinde deðilsin.");
	if(GetPlayerVehicleSeat(playerid) > 1) return SendErrorMessage(playerid, "Arka koltukta bu komutu kullanamazsýn.");
	if(!PlayerData[playerid][pLAWduty] && !PlayerData[playerid][pMEDduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

	new vehicleid = GetPlayerVehicleID(playerid);
	if(CarData[vehicleid][carFaction] == -1) return SendServerMessage(playerid, "Sadece birlik araçlarýndan car-sign silebilirsin.");

	format(CarData[vehicleid][carSign], 45, "-");
	SendServerMessage(playerid, "Carsign baþarýyla silindi, tekrar /carsign yazarak ekleyebilirsin.");
	if(IsValidDynamic3DTextLabel(CarData[vehicleid][carSign3D])) DestroyDynamic3DTextLabel(CarData[vehicleid][carSign3D]);
	return 1;
}

CMD:label(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty] && !PlayerData[playerid][pMEDduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

    Label_RouteCommands(playerid, params);
	return 1;
}

Label_RouteCommands(playerid, cmdtext[])
{
    new command[7], parameters[112];
    sscanf(cmdtext, "s[7]s[112]", command, parameters);

	if(strlen(command) == 0) {
		SendClientMessage(playerid, COLOR_GREY, "KULLANIM: /label [komut]");
		SendClientMessage(playerid, COLOR_GREY, "Ýpucu: '/label yardim' yazarak tüm listeyi görebilirsin.");
		return 1;
	}

    if(strcmp("ekle", command) == 0) LabelCMD_Create(playerid, parameters);
    else if(strcmp("kaldir", command) == 0) LabelCMD_Delete(playerid);
    else if(strcmp("liste", command) == 0) LabelCMD_List(playerid);
    else if(strcmp("yardim", command) == 0) LabelCMD_Help(playerid);
	return 1;
}

LabelCMD_Create(const playerid, const parameters[])
{
	new label_name[35];
	if(sscanf(parameters, "s[35]", label_name)) {
		SendClientMessage(playerid, COLOR_GREY, "KULLANIM: /label ekle [içerik]");
		return 1;
	}

	Label_Create(playerid, label_name);
    return 1;
}

LabelCMD_Delete(const playerid)
{
	if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

	new id;
	if((id = Label_Nearest(playerid)) != -1)
	{
		ConfirmDialog(playerid, "Onay", "{FFFFFF}Yakýnýndaki '{ADC3E7}bilgi yazýsýný{FFFFFF}' kaldýrmak konusunda emin misin?", "OnLabelDisband", id);
	}
	else SendErrorMessage(playerid, "Yakýnýnda bilgi yazýsý bulunmuyor.");
    return 1;
}

Server:OnLabelDisband(playerid, response, id)
{
	if(response)
	{
		//SendFDMessage(COLOR_EMT, sprintf("** HQ: %s %s, %s konumundaki yangýn ateþini kaldýrdý! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0), FireData[id][fire_location]));
        SendClientMessage(playerid, -1, "SERVER: {ADC3E7}Bilgi yazýsý {FFFFFF}silindi.");
		Label_Destroy(id);
	}
	return 1;
}

LabelCMD_List(const playerid) {

	new
		label_found,
		liststr[256];

    foreach(new i : Labels)
	{
		label_found++;
		format(liststr, sizeof(liststr), "%sBilgi Yazýsý {AFAFAF}[%s - %s]\n", liststr, LabelData[i][label_placedby], LabelData[i][label_location]);
	}

	if(label_found) return ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_LIST, "PD: Aktif Bilgi Yazýlarý", liststr, "Tamam", "<<");
	else ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_LIST, "PD: Aktif Bilgi Yazýlarý", "Hiç bilgi yazýsý bulunamadý.", "Tamam", "<<");
	return 1;
}

LabelCMD_Help(const playerid) {
	SendClientMessage(playerid, COLOR_ORANGE, "Bilgi Yazýsý Sistemi:");
	SendClientMessage(playerid, COLOR_ORANGE, "/label ekle - Yakýnýnýza bilgi yazýsý eklemeyi saðlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/label kaldir - Yakýnýnýzdaki bilgi yazýsýný kaldýrmayý saðlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/label liste - Eklenmiþ bilgi yazýsýlarýný görmenizi saðlar.");
	return 1;
}

CMD:elkoy(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

	new id, specifier[15], b_string[15];
	if(sscanf(params, "us[15]S()[15]", id, specifier, b_string))
		return SendUsageMessage(playerid, "/elkoy [oyuncu ID/isim] [silahlar, lisans, uyusturucu]");

	if(!IsPlayerConnected(id)) return SendServerMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendServerMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, id, 4.5)) return SendServerMessage(playerid, "Belirttiðin kiþiye yakýn deðilsin.");

	if(!strcmp(specifier, "silahlar"))
	{
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s, %s adlý kiþinin silahlarýna el koydu.", ReturnName(playerid, 0), ReturnName(id, 0));
		TakePlayerGuns(id);
	}
	else if(!strcmp(specifier, "lisans"))
	{
		new lictype[10];
		if(sscanf(b_string, "s[10]", lictype)) return SendUsageMessage(playerid, "/elkoy [oyuncu ID/isim] lisans [ehliyet, silah]");

		if(!strcmp(b_string, "ehliyet"))
		{
			SendLawMessage(COLOR_COP, sprintf("** HQ: %s %s, %s adlý kiþinin sürücü lisansýný iptal etti! **", Player_GetFactionRank(playerid), ReturnName(playerid, 1), ReturnName(id, 1)));
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s, %s adlý kiþinin sürücü lisansýna el koydu.", ReturnName(playerid, 0), ReturnName(id, 0));
			PlayerData[id][pDriversLicense] = false;
		}
		else if(!strcmp(b_string, "silah"))
		{
			SendLawMessage(COLOR_COP, sprintf("** HQ: %s %s, %s adlý kiþinin silah lisansýný iptal etti! **", Player_GetFactionRank(playerid), ReturnName(playerid, 1), ReturnName(id, 1)));
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s, %s adlý kiþinin silah lisansýna el koydu.", ReturnName(playerid, 0), ReturnName(id, 0));
			PlayerData[id][pWeaponsLicense] = false;
		}
		else return SendClientMessage(playerid, COLOR_ADM, "SERVER: Hatalý parametre girdin.");
	}
	else if(!strcmp(specifier, "uyusturucu"))
	{
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s, %s adlý kiþinin uyuþturucularýna el koydu.", ReturnName(playerid, 0), ReturnName(id, 0));
		for(new i = 1; i < MAX_PACK_SLOT; ++i) Drug_DefaultValues(playerid, i);
		return 1;
	}
	else return SendClientMessage(playerid, COLOR_ADM, "SERVER: Hatalý parametre girdin.");
	return true;
}

CMD:aracbagla(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Aracý sürer halde deðilsin.");

	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsValidPlayerCar(vehicleid)) return SendClientMessage(playerid, COLOR_ADM, "Bu araç baðlanamaz.");

	new id = Impound_Nearest(playerid);
	if (id == -1) return SendClientMessage(playerid, COLOR_ADM, "Araç baðlama noktasýnda deðilsin.");

	GetPlayerPos(playerid, CarData[vehicleid][carPos][0], CarData[vehicleid][carPos][1], CarData[vehicleid][carPos][2]);
	CarData[vehicleid][carImpounded] = id;

	Car_Save(vehicleid);
	SendClientMessageEx(playerid, COLOR_DARKGREEN, "SERVER: %s adlý kiþinin %s model aracýný baðladýn.", ReturnSQLName(CarData[vehicleid][carOwnerID]), ReturnVehicleName(vehicleid));

	foreach(new i : Player) if(PlayerData[i][pSQLID] == CarData[vehicleid][carOwnerID])
	{
		SendClientMessageEx(i, COLOR_DARKGREEN, "SERVER: %s model aracýn %s tarafýndan baðlandý.", ReturnVehicleName(vehicleid), ReturnName(playerid, 1));
	}
	return 1;
}

CMD:aranmaemri(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

	new
		id,
		reason[128];

	if(sscanf(params, "us[128]", id, reason)) return SendUsageMessage(playerid, "/aranmaemri [oyuncu ID/isim] [sebep]");

	if(!IsPlayerConnected(id)) return SendServerMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendServerMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(strlen(reason) < 3 || strlen(reason) > 128) return SendServerMessage(playerid, "Sebep 3 ile 128 karakter arasýnda olmalýdýr.");

    new add_query[256];
	mysql_format(m_Handle, add_query, sizeof(add_query), "INSERT INTO criminal_record (player_name, entry_reason, entry_date, entry_by) VALUES('%e', '%e', %i, '%e')", ReturnName(id, 1), reason, Time(), ReturnName(playerid, 1));
	mysql_tquery(m_Handle, add_query, "OnPlayerAddCharge", "ii", playerid, id);
	return 1;
}

CMD:setp(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);

	new
		id;
	if(sscanf(params, "i", id)) return SendUsageMessage(playerid, "/setp [(1-3)]");
	if(id < 1 || id > 3) return SendErrorMessage(playerid, "Hatalý spawn noktasý seçtin. (1-3)");

	PlayerData[playerid][pSpawnPrecinct] = id;
	SendClientMessageEx(playerid, COLOR_ADM, "[!] Birliðinin (%d) numaralý spawn noktasýný ayarladýn, artýk seçtiðin noktada oyuna baþlayacaksýn.", id);
	return 1;
}

CMD:candoldur(playerid, params[])
{
	if(IsPoliceFaction(playerid))
	{
		if(!IsNearFactionSpawn(playerid)) return SendErrorMessage(playerid, "Birlik spawn noktasý yakýnýnda deðilsin.");

		SendClientMessage(playerid, COLOR_WHITE, "Maksimum can ve zýrh temin edildi.");
		SetPlayerHealth(playerid, PlayerData[playerid][pMaxHealth]);
		SetPlayerArmour(playerid, 100);
		return 1;
	}

	new id = -1;
	if((id = IsPlayerInProperty(playerid)) != -1)
	{
		if(PropertyData[id][PropertyFaction] != -1)
		{
			if(PlayerData[playerid][pFaction] != PropertyData[id][PropertyFaction]) return SendErrorMessage(playerid, "Burada can dolduramazsýn.");

			if(FactionData[PropertyData[id][PropertyFaction]][FactionCopPerms])
			{
				if(PlayerData[playerid][pLAWduty])
				{
					//LogPlayerAction(playerid, "Healed and got 100 Armor");
					SendClientMessage(playerid, COLOR_WHITE, "Maksimum can ve zýrh temin edildi.");
					SetPlayerHealth(playerid, PlayerData[playerid][pMaxHealth]);
					SetPlayerArmour(playerid, 100);
				}
				else
				{
					//LogPlayerAction(playerid, "Healed to max health");
					SendClientMessage(playerid, COLOR_WHITE, "Canýn maksimum olacak þekilde dolduruldu.");
					SetPlayerHealth(playerid, PlayerData[playerid][pMaxHealth]);
				}
			}
			else if(FactionData[PropertyData[id][PropertyFaction]][FactionMedPerms])
			{
				if(PlayerData[playerid][pMEDduty])
				{
					new idx;
					if(sscanf(params, "u", idx)) return SendUsageMessage(playerid, "/candoldur [oyuncu ID/isim]");
					if(playerid == idx) return SendErrorMessage(playerid, "Kendi canýný dolduramazsýn.");
					if(!IsPlayerConnected(idx)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
					if(!pLoggedIn[idx]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
					if(!GetDistanceBetweenPlayers(playerid, idx, 4.5)) return SendErrorMessage(playerid, "Belirttiðin kiþiye yakýn deðilsin.");
					SendClientMessageEx(playerid, COLOR_EMT, "%s isimli oyuncunun canýný 100 olacak þekilde iyileþtirdin.", ReturnName(idx));
					SendClientMessageEx(idx, COLOR_EMT, "%s canýný 100 olacak þekilde iyileþtirdi.", ReturnName(playerid));
					SetPlayerHealth(idx, 100);
				}
				else SendClientMessage(playerid, COLOR_ADM, "Burada can dolduramazsýn.");
			}
			else
			{
				SetPlayerHealth(playerid, PlayerData[playerid][pMaxHealth]);
				SendClientMessage(playerid, COLOR_WHITE, "Canýn maksimum olacak þekilde dolduruldu.");
				//LogPlayerAction(playerid, "Healed to max health");
			}
		}
		else
		{
			new data[e_furniture];
			for(new i, j = Streamer_GetUpperBound(STREAMER_TYPE_OBJECT); i < j; i++)
			{
			    if(!IsValidDynamicObject(i)) continue;
			   	if(!IsHouseRefrigerator(Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_MODEL_ID))) continue;
			    if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, 0)) continue;

			    Streamer_GetArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, data);
		    	if(IsPlayerInRangeOfPoint(playerid, 2.5, data[furnitureX], data[furnitureY], data[furnitureZ]))
				{
					// 	LogPlayerAction(playerid, "Healed to max health");
					SetPlayerHealth(playerid, PlayerData[playerid][pMaxHealth]);
					SendClientMessage(playerid, COLOR_WHITE, "Canýn maksimum olacak þekilde dolduruldu.");
					SetPlayerChatBubble(playerid, sprintf("(( * %s canýný maksimum olarak yeniledi. ))", ReturnName(playerid, 1)), COLOR_EMOTE, 20.0, 4000);
					return 1;
				}
			}

			SendClientMessage(playerid, COLOR_ADM, "Yakýnýnda buzdolabý yok.");
		}
	}
	else SendErrorMessage(playerid, "Þu anda bunu yapamazsýn.");
	return 1;
}

CMD:uniforma(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!IsNearFactionSpawn(playerid)) return SendErrorMessage(playerid, "Birlik spawn noktasý yakýnýnda deðilsin.");
	Uniform_List(playerid);
	return 1;
}

Uniform_List(playerid, page = 0)
{
    new query[110];
	SetPVarInt(playerid, "faction_uniform_idx", page);
	mysql_format(m_Handle, query, sizeof(query), "SELECT id, skin_name, skin_race, skin_sex FROM faction_uniforms WHERE faction_id = %i LIMIT %i, 25", PlayerData[playerid][pFaction], page*MAX_CLOTHING_SHOW);
	mysql_tquery(m_Handle, query, "SQL_UniformList", "ii", playerid, page);
	return 1;
}

Server:SQL_UniformList(playerid, page)
{
	if(!IsPlayerConnected(playerid)) {
        return 0;
    }

    new rows = cache_num_rows();   
    if(!rows) {
        return SendClientMessage(playerid, COLOR_ADM, "SERVER: Hiç üniforma eklenmemiþ.");
    }

	new primary_str[1024], sub_str[64];
	new skin_name[20], id, skin_race, skin_sex;
	strcat(primary_str, "Model\tMilliyet\tCinsiyet\n");

	for(new i; i < rows; ++i)
	{
		cache_get_value_name_int(i, "id", id);
        cache_get_value_name(i, "skin_name", skin_name, sizeof(skin_name));
        cache_get_value_name_int(i, "skin_race", skin_race);
        cache_get_value_name_int(i, "skin_sex", skin_sex);

		format(sub_str, sizeof(sub_str), "%i %s\t%s\t%s\n", id, skin_name, Uniform_GetRace(skin_race), Uniform_GetSex(skin_sex));
		strcat(primary_str, sub_str);
	}

	if(page != 0) strcat(primary_str, "{FFFF00}Önceki Sayfa <<\n");
	if(rows >= MAX_CLOTHING_SHOW) strcat(primary_str, "{FFFF00}Sonraki Sayfa >>");

	Dialog_Show(playerid, UNIFORM_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Üniforma Seç", primary_str, "Seç", "Kapat");
	return 1;
}

Dialog:UNIFORM_LIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new page = GetPVarInt(playerid, "faction_uniform_idx");
		if(!strcmp(inputtext, "Önceki Sayfa <<")) return Uniform_List(playerid, page-1);
		if(!strcmp(inputtext, "Sonraki Sayfa >>")) return Uniform_List(playerid, page+1);
		
		new id;
        sscanf(inputtext, "i", id);
        PlayerData[playerid][pDutySkin] = Uniform_GetSkinID(id);
        SetPlayerSkin(playerid, PlayerData[playerid][pDutySkin]);
	}
    return 1;
}

Uniform_GetRace(id)
{
	new txt[14];
	switch(id)
	{
		case 1: txt = "Kafkasyalý";
		case 2: txt = "Asyalý";
		case 3: txt = "Afro-Amerikan";
		case 4: txt = "Hispanik";
	}
	return txt;
}

Uniform_GetSex(id)
{
	new txt[6];
	switch(id)
	{
		case 1: txt = "Erkek";
		case 2: txt = "Kadýn";
	}
	return txt;
}

Uniform_GetSkinID(id)
{
	new query[75], int;
	mysql_format(m_Handle, query, sizeof(query), "SELECT skin_id FROM faction_uniforms WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name_int(0, "skin_id", int);
	cache_delete(cache);
	return int;
}
 
IsNearFactionSpawn(playerid)
{
	new found, f = PlayerData[playerid][pFaction];

	if(!IsPlayerInRangeOfPoint(playerid, 5.0, FactionData[f][FactionSpawn][0], FactionData[f][FactionSpawn][1], FactionData[f][FactionSpawn][2]))
	{
		if(PlayerData[playerid][pSpawnPrecinct] != 0)
		{
			switch(PlayerData[playerid][pSpawnPrecinct])
			{
				case 1:
				{
					if(IsPlayerInRangeOfPoint(playerid, 5.0, FactionData[f][FactionSpawnEx1][0], FactionData[f][FactionSpawnEx1][1], FactionData[f][FactionSpawnEx1][2]))
					{
						found++;
					}
				}
				case 2:
				{
					if(IsPlayerInRangeOfPoint(playerid, 5.0, FactionData[f][FactionSpawnEx2][0], FactionData[f][FactionSpawnEx2][1], FactionData[f][FactionSpawnEx2][2]))
					{
						found++;
					}
				}
				case 3:
				{
					if(IsPlayerInRangeOfPoint(playerid, 5.0, FactionData[f][FactionSpawnEx3][0], FactionData[f][FactionSpawnEx3][1], FactionData[f][FactionSpawnEx3][2]))
					{
						found++;
					}
				}
			}
		}
	}
	else found++;
	return found;
}

Roadblock_List(playerid, page = 0)
{
    new query[100];
	SetPVarInt(playerid, "faction_roadblock_idx", page);
	mysql_format(m_Handle, query, sizeof(query), "SELECT id, RoadblockName FROM faction_roadblocks LIMIT %i, 25", page*MAX_CLOTHING_SHOW);
	mysql_tquery(m_Handle, query, "SQL_RoadblockList", "ii", playerid, page);
	return 1;
}

Server:SQL_RoadblockList(playerid, page)
{
	if(!IsPlayerConnected(playerid)) {
        return 0;
    }

    new rows = cache_num_rows();   
    if(!rows) {
        return SendClientMessage(playerid, COLOR_ADM, "SERVER: Hiç engel eklenmemiþ.");
    }

	new id, roadblock_name[25];
	new primary_str[756], sub_str[64];
	strcat(primary_str, "Model\n");

	for(new i; i < rows; ++i)
	{
		cache_get_value_name_int(i, "id", id);
        cache_get_value_name(i, "RoadblockName", roadblock_name, sizeof(roadblock_name));
		format(sub_str, sizeof(sub_str), "%i %s\n", id, roadblock_name);
		strcat(primary_str, sub_str);
	}

	if(page != 0) strcat(primary_str, "{FFFF00}Önceki Sayfa <<\n");
	if(rows >= MAX_CLOTHING_SHOW) strcat(primary_str, "{FFFF00}Sonraki Sayfa >>");

	Dialog_Show(playerid, ROADBLOCK_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Engel Seç", primary_str, "Seç", "Kapat");
	return 1;
}

Dialog:ROADBLOCK_LIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new page = GetPVarInt(playerid, "faction_roadblock_idx");
		if(!strcmp(inputtext, "Önceki Sayfa <<")) return Roadblock_List(playerid, page-1);
		if(!strcmp(inputtext, "Sonraki Sayfa >>")) return Roadblock_List(playerid, page+1);
		
		new id;
        sscanf(inputtext, "i", id);
        Roadblock_Create(playerid, Roadblock_GetInt(id, "RoadblockObjID"), Roadblock_GetString(id, "RoadblockName"));
	}
    return 1;
}

Roadblock_GetInt(id, wut[])
{
	new query[75], int;
	mysql_format(m_Handle, query, sizeof(query), "SELECT %s FROM faction_roadblocks WHERE id = %i LIMIT 1", wut, id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name_int(0, wut, int);
	cache_delete(cache);
	return int;
}

Roadblock_GetString(id, wut[])
{
	new query[75], int[25];
	mysql_format(m_Handle, query, sizeof(query), "SELECT %s FROM faction_roadblocks WHERE id = %i LIMIT 1", wut, id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name(0, wut, int, sizeof(int));
	cache_delete(cache);
	return int;
}

Attachment_List(playerid, page = 0)
{
    new query[100];
	SetPVarInt(playerid, "faction_attachment_idx", page);
	mysql_format(m_Handle, query, sizeof(query), "SELECT id, att_name, att_price FROM faction_attachments WHERE faction_id = %i LIMIT %i, 25", PlayerData[playerid][pFaction], page*MAX_CLOTHING_SHOW);
	mysql_tquery(m_Handle, query, "SQL_AttachmentList", "ii", playerid, page);
	return 1;
}

Server:SQL_AttachmentList(playerid, page)
{
	if(!IsPlayerConnected(playerid)) {
        return 0;
    }

    new rows = cache_num_rows();   
    if(!rows) {
        return SendClientMessage(playerid, COLOR_ADM, "SERVER: Hiç aksesuar eklenmemiþ.");
    }

	new id, att_name[20], att_price;
	new primary_str[756], sub_str[64];
	strcat(primary_str, "Model\tFiyat\n");

	for(new i; i < rows; ++i)
	{
		cache_get_value_name_int(i, "id", id);
        cache_get_value_name(i, "att_name", att_name, sizeof(att_name));
        cache_get_value_name_int(i, "att_price", att_price);

		format(sub_str, sizeof(sub_str), "%i %s\t$%s\n", id, att_name, MoneyFormat(att_price));
		strcat(primary_str, sub_str);
	}

	if(page != 0) strcat(primary_str, "{FFFF00}Önceki Sayfa <<\n");
	if(rows >= MAX_CLOTHING_SHOW) strcat(primary_str, "{FFFF00}Sonraki Sayfa >>");

	Dialog_Show(playerid, ACCESORY_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Aksesuar Seç", primary_str, "Seç", "Kapat");
	return 1;
}

Dialog:ACCESORY_LIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new page = GetPVarInt(playerid, "faction_attachment_idx");
		if(!strcmp(inputtext, "Önceki Sayfa <<")) return Attachment_List(playerid, page-1);
		if(!strcmp(inputtext, "Sonraki Sayfa >>")) return Attachment_List(playerid, page+1);
		
		new id;
        sscanf(inputtext, "i", id);
		new clothing_id = FreeAttachmentSlot(playerid);
		if(clothing_id == -1) return SendClientMessage(playerid, COLOR_WHITE, "SERVER: Aksesuar satýn alabilmek için ilk önce üstündekilerden bir kaçýný çýkar.");
		SendClientMessage(playerid, COLOR_WHITE, "ÝPUCU: {FFFF00}SPACE{FFFFFF} basarak bakýnabilirsin. Ýptal etmek için {FFFF00}ESC{FFFFFF} basabilirsin.");
		SendClientMessage(playerid, COLOR_WHITE, "Diðer aksesuarlarýný {FFFF00}/aksesuar{FFFFFF} yazarak düzenleyebilirsin.");
		
		SetPlayerAttachedObject(playerid, clothing_id, Attachment_GetInt(id, "att_id"), 2);
		EditAttachedObject(playerid, clothing_id);

		PlayerData[playerid][pClothingPrice] = Attachment_GetInt(id, "att_price");
		//format(PlayerData[playerid][pClothingName], 20, "%s", Attachment_Get("att_name", id));
		PlayerData[playerid][pBuyingClothing] = true;
	}
    return 1;
}

Attachment_GetInt(id, wut[])
{
	new query[75], int;
	mysql_format(m_Handle, query, sizeof(query), "SELECT %s FROM faction_attachments WHERE id = %i LIMIT 1", wut, id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name_int(0, wut, int);
	cache_delete(cache);
	return int;
}