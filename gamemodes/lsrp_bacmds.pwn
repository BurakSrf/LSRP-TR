CMD:kafesdowusu(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/kafesdowusu [1. oyuncu ID/adý]");
	if(playerid == id) return SendErrorMessage(playerid, "kendinle ws atamazsýn oç kabbe.");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kabbe oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kabbe henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, id, 4.5)) return SendErrorMessage(playerid, "Belirttiðin oça yakýn deðilsin.");
	if(oc_ws[playerid] == -1) return SendErrorMessage(playerid, "oç wsdesin napýyon.");
	if(oc_ws[id] != -1) return SendErrorMessage(playerid, "kappe çocuu wsde.");
	
	SendClientMessageEx(id, COLOR_ADM, "OÇWS: %s(%i) kappe çocuðu oç ws teklifi yolladý.", ReturnName(playerid), playerid);
	SendClientMessageEx(playerid, COLOR_ADM, "OÇWS: %s(%i) oçun çocuðuna ws teklifi yolladýn.", ReturnName(id), id);
	GivePlayerWeapon(playerid, 24, 999);
	GivePlayerWeapon(id, 24, 999);
	oc_ws[playerid] = id;
	oc_ws[id] = playerid;
	return 1;
}

CMD:yardimlar(playerid, params[])
{
	if (!PlayerData[playerid][pTester] && !PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	new
		sayi = 0;

	foreach(new i : Supports)
	{
		SendClientMessageEx(playerid, COLOR_ADM, "[Yardým: %i] {FF9900}%s(%i): %s", i+1, ReturnName(SupportData[i][SupportPlayer], 0), SupportData[i][SupportPlayer], SupportData[i][SupportText]);
		sayi++;
	}

	if (sayi == 0) return SendInfoMessage(playerid, "Hiç yardým isteði yok.");
	return 1;
}

CMD:yk(playerid, params[])return cmd_yardimkabul(playerid, params);
CMD:yardimkabul(playerid, params[])
{
	if (!PlayerData[playerid][pTester] && !PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);
	static id;
	if(sscanf(params, "d", id)) return SendUsageMessage(playerid, "/yk [yardým ID]");
	if (!Iter_Contains(Supports, (id-1))) return SendErrorMessage(playerid, "Belirttiðin yardým ID bulunamadý.");
	SendTesterMessage(COLOR_ORANGE, sprintf("[Yardým] Tester %s %i numaralý yardým isteðini kabul etti.", ReturnName(playerid, 1), id));
	cmd_pm(playerid, sprintf("%i Merhabalar, yardým isteðin kabul edildi. Birazdan sana yardýmcý olacaðým.", SupportData[(id-1)][SupportPlayer]));
	Support_Remove((id-1));
	return 1;
}

CMD:yr(playerid, params[])return cmd_yardimred(playerid, params);
CMD:yardimred(playerid, params[])
{
	if (!PlayerData[playerid][pTester] && !PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);
	static id;
	if(sscanf(params, "d", id)) return SendUsageMessage(playerid, "/yr [yardým ID]");
	if (!Iter_Contains(Supports, (id-1))) return SendErrorMessage(playerid, "Belirttiðin yardým ID bulunamadý.");
	SendTesterMessage(COLOR_ORANGE, sprintf("[Yardým] Tester %s %i numaralý yardým isteðini reddetti.", ReturnName(playerid, 1), id));
    cmd_pm(playerid, sprintf("%i Merhabalar, yardým isteðin reddedildi. Bu bir oto mesajdýr lütfen cevaplamayýn.", SupportData[(id-1)][SupportPlayer]));
	Support_Remove((id-1));
	return 1;
}

CMD:raporlar(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	new
		sayi = 0;

	foreach(new i : Reports)
	{
		SendClientMessageEx(playerid, COLOR_ADM, "[Rapor: %i] {FF9900}%s(%i): %s", i+1, ReturnName(ReportData[i][ReportPlayer], 0), ReportData[i][ReportPlayer], ReportData[i][ReportText]);
		sayi++;
	}

	if (sayi == 0) return SendInfoMessage(playerid, "Hiç rapor yok.");
	return 1;
}

CMD:rk(playerid, params[])return cmd_raporkabul(playerid, params);
CMD:raporkabul(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);
	static id;
	if(sscanf(params, "d", id)) return SendUsageMessage(playerid, "/rk [rapor ID]");
	if (!Iter_Contains(Reports, (id-1))) return SendErrorMessage(playerid, "Belirttiðin rapor ID bulunamadý.");
	SendAdminMessage(COLOR_ORANGE, sprintf("[Rapor] Admin %s %i numaralý raporu kabul etti.", ReturnName(playerid, 1), id));
	cmd_pm(playerid, sprintf("%i Merhabalar, raporun kabul edildi. Birazdan sana yardýmcý olacaðým.", ReportData[(id-1)][ReportPlayer]));
	Report_Remove((id-1));
	return 1;
}

CMD:rr(playerid, params[])return cmd_raporred(playerid, params);
CMD:raporred(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);
	static id;
	if(sscanf(params, "d", id)) return SendUsageMessage(playerid, "/rr [rapor ID]");
	if (!Iter_Contains(Reports, (id-1))) return SendErrorMessage(playerid, "Belirttiðin rapor ID bulunamadý.");
	SendAdminMessage(COLOR_ORANGE, sprintf("[Rapor] Admin %s %i numaralý raporu reddetti.", ReturnName(playerid, 1), id));
    cmd_pm(playerid, sprintf("%i Merhabalar, raporun reddedildi. Bu bir oto mesajdýr lütfen cevaplamayýn.", ReportData[(id-1)][ReportPlayer]));
	Report_Remove((id-1));
	return 1;
}

CMD:sokak(playerid, params[])
{
	new Float: x, Float: y, Float: z; GetPlayerPos(playerid, x, y, z);
	SendClientMessageEx(playerid, COLOR_WHITE, "Sokak: %s, %s, %s %i, San Andreas", GetPlayerStreet(playerid), GetZoneName(x, y, z), GetCityName(x, y, z), ReturnAreaCode(GetZoneID(x, y, z)));
	return 1;
}

CMD:makechopshop(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return 0;

    static
		id;
		
	id = Chopshop_Create(playerid);

	if (id == -1)
	    return SendErrorMessage(playerid, "Maksimum eklenebilecek Chopshop sýnýrýna ulaþýlmýþ.");

	SendClientMessageEx(playerid, COLOR_ADM, "SERVER: #%d numaralý Chopshop'u ekledin.", id);
	LogAdminAction(playerid, sprintf("%i numaralý Chopshop'u ekledi.", id));
	cmd_editchopshop(playerid, sprintf("%i position", id));
    return 1;
}

CMD:destroychopshop(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return 0;

	static
	    id = 0;

	if (sscanf(params, "d", id))
	    return SendUsageMessage(playerid, "/destroychopshop [chopshop ID]");

	if ((id < 0 || id >= MAX_CHOPSHOP) || !ChopshopData[id][chopshop_exist])
	    return SendErrorMessage(playerid, "Hatalý chopshop ID girdin.");

	Chopshop_Delete(id);
	SendClientMessageEx(playerid, COLOR_ADM, "SERVER: #%d numaralý Chopshop'u sildin.", id);
	LogAdminAction(playerid, sprintf("%i numaralý Chopshop'u sildi.", id));
	return 1;
}

CMD:editchopshop(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return 0;

	new
		id, str[30], b_str[30];

	if(sscanf(params, "is[30]S()[30]", id, str, b_str))
	{
		SendUsageMessage(playerid, "/editchopshop [chopshop ID] [parametre]");
		SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}position, wanted");
		return 1;
 	}

	if ((id < 0 || id >= MAX_CHOPSHOP) || !ChopshopData[id][chopshop_exist])
	    return SendErrorMessage(playerid, "Hatalý chopshop ID girdin.");

	if(Chopshop_Nearest(playerid) != id)
	    return SendErrorMessage(playerid, "Düzenlemek istediðin chopshop yakýnýnda deðilsin.");

	if(!strcmp(str, "position"))
	{
		if(EditingObject[playerid])
			return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

		EditingID[playerid] = id;
		EditingObject[playerid] = 4;
		EditDynamicObject(playerid, ChopshopData[id][chopshop_object][0]);

		SendClientMessageEx(playerid, COLOR_GOLD, "SERVER: %i numaralý Chopshop'un pozisyonunu güncelliyorsun.", id);
		LogAdminAction(playerid, sprintf("%i numaralý Chopshop'un pozisyonunu güncelliyor.", id));
	}
	else if(!strcmp(str, "wanted"))
	{
	    Chopshop_GetRandomModel(id);
	    Chopshop_Refresh(id);
	    
   		SendClientMessageEx(playerid, COLOR_GOLD, "SERVER: %i numaralý Chopshop'un istenen araç listesini güncelledin.", id);
		LogAdminAction(playerid, sprintf("%i numaralý Chopshop'un istenen araç listesini güncelledi.", id));
	}
	return 1;
}

Entrance_Create(playerid, name[])
{
	new id = Iter_Free(Entrances);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek bina sýnýrýna ulaþýlmýþ.");

	static
		Float: x,
		Float: y,
		Float: z,
		Float: angle;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);
			
	format(EntranceData[id][EntranceName], 32, name);
	EntranceData[id][EntranceIcon] = 1318;
	EntranceData[id][EntranceFaction] = 0;
	EntranceData[id][EntranceLocked] = true;

	EntranceData[id][EntrancePos][0] = x;
	EntranceData[id][EntrancePos][1] = y;
	EntranceData[id][EntrancePos][2] = z;
	EntranceData[id][EntrancePos][3] = angle;

	EntranceData[id][EntranceInteriorID] = GetPlayerInterior(playerid);
	EntranceData[id][EntranceWorld] = GetPlayerVirtualWorld(playerid);

	EntranceData[id][EntranceInt][0] = x;
	EntranceData[id][EntranceInt][1] = y;
	EntranceData[id][EntranceInt][2] = z + 10000;
	EntranceData[id][EntranceInt][3] = 0.0000;

	EntranceData[id][ExitInteriorID] = 99;
	EntranceData[id][ExitWorld] = 99;
	Iter_Add(Entrances, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý binayý ekledin. (kilidi açýp, iç kýsmý ayarlamayý unutmayýn)", id);
	mysql_tquery(m_Handle, "INSERT INTO entrances (EntranceLocked) VALUES(1)", "OnEntranceCreated", "d", id);
	Entrance_Refresh(id);
	return 1;
}

Server:OnEntranceCreated(id)
{
	EntranceData[id][EntranceID] = cache_insert_id();
	Entrance_Save(id);
	return 1;
}

Entrance_Save(id)
{
	new
	    query[200];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE entrances SET EntranceName = '%e', EnterX = %f, EnterY = %f, EnterZ = %f, EnterA = %f, EnterInterior = %i, EnterWorld = %i WHERE id = %i",
        EntranceData[id][EntranceName],
		EntranceData[id][EntrancePos][0],
	    EntranceData[id][EntrancePos][1],
	    EntranceData[id][EntrancePos][2],
	    EntranceData[id][EntrancePos][3],
	    EntranceData[id][EntranceInteriorID],
	    EntranceData[id][EntranceWorld],
	    EntranceData[id][EntranceID]
	);
	mysql_tquery(m_Handle, query);
	
	mysql_format(m_Handle, query, sizeof(query), "UPDATE entrances SET ExitX = %f, ExitY = %f, ExitZ = %f, ExitA = %f, ExitInterior = %i, ExitWorld = %i WHERE id = %i",
		EntranceData[id][EntranceInt][0],
	    EntranceData[id][EntranceInt][1],
	    EntranceData[id][EntranceInt][2],
	    EntranceData[id][EntranceInt][3],
	    EntranceData[id][ExitInteriorID],
	    EntranceData[id][ExitWorld],
	    EntranceData[id][EntranceID]
	);
	mysql_tquery(m_Handle, query);
	
	mysql_format(m_Handle, query, sizeof(query), "UPDATE entrances SET EntranceIcon = %i, EntranceFaction = %i, EntranceLocked = %i WHERE id = %i",
        EntranceData[id][EntranceIcon],
		EntranceData[id][EntranceFaction],
	    EntranceData[id][EntranceLocked],
	    EntranceData[id][EntranceID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

Entrance_Delete(id)
{
	foreach(new i : Player)
	{
		if(PlayerData[i][pInsideEntrance] == id)
		{
		    PlayerData[i][pInsideEntrance] = -1;
			SendPlayer(i, EntranceData[id][EntrancePos][0], EntranceData[id][EntrancePos][1], EntranceData[id][EntrancePos][2], EntranceData[id][EntrancePos][3], EntranceData[id][EntranceInteriorID], EntranceData[id][EntranceWorld]);
			SendClientMessage(i, COLOR_YELLOW, "SERVER: Bu bina silindiði için dýþarý çýkarýldýnýz.");
			SetCameraBehindPlayer(i);
		}
	}

	new
		query[64];

	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM entrances WHERE id = %i", EntranceData[id][EntranceID]);
	mysql_tquery(m_Handle, query);

	if (IsValidDynamicPickup(EntranceData[id][EntrancePickup][0])) DestroyDynamicPickup(EntranceData[id][EntrancePickup][0]);
	if (IsValidDynamicPickup(EntranceData[id][EntrancePickup][1])) DestroyDynamicPickup(EntranceData[id][EntrancePickup][1]);

	if (IsValidDynamicArea(EntranceData[id][EntranceAreaID][0])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, EntranceData[id][EntranceAreaID][0], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(EntranceData[id][EntranceAreaID][0]);
	}

	if (IsValidDynamicArea(EntranceData[id][EntranceAreaID][1])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, EntranceData[id][EntranceAreaID][1], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(EntranceData[id][EntranceAreaID][1]);
	}
	
	Iter_Remove(Entrances, id);
	return 1;
}

Entrance_Refresh(id)
{
	if (IsValidDynamicPickup(EntranceData[id][EntrancePickup][0])) DestroyDynamicPickup(EntranceData[id][EntrancePickup][0]);
	if (IsValidDynamicPickup(EntranceData[id][EntrancePickup][1])) DestroyDynamicPickup(EntranceData[id][EntrancePickup][1]);

	if (IsValidDynamicArea(EntranceData[id][EntranceAreaID][0])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, EntranceData[id][EntranceAreaID][0], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(EntranceData[id][EntranceAreaID][0]);
	}

	if (IsValidDynamicArea(EntranceData[id][EntranceAreaID][1])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, EntranceData[id][EntranceAreaID][1], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(EntranceData[id][EntranceAreaID][1]);
	}

	new array[2]; array[0] = 2; array[1] = id;
	EntranceData[id][EntrancePickup][0] = CreateDynamicPickup(EntranceData[id][EntranceIcon], 23, EntranceData[id][EntrancePos][0], EntranceData[id][EntrancePos][1], EntranceData[id][EntrancePos][2], EntranceData[id][EntranceWorld], EntranceData[id][EntranceInteriorID]);
	EntranceData[id][EntranceAreaID][0] = CreateDynamicSphere(EntranceData[id][EntrancePos][0], EntranceData[id][EntrancePos][1], EntranceData[id][EntrancePos][2], 3.0, EntranceData[id][EntranceWorld], EntranceData[id][EntranceInteriorID]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, EntranceData[id][EntranceAreaID][0], E_STREAMER_EXTRA_ID, array, 2);

	array[0] = 3; array[1] = id;
	EntranceData[id][EntrancePickup][1] = CreateDynamicPickup(EntranceData[id][EntranceIcon], 23, EntranceData[id][EntranceInt][0], EntranceData[id][EntranceInt][1], EntranceData[id][EntranceInt][2], EntranceData[id][ExitWorld], EntranceData[id][ExitInteriorID]);
	EntranceData[id][EntranceAreaID][1] = CreateDynamicSphere(EntranceData[id][EntranceInt][0], EntranceData[id][EntranceInt][1], EntranceData[id][EntranceInt][2], 3.0, EntranceData[id][ExitWorld], EntranceData[id][ExitInteriorID]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, EntranceData[id][EntranceAreaID][1], E_STREAMER_EXTRA_ID, array, 2);
	return 1;
}

Entrance_Nearest(playerid)
{
	return GetPVarInt(playerid, "AtEntrance");
}

Garage_Create(playerid, linkid)
{
	new id = Iter_Free(Garages);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek garaj sýnýrýna ulaþýlmýþ.");

	static
		Float: x,
		Float: y,
		Float: z,
		Float: angle;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);

	GarageData[id][GarageFaction] = 0;
	GarageData[id][GaragePropertyID] = linkid;
	GarageData[id][GarageLocked] = true;

	GarageData[id][GaragePos][0] = x;
	GarageData[id][GaragePos][1] = y;
	GarageData[id][GaragePos][2] = z;
	GarageData[id][GaragePos][3] = angle;

	GarageData[id][EnterInteriorID] = GetPlayerInterior(playerid);
	GarageData[id][EnterWorld] = GetPlayerVirtualWorld(playerid);

	GarageData[id][GarageInt][0] = x;
	GarageData[id][GarageInt][1] = y;
	GarageData[id][GarageInt][2] = z + 10000;
	GarageData[id][GarageInt][3] = 0.0000;

	GarageData[id][ExitInteriorID] = 99;
	GarageData[id][ExitWorld] = 99;
	Iter_Add(Garages, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý garajý (ev sahibi: %s) ekledin. (kilidi açýp, iç kýsmý ayarlamayý unutmayýn)", id, ReturnSQLName(PropertyData[linkid][PropertyOwnerID]));
	mysql_tquery(m_Handle, "INSERT INTO garages (GarageLocked) VALUES(1)", "OnGarageCreated", "d", id);
	Garage_Refresh(id);
	return 1;
}

Server:OnGarageCreated(id)
{
	GarageData[id][GarageID] = cache_insert_id();
	Garage_Save(id);
	return 1;
}

Garage_Refresh(id)
{
	if (IsValidDynamicArea(GarageData[id][GarageAreaID][0])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, GarageData[id][GarageAreaID][0], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(GarageData[id][GarageAreaID][0]);
	}

	if (IsValidDynamicArea(GarageData[id][GarageAreaID][1])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, GarageData[id][GarageAreaID][1], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(GarageData[id][GarageAreaID][1]);
	}

	new array[2]; array[0] = 9; array[1] = id;
	GarageData[id][GarageAreaID][0] = CreateDynamicSphere(GarageData[id][GaragePos][0], GarageData[id][GaragePos][1], GarageData[id][GaragePos][2], 5.0, GarageData[id][EnterWorld], GarageData[id][EnterInteriorID]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, GarageData[id][GarageAreaID][0], E_STREAMER_EXTRA_ID, array, 2);

	array[0] = 10; array[1] = id;
	GarageData[id][GarageAreaID][1] = CreateDynamicSphere(GarageData[id][GarageInt][0], GarageData[id][GarageInt][1], GarageData[id][GarageInt][2], 5.0, GarageData[id][ExitWorld], GarageData[id][ExitInteriorID]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, GarageData[id][GarageAreaID][1], E_STREAMER_EXTRA_ID, array, 2);
	return 1;
}

Garage_Save(id)
{
	new
	    query[200];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE garages SET GaragePropertyID = %i, EnterX = %f, EnterY = %f, EnterZ = %f, EnterA = %f, EnterInterior = %i, EnterWorld = %i WHERE id = %i",
        GarageData[id][GaragePropertyID],
		GarageData[id][GaragePos][0],
	    GarageData[id][GaragePos][1],
	    GarageData[id][GaragePos][2],
	    GarageData[id][GaragePos][3],
	    GarageData[id][EnterInteriorID],
	    GarageData[id][EnterWorld],
	    GarageData[id][GarageID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE garages SET ExitX = %f, ExitY = %f, ExitZ = %f, ExitA = %f, ExitInterior = %i, ExitWorld = %i WHERE id = %i",
		GarageData[id][GarageInt][0],
	    GarageData[id][GarageInt][1],
	    GarageData[id][GarageInt][2],
	    GarageData[id][GarageInt][3],
	    GarageData[id][ExitInteriorID],
	    GarageData[id][ExitWorld],
	    GarageData[id][GarageID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE garages SET GarageFaction = %i, GarageLocked = %i WHERE id = %i",
		GarageData[id][GarageFaction],
	    GarageData[id][GarageLocked],
	    GarageData[id][GarageID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

Garage_Delete(id)
{
	foreach(new i : Player)
	{
		if(PlayerData[i][pInsideGarage] == id)
		{
		    PlayerData[i][pInsideGarage] = 0;
			SendPlayer(i, GarageData[id][GaragePos][0], GarageData[id][GaragePos][1], GarageData[id][GaragePos][2], GarageData[id][GaragePos][3], GarageData[id][EnterInteriorID], GarageData[id][EnterWorld]);
			SendClientMessage(i, COLOR_YELLOW, "SERVER: Bu garajýn silindiði için dýþarý çýkarýldýnýz.");
			SetCameraBehindPlayer(i);
		}
	}

	new
		query[64];

	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM garages WHERE id = %i", GarageData[id][GarageID]);
	mysql_tquery(m_Handle, query);

	if (IsValidDynamicArea(GarageData[id][GarageAreaID][0])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, GarageData[id][GarageAreaID][0], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(GarageData[id][GarageAreaID][0]);
	}

	if (IsValidDynamicArea(GarageData[id][GarageAreaID][1])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, GarageData[id][GarageAreaID][1], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(GarageData[id][GarageAreaID][1]);
	}

	Iter_Remove(Garages, id);
	return 1;
}

CMD:makeimpound(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3) return 0;

	static
	    id = -1,
		Float:x,
		Float:y,
		Float:z;

	if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
 		return SendErrorMessage(playerid, "Araç baðlama noktasýnýn bina içerisinde olamaz.");

	GetPlayerPos(playerid, x, y, z);

	id = Impound_Create(x, y, z);

	if (id == -1)
	    return SendErrorMessage(playerid, "Maksimum eklenebilecek baðlama noktasý sýnýrýna ulaþýlmýþ.");

	SendClientMessageEx(playerid, COLOR_ADM, "SERVER: #%d numaralý baðlama noktasýný ekledin.", id);
	LogAdminAction(playerid, sprintf("%i numaralý baðlama noktasýný oluþturdu.", id));
	return 1;
}

CMD:destroyimpound(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3) return 0;

	static
	    id = 0;

	if (sscanf(params, "d", id))
	    return SendUsageMessage(playerid, "/destroyimpound [impound ID]");

	if ((id < 0 || id >= MAX_IMPOUND_LOTS) || !ImpoundData[id][impoundExists])
	    return SendErrorMessage(playerid, "Hatalý impound ID girdin.");

	Impound_Delete(id);
	SendClientMessageEx(playerid, COLOR_ADM, "SERVER: #%d numaralý baðlama noktasýný sildin.", id);
	LogAdminAction(playerid, sprintf("%i numaralý baðlama noktasýný sildi.", id));
	return 1;
}

CMD:editimpound(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3) return 0;

	static
	    id,
	    type[24],
	    string[128];

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendUsageMessage(playerid, "/editimpound [impound ID] [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}location, release");
		return 1;
	}
	if ((id < 0 || id >= MAX_IMPOUND_LOTS) || !ImpoundData[id][impoundExists])
	    return SendErrorMessage(playerid, "Hatalý impound ID girdin.");

	if (!strcmp(type, "location", true))
	{
	    static
	        Float:x,
	        Float:y,
	        Float:z;

	    GetPlayerPos(playerid, x, y, z);

		ImpoundData[id][impoundLot][0] = x;
		ImpoundData[id][impoundLot][1] = y;
		ImpoundData[id][impoundLot][2] = z;

		Impound_Refresh(id);
		Impound_Save(id);

		SendClientMessageEx(playerid, COLOR_ADM, "SERVER: #%d numaralý baðlama noktasýnýn baðlama lokasyonunu ayarladýn.", id);
		LogAdminAction(playerid, sprintf("%i numaralý baðlama noktasýnýn baðlama lokasyonunu ayarladý.", id));
	}
	else if (!strcmp(type, "release", true))
	{
	    static
	        Float:x,
	        Float:y,
	        Float:z,
			Float:angle;

	    GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);

		ImpoundData[id][impoundRelease][0] = x;
		ImpoundData[id][impoundRelease][1] = y;
		ImpoundData[id][impoundRelease][2] = z;
		ImpoundData[id][impoundRelease][3] = angle;

		Impound_Save(id);
		SendClientMessageEx(playerid, COLOR_ADM, "SERVER: #%d numaralý baðlama noktasýnýn çýkýþ lokasyonunu ayarladýn.", id);
		LogAdminAction(playerid, sprintf("%i numaralý baðlama noktasýnýn çýkýþ lokasyonunu ayarladý.", id));
	}
	return 1;
}

CMD:garaj(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/garaj [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
	    static link_id;
	    if(sscanf(string, "i", link_id)) return SendUsageMessage(playerid, "/garaj ekle [baðlantýlý ev ID]");
        //if (!Iter_Contains(Properties, link_id)) return SendErrorMessage(playerid, "Hatalý ev ID girdin.");
		Garage_Create(playerid, link_id);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/garaj git [garaj ID]");
		if (!Iter_Contains(Garages, id)) return SendErrorMessage(playerid, "Hatalý garaj ID girdin.");
		SendPlayer(playerid, GarageData[id][GaragePos][0], GarageData[id][GaragePos][1], GarageData[id][GaragePos][2], GarageData[id][GaragePos][3], GarageData[id][EnterInteriorID], GarageData[id][EnterWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý garaja ýþýnlandýn.", id);
		return 1;
 	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];

		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/garaj duzenle [bina ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[giris][cikis][kilit][birlik]");
			return 1;
		}

		if (!Iter_Contains(Garages, id)) return SendErrorMessage(playerid, "Hatalý garaj ID girdin.");

		if (!strcmp(type_two, "giris", true))
		{
			GetPlayerPos(playerid, GarageData[id][GaragePos][0], GarageData[id][GaragePos][1], GarageData[id][GaragePos][2]);
			GetPlayerFacingAngle(playerid, GarageData[id][GaragePos][3]);

			GarageData[id][EnterInteriorID] = GetPlayerInterior(playerid);
			GarageData[id][EnterWorld] = GetPlayerVirtualWorld(playerid);

            SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu garajýn giriþ kýsmýný güncelledin.");
			Garage_Refresh(id);
			Garage_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "cikis", true))
		{
			GetPlayerPos(playerid, GarageData[id][GarageInt][0], GarageData[id][GarageInt][1], GarageData[id][GarageInt][2]);
			GetPlayerFacingAngle(playerid, GarageData[id][GarageInt][3]);

			GarageData[id][ExitInteriorID] = GetPlayerInterior(playerid);
			GarageData[id][ExitWorld] = GetPlayerVirtualWorld(playerid);

			foreach(new i : Player)
			{
				if(PlayerData[i][pInsideGarage] == id)
				{
					SendPlayer(i, GarageData[id][GarageInt][0], GarageData[id][GarageInt][1], GarageData[id][GarageInt][2], GarageData[id][GarageInt][3], GarageData[id][ExitInteriorID], GarageData[id][ExitWorld]);
					SendClientMessage(i, COLOR_YELLOW, "SERVER: Bu garajýn iç kýsmý güncellendi.");
					SetCameraBehindPlayer(i);
				}
			}

			SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu garajýn çýkýþ kýsmýný güncelledin.");
			Garage_Refresh(id);
			Garage_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "kilit", true))
		{
			new locked;
			if (sscanf(string_two, "d", locked)) return SendUsageMessage(playerid, "/garaj duzenle [garaj ID] kilit [0/1]");
			if (locked < 0 || locked > 1)	return SendErrorMessage(playerid, "Hatalý kilit durumu girdin. (0/1)");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu garajýn kapýlarýný %s olarak güncelledin.", !locked ? ("kilitli deðil") : ("kilitli"));
			GarageData[id][GarageLocked] = bool:locked;
			Garage_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "birlik", true))
		{
			new faction;
			if(sscanf(string_two, "d", faction)) return SendUsageMessage(playerid, "/garaj duzenle [garaj ID] birlik [birlik ID]");
            if(!Iter_Contains(Factions, faction)) return SendErrorMessage(playerid, "Hatalý birlik ID girdin.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu garajýn birliðini %i olarak güncelledin.", faction);
			GarageData[id][GarageFaction] = faction;
			Entrance_Save(id);
			return 1;
		}
	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/garaj sil [bina ID]");
		if (!Iter_Contains(Garages, id)) return SendErrorMessage(playerid, "Hatalý garaj ID girdin.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý garajý sildin.", id);
		Garage_Delete(id);
		return 1;
 	}
 	else SendClientMessage(playerid, COLOR_ADM, "SERVER: Geçersiz parametre girdin.");
	return 1;
}

CMD:bina(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];

	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/bina [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
		if (isnull(string) || strlen(string) > 32) return SendUsageMessage(playerid, "/bina ekle [bina adý]");
		Entrance_Create(playerid, string);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/bina git [bina ID]");
		if (!Iter_Contains(Entrances, id)) return SendErrorMessage(playerid, "Hatalý bina ID girdin.");
		SendPlayer(playerid, EntranceData[id][EntrancePos][0], EntranceData[id][EntrancePos][1], EntranceData[id][EntrancePos][2], EntranceData[id][EntrancePos][3], EntranceData[id][EntranceInteriorID], EntranceData[id][EntranceWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý binaya ýþýnlandýn.", id);
		return 1;
 	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];

		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/bina duzenle [bina ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[giris][cikis][ad][kilit][ikon]");
			return 1;
		}

		if (!Iter_Contains(Entrances, id)) return SendErrorMessage(playerid, "Hatalý bina ID girdin.");

		if (!strcmp(type_two, "giris", true))
		{
			GetPlayerPos(playerid, EntranceData[id][EntrancePos][0], EntranceData[id][EntrancePos][1], EntranceData[id][EntrancePos][2]);
			GetPlayerFacingAngle(playerid, EntranceData[id][EntrancePos][3]);

			EntranceData[id][EntranceInteriorID] = GetPlayerInterior(playerid);
			EntranceData[id][EntranceWorld] = GetPlayerVirtualWorld(playerid);

            SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu binanýn giriþ kýsmýný güncelledin.");

			Entrance_Refresh(id);
			Entrance_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "cikis", true))
		{
			GetPlayerPos(playerid, EntranceData[id][EntranceInt][0], EntranceData[id][EntranceInt][1], EntranceData[id][EntranceInt][2]);
			GetPlayerFacingAngle(playerid, EntranceData[id][EntranceInt][3]);

			EntranceData[id][ExitInteriorID] = GetPlayerInterior(playerid);
			EntranceData[id][ExitWorld] = GetPlayerVirtualWorld(playerid);

			foreach(new i : Player)
			{
				if(PlayerData[i][pInsideEntrance] == id)
				{
					SendPlayer(i, EntranceData[id][EntranceInt][0], EntranceData[id][EntranceInt][1], EntranceData[id][EntranceInt][2], EntranceData[id][EntranceInt][3], EntranceData[id][ExitInteriorID], EntranceData[id][ExitWorld]);
					SendClientMessage(i, COLOR_YELLOW, "SERVER: Bu binanýn iç kýsmý güncellendi.");
					SetCameraBehindPlayer(i);
				}
			}

			SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu binanýn çýkýþ kýsmýný güncelledin.");

			Entrance_Refresh(id);
			Entrance_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "ad", true))
		{
			new name[32];
			if (sscanf(string_two, "s[32]", name)) return SendUsageMessage(playerid, "/bina duzenle [bina ID] name [bina adý]");
			format(EntranceData[id][EntranceName], 32, name);
			Entrance_Refresh(id);
			Entrance_Save(id);

			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu binanýn adýný %s olarak güncelledin.", name);
			return 1;
		}
		else if (!strcmp(type_two, "kilit", true))
		{
			new locked;
			if (sscanf(string_two, "d", locked)) return SendUsageMessage(playerid, "/bina duzenle [bina ID] locked [0/1]");
			if (locked < 0 || locked > 1)	return SendErrorMessage(playerid, "Hatalý kilit durumu girdin. (0/1)");
			EntranceData[id][EntranceLocked] = bool:locked;
			Entrance_Save(id);

			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu binanýn kapýlarýný %s olarak güncelledin.", !locked ? ("kilitli deðil") : ("kilitli"));
			return 1;
		}
		else if (!strcmp(type_two, "ikon", true))
		{
			new icon;
			if (sscanf(string_two, "d", icon)) return SendUsageMessage(playerid, "/bina duzenle [bina ID] icon [ikon ID]");
			EntranceData[id][EntranceIcon] = icon;
			Entrance_Refresh(id);
			Entrance_Save(id);

			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu binanýn ikonunu %i olarak güncelledin.", icon);
			return 1;
		}
	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/bina sil [bina ID]");
		if (!Iter_Contains(Entrances, id)) return SendErrorMessage(playerid, "Hatalý bina ID girdin.");
		Entrance_Delete(id);

		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý binayý sildin.", id);
		return 1;
 	}
	return 1;
}

PNS_Create(playerid, name[])
{
	new id = Iter_Free(Sprays);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek PNS sýnýrýna ulaþýlmýþ.");
		
	static
		Float: x,
		Float: y,
		Float: z,
		Float: angle;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);

	format(PNSData[id][PnsName], 45, name);
	PNSData[id][PnsPrice] = 20;
	PNSData[id][PnsEarnings] = 0;
	PNSData[id][PnsOccupied] = false;

	PNSData[id][PnsPos][0] = x;
	PNSData[id][PnsPos][1] = y;
	PNSData[id][PnsPos][2] = z;
	PNSData[id][PnsPos][3] = angle;

	PNSData[id][EnterInteriorID] = GetPlayerInterior(playerid);
	PNSData[id][EnterWorld] = GetPlayerVirtualWorld(playerid);

	PNSData[id][PnsInt][0] = x;
	PNSData[id][PnsInt][1] = y;
	PNSData[id][PnsInt][2] = z + 10000;
	PNSData[id][PnsInt][3] = 0.0000;

	PNSData[id][ExitInteriorID] = 99;
	PNSData[id][ExitWorld] = 99;
	Iter_Add(Sprays, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý PNS'yi ekledin. (kilidi açýp, iç kýsmý ayarlamayý unutmayýn)", id);
	mysql_tquery(m_Handle, "INSERT INTO paynsprays (PnsEarnings) VALUES(20)", "OnPNSCreated", "d", id);
	PNS_Refresh(id);
	return 1;
}

Server:OnPNSCreated(id)
{
	PNSData[id][PnsID] = cache_insert_id();
	PNS_Save(id);
	return 1;
}

PNS_Save(id)
{
	new
	    query[255];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE paynsprays SET PnsName = '%e', EnterX = %f, EnterY = %f, EnterZ = %f, EnterA = %f, EnterInterior = %i, EnterWorld = %i WHERE id = %i",
        PNSData[id][PnsName],
		PNSData[id][PnsPos][0],
	    PNSData[id][PnsPos][1],
	    PNSData[id][PnsPos][2],
	    PNSData[id][PnsPos][3],
	    PNSData[id][EnterInteriorID],
	    PNSData[id][EnterWorld],
	    PNSData[id][PnsID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE paynsprays SET RepairX = %f, RepairY = %f, RepairZ = %f, RepairA = %f, RepairInterior = %i, RepairWorld = %i WHERE id = %i",
		PNSData[id][PnsInt][0],
	    PNSData[id][PnsInt][1],
	    PNSData[id][PnsInt][2],
	    PNSData[id][PnsInt][3],
	    PNSData[id][ExitInteriorID],
	    PNSData[id][ExitWorld],
	    PNSData[id][PnsID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE paynsprays SET PnsPrice = %i, PnsEarnings = %i WHERE id = %i",
		PNSData[id][PnsPrice],
	    PNSData[id][PnsEarnings],
	    PNSData[id][PnsID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

PNS_Delete(id)
{
	new
		query[64];

	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM paynsprays WHERE id = %i", PNSData[id][PnsID]);
	mysql_tquery(m_Handle, query);

	if (IsValidDynamicPickup(PNSData[id][PnsPickup])) DestroyDynamicPickup(PNSData[id][PnsPickup]);

	if (IsValidDynamicArea(PNSData[id][PnsAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, PNSData[id][PnsAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(PNSData[id][PnsAreaID]);
	}

	Iter_Remove(Sprays, id);
	return 1;
}

PNS_Refresh(id)
{
	if (IsValidDynamicPickup(PNSData[id][PnsPickup])) DestroyDynamicPickup(PNSData[id][PnsPickup]);
	if (IsValidDynamicArea(PNSData[id][PnsAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, PNSData[id][PnsAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(PNSData[id][PnsAreaID]);
	}

	PNSData[id][PnsPickup] = CreateDynamicPickup(1239, 1, PNSData[id][PnsPos][0], PNSData[id][PnsPos][1], PNSData[id][PnsPos][2], PNSData[id][EnterWorld], PNSData[id][EnterInteriorID]);
	
	new array[2]; array[0] = 8; array[1] = id;
	PNSData[id][PnsAreaID] = CreateDynamicSphere(PNSData[id][PnsPos][0], PNSData[id][PnsPos][1], PNSData[id][PnsPos][2], 5.0, PNSData[id][EnterWorld], PNSData[id][EnterInteriorID]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, PNSData[id][PnsAreaID], E_STREAMER_EXTRA_ID, array, 2);
	return 1;
}

CMD:pns(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];

	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/pns [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
		if (isnull(string) || strlen(string) > 32) return SendUsageMessage(playerid, "/pns ekle [pns adý]");
		PNS_Create(playerid, string);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/pns git [pns ID]");
		if (!Iter_Contains(Sprays, id)) return SendErrorMessage(playerid, "Hatalý PNS ID girdin.");
		SendPlayer(playerid, PNSData[id][PnsPos][0], PNSData[id][PnsPos][1], PNSData[id][PnsPos][2], PNSData[id][PnsPos][3], PNSData[id][EnterInteriorID], PNSData[id][EnterWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý PNS'e ýþýnlandýn.", id);
		return 1;
 	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];

		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/pns duzenle [pns ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[giris][cikis][ad][ucret]");
			return 1;
		}

		if (!Iter_Contains(Sprays, id)) return SendErrorMessage(playerid, "Hatalý PNS ID girdin.");

		if (!strcmp(type_two, "giris", true))
		{
			GetPlayerPos(playerid, PNSData[id][PnsPos][0], PNSData[id][PnsPos][1], PNSData[id][PnsPos][2]);
			GetPlayerFacingAngle(playerid, PNSData[id][PnsPos][3]);

			PNSData[id][EnterInteriorID] = GetPlayerInterior(playerid);
			PNSData[id][EnterWorld] = GetPlayerVirtualWorld(playerid);

            SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu PNS'nin giriþ kýsmýný güncelledin.");

			PNS_Refresh(id);
			PNS_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "cikis", true))
		{
			GetPlayerPos(playerid, PNSData[id][PnsInt][0], PNSData[id][PnsInt][1], PNSData[id][PnsInt][2]);
			GetPlayerFacingAngle(playerid, PNSData[id][PnsInt][3]);

			PNSData[id][ExitInteriorID] = GetPlayerInterior(playerid);
			PNSData[id][ExitWorld] = GetPlayerVirtualWorld(playerid);

			SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu PNS'nin çýkýþ kýsmýný güncelledin.");

			PNS_Refresh(id);
			PNS_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "ad", true))
		{
			new name[45];
			if (sscanf(string_two, "s[45]", name)) return SendUsageMessage(playerid, "/pns duzenle [pns ID] ad [pns adý]");
			format(PNSData[id][PnsName], 45, name);

			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu PNS'nin adýný %s olarak güncelledin.", name);
			PNS_Refresh(id);
			PNS_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "ucret", true))
		{
			new amount;
			if (sscanf(string_two, "d", amount)) return SendUsageMessage(playerid, "/pns duzenle [pns ID] ucret [miktar]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu PNS'nin ücretini %i olarak güncelledin.", amount);
			PNSData[id][PnsPrice] = amount;
			PNS_Refresh(id);
			PNS_Save(id);
			return 1;
		}
	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/pns sil [pns ID]");
		if (!Iter_Contains(Sprays, id)) return SendErrorMessage(playerid, "Hatalý PNS ID girdin.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý PNS'yi sildin.", id);
		PNS_Delete(id);
		return 1;
 	}
 	return 1;
}

Actor_Create(playerid, name[])
{
	new id = Iter_Free(Actors);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek aktör sýnýrýna ulaþýlmýþ.");

	format(ActorData[id][ActorName], 45, name);
    GetPlayerPos(playerid, ActorData[id][ActorPos][0], ActorData[id][ActorPos][1], ActorData[id][ActorPos][2]);
    GetPlayerFacingAngle(playerid, ActorData[id][ActorPos][3]);
    ActorData[id][ActorInterior] = GetPlayerInterior(playerid);
	ActorData[id][ActorWorld] = GetPlayerVirtualWorld(playerid);
	Iter_Add(Actors, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý aktörü ekledin. (ayarlamayý unutmayýn)", id);
	mysql_tquery(m_Handle, "INSERT INTO actors (ActorWorld) VALUES(0)", "OnActorCreated", "d", id);
	Actor_Refresh(id);
	return 1;
}

Server:OnActorCreated(id)
{
	ActorData[id][ActorID] = cache_insert_id();
	Actor_Save(id);
	return 1;
}

Actor_Save(id)
{
	new
	    query[290];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE actors SET ActorName = '%e', ActorSkin = %i, ActorX = %f, ActorY = %f, ActorZ = %f, ActorA = %f, ActorInterior = %i, ActorWorld = %i WHERE id = %i",
        ActorData[id][ActorName],
        ActorData[id][ActorModel],
		ActorData[id][ActorPos][0],
	    ActorData[id][ActorPos][1],
	    ActorData[id][ActorPos][2],
	    ActorData[id][ActorPos][3],
	    ActorData[id][ActorInterior],
	    ActorData[id][ActorWorld],
	    ActorData[id][ActorID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

Actor_Delete(id)
{
	new
		query[64];

	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM actors WHERE id = %i", ActorData[id][ActorID]);
	mysql_tquery(m_Handle, query);

    if(IsValidDynamic3DTextLabel(ActorData[id][ActorLabel])) DestroyDynamic3DTextLabel(ActorData[id][ActorLabel]);
	if(IsValidDynamicActor(ActorData[id][ActorObject])) DestroyDynamicActor(ActorData[id][ActorObject]);
	Iter_Remove(Actors, id);
	return 1;
}

Actor_Refresh(id)
{
    if(IsValidDynamic3DTextLabel(ActorData[id][ActorLabel])) DestroyDynamic3DTextLabel(ActorData[id][ActorLabel]);
	if(IsValidDynamicActor(ActorData[id][ActorObject])) DestroyDynamicActor(ActorData[id][ActorObject]);
	
	ActorData[id][ActorObject] = CreateDynamicActor(ActorData[id][ActorModel], ActorData[id][ActorPos][0], ActorData[id][ActorPos][1], ActorData[id][ActorPos][2], ActorData[id][ActorPos][3], 1, 100.0, ActorData[id][ActorWorld], ActorData[id][ActorInterior]);
    ActorData[id][ActorLabel] = CreateDynamic3DTextLabel(ActorData[id][ActorName], COLOR_WHITE, ActorData[id][ActorPos][0], ActorData[id][ActorPos][1], ActorData[id][ActorPos][2]+1.0, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1, ActorData[id][ActorWorld], ActorData[id][ActorInterior]);
	return 1;
}

CMD:aktor(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];

	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/aktor [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
		if (isnull(string) || strlen(string) > 32) return SendUsageMessage(playerid, "/aktor ekle [aktör adý]");
		Actor_Create(playerid, string);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/aktor git [aktör ID]");
		if (!Iter_Contains(Actors, id)) return SendErrorMessage(playerid, "Hatalý aktör ID girdin.");
		SendPlayer(playerid, ActorData[id][ActorPos][0], ActorData[id][ActorPos][1], ActorData[id][ActorPos][2], ActorData[id][ActorPos][3], 0, ActorData[id][ActorWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý aktöre ýþýnlandýn.", id);
		return 1;
 	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];

		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/aktor duzenle [aktör ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[pozisyon][kiyafet][ad]");
			return 1;
		}

		if (!Iter_Contains(Actors, id)) return SendErrorMessage(playerid, "Hatalý aktör ID girdin.");

		if (!strcmp(type_two, "pozisyon", true))
		{
			GetPlayerPos(playerid, ActorData[id][ActorPos][0], ActorData[id][ActorPos][1], ActorData[id][ActorPos][2]);
			GetPlayerFacingAngle(playerid, ActorData[id][ActorPos][3]);
			ActorData[id][ActorInterior] = GetPlayerInterior(playerid);
			ActorData[id][ActorWorld] = GetPlayerVirtualWorld(playerid);
            SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu aktörün giriþ kýsmýný güncelledin.");
			Actor_Refresh(id);
			Actor_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "ad", true))
		{
			new name[45];
			if (sscanf(string_two, "s[45]", name)) return SendUsageMessage(playerid, "/aktor duzenle [aktör ID] ad [aktör adý]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu aktörün adýný %s olarak güncelledin.", name);
			format(ActorData[id][ActorName], 45, name);
			Actor_Refresh(id);
			Actor_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "kiyafet", true))
		{
			new skin;
			if (sscanf(string_two, "d", skin)) return SendUsageMessage(playerid, "/aktor duzenle [aktör ID] kiyafet [skin ID]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu aktörün kýyafetini %i olarak güncelledin.", skin);
			ActorData[id][ActorModel] = skin;
			Actor_Refresh(id);
			Actor_Save(id);
			return 1;
		}
	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/aktor sil [aktör ID]");
		if (!Iter_Contains(Actors, id)) return SendErrorMessage(playerid, "Hatalý aktör ID girdin.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý aktörü sildin.", id);
		Actor_Delete(id);
		return 1;
 	}
 	return 1;
}

CMD:atm(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];

	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/atm [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
		ATM_Create(playerid);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/atm git [atm ID]");
		if (!Iter_Contains(ATMs, id)) return SendErrorMessage(playerid, "Hatalý atm ID girdin.");
		SendPlayer(playerid, ATMData[id][AtmPos][0], ATMData[id][AtmPos][1], ATMData[id][AtmPos][2], ATMData[id][AtmPos][3], ATMData[id][AtmInterior], ATMData[id][AtmWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý ATM noktasýna ýþýnlandýn.", id);
		return 1;
 	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/atm duzenle [atm ID]");
		if (!Iter_Contains(ATMs, id)) return SendErrorMessage(playerid, "Hatalý atm ID girdin.");
		if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

		EditingID[playerid] = id;
		EditingObject[playerid] = 9;
		EditDynamicObject(playerid, ATMData[id][AtmObject]);
		return 1;
	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/atm sil [atm ID]");
		if (!Iter_Contains(ATMs, id)) return SendErrorMessage(playerid, "Hatalý atm ID girdin.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý ATM noktasýný sildin.", id);
		ATM_Delete(id);
		return 1;
 	}
 	return 1;
}

ATM_Delete(id)
{
    new
        query[64];

	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM atms WHERE id = %i", ATMData[id][AtmID]);
	mysql_tquery(m_Handle, query);

    if (IsValidDynamicObject(ATMData[id][AtmObject])) DestroyDynamicObject(ATMData[id][AtmObject]);
    if (IsValidDynamicArea(ATMData[id][AtmAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, ATMData[id][AtmAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(ATMData[id][AtmAreaID]);
	}

    Iter_Remove(ATMs, id);
	return 1;
}

ATM_Nearest(playerid)
{
	return GetPVarInt(playerid, "AtATM");
}

ATM_Create(playerid)
{
	new id = Iter_Free(ATMs);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek ATM sýnýrýna ulaþýlmýþ.");

    static
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

	GetPlayerPos(playerid, x, y, z);
 	GetPlayerFacingAngle(playerid, angle);
 	
    x += 1.0 * floatsin(-angle, degrees);
	y += 1.0 * floatcos(-angle, degrees);

    ATMData[id][AtmPos][0] = x;
    ATMData[id][AtmPos][1] = y;
    ATMData[id][AtmPos][2] = z;
    
    ATMData[id][AtmPos][3] = 0.0;
    ATMData[id][AtmPos][4] = 0.0;
    ATMData[id][AtmPos][5] = angle;

    ATMData[id][AtmInterior] = GetPlayerInterior(playerid);
    ATMData[id][AtmWorld] = GetPlayerVirtualWorld(playerid);
    Iter_Add(ATMs, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý ATM noktasýný ekledin.", id);
	mysql_tquery(m_Handle, "INSERT INTO atms (AtmInterior) VALUES(0)", "OnATMCreated", "d", id);
	ATM_Refresh(id);
	return 1;
}

ATM_Refresh(id)
{
    if (IsValidDynamicObject(ATMData[id][AtmObject])) DestroyDynamicObject(ATMData[id][AtmObject]);
	if (IsValidDynamicArea(ATMData[id][AtmAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, ATMData[id][AtmAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(ATMData[id][AtmAreaID]);
	}

	ATMData[id][AtmObject] = CreateDynamicObject(-21027, ATMData[id][AtmPos][0], ATMData[id][AtmPos][1], ATMData[id][AtmPos][2], ATMData[id][AtmPos][3], ATMData[id][AtmPos][4], ATMData[id][AtmPos][5], ATMData[id][AtmWorld], ATMData[id][AtmInterior]);
	
	new array[2]; array[0] = 18; array[1] = id;
	ATMData[id][AtmAreaID] = CreateDynamicSphere(ATMData[id][AtmPos][0], ATMData[id][AtmPos][1], ATMData[id][AtmPos][2], 2.0, ATMData[id][AtmWorld], ATMData[id][AtmInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, ATMData[id][AtmAreaID], E_STREAMER_EXTRA_ID, array, 2);
	return 1;
}

ATM_Save(id)
{
	new
	    query[355];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE atms SET AtmX = %f, AtmY = %f, AtmZ = %f, AtmRX = %f, AtmRY = %f, AtmRZ = %f, AtmInterior = %i, AtmWorld = %i WHERE id = %i",
		ATMData[id][AtmPos][0],
	    ATMData[id][AtmPos][1],
	    ATMData[id][AtmPos][2],
	    ATMData[id][AtmPos][3],
	    ATMData[id][AtmPos][4],
	    ATMData[id][AtmPos][5],
	    ATMData[id][AtmInterior],
	    ATMData[id][AtmWorld],
	    ATMData[id][AtmID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

Server:OnATMCreated(id)
{
	ATMData[id][AtmID] = cache_insert_id();
 	ATM_Save(id);
	return 1;
}

Teleport_List(playerid, page = 0)
{
	SetPVarInt(playerid, "teleport_idx", page);

    new query[82];
	mysql_format(m_Handle, query, sizeof(query), "SELECT id, TeleportName FROM teleports LIMIT %d, 25", page*MAX_CLOTHING_SHOW);
	mysql_tquery(m_Handle, query, "SQL_TeleportList", "ii", playerid, page);
	return 1;
}

Server:SQL_TeleportList(playerid, page)
{
	if(!IsPlayerConnected(playerid)) {
        return 0;
    }

    new rows = cache_num_rows();   
    if(!rows) {
        return SendClientMessage(playerid, COLOR_ADM, "SERVER: Hiç ýþýnlanma noktasý eklenmemiþ.");
    }

	new primary_str[1024], id, teleport_name[30];

	for(new i; i < rows; ++i)
	{
		cache_get_value_name_int(i, "id", id);
        cache_get_value_name(i, "TeleportName", teleport_name, sizeof(teleport_name));
		format(primary_str, sizeof(primary_str), "%s[%i] {AFAFAF}%s\n", primary_str, id, teleport_name);
	}

	if(page != 0) strcat(primary_str, "{FFFF00}Önceki Sayfa <<\n");
	if(rows >= MAX_CLOTHING_SHOW) strcat(primary_str, "{FFFF00}Sonraki Sayfa >>");

	Dialog_Show(playerid, TELEPORT_LIST, DIALOG_STYLE_LIST, "Iþýnlanma Listesi", primary_str, "Iþýnlan", "<< Kapat");
	return 1;
}

Dialog:TELEPORT_LIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new page = GetPVarInt(playerid, "teleport_idx");
		if(!strcmp(inputtext, "Önceki Sayfa <<")) return Teleport_List(playerid, page-1);
		if(!strcmp(inputtext, "Sonraki Sayfa >>")) return Teleport_List(playerid, page+1);
		
		new id;
        sscanf(inputtext[0], "P<[]>{s[2]}i", id);
		SendPlayer(playerid, floatstr(Teleport_GetPosition(id, "TeleportX")), floatstr(Teleport_GetPosition(id, "TeleportY")), floatstr(Teleport_GetPosition(id, "TeleportZ")), floatstr(Teleport_GetPosition(id, "TeleportA")), Teleport_GetInt(id, "TeleportInterior"), Teleport_GetInt(id, "TeleportWorld"));
		SendClientMessageEx(playerid, COLOR_GREY, "SERVER: %s isimli noktaya ýþýnlandýn.", Teleport_GetName(id));
		ResetHouseVar(playerid);
	}
    return 1;
}

Teleport_GetInt(id, where[])
{
	new query[75], int;
	mysql_format(m_Handle, query, sizeof(query), "SELECT %s FROM teleports WHERE id = %i LIMIT 1", where, id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name_int(0, where, int);
	cache_delete(cache);
	return int;
}

Teleport_GetPosition(id, where[])
{
	new query[75], Float: pos;
	mysql_format(m_Handle, query, sizeof(query), "SELECT %s FROM teleports WHERE id = %i LIMIT 1", where, id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name_float(0, where, pos);
	format(query, sizeof(query), "%f", pos);
	cache_delete(cache);
	return query;
}

Teleport_GetName(id)
{
	new query[75], teleport_name[30];
	mysql_format(m_Handle, query, sizeof(query), "SELECT TeleportName FROM teleports WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name(0, "TeleportName", teleport_name);
	cache_delete(cache);
	return teleport_name;
}

Teleport_Exists(id)
{
	new query[50], sonuc = 0;
	mysql_format(m_Handle, query, sizeof(query), "SELECT id FROM teleports WHERE id = %i", id);
	new Cache:cache = mysql_query(m_Handle, query);
	if(cache_num_rows()) sonuc = 1;
	cache_delete(cache);
	return sonuc;
}

CMD:teleport(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/teleport [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git, liste");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
		if(isnull(string) || strlen(string) > 30) return SendUsageMessage(playerid, "/teleport ekle [teleport adý]");
		
		new
		    Float: x,
		    Float: y,
		    Float: z,
		    Float: a;

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);

		new query[256];
		mysql_format(m_Handle, query, sizeof(query), "INSERT INTO teleports (TeleportName, TeleportX, TeleportY, TeleportZ, TeleportA, TeleportInterior, TeleportWorld) VALUES('%e', %f, %f, %f, %f, %i, %i)", string, x, y, z, a, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
        new Cache: cache = mysql_query(m_Handle, query);
        SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý ýþýnlanma noktasý baþarýyla eklendi.", cache_insert_id());
        cache_delete(cache);
		return 1;
	}
	else if (!strcmp(type, "liste", true))
	{
		Teleport_List(playerid);
		return 1;
	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if(sscanf(string, "i", id)) return SendUsageMessage(playerid, "/teleport sil [tp ID]");
		if(!Teleport_Exists(id)) return SendErrorMessage(playerid, "Hatalý tp ID girdin.");

		new query[64];
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý ýþýnlanma noktasýný sildin.", id);
		mysql_format(m_Handle, query, sizeof(query), "DELETE FROM teleports WHERE id = %i", id);
		mysql_tquery(m_Handle, query);
		return 1;
 	}
 	return 1;
}

CMD:akapi(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/akapi [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
		if (isnull(string) || strlen(string) > 35) return SendUsageMessage(playerid, "/akapi ekle [kapý adý]");
		Door_Create(playerid, string);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/akapi git [kapý ID]");
		if (!Iter_Contains(Doors, id)) return SendErrorMessage(playerid, "Hatalý kapý ID girdin.");
		SendPlayer(playerid, DoorData[id][EnterPos][0], DoorData[id][EnterPos][1], DoorData[id][EnterPos][2], DoorData[id][EnterPos][3], DoorData[id][EnterInterior], DoorData[id][EnterWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý kapýya ýþýnlandýn.", id);
		return 1;
 	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];
		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/akapi duzenle [kapý ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[giris][cikis][birlik][kilit][ad]");
			return 1;
		}

		if (!Iter_Contains(Doors, id)) return SendErrorMessage(playerid, "Hatalý kapý ID girdin.");

		if (!strcmp(type_two, "giris", true))
		{
			GetPlayerPos(playerid, DoorData[id][EnterPos][0], DoorData[id][EnterPos][1], DoorData[id][EnterPos][2]);
			GetPlayerFacingAngle(playerid, DoorData[id][EnterPos][3]);

		    DoorData[id][EnterInterior] = GetPlayerInterior(playerid);
	    	DoorData[id][EnterWorld] = GetPlayerVirtualWorld(playerid);

            SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu kapýnýn dýþ pozisyonunu güncelledin.");
            Door_Refresh(id);
			Door_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "cikis", true))
		{
			GetPlayerPos(playerid, DoorData[id][ExitPos][0], DoorData[id][ExitPos][1], DoorData[id][ExitPos][2]);
			GetPlayerFacingAngle(playerid, DoorData[id][ExitPos][3]);

		    DoorData[id][ExitInterior] = GetPlayerInterior(playerid);
	    	DoorData[id][ExitWorld] = GetPlayerVirtualWorld(playerid);

            SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu kapýnýn iç pozisyonunu güncelledin.");
            Door_Refresh(id);
			Door_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "birlik", true))
		{
			new faction;
			if (sscanf(string_two, "d", faction)) return SendUsageMessage(playerid, "/akapi duzenle [kapý ID] birlik [birlik ID]");
			if (!Iter_Contains(Factions, faction)) return SendErrorMessage(playerid, "Hatalý birlik ID girdin.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu kapýnýn sahibini %i birliði olarak güncelledin.", faction);
			DoorData[id][DoorFaction] = faction;
			Door_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "kilit", true))
		{
			new locked;
			if (sscanf(string_two, "d", locked)) return SendUsageMessage(playerid, "/akapi duzenle [kapi ID] kilit [0/1]");
			if (locked < 0 || locked > 1)	return SendErrorMessage(playerid, "Hatalý kilit durumu girdin. (0/1)");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu kapýnýn kilidini %s olarak güncelledin.", !locked ? ("kilitli deðil") : ("kilitli"));
			DoorData[id][DoorLocked] = bool:locked;
			Door_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "ad", true))
		{
			new name[35];
			if (sscanf(string_two, "s[35]", name)) return SendUsageMessage(playerid, "/kapi duzenle [kapý ID] ad [kapý adý]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu kapýnýn adýný %s olarak güncelledin.", name);
			format(DoorData[id][DoorName], 35, name);
			Door_Save(id);
			return 1;
		}
	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/akapi sil [kapý ID]");
		if (!Iter_Contains(Doors, id)) return SendErrorMessage(playerid, "Hatalý kapý ID girdin.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý kapýyý sildin.", id);
		Door_Delete(id);
		return 1;
 	}
 	return 1;
}

Door_Create(playerid, doorname[])
{
	new id = Iter_Free(Doors);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek kapý sýnýrýna ulaþýlmýþ.");

    static
	    Float: x,
	    Float: y,
	    Float: z,
	    Float: angle;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

    DoorData[id][DoorFaction] = 0;
    DoorData[id][DoorLocked] = true;
    format(DoorData[id][DoorName], 35, "%s", doorname);

	DoorData[id][EnterPos][0] = x;
	DoorData[id][EnterPos][1] = y;
	DoorData[id][EnterPos][2] = z;
	DoorData[id][EnterPos][3] = angle;

	DoorData[id][EnterInterior] = GetPlayerInterior(playerid);
	DoorData[id][EnterWorld] = GetPlayerVirtualWorld(playerid);

	DoorData[id][ExitPos][0] = x;
	DoorData[id][ExitPos][1] = y;
	DoorData[id][ExitPos][2] = z + 10000;
	DoorData[id][ExitPos][3] = 0.0000;

	DoorData[id][ExitInterior] = 99;
	DoorData[id][ExitWorld] = 99;
	Iter_Add(Doors, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý kapýyý noktasýný ekledin. (kilidi açýp, düzenlemeyi unutma)", id);
	mysql_tquery(m_Handle, "INSERT INTO doors (DoorLocked) VALUES(1)", "OnDoorCreated", "d", id);
	Door_Refresh(id);
	return 1;
}

Server:OnDoorCreated(id)
{
	DoorData[id][DoorID] = cache_insert_id();
	Door_Save(id);
	return 1;
}

Door_Save(id)
{
	new
		query[355];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE doors SET DoorName = '%e', PosX = %f, PosY = %f, PosZ = %f, PosA = %f, PosInterior = %i, PosWorld = %i WHERE id = %i",
        DoorData[id][DoorName],
		DoorData[id][EnterPos][0],
        DoorData[id][EnterPos][1],
        DoorData[id][EnterPos][2],
     	DoorData[id][EnterPos][3],
        DoorData[id][EnterInterior],
        DoorData[id][EnterWorld],
        DoorData[id][DoorID]
	);
	mysql_tquery(m_Handle, query);
	
	mysql_format(m_Handle, query, sizeof(query), "UPDATE doors SET IntX = %f, IntY = %f, IntZ = %f, IntA = %f, IntInterior = %i, IntWorld = %i, DoorFaction = %i, DoorLocked = %i WHERE id = %i",
		DoorData[id][ExitPos][0],
        DoorData[id][ExitPos][1],
        DoorData[id][ExitPos][2],
     	DoorData[id][ExitPos][3],
        DoorData[id][ExitInterior],
        DoorData[id][ExitWorld],
		DoorData[id][DoorFaction],
		DoorData[id][DoorLocked],
        DoorData[id][DoorID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

Door_Delete(id)
{
    new
        query[64];

	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM doors WHERE id = %i", DoorData[id][DoorID]);
	mysql_tquery(m_Handle, query);

	if (IsValidDynamicArea(DoorData[id][DoorAreaID][0])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, DoorData[id][DoorAreaID][0], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(DoorData[id][DoorAreaID][0]);
	}

	if (IsValidDynamicArea(DoorData[id][DoorAreaID][1])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, DoorData[id][DoorAreaID][1], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(DoorData[id][DoorAreaID][1]);
	}

    Iter_Remove(Doors, id);
	return 1;
}

Door_Refresh(id)
{
	if (IsValidDynamicArea(DoorData[id][DoorAreaID][0])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, DoorData[id][DoorAreaID][0], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(DoorData[id][DoorAreaID][0]);
	}

	if (IsValidDynamicArea(DoorData[id][DoorAreaID][1])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, DoorData[id][DoorAreaID][1], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(DoorData[id][DoorAreaID][1]);
	}

	new array[2]; array[0] = 5; array[1] = id;
	DoorData[id][DoorAreaID][0] = CreateDynamicSphere(DoorData[id][EnterPos][0], DoorData[id][EnterPos][1], DoorData[id][EnterPos][2], 3.0, DoorData[id][EnterWorld], DoorData[id][EnterInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, DoorData[id][DoorAreaID][0], E_STREAMER_EXTRA_ID, array, 2);

	array[0] = 6; array[1] = id;
	DoorData[id][DoorAreaID][1] = CreateDynamicSphere(DoorData[id][ExitPos][0], DoorData[id][ExitPos][1], DoorData[id][ExitPos][2], 3.0, DoorData[id][ExitWorld], DoorData[id][ExitInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, DoorData[id][DoorAreaID][1], E_STREAMER_EXTRA_ID, array, 2);
	return 1;
}

CMD:agate(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/agate [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/agate ekle [obje ID]");
		Gate_Create(playerid, id);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/agate git [gate ID]");
		if (!Iter_Contains(Gates, id)) return SendErrorMessage(playerid, "Hatalý gate ID girdin.");
		SendPlayer(playerid, GateData[id][GatePos][0], GateData[id][GatePos][1], GateData[id][GatePos][2], GateData[id][GatePos][3], GateData[id][GateInterior], GateData[id][GateWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý hareketli kapýya ýþýnlandýn.", id);
		return 1;
 	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];
		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/agate duzenle [gate ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[pozisyon][apozisyon][hiz][alan][sure][model][link][birlik][texture]");
			return 1;
		}

		if (!Iter_Contains(Gates, id)) return SendErrorMessage(playerid, "Hatalý gate ID girdin.");

		if (!strcmp(type_two, "pozisyon", true))
		{
			if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");
		
			EditingID[playerid] = id;
			EditingObject[playerid] = 1;
			EditDynamicObject(playerid, GateData[id][GateObject]);
			return 1;
		}
		else if (!strcmp(type_two, "apozisyon", true))
		{
			if(GateData[id][GateStatus]) return SendErrorMessage(playerid, "Düzenlemek istediðin kapýyý ilk önce kapat.");
			if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

			EditingID[playerid] = id;
			EditingObject[playerid] = 2;
			EditDynamicObject(playerid, GateData[id][GateObject]);
			return 1;
		}
		else if (!strcmp(type_two, "alan", true))
		{
			new Float: alan;
			if (sscanf(string_two, "f", alan)) return SendUsageMessage(playerid, "/agate duzenle [gate ID] alan [miktar(0-20)]");
			if (alan < 0.0 || alan > 20.0) return SendErrorMessage(playerid, "Bu hareketli kapýnýn alaný 0 - 20 deðerlerini alabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu hareketli kapýnýn hýzýný %f olarak güncelledin.", alan);
			GateData[id][GateRadius] = alan;
			Gate_Refresh(id);
			Gate_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "hiz", true))
		{
			new Float: speed;
			if (sscanf(string_two, "f", speed)) return SendUsageMessage(playerid, "/agate duzenle [gate ID] hiz [miktar(0-20)]");
			if (speed < 0.0 || speed > 20.0) return SendErrorMessage(playerid, "Bu hareketli kapýnýn hýzý 0 - 20 deðerlerini alabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu hareketli kapýnýn hýzýný %f olarak güncelledin.", speed);
			GateData[id][GateSpeed] = speed;
			Gate_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "sure", true))
		{
			new sure;
			if (sscanf(string_two, "d", sure)) return SendUsageMessage(playerid, "/agate duzenle [gate ID] sure [miktar(0-60000ms)]");
			if (sure < 0 || sure > 60000) return SendErrorMessage(playerid, "Bu hareketli kapýnýn hýzý 0 - 60000 milisaniye deðerlerini alabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu hareketli kapýnýn kapanma süresini %i olarak güncelledin. (0 girildiyse otomatik kapanmaz)", sure);
			GateData[id][GateTime] = sure;
			Gate_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "model", true))
		{
			new model;
			if (sscanf(string_two, "d", model)) return SendUsageMessage(playerid, "/agate duzenle [gate ID] model [obje ID]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu hareketli kapýnýn modelini %i olarak güncelledin.", model);
			GateData[id][GateModel] = model;
			Gate_Refresh(id);
			Gate_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "link", true))
		{
			static linkid = -1;
			if(sscanf(string_two, "i", linkid)) return SendUsageMessage(playerid, "/agate duzenle [gate ID] link [gate ID]");
			if(!Iter_Contains(Gates, linkid)) return SendErrorMessage(playerid, "Hatalý gate ID girdin.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu hareketli kapýyý %i numaralý hareketli kapýya baðladýn.", linkid);
			GateData[id][GateLinkID] = (linkid == -1) ? (-1) : (GateData[linkid][GateID]);
			Gate_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "texture", true))
		{
			new tindex, tmodel, txdname[33], texturename[33];
			if (sscanf(string_two, "dds[33]s[33]", tindex, tmodel, txdname, texturename)) return SendUsageMessage(playerid, "/agate duzenle [gate ID] texture [tindex] [tmodel] [txdname] [txtname]");
			SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu hareketli kapýnýn texture güncelledin.");
			GateData[id][GateTIndex] = tindex;
			GateData[id][GateTModel] = tmodel;
			format(GateData[id][GateTXDName], 33, "%s", txdname);
			format(GateData[id][GateTextureName], 33, "%s", texturename);
			Gate_Refresh(id);
			Gate_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "birlik", true))
		{
			new faction;
			if (sscanf(string_two, "d", faction)) return SendUsageMessage(playerid, "/agate duzenle [gate ID] birlik [birlik ID]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu hareketli kapýnýn sahibi %i birliði olarak güncelledin.", faction);
			GateData[id][GateFaction] = faction;
			Gate_Save(id);
			return 1;
		}
	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/agate sil [gate ID]");
		if (!Iter_Contains(Gates, id)) return SendErrorMessage(playerid, "Hatalý gate ID girdin.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý hareketli kapýyý sildin.", id);
		Gate_Delete(id);
		return 1;
 	}
 	return 1;
}

Gate_Create(playerid, model)
{
	new id = Iter_Free(Gates);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek hareketli kapý sýnýrýna ulaþýlmýþ.");

	static
		Float:x,
		Float:y,
		Float:z,
		Float:angle;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);
	
	GateData[id][GateModel] = model;
	GateData[id][GateSpeed] = 3.0;
	GateData[id][GateRadius] = 5.0;
	GateData[id][GateStatus] = false;
	GateData[id][GateTime] = 0;

	GateData[id][GatePos][0] = x + (3.0 * floatsin(-angle, degrees));
	GateData[id][GatePos][1] = y + (3.0 * floatcos(-angle, degrees));
	GateData[id][GatePos][2] = z;
	GateData[id][GatePos][3] = 0.0;
	GateData[id][GatePos][4] = 0.0;
	GateData[id][GatePos][5] = angle;

	GateData[id][GateMovePos][0] = x + (3.0 * floatsin(-angle, degrees));
	GateData[id][GateMovePos][1] = y + (3.0 * floatcos(-angle, degrees));
	GateData[id][GateMovePos][2] = z - 10.0;
	GateData[id][GateMovePos][3] = -1000.0;
	GateData[id][GateMovePos][4] = -1000.0;
	GateData[id][GateMovePos][5] = -1000.0;

	GateData[id][GateInterior] = GetPlayerInterior(playerid);
	GateData[id][GateWorld] = GetPlayerVirtualWorld(playerid);

	GateData[id][GateTIndex] = 0;
	GateData[id][GateTModel] = 0;
	
	GateData[id][GateLinkID] = -1;
	GateData[id][GateFaction] = -1;
	Iter_Add(Gates, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý hareketli kapýyý ekledin. (düzenlemeyi unutma)", id);
	mysql_tquery(m_Handle, "INSERT INTO gates (GateSpeed) VALUES(3.0)", "OnGateCreated", "d", id);
	Gate_Refresh(id);
	return 1;
}

Server:OnGateCreated(id)
{
	GateData[id][GateID] = cache_insert_id();
	Gate_Save(id);
	return 1;
}

Gate_Refresh(id)
{
    if (IsValidDynamicObject(GateData[id][GateObject])) DestroyDynamicObject(GateData[id][GateObject]);

	if (IsValidDynamicArea(GateData[id][GateAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, GateData[id][GateAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(GateData[id][GateAreaID]);
	}
	
	GateData[id][GateObject] = CreateDynamicObject(GateData[id][GateModel], GateData[id][GatePos][0], GateData[id][GatePos][1], GateData[id][GatePos][2], GateData[id][GatePos][3], GateData[id][GatePos][4], GateData[id][GatePos][5], GateData[id][GateWorld], GateData[id][GateInterior]);
	if (GateData[id][GateTModel] != 0) SetDynamicObjectMaterial(GateData[id][GateObject], GateData[id][GateTIndex], GateData[id][GateTModel], GateData[id][GateTXDName], GateData[id][GateTextureName], 0);

	new array[2]; array[0] = 11; array[1] = id;
	GateData[id][GateAreaID] = CreateDynamicSphere(GateData[id][GatePos][0], GateData[id][GatePos][1], GateData[id][GatePos][2], GateData[id][GateRadius], GateData[id][GateWorld], GateData[id][GateInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, GateData[id][GateAreaID], E_STREAMER_EXTRA_ID, array, 2);
	return 1;
}

Gate_Delete(id)
{
    new
        query[64];

	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM gates WHERE id = %i", GateData[id][GateID]);
	mysql_tquery(m_Handle, query);

    if (IsValidDynamicObject(GateData[id][GateObject])) DestroyDynamicObject(GateData[id][GateObject]);

	if (IsValidDynamicArea(GateData[id][GateAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, GateData[id][GateAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(GateData[id][GateAreaID]);
	}

    Iter_Remove(Gates, id);
	return 1;
}

Gate_Save(id)
{
	new
		query[355];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE gates SET GateModel = %i, GateSpeed = %f, GateRadius = %f, GateTime = %i, GateInterior = %i, GateWorld = %i WHERE id = %i",
		GateData[id][GateModel],
        GateData[id][GateSpeed],
        GateData[id][GateRadius],
     	GateData[id][GateTime],
     	GateData[id][GateInterior],
	 	GateData[id][GateWorld],
        GateData[id][GateID]
	);
	mysql_tquery(m_Handle, query);
	
	mysql_format(m_Handle, query, sizeof(query), "UPDATE gates SET PosX = %f, PosY = %f, PosZ = %f, RotX = %f, RotY = %f, RotZ = %f, GateFaction = %i, GateLinkID = %i WHERE id = %i",
		GateData[id][GatePos][0],
		GateData[id][GatePos][1],
		GateData[id][GatePos][2],
		GateData[id][GatePos][3],
		GateData[id][GatePos][4],
		GateData[id][GatePos][5],
		GateData[id][GateFaction],
		GateData[id][GateLinkID],
        GateData[id][GateID]
	);
	mysql_tquery(m_Handle, query);
	
	mysql_format(m_Handle, query, sizeof(query), "UPDATE gates SET OpenX = %f, OpenY = %f, OpenZ = %f, OpenRotX = %f, OpenRotY = %f, OpenRotZ = %f, TIndex = %i, TModel = %i WHERE id = %i",
		GateData[id][GateMovePos][0],
		GateData[id][GateMovePos][1],
		GateData[id][GateMovePos][2],
		GateData[id][GateMovePos][3],
		GateData[id][GateMovePos][4],
		GateData[id][GateMovePos][5],
		GateData[id][GateTIndex],
		GateData[id][GateTModel],
        GateData[id][GateID]
	);
	mysql_tquery(m_Handle, query);
	
	mysql_format(m_Handle, query, sizeof(query), "UPDATE gates SET TXDName = '%e', TextureName = '%e' WHERE id = %i",
		GateData[id][GateTXDName],
		GateData[id][GateTextureName],
        GateData[id][GateID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

GetGateByID(sqlid)
{
	foreach(new i : Gates) if (GateData[i][GateID] == sqlid)
		return i;

	return -1;
}

Server:CloseGate(id, linkid, Float:fX, Float:fY, Float:fZ, Float:speed, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	MoveDynamicObject(GateData[id][GateObject], fX, fY, fZ, speed, fRotX, fRotY, fRotZ);

	new tmp_id = -1;
	if ((tmp_id = GetGateByID(linkid)) != -1)
		MoveDynamicObject(GateData[tmp_id][GateObject], GateData[tmp_id][GatePos][0], GateData[tmp_id][GatePos][1], GateData[tmp_id][GatePos][2], speed, GateData[tmp_id][GatePos][3], GateData[tmp_id][GatePos][4], GateData[tmp_id][GatePos][5]), GateData[tmp_id][GateStatus] = false;

	GateData[id][GateStatus] = false;
	return 1;
}

Gate_Operate(id)
{
	if (Iter_Contains(Gates, id))
	{
		new tmp_id = -1;

		if (!GateData[id][GateStatus])
		{
			GateData[id][GateStatus] = true;
			MoveDynamicObject(GateData[id][GateObject], GateData[id][GateMovePos][0], GateData[id][GateMovePos][1], GateData[id][GateMovePos][2], GateData[id][GateSpeed], GateData[id][GateMovePos][3], GateData[id][GateMovePos][4], GateData[id][GateMovePos][5]);

			if (GateData[id][GateTime] > 0) {
				GateData[id][GateTimer] = SetTimerEx("CloseGate", GateData[id][GateTime], false, "ddfffffff", id, GateData[id][GateLinkID], GateData[id][GatePos][0], GateData[id][GatePos][1], GateData[id][GatePos][2], GateData[id][GateSpeed], GateData[id][GatePos][3], GateData[id][GatePos][4], GateData[id][GatePos][5]);
			}

			if (GateData[id][GateLinkID] != -1 && (tmp_id = GetGateByID(GateData[id][GateLinkID])) != -1)
			{
				GateData[tmp_id][GateStatus] = true;
				MoveDynamicObject(GateData[tmp_id][GateObject], GateData[tmp_id][GateMovePos][0], GateData[tmp_id][GateMovePos][1], GateData[tmp_id][GateMovePos][2], GateData[tmp_id][GateSpeed], GateData[tmp_id][GateMovePos][3], GateData[tmp_id][GateMovePos][4], GateData[tmp_id][GateMovePos][5]);
			}
		}
		else if (GateData[id][GateStatus])
		{
			GateData[id][GateStatus] = false;
			MoveDynamicObject(GateData[id][GateObject], GateData[id][GatePos][0], GateData[id][GatePos][1], GateData[id][GatePos][2], GateData[id][GateSpeed], GateData[id][GatePos][3], GateData[id][GatePos][4], GateData[id][GatePos][5]);

			if (GateData[id][GateTime] > 0) {
				KillTimer(GateData[id][GateTimer]);
			}
			if (GateData[id][GateLinkID] != -1 && (tmp_id = GetGateByID(GateData[id][GateLinkID])) != -1)
			{
				GateData[tmp_id][GateStatus] = false;
				MoveDynamicObject(GateData[tmp_id][GateObject], GateData[tmp_id][GatePos][0], GateData[tmp_id][GatePos][1], GateData[tmp_id][GatePos][2], GateData[tmp_id][GateSpeed], GateData[tmp_id][GatePos][3], GateData[tmp_id][GatePos][4], GateData[tmp_id][GatePos][5]);
			}
		}
	}
	return 1;
}

CMD:obje(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];

	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/obje [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/obje ekle [obje ID]");
		Object_Create(playerid, id);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/obje git [atm ID]");
		if (!Iter_Contains(Objects, id)) return SendErrorMessage(playerid, "Hatalý obje ID girdin.");
		SendPlayer(playerid, ObjectData[id][ObjectPos][0], ObjectData[id][ObjectPos][1], ObjectData[id][ObjectPos][2], ObjectData[id][ObjectPos][3], ObjectData[id][ObjectInterior], ObjectData[id][ObjectWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý objeye ýþýnlandýn.", id);
		return 1;
 	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];
		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/obje duzenle [obje ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[pozisyon][model]");
			return 1;
		}

		if (!Iter_Contains(Objects, id)) return SendErrorMessage(playerid, "Hatalý obje ID girdin.");

		if (!strcmp(type_two, "pozisyon", true))
		{
			if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

			EditingID[playerid] = id;
			EditingObject[playerid] = 10;
			EditDynamicObject(playerid, ObjectData[id][ObjectHolder]);
			return 1;
		}
		else if (!strcmp(type_two, "model", true))
		{
			new mdl;
			if (sscanf(string_two, "d", mdl)) return SendUsageMessage(playerid, "/obje duzenle [obje ID] model [yeni obje ID]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu objenin modelini %i olarak güncelledin.", mdl);
			ObjectData[id][ObjectModel] = mdl;
			Object_Refresh(id);
			Object_Save(id);
			return 1;
		}
		return 1;
	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/obje sil [obje ID]");
		if (!Iter_Contains(Objects, id)) return SendErrorMessage(playerid, "Hatalý obje ID girdin.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý objeyi sildin.", id);
		Object_Delete(id);
		return 1;
 	}
 	return 1;
}

Object_Create(playerid, objectid)
{
	new id = Iter_Free(Objects);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek obje sýnýrýna ulaþýlmýþ.");

    static
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

	GetPlayerPos(playerid, x, y, z);
 	GetPlayerFacingAngle(playerid, angle);

    x += 1.0 * floatsin(-angle, degrees);
	y += 1.0 * floatcos(-angle, degrees);

    ObjectData[id][ObjectPos][0] = x;
    ObjectData[id][ObjectPos][1] = y;
    ObjectData[id][ObjectPos][2] = z;

    ObjectData[id][ObjectPos][3] = 0.0;
    ObjectData[id][ObjectPos][4] = 0.0;
    ObjectData[id][ObjectPos][5] = angle;
    
	ObjectData[id][ObjectModel] = objectid;
    ObjectData[id][ObjectInterior] = GetPlayerInterior(playerid);
    ObjectData[id][ObjectWorld] = GetPlayerVirtualWorld(playerid);
    Iter_Add(Objects, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý objeyi ekledin.", id);
	mysql_tquery(m_Handle, "INSERT INTO objects (ObjectInterior) VALUES(0)", "OnObjectCreated", "d", id);
	Object_Refresh(id);
	return 1;
}

Object_Nearest(playerid)
{
	return GetPVarInt(playerid, "AtObject");
}

Object_Refresh(id)
{
    if (IsValidDynamicObject(ObjectData[id][ObjectHolder])) DestroyDynamicObject(ObjectData[id][ObjectHolder]);
	if (IsValidDynamicArea(ObjectData[id][ObjectAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, ObjectData[id][ObjectAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(ObjectData[id][ObjectAreaID]);
	}

	ObjectData[id][ObjectHolder] = CreateDynamicObject(ObjectData[id][ObjectModel], ObjectData[id][ObjectPos][0], ObjectData[id][ObjectPos][1], ObjectData[id][ObjectPos][2], ObjectData[id][ObjectPos][3], ObjectData[id][ObjectPos][4], ObjectData[id][ObjectPos][5], ObjectData[id][ObjectWorld], ObjectData[id][ObjectInterior]);
	
	new array[2]; array[0] = 20; array[1] = id;
	ObjectData[id][ObjectAreaID] = CreateDynamicSphere(ObjectData[id][ObjectPos][0], ObjectData[id][ObjectPos][1], ObjectData[id][ObjectPos][2], 2.0, ObjectData[id][ObjectWorld], ObjectData[id][ObjectInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, ObjectData[id][ObjectAreaID], E_STREAMER_EXTRA_ID, array, 2);
	return 1;
}

Object_Save(id)
{
	new
	    query[355];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE objects SET ObjectModel = %i, ObjectX = %f, ObjectY = %f, ObjectZ = %f, ObjectRX = %f, ObjectRY = %f, ObjectRZ = %f, ObjectInterior = %i, ObjectWorld = %i WHERE id = %i",
        ObjectData[id][ObjectModel],
		ObjectData[id][ObjectPos][0],
	    ObjectData[id][ObjectPos][1],
	    ObjectData[id][ObjectPos][2],
	    ObjectData[id][ObjectPos][3],
	    ObjectData[id][ObjectPos][4],
	    ObjectData[id][ObjectPos][5],
	    ObjectData[id][ObjectInterior],
	    ObjectData[id][ObjectWorld],
	    ObjectData[id][ObjectID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

Server:OnObjectCreated(id)
{
	ObjectData[id][ObjectID] = cache_insert_id();
 	Object_Save(id);
	return 1;
}

Object_Delete(id)
{
    new
        query[64];

	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM objects WHERE id = %i", ObjectData[id][ObjectID]);
	mysql_tquery(m_Handle, query);

    if (IsValidDynamicObject(ObjectData[id][ObjectHolder])) DestroyDynamicObject(ObjectData[id][ObjectHolder]);
	if (IsValidDynamicArea(ObjectData[id][ObjectAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, ObjectData[id][ObjectAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(ObjectData[id][ObjectAreaID]);
	}

    Iter_Remove(Objects, id);
	return 1;
}

CMD:agraffiti(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/agraffiti [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
 		new list[128];
	    for(new i = 0; i < sizeof(g_spraytag); i ++)
	    {
	        format(list, sizeof(list), "%s%s\n", list, g_spraytag[i][tag_name]);
	    }
	    ShowPlayerDialog(playerid, DIALOG_SPRAY_CREATE, DIALOG_STYLE_LIST, "Graffiti Resimi:", list, "Seç", "<<");
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/agraffiti git [graffiti ID]");
		if (!Iter_Contains(Tags, id)) return SendErrorMessage(playerid, "Hatalý graffiti ID girdin.");
		SendPlayer(playerid, SprayData[id][SprayLocation][0], SprayData[id][SprayLocation][1], SprayData[id][SprayLocation][2], SprayData[id][SprayLocation][3], SprayData[id][SprayInterior], SprayData[id][SprayWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý graffitiye ýþýnlandýn.", id);
		return 1;
 	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/agraffiti duzenle [graffiti ID]");
		if (!Iter_Contains(Tags, id)) return SendErrorMessage(playerid, "Hatalý graffiti ID girdin.");
		if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

		EditingID[playerid] = id;
		EditingObject[playerid] = 11;
		EditDynamicObject(playerid, SprayData[id][SprayObject]);
		return 1;
 	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/agraffiti sil [graffiti ID]");
		if (!Iter_Contains(Tags, id)) return SendErrorMessage(playerid, "Hatalý graffiti ID girdin.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý graffitiyi sildin.", id);
		Spray_Delete(id);
		return 1;
 	}
 	return 1;
}

Spray_Create(playerid, listitem)
{
	new id = Iter_Free(Tags);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek graffiti noktasý sýnýrýna ulaþýlmýþ.");

    static
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

	GetPlayerPos(playerid, x, y, z);
 	GetPlayerFacingAngle(playerid, angle);

    x += 1.0 * floatsin(-angle, degrees);
	y += 1.0 * floatcos(-angle, degrees);

    SprayData[id][SprayLocation][0] = x;
    SprayData[id][SprayLocation][1] = y;
    SprayData[id][SprayLocation][2] = z;

    SprayData[id][SprayLocation][3] = 0.0;
    SprayData[id][SprayLocation][4] = 0.0;
    SprayData[id][SprayLocation][5] = angle;

	SprayData[id][SprayModel] = listitem;
    SprayData[id][SprayInterior] = GetPlayerInterior(playerid);
    SprayData[id][SprayWorld] = GetPlayerVirtualWorld(playerid);
    Iter_Add(Tags, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý graffiti noktasýný ekledin.", id);
	mysql_tquery(m_Handle, "INSERT INTO sprays (SprayInterior) VALUES(0)", "OnSprayCreated", "d", id);
	Spray_Refresh(id);
	return 1;
}

Server:OnSprayCreated(id)
{
	SprayData[id][SprayID] = cache_insert_id();
 	Spray_Save(id);
	return 1;
}

Spray_Refresh(id)
{
	if (IsValidDynamicObject(SprayData[id][SprayObject])) DestroyDynamicObject(SprayData[id][SprayObject]);

	if (IsValidDynamicArea(SprayData[id][SprayAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, SprayData[id][SprayAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(SprayData[id][SprayAreaID]);
	}

	SprayData[id][SprayObject] = CreateDynamicObject(SprayData[id][SprayModel], SprayData[id][SprayLocation][0], SprayData[id][SprayLocation][1], SprayData[id][SprayLocation][2], SprayData[id][SprayLocation][3], SprayData[id][SprayLocation][4], SprayData[id][SprayLocation][5], SprayData[id][SprayWorld], SprayData[id][SprayInterior]);
	
	new array[2]; array[0] = 12; array[1] = id;
	SprayData[id][SprayAreaID] = CreateDynamicSphere(SprayData[id][SprayLocation][0], SprayData[id][SprayLocation][1], SprayData[id][SprayLocation][2], 2.0, SprayData[id][SprayWorld], SprayData[id][SprayInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, SprayData[id][SprayAreaID], E_STREAMER_EXTRA_ID, array, 2);
	return 1;
}

Spray_Save(id)
{
	new
	    query[355];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE sprays SET SprayModel = %i, SprayX = %f, SprayY = %f, SprayZ = %f, SprayRX = %f, SprayRY = %f, SprayRZ = %f, SprayInterior = %i, SprayWorld = %i WHERE id = %i",
        SprayData[id][SprayModel],
		SprayData[id][SprayLocation][0],
	    SprayData[id][SprayLocation][1],
	    SprayData[id][SprayLocation][2],
	    SprayData[id][SprayLocation][3],
	    SprayData[id][SprayLocation][4],
	    SprayData[id][SprayLocation][5],
	    SprayData[id][SprayInterior],
	    SprayData[id][SprayWorld],
	    SprayData[id][SprayID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

Spray_Delete(id)
{
    new
        query[64];

	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM sprays WHERE id = %i", SprayData[id][SprayID]);
	mysql_tquery(m_Handle, query);

    if (IsValidDynamicObject(SprayData[id][SprayObject])) DestroyDynamicObject(SprayData[id][SprayObject]);
	if (IsValidDynamicArea(SprayData[id][SprayAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, SprayData[id][SprayAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(SprayData[id][SprayAreaID]);
	}
	
    Iter_Remove(Tags, id);
	return 1;
}

Spray_Nearest(playerid)
{
	return GetPVarInt(playerid, "AtSpray");
}

CMD:billboard(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/billboard [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, kirabitir, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
 		Billboard_Create(playerid);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/billboard git [billboard ID]");
		if (!Iter_Contains(Billboards, id)) return SendErrorMessage(playerid, "Hatalý billboard ID girdin.");
		SendPlayer(playerid, BillboardData[id][BillboardLocation][0], BillboardData[id][BillboardLocation][1], BillboardData[id][BillboardLocation][2], BillboardData[id][BillboardLocation][3], BillboardData[id][BillboardInterior], BillboardData[id][BillboardWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý billboard noktasýna ýþýnlandýn.", id);
		if(PlayerData[playerid][pAdminDuty])
		{
			SendClientMessageEx(playerid, COLOR_YELLOW, "BILLBOARD ID: [%i] VERÝTABANI ID: [%i]", id, BillboardData[id][BillboardID]);
			if(BillboardData[id][BillboardRentedBy] != 0) SendClientMessageEx(playerid, COLOR_YELLOW, "KÝRALAYAN: [%s] BÝTÝÞ SÜRESÝ: [%s] ", ReturnSQLName(BillboardData[id][BillboardRentedBy]), GetFullTime(BillboardData[id][BillboardRentExpiresAt]));
		}
		return 1;
 	}
 	else if (!strcmp(type, "kirabitir", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/billboard kirabitir [billboard ID]");
		if (!Iter_Contains(Billboards, id)) return SendErrorMessage(playerid, "Hatalý billboard ID girdin.");
		if (!BillboardData[id][BillboardRentedBy]) return SendErrorMessage(playerid, "Bu billboard kiralanmamýþ.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý billboard noktasýna kirasýný bitirdin.", id);
 		
 		BillboardData[id][BillboardRentedBy] = 0;
 		BillboardData[id][BillboardRentExpiresAt] = 0;
 		format(BillboardData[id][BillboardText], 128, "Yok");
		Billboard_Refresh(id);
		Billboard_Save(id);
		return 1;
 	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];
		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/billboard duzenle [billboard ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[pozisyon][model]");
			return 1;
		}

		if (!Iter_Contains(Billboards, id)) return SendErrorMessage(playerid, "Hatalý billboard ID girdin.");

		if (!strcmp(type_two, "pozisyon", true))
		{
			if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

			EditingID[playerid] = id;
			EditingObject[playerid] = 12;
			EditDynamicObject(playerid, BillboardData[id][BillboardObject]);
			return 1;
		}
		else if (!strcmp(type_two, "model", true))
		{
			new mdl;
			if (sscanf(string_two, "d", mdl)) return SendUsageMessage(playerid, "/billboard duzenle [billboard ID] model [yeni obje ID]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu billboardýn modelini %i olarak güncelledin.", mdl);
			BillboardData[id][BillboardModel] = mdl;
			Billboard_Refresh(id);
			Billboard_Save(id);
			return 1;
		}
		return 1;
 	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/billboard sil [billboard ID]");
		if (!Iter_Contains(Billboards, id)) return SendErrorMessage(playerid, "Hatalý billboard ID girdin.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý billboard noktasýný sildin.", id);
		Billboard_Delete(id);
		return 1;
 	}
 	return 1;
}

Billboard_Create(playerid)
{
	new id = Iter_Free(Billboards);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek billboard noktasý sýnýrýna ulaþýlmýþ.");

    static
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

	GetPlayerPos(playerid, x, y, z);
 	GetPlayerFacingAngle(playerid, angle);

    x += 1.0 * floatsin(-angle, degrees);
	y += 1.0 * floatcos(-angle, degrees);

    BillboardData[id][BillboardLocation][0] = x;
    BillboardData[id][BillboardLocation][1] = y;
    BillboardData[id][BillboardLocation][2] = z;

    BillboardData[id][BillboardLocation][3] = 0.0;
    BillboardData[id][BillboardLocation][4] = 0.0;
    BillboardData[id][BillboardLocation][5] = angle;

	BillboardData[id][BillboardModel] = -21029;
    BillboardData[id][BillboardInterior] = GetPlayerInterior(playerid);
    BillboardData[id][BillboardWorld] = GetPlayerVirtualWorld(playerid);
    BillboardData[id][BillboardRentExpiresAt] = 0;
    BillboardData[id][BillboardRentedBy] = 0;
    BillboardData[id][BillboardText] = EOS;
    Iter_Add(Billboards, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý billboard noktasýný ekledin.", id);
	mysql_tquery(m_Handle, "INSERT INTO billboards (BillboardInterior) VALUES(0)", "OnBillboardCreated", "d", id);
	Billboard_Refresh(id);
	return 1;
}

Billboard_Available(playerid)
{
    foreach(new i : Billboards) if(ReturnCityCode(BillboardData[i][BillboardInArea]) == ReturnCityCode(GetPlayerCityID(playerid)) && !BillboardData[i][BillboardRentedBy])
  	{
		if (GetPlayerInterior(playerid) == BillboardData[i][BillboardInterior] && GetPlayerVirtualWorld(playerid) == BillboardData[i][BillboardWorld])
			return i;
	}
	return -1;
}

Billboard_Publish(playerid, id, text[])
{
	BillboardData[id][BillboardRentExpiresAt] = Time() + (1 * 3600); // 24 olacak
	BillboardData[id][BillboardRentedBy] = PlayerData[playerid][pSQLID];

    SendClientMessageEx(playerid, COLOR_YELLOW, "1-800-BLBRD (telefon): Ýlanýnýz en kýsa sürede çevre bölgede yayýnlanacaktýr, ilanýn %s", GetFullTime(BillboardData[id][BillboardRentExpiresAt]));
	SendClientMessage(playerid, COLOR_YELLOW, "...tarihine kadar gösterilecektir.");

	if(strlen(text) > 22) format(BillboardData[id][BillboardText], 128, "%.22s\n%s\nÝletiþim: %i", text, text[22], ReturnPhoneNumber(playerid));
	else format(BillboardData[id][BillboardText], 128, "%s\nÝletiþim: %i", text, ReturnPhoneNumber(playerid));
	
	ReplaceText(BillboardData[id][BillboardText], "(y)", "\n");
	SetDynamicObjectMaterialText(BillboardData[id][BillboardObject], 0, BillboardData[id][BillboardText], OBJECT_MATERIAL_SIZE_512x256, "New Times Roman", 40, 0, 0xFF000000, 0xFFFAFAFA, 1);
	Billboard_Save(id);
	return 1;
}

Server:OnBillboardCreated(id)
{
	BillboardData[id][BillboardID] = cache_insert_id();
 	Billboard_Save(id);
	return 1;
}

Billboard_Refresh(id)
{
	if (IsValidDynamicObject(BillboardData[id][BillboardObject])) DestroyDynamicObject(BillboardData[id][BillboardObject]);
	BillboardData[id][BillboardObject] = CreateDynamicObject(BillboardData[id][BillboardModel], BillboardData[id][BillboardLocation][0], BillboardData[id][BillboardLocation][1], BillboardData[id][BillboardLocation][2], BillboardData[id][BillboardLocation][3], BillboardData[id][BillboardLocation][4], BillboardData[id][BillboardLocation][5], BillboardData[id][BillboardWorld], BillboardData[id][BillboardInterior]);
	BillboardData[id][BillboardInArea] = GetCityID(BillboardData[id][BillboardLocation][0], BillboardData[id][BillboardLocation][1], BillboardData[id][BillboardLocation][2]);

	if(!strmatch(BillboardData[id][BillboardText], "Yok")) 
	{
		ReplaceText(BillboardData[id][BillboardText], "(y)", "\n");
		SetDynamicObjectMaterialText(BillboardData[id][BillboardObject], 0, BillboardData[id][BillboardText], OBJECT_MATERIAL_SIZE_512x256, "New Times Roman", 40, 0, 0xFF000000, 0xFFFAFAFA, 1);
	}
	return 1;
}

Billboard_Save(id)
{
	new
	    query[355];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE billboards SET BillboardModel = %i, BillboardText = '%e', BillboardX = %f, BillboardY = %f, BillboardZ = %f WHERE id = %i",
        BillboardData[id][BillboardModel],
        BillboardData[id][BillboardText],
		BillboardData[id][BillboardLocation][0],
	    BillboardData[id][BillboardLocation][1],
	    BillboardData[id][BillboardLocation][2],
	    BillboardData[id][BillboardID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE billboards SET BillboardRX = %f, BillboardRY = %f, BillboardRZ = %f, BillboardInterior = %i, BillboardWorld = %i WHERE id = %i",
		BillboardData[id][BillboardLocation][3],
	    BillboardData[id][BillboardLocation][4],
	    BillboardData[id][BillboardLocation][5],
	    BillboardData[id][BillboardInterior],
	    BillboardData[id][BillboardWorld],
	    BillboardData[id][BillboardID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE billboards SET BillboardRentedBy = %i, BillboardRentExpiresAt = %i WHERE id = %i",
	    BillboardData[id][BillboardRentedBy],
	    BillboardData[id][BillboardRentExpiresAt],
	    BillboardData[id][BillboardID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

Billboard_Delete(id)
{
    new
        query[64];

	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM billboards WHERE id = %i", BillboardData[id][BillboardID]);
	mysql_tquery(m_Handle, query);

	if (IsValidDynamicObject(BillboardData[id][BillboardObject])) DestroyDynamicObject(BillboardData[id][BillboardObject]);
	//BillboardData[id][BillboardObject] = CreateDynamicObject(BillboardData[id][BillboardModel], BillboardData[id][BillboardLocation][0], BillboardData[id][BillboardLocation][1], BillboardData[id][BillboardLocation][2], BillboardData[id][BillboardLocation][3], BillboardData[id][BillboardLocation][4], BillboardData[id][BillboardLocation][5], BillboardData[id][BillboardWorld], BillboardData[id][BillboardInterior]);
    Iter_Remove(Billboards, id);
	return 1;
}

/*
CMD:pickup(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/pickup [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
		if (isnull(string) || strlen(string) > 120) return SendUsageMessage(playerid, "/pickup ekle [mesaj]");
 		Pickup_Create(playerid, string);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/tutuklama git [tutuklama ID]");
		if (!Iter_Contains(Arrests, id)) return SendErrorMessage(playerid, "Hatalý tutuklama ID girdin.");
		SendPlayer(playerid, ArrestData[id][ArrestLocation][0], ArrestData[id][ArrestLocation][1], ArrestData[id][ArrestLocation][2], 90.0, ArrestData[id][ArrestInterior], ArrestData[id][ArrestWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý tutuklama noktasýna ýþýnlandýn.", id);
		return 1;
 	}
 	else if (!strcmp(type, "duzenle", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/tutuklama duzenle [tutuklama ID]");
		if (!Iter_Contains(Arrests, id)) return SendErrorMessage(playerid, "Hatalý tutuklama ID girdin.");

		GetPlayerPos(playerid, ArrestData[id][ArrestLocation][0], ArrestData[id][ArrestLocation][1], ArrestData[id][ArrestLocation][2]);
	    ArrestData[id][ArrestInterior] = GetPlayerInterior(playerid);
	    ArrestData[id][ArrestWorld] = GetPlayerVirtualWorld(playerid);
	    Arrest_Refresh(id);
	    Arrest_Save(id);
		return 1;
 	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/tutuklama sil [tutuklama ID]");
		if (!Iter_Contains(Arrests, id)) return SendErrorMessage(playerid, "Hatalý tutuklama ID girdin.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý tutuklama noktasýný sildin.", id);
		Arrest_Delete(id);
		return 1;
 	}
 	return 1;
}

Pickup_Create(playerid, msg[])
{
	new id = Iter_Free(Pickups);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek pickup sýnýrýna ulaþýlmýþ.");

	GetPlayerPos(playerid, PickupData[id][PickupLocation][0], PickupData[id][PickupLocation][1], PickupData[id][PickupLocation][2]);
	PickupData[id][PickupInterior] = GetPlayerInterior(playerid);
	PickupData[id][PickupWorld] = GetPlayerVirtualWorld(playerid);
	PickupData[id][PickupRange] = 7.0;
	PickupData[id][PickupIcon] = 1239;

	ReplaceText(msg, "((", "{"), ReplaceText(msg, "))", "}"), ReplaceText(msg, "(n)", "\n");
	format(PickupData[id][PickupText], 128, msg);
    Iter_Add(Pickups, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý pickup ekledin.", id);
	mysql_tquery(m_Handle, "INSERT INTO pickups (PickupInterior) VALUES(0)", "OnPickupCreated", "d", id);
	Pickup_Refresh(id);
	return 1;
}

Server:OnPickupCreated(id)
{
	if (Iter_Contains(Pickups, id))
	{
		PickupData[id][PickupID] = cache_insert_id();
		Pickup_Save(id);
	}
	return 1;
}*/

Boombox_Nearest(playerid, Float: distance = 20.0)
{
	if(GetPVarInt(playerid, "AtBoombox") != -1)
	{
		new b = GetPVarInt(playerid, "AtBoombox");
		if (IsPlayerInRangeOfPoint(playerid, distance, BoomboxData[b][BoomboxLocation][0], BoomboxData[b][BoomboxLocation][1], BoomboxData[b][BoomboxLocation][2]))
		{
			return b;
		}
	}
	return -1;
}

Boombox_Placed(playerid)
{
	foreach(new i : Boomboxs) if (BoomboxData[i][BoomboxOwnerID] == PlayerData[playerid][pSQLID])
	{
		return i;
	}
	return -1;
}

Boombox_Create(playerid)
{
	new id = Iter_Free(Boomboxs);
   	if (id == -1) return SendErrorMessage(playerid, "Þu anda boombox ekleyemiyorsun, lütfen daha sonra tekrar dene.");

   	BoomboxData[id][BoomboxOwnerID] = PlayerData[playerid][pSQLID];
	GetPlayerPos(playerid, BoomboxData[id][BoomboxLocation][0], BoomboxData[id][BoomboxLocation][1], BoomboxData[id][BoomboxLocation][2]);
    BoomboxData[id][BoomboxInterior] = GetPlayerInterior(playerid);
    BoomboxData[id][BoomboxWorld] = GetPlayerVirtualWorld(playerid);
    Iter_Add(Boomboxs, id);

	SendClientMessage(playerid, COLOR_DARKGREEN, "SERVER: Yere boombox koydun. Düzenlemek için /boombox duzenle");
	Boombox_Refresh(id);
	return 1;
}

Boombox_Refresh(id)
{
	if (Iter_Contains(Boomboxs, id))
	{
        if (IsValidDynamicObject(BoomboxData[id][BoomboxObject])) DestroyDynamicObject(BoomboxData[id][BoomboxObject]);
    	if (IsValidDynamicArea(BoomboxData[id][BoomboxAreaID])) {
	    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, BoomboxData[id][BoomboxAreaID], E_STREAMER_PLAYER_ID, id);
    	    DestroyDynamicArea(BoomboxData[id][BoomboxAreaID]);
    	}

		BoomboxData[id][BoomboxObject] = CreateDynamicObject(2226, BoomboxData[id][BoomboxLocation][0], BoomboxData[id][BoomboxLocation][1], BoomboxData[id][BoomboxLocation][2], BoomboxData[id][BoomboxLocation][3], BoomboxData[id][BoomboxLocation][4], BoomboxData[id][BoomboxLocation][5], BoomboxData[id][BoomboxWorld], BoomboxData[id][BoomboxInterior]);
		new array[2]; array[0] = 24; array[1] = id;
		BoomboxData[id][BoomboxAreaID] = CreateDynamicCircle(BoomboxData[id][BoomboxLocation][0], BoomboxData[id][BoomboxLocation][1], 30.0, BoomboxData[id][BoomboxWorld], BoomboxData[id][BoomboxInterior]);
		Streamer_SetArrayData(STREAMER_TYPE_AREA, BoomboxData[id][BoomboxAreaID], E_STREAMER_EXTRA_ID, array, 2);
	}
	return 1;
}

Boombox_Delete(id)
{
	if (Iter_Contains(Boomboxs, id))
	{
        if (IsValidDynamicObject(BoomboxData[id][BoomboxObject])) DestroyDynamicObject(BoomboxData[id][BoomboxObject]);
    	if (IsValidDynamicArea(BoomboxData[id][BoomboxAreaID])) {
	    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, BoomboxData[id][BoomboxAreaID], E_STREAMER_PLAYER_ID, id);
    	    DestroyDynamicArea(BoomboxData[id][BoomboxAreaID]);
    	}

		Iter_Remove(Boomboxs, id);
	}
	return 1;
}

CMD:yaris(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/yaris [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}liste");
		return 1;
	}

	if (!strcmp(type, "liste", true))
	{
		mysql_tquery(m_Handle, "SELECT * FROM races ORDER BY RaceCreatedAt DESC LIMIT 20", "DisplayRacesList", "i", playerid);
		return 1;
 	}
 	return 1;
}

/*CMD:galeri(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/galeri [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
		static id, vehname[45];
		if (sscanf(string, "i", id, vehname)) return SendUsageMessage(playerid, "/galeri ekle [araç ID] [araç adý]");
		if (isnull(vehname) || strlen(vehname) > 45) return SendErrorMessage(playerid, "Araç adý en fazla 45 karakter olabilir.");
		if (!GetVehicleModelByName(vehname)) return SendErrorMessage(playerid, "Hatalý model ID girdiniz.");
 		Pickup_Create(playerid, string);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/tutuklama git [tutuklama ID]");
		if (!Iter_Contains(Arrests, id)) return SendErrorMessage(playerid, "Hatalý tutuklama ID girdin.");
		SendPlayer(playerid, ArrestData[id][ArrestLocation][0], ArrestData[id][ArrestLocation][1], ArrestData[id][ArrestLocation][2], 90.0, ArrestData[id][ArrestInterior], ArrestData[id][ArrestWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý tutuklama noktasýna ýþýnlandýn.", id);
		return 1;
 	}
 	else if (!strcmp(type, "duzenle", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/tutuklama duzenle [tutuklama ID]");
		if (!Iter_Contains(Arrests, id)) return SendErrorMessage(playerid, "Hatalý tutuklama ID girdin.");

		GetPlayerPos(playerid, ArrestData[id][ArrestLocation][0], ArrestData[id][ArrestLocation][1], ArrestData[id][ArrestLocation][2]);
	    ArrestData[id][ArrestInterior] = GetPlayerInterior(playerid);
	    ArrestData[id][ArrestWorld] = GetPlayerVirtualWorld(playerid);
	    Arrest_Refresh(id);
	    Arrest_Save(id);
		return 1;
 	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/tutuklama sil [tutuklama ID]");
		if (!Iter_Contains(Arrests, id)) return SendErrorMessage(playerid, "Hatalý tutuklama ID girdin.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý tutuklama noktasýný sildin.", id);
		Arrest_Delete(id);
		return 1;
 	}
 	return 1;
}*/

CMD:acctv(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/acctv [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git");
		return 1;
	}
	
	if (!strcmp(type, "ekle", true))
	{
	   	if (isnull(string) || strlen(string) > 30) return SendUsageMessage(playerid, "/acctv ekle [isim]");
	    Camera_Create(playerid, string);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "i", id)) return SendUsageMessage(playerid, "/acctv git [cctv ID]");
		if (!Iter_Contains(Cameras, id)) return SendErrorMessage(playerid, "Hatalý cctv ID girdin.");
		SendPlayer(playerid, CameraData[id][CameraLocation][0], CameraData[id][CameraLocation][1], CameraData[id][CameraLocation][2], CameraData[id][CameraLocation][5], CameraData[id][CameraInterior], CameraData[id][CameraWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý CCTV noktasýna ýþýnlandýn.", id);
		return 1;
 	}
 	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];
		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/acctv duzenle [cctv ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[pozisyon][isim]");
			return 1;
		}

		if (!Iter_Contains(Cameras, id)) return SendErrorMessage(playerid, "Hatalý cctv ID girdin.");

		if (!strcmp(type_two, "pozisyon", true))
		{
			if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

			EditingID[playerid] = id;
			EditingObject[playerid] = 3;
			EditDynamicObject(playerid, CameraData[id][CameraObject]);
			return 1;
		}
		else if (!strcmp(type_two, "isim", true))
		{
			new cctv_name[30];
			if(sscanf(string_two, "s[128]", cctv_name)) return SendUsageMessage(playerid, "/acctv duzenle [cctv ID] ad [isim]");
			if(isnull(cctv_name) || strlen(cctv_name) > 30) return SendErrorMessage(playerid, "Kamera ismi maksimum 30 karakter olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu CCTV noktasýnýn adýný %s olarak güncelledin.", cctv_name);
			format(CameraData[id][CameraName], 30, cctv_name);
			Camera_Save(id);
			return 1;
		}
	}
 	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "i", id)) return SendUsageMessage(playerid, "/acctv sil [cctv ID]");
		if (!Iter_Contains(Cameras, id)) return SendErrorMessage(playerid, "Hatalý cctv ID girdin.");
		if (GetPVarInt(playerid, "AtCCTV") != id) return SendErrorMessage(playerid, "Silmek istediðin CCTV noktasýna yakýn olmalýsýn.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý CCTV noktasýný sildin.", id);
		Camera_Delete(id);
		return 1;
 	}
	return 1;
}

Camera_Create(playerid, name[])
{
	new id = Iter_Free(Cameras);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek CCTV sýnýrýna ulaþýlmýþ.");

	format(CameraData[id][CameraName], 30, name);
    GetPlayerPos(playerid, CameraData[id][CameraLocation][0], CameraData[id][CameraLocation][1], CameraData[id][CameraLocation][2]);
    CameraData[id][CameraLocation][3] = 0.0;
    CameraData[id][CameraLocation][4] = 0.0;
    CameraData[id][CameraLocation][5] = 0.0;
	CameraData[id][CameraInterior] = GetPlayerInterior(playerid);
	CameraData[id][CameraWorld] = GetPlayerVirtualWorld(playerid);
	Iter_Add(Cameras, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý CCTV noktasýný ekledin. (ayarlamayý unutmayýn)", id);
	mysql_tquery(m_Handle, "INSERT INTO cameras (CameraInterior) VALUES (0)", "OnCameraCreated", "d", id);
	Camera_Refresh(id);
	return 1;
}

Server:OnCameraCreated(id)
{
	CameraData[id][CameraID] = cache_insert_id();
	Camera_Save(id);
	return 1;
}

Camera_Save(id)
{
	new
		query[454];

    mysql_format(m_Handle, query, sizeof(query), "UPDATE cameras SET CameraName = '%e', CameraX = %f, CameraY = %f, CameraZ = %f, CameraRX = %f, CameraRY = %f, CameraRZ = %f, CameraInterior = %i, CameraWorld = %i WHERE id = %i",
        CameraData[id][CameraName],
        CameraData[id][CameraLocation][0],
        CameraData[id][CameraLocation][1],
        CameraData[id][CameraLocation][2],
        CameraData[id][CameraLocation][3],
        CameraData[id][CameraLocation][4],
        CameraData[id][CameraLocation][5],
        CameraData[id][CameraInterior],
        CameraData[id][CameraWorld],
        CameraData[id][CameraID]);
    
    mysql_tquery(m_Handle, query);
	return 1;
}

Camera_Delete(id)
{
    new
        query[64];

	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM cameras WHERE id = %i", CameraData[id][CameraID]);
	mysql_tquery(m_Handle, query);

    if(IsValidDynamicObject(CameraData[id][CameraObject])) DestroyDynamicObject(CameraData[id][CameraObject]);
	if (IsValidDynamicArea(CameraData[id][CameraAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, CameraData[id][CameraAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(CameraData[id][CameraAreaID]);
	}

	Iter_Remove(Cameras, id);
	return 1;
}

Camera_Refresh(id)
{
    if(IsValidDynamicObject(CameraData[id][CameraObject])) DestroyDynamicObject(CameraData[id][CameraObject]);
	if (IsValidDynamicArea(CameraData[id][CameraAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, CameraData[id][CameraAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(CameraData[id][CameraAreaID]);
	}

	CameraData[id][CameraObject] = CreateDynamicObject(1622, CameraData[id][CameraLocation][0], CameraData[id][CameraLocation][1], CameraData[id][CameraLocation][2], CameraData[id][CameraLocation][3], CameraData[id][CameraLocation][4], CameraData[id][CameraLocation][5], CameraData[id][CameraWorld], CameraData[id][CameraInterior]);
	new array[2]; array[0] = 22; array[1] = id;
	CameraData[id][CameraAreaID] = CreateDynamicSphere(CameraData[id][CameraLocation][0], CameraData[id][CameraLocation][1], CameraData[id][CameraLocation][2], 3.0, CameraData[id][CameraWorld], CameraData[id][CameraInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, CameraData[id][CameraAreaID], E_STREAMER_EXTRA_ID, array, 2);
	return 1;
}

Camera_Nearest(playerid)
{
    return GetPVarInt(playerid, "AtCCTV");
}

Camera_List(playerid)
{
	new 
		primary[900], sub[90];

	foreach(new i : Cameras)
	{
		format(sub, sizeof(sub), "%s\t{AFAFAF}[%s]\n", CameraData[i][CameraName], GetStreet(CameraData[i][CameraLocation][0], CameraData[i][CameraLocation][1], CameraData[i][CameraLocation][2]));
		strcat(primary, sub);
	}

	strcat(primary, "{FFFF00}Kapatmak için týklayýn.");
	Dialog_Show(playerid, CCTV_LIST, DIALOG_STYLE_TABLIST, "Close Circuit TeleVision", primary, "Tamam", "Kapat <<<");
	return 1;
}

Dialog:CCTV_LIST(playerid, response, listitem, inputtext[])
{
	if(response) 
	{
		if(!strcmp(inputtext, "Kapatmak için týklayýn."))
		{
			Camera_Quit(playerid);
			return 1;
		}

		Camera_Watch(playerid, listitem);
		return 1;
	}
    return 1;
}

Camera_Watch(playerid, id)
{
	if(CCTVID[playerid] == -1)
    {
		GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
		GetPlayerFacingAngle(playerid, PlayerData[playerid][pPos][3]);

		PlayerData[playerid][pInterior] = GetPlayerInterior(playerid);
		PlayerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
    }

    RemovePlayerFromVehicle(playerid);
	SetPlayerInterior(playerid, CameraData[id][CameraInterior]);
	SetPlayerVirtualWorld(playerid, CameraData[id][CameraWorld]);

	TogglePlayerSpectating(playerid, 1);
    AttachCameraToDynamicObject(playerid, CameraData[id][CameraObject]);
   	CCTVID[playerid] = id;

    SendClientMessageEx(playerid, COLOR_ADM, "SERVER: %s kamerasýný izlemeye baþladýn.", CameraData[id][CameraName]);
    return 1;
}

Camera_Quit(playerid)
{
	TogglePlayerSpectating(playerid, 0);
    return 1;
}

CMD:aisyeri(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/aisyeri [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sat, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
	    new business_type, business_name[128];
	    if(sscanf(string, "is[128]", business_type, business_name)) 
	    {
	    	SendUsageMessage(playerid, "/aisyeri ekle [iþyeri tipi] [iþyeri adý]");
	    	SendClientMessage(playerid, COLOR_WHITE, "1: [Maðaza] 2: [Genel Maðaza] 3: [Pawnshop] 4: [Restaurant] 5: [Silahçý]");
			SendClientMessage(playerid, COLOR_WHITE, "6: [Kýyafetçi] 7: [Banka] 8: [Gece Kulübü] 9: [Galeri] 10: [Benzinci]");
			SendClientMessage(playerid, COLOR_WHITE, "11: [Reklamcý] 12: [Eczane] 13: [Özel]");
			return 1;
	    }	

		if(business_type < 0 || business_type > 12) return SendErrorMessage(playerid, "Hatalý iþyeri tipi girdin.");
	    if(isnull(business_name) || strlen(business_name) > 128) return SendErrorMessage(playerid, "Ýþyeri adý maksimum 128 karakter olabilir.");
	    Business_Create(playerid, business_type, business_name);
		return 1;
	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];
		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/aisyeri duzenle [iþyeri ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[dis][ic][ad][fiyat][seviye][tip][kilit]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[girisfiyat][pickup][istenenkargo][kargomiktar][kargofiyat]");
			return 1;
		}

		if (!Iter_Contains(Businesses, id)) return SendErrorMessage(playerid, "Hatalý iþyeri ID girdin.");

		if (!strcmp(type_two, "dis", true))
		{
		    GetPlayerPos(playerid, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2]);
		    GetPlayerFacingAngle(playerid, BusinessData[id][EnterPos][3]);
			BusinessData[id][EnterInterior] = GetPlayerInterior(playerid);
			BusinessData[id][EnterWorld] = GetPlayerVirtualWorld(playerid);

            SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu iþyerinin dýþ pozisyonunu güncelledin.");
			Business_Refresh(id);
			Business_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "ic", true))
		{
		    GetPlayerPos(playerid, BusinessData[id][ExitPos][0], BusinessData[id][ExitPos][1], BusinessData[id][ExitPos][2]);
		    GetPlayerFacingAngle(playerid, BusinessData[id][ExitPos][3]);
			BusinessData[id][ExitInterior] = GetPlayerInterior(playerid);
			BusinessData[id][ExitWorld] = GetPlayerVirtualWorld(playerid);

			if(BusinessData[id][BusinessType] == BUSINESS_BANK)
			{
				SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu iþyerinin banka noktasý iç pozisyonu deðiþtiðinden dolayý silindi.");
				if(IsValidDynamicPickup(BusinessData[id][BankPickup])) DestroyDynamicPickup(BusinessData[id][BankPickup]);
				for(new i = 0; i < 3; i++) BusinessData[id][BankPos][i] = 0.0;
			}

			foreach(new i : Player) if(PlayerData[i][pInsideBusiness] == id)
			{
				SendPlayer(i, BusinessData[id][ExitPos][0], BusinessData[id][ExitPos][1], BusinessData[id][ExitPos][2], BusinessData[id][ExitPos][3], BusinessData[id][ExitInterior], BusinessData[id][ExitWorld]);
				SendClientMessage(i, COLOR_YELLOW, "SERVER: Bu iþyeri iç kýsmý güncellendi.");
				SetCameraBehindPlayer(i);
			}

			SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu iþyerinin iç pozisyonunu güncelledin.");
			Business_Refresh(id);
			Business_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "ad", true))
		{
			new business_name[128];
			if (sscanf(string_two, "s[128]", business_name)) return SendUsageMessage(playerid, "/aisyeri duzenle [iþyeri ID] ad [iþyeri adý]");
			if(isnull(business_name) || strlen(business_name) > 128) return SendErrorMessage(playerid, "Ýþyeri adý maksimum 128 karakter olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu iþyerinin adýný %s olarak güncelledin.", business_name);
			format(BusinessData[id][BusinessName], 128, business_name);
			Business_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "kilit", true))
		{
			new locked;
			if (sscanf(string_two, "d", locked)) return SendUsageMessage(playerid, "/aisyeri duzenle [iþyeri ID] kilit [0/1]");
			if (locked < 0 || locked > 1) return SendErrorMessage(playerid, "Hatalý kilit durumu girdin. (0/1)");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu iþyerinin kapýlarýný %s olarak güncelledin.", !locked ? ("kilitli deðil") : ("kilitli"));
			BusinessData[id][BusinessLocked] = bool:locked;
			Business_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "fiyat", true))
		{
			static fiyat;
			if (sscanf(string_two, "d", fiyat)) return SendUsageMessage(playerid, "/aisyeri duzenle [iþyeri ID] fiyat [miktar]");
			if (fiyat < 25000) return SendErrorMessage(playerid, "Bu iþyerinin fiyatý en az $25,000 olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu iþyerinin fiyatýný $%s olarak güncelledin.", MoneyFormat(fiyat));
			BusinessData[id][BusinessPrice] = fiyat;
			Business_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "seviye", true))
		{
			static level;
			if (sscanf(string_two, "d", level)) return SendUsageMessage(playerid, "/aisyeri duzenle [iþyeri ID] seviye [level]");
			if (level < 1) return SendErrorMessage(playerid, "Bu iþyerinin seviyesi en az 1 olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu iþyerinin seviyesini %i olarak güncelledin.", level);
			BusinessData[id][BusinessLevel] = level;
			Business_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "tip", true))
		{
			static tip;
			if (sscanf(string_two, "i", tip)) 
			{
				SendUsageMessage(playerid, "/aisyeri duzenle [iþyeri ID] tip [iþyeri tipi]");
				SendClientMessage(playerid, COLOR_WHITE, "1: [Maðaza] 2: [Genel Maðaza] 3: [Pawnshop] 4: [Restaurant] 5: [Silahçý]");
				SendClientMessage(playerid, COLOR_WHITE, "6: [Kýyafetçi] 7: [Banka] 8: [Gece Kulübü] 9: [Galeri] 10: [Özel]");
				return 1;
			}

			if(tip < 1 || tip > 11) return SendErrorMessage(playerid, "Hatalý iþyeri tipi girdin.");

			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu iþyerinin seviyesini %i olarak güncelledin.", tip);
			BusinessData[id][BusinessType] = tip;
			Business_Refresh(id);
			Business_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "pickup", true))
		{
			if (BusinessData[id][BusinessType] != BUSINESS_BANK) return SendErrorMessage(playerid, "Bu iþyerinin tipi banka deðil.");
		    GetPlayerPos(playerid, BusinessData[id][BankPos][0], BusinessData[id][BankPos][1], BusinessData[id][BankPos][2]);
			BusinessData[id][BankInterior] = GetPlayerInterior(playerid);
			BusinessData[id][BankWorld] = GetPlayerVirtualWorld(playerid);
            SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu iþyerinin banka maaþ pozisyonunu güncelledin.");
			Business_Refresh(id);
			Business_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "kargomiktar", true))
		{
			static level;
			if (sscanf(string_two, "i", level)) return SendUsageMessage(playerid, "/aisyeri duzenle [iþyeri ID] kargomiktar [miktar]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu iþyerinin kargo miktarýný %i olarak güncelledin.", level);
			BusinessData[id][BusinessProduct] = level;
			Business_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "istenenkargo", true))
		{
			static level;
			if (sscanf(string_two, "i", level)) return SendUsageMessage(playerid, "/aisyeri duzenle [iþyeri ID] istenenkargo [miktar]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu iþyerinin istenen kargo miktarýýn %i olarak güncelledin.", level);
			BusinessData[id][BusinessWantedProduct] = level;
			Business_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "kargofiyat", true))
		{
			static level;
			if (sscanf(string_two, "i", level)) return SendUsageMessage(playerid, "/aisyeri duzenle [iþyeri ID] kargofiyat [miktar]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu iþyerinin kargo alýþ fiyatýný %s olarak güncelledin.", MoneyFormat(level));
			BusinessData[id][BusinessProductPrice] = level;
			Business_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "girisfiyat", true))
		{
			static fiyat;
			if (sscanf(string_two, "i", fiyat)) return SendUsageMessage(playerid, "/aisyeri duzenle [iþyeri ID] girisfiyat [miktar]");
			if (fiyat < 1) return SendErrorMessage(playerid, "Bu iþyerinin giriþ fiyatý en az $1 olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu iþyerinin giriþ fiyatýný $%s olarak güncelledin.", MoneyFormat(fiyat));
			BusinessData[id][BusinessFee] = fiyat;
			Business_Save(id);
			return 1;
		}
	}	
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "i", id)) return SendUsageMessage(playerid, "/aisyeri git [iþyeri ID]");
		if (!Iter_Contains(Businesses, id)) return SendErrorMessage(playerid, "Hatalý iþyeri ID girdin.");
		SendPlayer(playerid, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], BusinessData[id][EnterPos][3], BusinessData[id][EnterInterior], BusinessData[id][EnterWorld]);
		if (!BusinessData[id][BusinessOwnerSQLID]) SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý iþyerine ýþýnlandýn. (sahip: satýlýk durumda)", id);
		else SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý iþyerine ýþýnlandýn. (sahip: %s)", id, ReturnSQLName(BusinessData[id][BusinessOwnerSQLID]));
		return 1;
 	}
 	else if (!strcmp(type, "sat", true))
	{
		static id;
		if (sscanf(string, "i", id)) return SendUsageMessage(playerid, "/aisyeri sat [iþyeri ID]");
		if (!Iter_Contains(Businesses, id)) return SendErrorMessage(playerid, "Hatalý iþyeri ID girdin.");
		if (!BusinessData[id][BusinessOwnerSQLID]) return SendErrorMessage(playerid, "Sahibi olmayan iþyerini satamazsýn.");
		if (GetPVarInt(playerid, "AtBusiness") != id) return SendErrorMessage(playerid, "Satmak istediðin iþyerine yakýn olmalýsýn.");
		foreach(new i : Player) if(strfind(ReturnName(i, 1), ReturnSQLName(BusinessData[id][BusinessOwnerSQLID]), true) != -1) SendClientMessageEx(i, COLOR_YELLOW, "SERVER: %i numaralý iþyerine %s isimli yönetici tarafýndan el konuldu.", id, ReturnName(playerid, 1));
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý iþyerine el koydun.", id);
		BusinessData[id][BusinessOwnerSQLID] = 0;
		Business_Save(id);
		return 1;
 	}
 	else if (!strcmp(type, "sil", true))
	{
		static id;
		if (sscanf(string, "i", id)) return SendUsageMessage(playerid, "/aisyeri sil [iþyeri ID]");
		if (!Iter_Contains(Businesses, id)) return SendErrorMessage(playerid, "Hatalý iþyeri ID girdin.");
		if (GetPVarInt(playerid, "AtBusiness") != id) return SendErrorMessage(playerid, "Silmek istediðin iþyerine yakýn olmalýsýn.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý iþyerini sildin.", id);
		Business_Delete(id);
		return 1;
 	}
	return 1;
}

CMD:p2biz(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	static id, bizid;
	if(sscanf(params, "ud", id, bizid)) return SendUsageMessage(playerid, "/p2biz [oyuncu ID/adý] [iþyeri ID]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!Iter_Contains(Businesses, bizid)) return SendErrorMessage(playerid, "Hatalý iþyeri ID girdin.");

	SendPlayer(id, BusinessData[bizid][EnterPos][0], BusinessData[bizid][EnterPos][1], BusinessData[bizid][EnterPos][2], BusinessData[bizid][EnterPos][3], BusinessData[bizid][EnterInterior], BusinessData[bizid][EnterWorld]);
	SendClientMessageEx(id, COLOR_GREY, "AdmCmd: %s isimli yönetici seni %i numaralý iþyerine gönderdi.", ReturnName(playerid, 1), bizid);
	//LogAdminAction(playerid, sprintf("%s isimli kiþinin #%d numaralý iþyerine gönderdi.", ReturnName(playerb, 1), bizid));
	return 1;
}

CMD:agise(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/agise [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sil, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
		static id, toll_name[25];
		if(sscanf(string, "is[25]", id, toll_name)) return SendUsageMessage(playerid, "/agise ekle [obje ID] [giþe adý]");
		if(strlen(toll_name) < 5 || strlen(toll_name) > 25) return SendErrorMessage(playerid, "Giþe adý en az 5 karakter en fazla 25 karakter olabilir.");
		Toll_Create(playerid, id, toll_name);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if (sscanf(string, "d", id)) return SendUsageMessage(playerid, "/agise git [giþe ID]");
		if (!Iter_Contains(Tolls, id)) return SendErrorMessage(playerid, "Hatalý giþe ID girdin.");
		SendPlayer(playerid, TollData[id][TollPos][0], TollData[id][TollPos][1], TollData[id][TollPos][2], TollData[id][TollPos][5], TollData[id][TollInterior], TollData[id][TollWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý giþeye ýþýnlandýn.", id);
		return 1;
 	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];
		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/agise duzenle [giþe ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[pozisyon][apozisyon][model][fiyat][isim]");
			return 1;
		}

		if(!Iter_Contains(Tolls, id)) return SendErrorMessage(playerid, "Hatalý giþe ID girdin.");

		if (!strcmp(type_two, "pozisyon", true))
		{
			if(TollData[id][TollStatus]) return SendErrorMessage(playerid, "Düzenlemek istediðin giþenin kapanmasýný bekle.");
			if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");
		
			EditingID[playerid] = id;
			EditingObject[playerid] = 17;
			EditDynamicObject(playerid, TollData[id][TollObject]);
			return 1;
		}
		else if (!strcmp(type_two, "apozisyon", true))
		{
			if(TollData[id][TollStatus]) return SendErrorMessage(playerid, "Düzenlemek istediðin giþenin kapanmasýný bekle.");
			if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

			EditingID[playerid] = id;
			EditingObject[playerid] = 18;
			EditDynamicObject(playerid, TollData[id][TollObject]);
			return 1;
		}
		else if (!strcmp(type_two, "model", true))
		{
			new model;
			if (sscanf(string_two, "i", model)) return SendUsageMessage(playerid, "/agise duzenle [giþe ID] model [obje ID]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu giþenin modelini %i olarak güncelledin.", model);
			TollData[id][TollModel] = model;
			Toll_Refresh(id);
			Toll_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "fiyat", true))
		{
			new price;
			if(sscanf(string_two, "i", price)) return SendUsageMessage(playerid, "/agise duzenle [giþe ID] fiyat [miktar]");
			if(price < 1 || price > 1000) return SendErrorMessage(playerid, "Giþenin fiyatý en az $1 en fazla $1,000 olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu giþenin fiyatýný $%i olarak güncelledin.", price);
			TollData[id][TollPrice] = price;
			Toll_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "isim", true))
		{
			new toll_name[25];
			if(sscanf(string_two, "s[25]", toll_name)) return SendUsageMessage(playerid, "/agise duzenle [giþe ID] isim [yeni isim]");
			if(strlen(toll_name) < 5 || strlen(toll_name) > 25) return SendErrorMessage(playerid, "Giþe adý en az 5 karakter en fazla 25 karakter olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu giþenin adýný %s olarak güncelledin.", toll_name);
			format(TollData[id][TollName], 25, "%s", toll_name);
			Toll_Save(id);
			return 1;
		}
	}
	else if (!strcmp(type, "sil", true))
	{
		static id;
		if(sscanf(string, "i", id)) return SendUsageMessage(playerid, "/agise sil [giþe ID]");
		if(!Iter_Contains(Tolls, id)) return SendErrorMessage(playerid, "Hatalý giþe ID girdin.");
		if(GetPVarInt(playerid, "AtToll") != id) return SendErrorMessage(playerid, "Silmek istediðin giþeye yakýn olmalýsýn.");
		if(TollData[id][TollStatus]) return SendErrorMessage(playerid, "Silmek istediðin giþenin kapanmasýný bekle.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý giþeyi sildin.", id);
		Toll_Delete(id);
		return 1;
 	}
 	return 1;
}

Toll_Create(playerid, model, name[])
{
	new id = Iter_Free(Tolls);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek giþe sýnýrýna ulaþýlmýþ.");

	static
		Float:x,
		Float:y,
		Float:z,
		Float:angle;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	format(TollData[id][TollName], 25, "%s", name);
	TollData[id][TollModel] = model;
	TollData[id][TollPrice] = 20;

	TollData[id][TollPos][0] = x + (3.0 * floatsin(-angle, degrees));
	TollData[id][TollPos][1] = y + (3.0 * floatcos(-angle, degrees));
	TollData[id][TollPos][2] = z;
	TollData[id][TollPos][3] = 0.0;
	TollData[id][TollPos][4] = 0.0;
	TollData[id][TollPos][5] = angle;

	TollData[id][TollInterior] = GetPlayerInterior(playerid);
	TollData[id][TollWorld] = GetPlayerVirtualWorld(playerid);

	TollData[id][TollMovePos][0] = x + (3.0 * floatsin(-angle, degrees));
	TollData[id][TollMovePos][1] = y + (3.0 * floatcos(-angle, degrees));
	TollData[id][TollMovePos][2] = z - 10.0;
	TollData[id][TollMovePos][3] = -1000.0;
	TollData[id][TollMovePos][4] = -1000.0;
	TollData[id][TollMovePos][5] = -1000.0;

	TollData[id][TollLocked] = false;
	TollData[id][TollStatus] = false;
	Iter_Add(Tolls, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý giþeyi ekledin. (düzenlemeyi unutma)", id);
	mysql_tquery(m_Handle, "INSERT INTO tolls (TollPrice) VALUES(20)", "OnTollCreated", "d", id);
	Toll_Refresh(id);
	return 1;
}

Server:OnTollCreated(id)
{
	TollData[id][TollID] = cache_insert_id();
	Toll_Save(id);
	return 1;
}

Toll_OpenedCount()
{
	new count = 0;
	foreach(new i: Tolls) if(TollData[i][TollStatus]) count++;
	return count;
}

Toll_Refresh(id)
{
	if(IsValidDynamicObject(TollData[id][TollObject])) DestroyDynamicObject(TollData[id][TollObject]);
	if(IsValidDynamicArea(TollData[id][TollAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, TollData[id][TollAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(TollData[id][TollAreaID]);
	}

	TollData[id][TollObject] = CreateDynamicObject(TollData[id][TollModel], TollData[id][TollPos][0], TollData[id][TollPos][1], TollData[id][TollPos][2], TollData[id][TollPos][3], TollData[id][TollPos][4], TollData[id][TollPos][5], TollData[id][TollWorld], TollData[id][TollInterior]);

	new array[2]; array[0] = 7; array[1] = id;
	TollData[id][TollAreaID] = CreateDynamicSphere(TollData[id][TollPos][0], TollData[id][TollPos][1], TollData[id][TollPos][2], 9.0, TollData[id][TollWorld], TollData[id][TollInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, TollData[id][TollAreaID], E_STREAMER_EXTRA_ID, array, 2);
	return 1;
}

Toll_Save(id)
{
	new 
		query[354];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE tolls SET TollName = '%e', TollModel = %i, TollPrice = %i, PosX = %f, PosY = %f, PosZ = %f, RotX = %f, RotY = %f, RotZ = %f WHERE id = %i",
        TollData[id][TollName],
		TollData[id][TollModel],
	    TollData[id][TollPrice],
		TollData[id][TollPos][0],
	    TollData[id][TollPos][1],
	    TollData[id][TollPos][2],
	    TollData[id][TollPos][3],
	    TollData[id][TollPos][4],
	    TollData[id][TollPos][5],
	    TollData[id][TollID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE tolls SET TollInterior = %i, TollWorld = %i, OpenX = %f, OpenY = %f, OpenZ = %f, OpenRotX = %f, OpenRotY = %f, OpenRotZ = %f WHERE id = %i",
        TollData[id][TollInterior],
		TollData[id][TollWorld],
		TollData[id][TollMovePos][0],
	    TollData[id][TollMovePos][1],
	    TollData[id][TollMovePos][2],
	    TollData[id][TollMovePos][3],
	    TollData[id][TollMovePos][4],
	    TollData[id][TollMovePos][5],
	    TollData[id][TollID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

Toll_Delete(id)
{
    new
        query[64];

	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM tolls WHERE id = %i", TollData[id][TollID]);
	mysql_tquery(m_Handle, query);

	if(IsValidDynamicObject(TollData[id][TollObject])) DestroyDynamicObject(TollData[id][TollObject]);
	if(IsValidDynamicArea(TollData[id][TollAreaID])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, TollData[id][TollAreaID], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(TollData[id][TollAreaID]);
	}

    Iter_Remove(Tolls, id);
	return 1;
}

CMD:akargo(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/akargo [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}duzenle, duzenle, git");
		return 1;
	}

	if (!strcmp(type, "git", true))
	{
		static id;
		if(sscanf(string, "i", id)) return SendUsageMessage(playerid, "/abirlik git [kargo noktasý ID]");
		if(!Iter_Contains(Trucker, id)) return SendErrorMessage(playerid, "Hatalý kargo noktasý ID girdin");
		SendPlayer(playerid, TruckerData[id][tPosX], TruckerData[id][tPosY], TruckerData[id][tPosZ], 90.0, 0, 0);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s (ID: %i) kargo noktasýna noktasýna ýþýnlandýn.", TruckerData[id][tName], id);
		return 1;
 	}
 	
	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];
		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/akargo duzenle [kargo noktasý ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[kapasite][kkapasite][fiyat][u/t][kilit][tip]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[urun][pozisyon]");
			return 1;
		}

		if(!Iter_Contains(Trucker, id)) return SendErrorMessage(playerid, "Hatalý kargo noktasý ID girdin");
		
		if (!strcmp(type_two, "pozisyon", true))
		{
			GetPlayerPos(playerid, TruckerData[id][tPosX], TruckerData[id][tPosY], TruckerData[id][tPosZ]);
			Industry_Refresh(id);
			Industry_Save(id);
			return 1;
		}
		else if(!strcmp(type_two, "kapasite", true))
		{
			new pd;
			if(sscanf(string_two, "i", pd)) return SendUsageMessage(playerid, "/akargo duzenle [kargo noktasý ID] kapasite [miktar]");
        	if(pd < 0 || pd > TruckerData[id][tStorageSize])
	    		return SendErrorMessage(playerid, "Kapasite 0 - %i aralýðýnda olmalýdýr.", TruckerData[id][tStorageSize]);

			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s(ID: %i) kargo noktasýnýn kapasitesini %i olarak ayarladýn.", TruckerData[id][tName], id, pd);
			TruckerData[id][tStorage] = pd;
			Industry_Update(id);
			Industry_Save(id);
			return 1;
		}
		else if(!strcmp(type_two, "kkapasite", true))
		{
			new pd;
			if(sscanf(string_two, "i", pd)) return SendUsageMessage(playerid, "/akargo duzenle [kargo noktasý ID] kkapasite [miktar]");
        	if(pd < 0 || pd > 10000) return SendErrorMessage(playerid, "Kapasite 0 - 10000 aralýðýnda olmalýdýr.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s(ID: %i) kargo noktasýnýn kalýcý kapasitesini %i olarak ayarladýn.", TruckerData[id][tName], id, pd);
			TruckerData[id][tStorageSize] = pd;
			Industry_Refresh(id);
			Industry_Save(id);
			return 1;
		}
		else if(!strcmp(type_two, "fiyat", true))
		{
			new pd;
			if(sscanf(string_two, "i", pd)) return SendUsageMessage(playerid, "/akargo duzenle [kargo noktasý ID] fiyat [miktar]");
        	if(pd < 0 || pd > 10000) return SendErrorMessage(playerid, "Kapasite 0 - 10000 aralýðýnda olmalýdýr.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s(ID: %i) kargo noktasýnýn fiyatýný %i olarak ayarladýn.", TruckerData[id][tName], id, pd);
			TruckerData[id][tPrice] = pd;
			Industry_Update(id);
			Industry_Save(id);
			return 1;
		}
		else if(!strcmp(type_two, "u/t", true))
		{
			new pd;
			if(sscanf(string_two, "i", pd)) return SendUsageMessage(playerid, "/akargo duzenle [kargo noktasý ID] u/t [miktar]");
        	if(pd < -100 || pd > 100) return SendErrorMessage(playerid, "Üretim/tüketim -100 - 100 aralýðýnda olmalýdýr.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s(ID: %i) kargo noktasýnýn üretim/tüketimini %i olarak ayarladýn.", TruckerData[id][tName], id, pd);
			TruckerData[id][tProductAmount] = pd;
			Industry_Refresh(id);
			Industry_Save(id);
			return 1;
		}
		else if(!strcmp(type_two, "kilit", true))
		{
			new pd;
			if(sscanf(string_two, "i", pd)) return SendUsageMessage(playerid, "/akargo duzenle [kargo noktasý ID] kilit [0-1]");
			if(pd < 0 || pd > 1) return SendErrorMessage(playerid, "Girilebilecek deðer en az 0 en fazla 1 olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s(ID: %i) kargo noktasýnýn kiliti durumunu %s olarak ayarladýn.", TruckerData[id][tName], id, (pd == 1) ? ("kilitli"): ("kilitli deðil"));
			TruckerData[id][tLocked] = pd;
			Industry_Save(id);
			return 1;
		}
		else if(!strcmp(type_two, "tip", true))
		{
			new pd;
			if(sscanf(string_two, "i", pd)) 
			{
				SendUsageMessage(playerid, "/akargo duzenle [kargo noktasý ID] tip [0-3]");
				SendInfoMessage(playerid, "0 - Özel | 1 - Satýlan | 2 - Gemi | 3 - Alýnan");
				return 1;
			}

        	if(pd < 0 || pd > 3) return SendErrorMessage(playerid, "Tip 0 - 3 aralýðýnda olmalýdýr.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s(ID: %i) kargo noktasýnýn tipini %i olarak ayarladýn.", TruckerData[id][tName], id, pd);
			TruckerData[id][tType] = pd;
			Industry_Save(id);
			return 1;
		}
		else if(!strcmp(type_two, "urun", true))
		{
			new pd;
			if(sscanf(string_two, "i", pd)) 
			{
				SendUsageMessage(playerid, "/akargo duzenle [kargo noktasý ID] urun [tip numarasý]");
				for(new j; j != MAX_TRUCK_PRODUCT; j++) {
					SendClientMessageEx(playerid, COLOR_WHITE, "%i - %s;", j, TruckerData_product[j]);
				}
				return 1;
			}

			if(pd < 0 || pd > MAX_TRUCK_PRODUCT-1)
	    		return SendErrorMessage(playerid, "Ürün tipi 0 - %i aralýðýnda olmalýdýr.", MAX_TRUCK_PRODUCT-1);

			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s(ID: %i) kargo noktasýnýn ürün tipini %s(ID: %i) olarak ayarladýn.", TruckerData[id][tName], id, TruckerData_product[pd], pd);
			TruckerData[id][tProductID] = pd;
			Industry_Refresh(id);
			Industry_Save(id);
			return 1;
		}
		else if(!strcmp(type_two, "gps", true))
		{
			new pd;
			if(sscanf(string_two, "i", pd)) return SendUsageMessage(playerid, "/akargo duzenle [kargo noktasý ID] gps [0-1]");
			if(pd < 0 || pd > 1) return SendErrorMessage(playerid, "Girilebilecek deðer en az 0 en fazla 1 olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s(ID: %i) kargo noktasýnýn GPS durumunu %s olarak ayarladýn.", TruckerData[id][tName], id, (pd == 1) ? ("görünür"): ("gizli"));
			TruckerData[id][tGps] = pd;
			Industry_Save(id);
			return 1;
		}
	}

 	return 1;
}


CMD:abirlik(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/abirlik [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, git");
		return 1;
	}

	if (!strcmp(type, "ekle", true))
	{
	    new f_name[128], f_abbrev[128];
	    if(sscanf(string, "p<->s[128]s[128]", f_name, f_abbrev)) 
	    {
	    	SendUsageMessage(playerid, "/abirlik ekle [birlik adý]-[birlik kýsaltmasý]");
			return 1;
	    }	

	    if(isnull(f_name) || strlen(f_name) > 128) return SendErrorMessage(playerid, "Birlik adý maksimum 128 karakter olabilir.");
	    if(isnull(f_abbrev) || strlen(f_abbrev) > 128) return SendErrorMessage(playerid, "Birlik kýsaltmasý maksimum 128 karakter olabilir.");
		Faction_Create(playerid, f_name, f_abbrev);
		return 1;
	}
	else if (!strcmp(type, "git", true))
	{
		static id;
		if(sscanf(string, "i", id)) return SendUsageMessage(playerid, "/abirlik git [birlik ID]");
		if(!Iter_Contains(Factions, id)) return SendErrorMessage(playerid, "Hatalý birlik ID girdin.");
		SendPlayer(playerid, FactionData[id][FactionSpawn][0], FactionData[id][FactionSpawn][1], FactionData[id][FactionSpawn][2], FactionData[id][FactionSpawn][3], FactionData[id][FactionSpawnInterior], FactionData[id][FactionSpawnVW]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý birlik noktasýna ýþýnlandýn.", id);
		return 1;
 	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];
		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/abirlik duzenle [birlik ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[isim][kisaltma][pd][fd][san]");
			return 1;
		}

		if(!Iter_Contains(Factions, id)) return SendErrorMessage(playerid, "Hatalý birlik ID girdin.");
		
		if(!strcmp(type_two, "isim", true))
		{
			new faction_name[128];
			if(sscanf(string_two, "s[128]", faction_name)) return SendUsageMessage(playerid, "/abirlik duzenle [birlik ID] isim [yeni isim]");
			if(isnull(faction_name) || strlen(faction_name) > 128) return SendErrorMessage(playerid, "Birlik adý maksimum 128 karakter olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý birliðin adýný %s olarak güncelledin.", id, faction_name);
			format(FactionData[id][FactionName], 128, "%s", faction_name);
			Faction_Save(id);
			return 1;
		}
		else if(!strcmp(type_two, "kisaltma", true))
		{
			new abbrev[128];
			if(sscanf(string_two, "s[128]", abbrev)) return SendUsageMessage(playerid, "/abirlik duzenle [birlik ID] kisaltma [yeni kýsaltma]");
			if(isnull(abbrev) || strlen(abbrev) > 128) return SendErrorMessage(playerid, "Birlik adý maksimum 128 karakter olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý birliðin kýsaltmasýný %s olarak güncelledin.", id, abbrev);
			format(FactionData[id][FactionAbbrev], 128, "%s", abbrev);
			Faction_Save(id);
			return 1;
		}
		else if(!strcmp(type_two, "pd", true))
		{
			new pd;
			if(sscanf(string_two, "i", pd)) return SendUsageMessage(playerid, "/abirlik duzenle [birlik ID] pd [0-1]");
			if(pd < 0 || pd > 1) return SendErrorMessage(playerid, "Girilebilecek deðer en az 0 en fazla 1 olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý birliði polis birliði komutlarýný kullanma %s", id, (pd == 1) ? ("yetkisi verdin."): ("yetkisini aldýn."));
			FactionData[id][FactionCopPerms] = pd;
			Faction_Save(id);
			return 1;
		}
		else if(!strcmp(type_two, "fd", true))
		{
			new pd;
			if(sscanf(string_two, "i", pd)) return SendUsageMessage(playerid, "/abirlik duzenle [birlik ID] fd [0-1]");
			if(pd < 0 || pd > 1) return SendErrorMessage(playerid, "Girilebilecek deðer en az 0 en fazla 1 olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý birliði medikal birliði komutlarýný kullanma %s", id, (pd == 1) ? ("yetkisi verdin."): ("yetkisini aldýn."));
			FactionData[id][FactionMedPerms] = pd;
			Faction_Save(id);
			return 1;
		}
		else if(!strcmp(type_two, "san", true))
		{
			new pd;
			if(sscanf(string_two, "i", pd)) return SendUsageMessage(playerid, "/abirlik duzenle [birlik ID] san [0-1]");
			if(pd < 0 || pd > 1) return SendErrorMessage(playerid, "Girilebilecek deðer en az 0 en fazla 1 olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý birliði yayýn birliði komutlarýný kullanma %s", id, (pd == 1) ? ("yetkisi verdin."): ("yetkisini aldýn."));
			FactionData[id][FactionSanPerms] = pd;
			Faction_Save(id);
			return 1;
		}
	}
 	return 1;
}

Faction_Create(playerid, f_name[], f_abbrev[])
{
	new id = Iter_Free(Factions);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek birlik sýnýrýna ulaþýlmýþ.");

	format(FactionData[id][FactionName], 128, "%s", f_name);
	format(FactionData[id][FactionAbbrev], 128, "%s", f_abbrev);
	Iter_Add(Factions, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý birliði ekledin.", id);
    mysql_tquery(m_Handle, "INSERT INTO factions (Bank) VALUES(0)", "OnFactionCreated", "d", id);
	//Faction_Refresh(id);
	return 1;
}

Server:OnFactionCreated(id)
{
	FactionData[id][FactionID] = cache_insert_id();

	new query[66];
	mysql_format(m_Handle, query, sizeof(query), "INSERT INTO faction_ranks (faction_id) VALUES (%i)", FactionData[id][FactionID]);
	mysql_tquery(m_Handle, query);

	Faction_Save(id);
	return 1;
}

Faction_Save(id)
{
	new
	    query[454];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE factions SET Name = '%e', Abbreviation = '%e', MaxRanks = %i, EditRank = %i, ChatRank = %i, TowRank = %i, ChatColor = %i, ChatStatus = %i WHERE id = %i",
	    FactionData[id][FactionName],
	    FactionData[id][FactionAbbrev],
	    FactionData[id][FactionMaxRanks],
	    FactionData[id][FactionEditrank],
	    FactionData[id][FactionChatrank],
	    FactionData[id][FactionTowrank],
	    FactionData[id][FactionChatColor],
	    FactionData[id][FactionChatStatus],
	    FactionData[id][FactionID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE factions SET CopPerms = %i, MedPerms = %i, SanPerms = %i, SpawnX = %f, SpawnY = %f, SpawnZ = %f, SpawnA = %f, SpawnInt = %i, SpawnWorld = %i, Bank = %i WHERE id = %i",
	    FactionData[id][FactionCopPerms],
	    FactionData[id][FactionMedPerms],
	    FactionData[id][FactionSanPerms],
	    FactionData[id][FactionSpawn][0],
	    FactionData[id][FactionSpawn][1],
	    FactionData[id][FactionSpawn][2],
	    FactionData[id][FactionSpawn][3],
	    FactionData[id][FactionSpawnInterior],
	    FactionData[id][FactionSpawnVW],
	    FactionData[id][FactionBank],
	    FactionData[id][FactionID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE factions SET ExSpawn1X = %f, ExSpawn1Y = %f, ExSpawn1Z = %f, ExSpawn1Int = %i, ExSpawn1World = %i WHERE id = %i",
	    FactionData[id][FactionSpawnEx1][0],
	    FactionData[id][FactionSpawnEx1][1],
	    FactionData[id][FactionSpawnEx1][2],
	    FactionData[id][FactionSpawnEx1][3],
	    FactionData[id][FactionSpawnEx1Interior],
	    FactionData[id][FactionSpawnEx1VW],
	    FactionData[id][FactionID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE factions SET ExSpawn2X = %f, ExSpawn2Y = %f, ExSpawn2Z = %f, ExSpawn2Int = %i, ExSpawn2World = %i WHERE id = %i",
	    FactionData[id][FactionSpawnEx2][0],
	    FactionData[id][FactionSpawnEx2][1],
	    FactionData[id][FactionSpawnEx2][2],
	    FactionData[id][FactionSpawnEx2][3],
	    FactionData[id][FactionSpawnEx2Interior],
	    FactionData[id][FactionSpawnEx2VW],
	    FactionData[id][FactionID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE factions SET ExSpawn3X = %f, ExSpawn3Y = %f, ExSpawn3Z = %f, ExSpawn3Int = %i, ExSpawn3World = %i WHERE id = %i",
	    FactionData[id][FactionSpawnEx3][0],
	    FactionData[id][FactionSpawnEx3][1],
	    FactionData[id][FactionSpawnEx3][2],
	    FactionData[id][FactionSpawnEx3][3],
	    FactionData[id][FactionSpawnEx3Interior],
	    FactionData[id][FactionSpawnEx3VW],
	    FactionData[id][FactionID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

Faction_SaveRanks(id)
{
	new
		query[456];

	for(new i = 1; i < MAX_FACTION_RANKS; i++)
	{
		mysql_format(m_Handle, query, sizeof(query), "UPDATE faction_ranks SET factionrank%i = '%e' WHERE faction_id = %i", i, FactionRanks[id][i], FactionData[id][FactionID]);
		mysql_tquery(m_Handle, query);
		
		mysql_format(m_Handle, query, sizeof(query), "UPDATE faction_ranks SET factionranksalary%i = %i WHERE faction_id = %i", i, FactionRanksSalary[id][i], FactionData[id][FactionID]);
		mysql_tquery(m_Handle, query);
	}
	return 1;
}
