CMD:me(playerid, params[])
{
	if(isnull(params)) return SendUsageMessage(playerid, "/me [eylem]");

	if(strlen(params) > 84)
	{
	    SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s %.84s", ReturnName(playerid, 0), params);
	    SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "...%s", params[84]);
	}
	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s %s", ReturnName(playerid, 0), params);
	return 1;
}

CMD:melow(playerid, params[])
{
	if(isnull(params)) return SendUsageMessage(playerid, "/melow [eylem]");

	if(strlen(params) > 84)
	{
	    SendNearbyMessage(playerid, 10.0, COLOR_EMOTE, "* %s %.84s", ReturnName(playerid, 0), params);
	    SendNearbyMessage(playerid, 10.0, COLOR_EMOTE, "...%s", params[84]);
	}
	else SendNearbyMessage(playerid, 10.0, COLOR_EMOTE, "* %s %s", ReturnName(playerid, 0), params);
	return 1;
}

CMD:my(playerid, params[])
{
	if(isnull(params)) return SendUsageMessage(playerid, "/my [eylem]");

	if(strlen(params) > 84)
	{
	    SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s %.84s", ReturnName(playerid, 0), params);
	    SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "...%s", params[84]);
	}
	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s %s", ReturnName(playerid, 0), params);
	return 1;
}

CMD:amy(playerid, params[])
{
	if(PlayerData[playerid][pBrutallyWounded]) return SendServerMessage(playerid, "Þu anda bunu yapamazsýn.");
	if(isnull(params)) return SendUsageMessage(playerid, "/amy [eylem]");

	SetPlayerChatBubble(playerid, sprintf("* %s %s", ReturnName(playerid, 0), params), COLOR_EMOTE, 25.0, 10000);
	SendClientMessageEx(playerid, COLOR_EMOTE, "> %s %s", ReturnName(playerid, 0), params);
	return 1;
}

CMD:do(playerid, params[])
{
	if(isnull(params)) return SendUsageMessage(playerid, "/do [eylem]");

	if(strlen(params) > 84)
	{
	    SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %.84s", params);
	    SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "...%s (( %s ))", params[84], ReturnName(playerid, 0));
	}
	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s (( %s ))", params, ReturnName(playerid, 0));
	return 1;
}

CMD:dolow(playerid, params[])
{
	if(isnull(params)) return SendUsageMessage(playerid, "/dolow [eylem]");

	if(strlen(params) > 84)
	{
	    SendNearbyMessage(playerid, 10.0, COLOR_EMOTE, "* %.84s", params);
	    SendNearbyMessage(playerid, 10.0, COLOR_EMOTE, "...%s (( %s ))", params[84], ReturnName(playerid, 0));
	}
	else SendNearbyMessage(playerid, 10.0, COLOR_EMOTE, "* %s (( %s ))", params, ReturnName(playerid, 0));
	return 1;
}

CMD:ame(playerid, params[])
{
	if(PlayerData[playerid][pBrutallyWounded]) return SendServerMessage(playerid, "Þu anda bunu yapamazsýn.");
	if(isnull(params)) return SendUsageMessage(playerid, "/ame [eylem]");

	SetPlayerChatBubble(playerid, sprintf("* %s %s", ReturnName(playerid, 0), params), COLOR_EMOTE, 25.0, 10000);
	SendClientMessageEx(playerid, COLOR_EMOTE, "> %s %s", ReturnName(playerid, 0), params);
	return 1;
}

CMD:sme(playerid, params[])
{
	if(PlayerData[playerid][pBrutallyWounded]) return SendServerMessage(playerid, "Þu anda bunu yapamazsýn.");

	new time, msg[128];
	if(sscanf(params, "is[128]", time, msg)) return SendUsageMessage(playerid, "/sme [süre(1-120 saniye)] [eylem]");
    if(time < 1 || time > 120) return SendServerMessage(playerid, "Süre en az 1 en fazla 120 saniye olmalýdýr.");
	if(strlen(msg) > 128) return SendServerMessage(playerid, "Eylem içeriði en fazla 128 karakteri olmalýdýr.");

	SetPlayerChatBubble(playerid, sprintf("* %s %s", ReturnName(playerid, 0), msg), COLOR_EMOTE, 25.0, time*1000);
	SendClientMessageEx(playerid, COLOR_EMOTE, "> %s %s", ReturnName(playerid, 0), msg);
	return 1;
}

CMD:vme(playerid, params[])
{
    if(!HaveVME[playerid])
    {
		new vehicleid = INVALID_VEHICLE_ID;

		if(!IsPlayerInAnyVehicle(playerid))
			vehicleid = GetNearestVehicle(playerid);
		else
			vehicleid = GetPlayerVehicleID(playerid);

		if(vehicleid == INVALID_VEHICLE_ID) return SendServerMessage(playerid, "Yakýnýnda araç yok.");
		if(CarData[vehicleid][carLocked] && !PlayerData[playerid][pAdminDuty]) return SendServerMessage(playerid, "Bu araç kilitli.");

  		new time, msg[31];
    	if(sscanf(params, "ds[31]", time, msg)) return SendUsageMessage(playerid, "/vme [süre(1-15 dk.)] [mesaj]");
	    if(time < 1 || time > 15) return SendServerMessage(playerid, "Süre dakika cinsinden en az 1 en fazla 15 olmalýdýr.");
		if(strlen(msg) > 30) return SendServerMessage(playerid, "Mesajýnýzýn içeriði 30 karakteri geçmemelidir.");

		static
    		Float:fSize[3],
    		Float:fSeat[3];

	    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]);
		GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONTSEAT, fSeat[0], fSeat[1], fSeat[2]);

	    VME[playerid] = Create3DTextLabel(sprintf("(( %s )) %s", ReturnName(playerid, 1), msg), COLOR_EMOTE, -fSeat[0], fSeat[1], fSize[2] / 2.0, 25.0, 0, 0);
	    Attach3DTextLabelToVehicle(VME[playerid], vehicleid, 0.0, 0.0, 1.0);

	    TimerVME[playerid] = SetTimerEx("DestroyVME", time*60000, false, "i", playerid);
 	   	HaveVME[playerid] = 1;

 	   	SendClientMessageEx(playerid, COLOR_ADM, "[!] {FFFFFF}Mesajýnýzýn baþarýyla araca sabitlendi, %d dakika sonra otomatik olarak silinecektir.", time);
 	   	SendClientMessage(playerid, COLOR_ADM, "Araç mesajýný silmek isterseniz tekrardan /vme yazabilirsiniz.");
    } else {
        SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}Araca sabitlediðiniz mesaj baþarýyla silindi.");
		Delete3DTextLabel(VME[playerid]);
	    KillTimer(TimerVME[playerid]);
		HaveVME[playerid] = 0;
    }
    return 1;
}

Server:DestroyVME(playerid)
{
    Delete3DTextLabel(VME[playerid]);
    if(IsPlayerConnected(playerid)) KillTimer(TimerVME[playerid]), HaveVME[playerid] = 0;
    return 1;
}