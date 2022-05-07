//FD Commands:
CMD:opbitir(playerid, params[])
{
	if(!IsMedicFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pMEDduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

	new
		playerb,
		str[128];

	if(sscanf(params, "u", playerb)) return SendClientMessage(playerid, COLOR_GREY, "KULLANIM: /opbitir [oyuncuID/isim]");
	if(!IsPlayerConnected(playerb)) return SendClientMessage(playerid, COLOR_GREY, "HATA: Girdiðin oyuncu ID veya isim aktif deðil.");
	if(playerb == playerid) return SendClientMessage(playerid, COLOR_GREY, "HATA: Kendi kendini iyileþtiremezsin.");
	if(!GetDistanceBetweenPlayers(playerid, playerb, 6.0)) return SendClientMessage(playerid, COLOR_GREY, "SERVER: Bu kiþiye yakýn deðilsin..");
	if(GetPlayerTeam(playerb) != STATE_WOUNDED) return SendClientMessage(playerid, COLOR_GREY, "SERVER: Kiþinin yaralý olmasý gerek.");

	PlayerData[playerb][pBrutallyWounded] = 0;

	SetPlayerTeam(playerb, STATE_ALIVE);
	SetPlayerHealth(playerb, 50);

	format(str, sizeof(str), "** HQ: %s %s, %s üstünde operasyonunu bitirdi! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0), ReturnName(playerb));
	SendFDMessage(COLOR_EMT, str);

	format(str, sizeof(str), "%s revived %s with \"/opbitir\".", ReturnName(playerid), ReturnName(playerb));
	adminWarn(1, str);

	SendClientMessageEx(playerid, COLOR_EMT, "SERVER: %s üzerinde operasyonunu bitirdin.", ReturnName(playerb, 0));
	SendClientMessageEx(playerb, COLOR_EMT, "SERVER: %s tarafýndan iyileþtirildin.", ReturnName(playerid, 0));
	return 1;
}

CMD:ates(playerid, params[])
{
	if(!IsMedicFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pMEDduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

    Fire_RouteCommands(playerid, params);
	return 1;
}

Fire_RouteCommands(playerid, cmdtext[])
{
    new command[6];
    sscanf(cmdtext, "s[8]", command);

	if(strlen(command) == 0) {
		SendClientMessage(playerid, COLOR_GREY, "KULLANIM: /ates [komut]");
		SendClientMessage(playerid, COLOR_GREY, "Ýpucu: '/ates yardim' yazarak tüm listeyi görebilirsin.");
		return 1;
	}

    if(strcmp("ekle", command) == 0) FireCMD_Create(playerid);
    else if(strcmp("kaldir", command) == 0) FireCMD_Delete(playerid);
    else if(strcmp("duzenle", command) == 0) FireCMD_Edit(playerid);
	else if(strcmp("liste", command) == 0) FireCMD_List(playerid);
 	else if(strcmp("yardim", command) == 0) FireCMD_Help(playerid);
	return 1;
}

FireCMD_Create(const playerid)
{
	if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");
	Fire_Create(playerid);
    return 1;
}

FireCMD_Delete(const playerid)
{
	if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

	new id;
	if((id = Fire_Nearest(playerid)) != -1)
	{
		ConfirmDialog(playerid, "Onay", "{FFFFFF}Yakýnýndaki '{ADC3E7}yangýn ateþi{FFFFFF}' objesini kaldýrmak konusunda emin misin?", "OnFireDisband", id);
	}
	else SendErrorMessage(playerid, "Yakýnýnda yangýn ateþi bulunmuyor.");
    return 1;
}

Server:OnFireDisband(playerid, response, id)
{
	if(response)
	{
		SendFDMessage(COLOR_EMT, sprintf("** HQ: %s %s, %s konumundaki yangýn ateþini kaldýrdý! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0), FireData[id][fire_location]));
		Fire_Destroy(id);
	}
	return 1;
}

FireCMD_Edit(const playerid)
{
	if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

	new id;
	if((id = Fire_Nearest(playerid)) != -1)
	{
	    if(FireData[id][f_is_editing]) return SendErrorMessage(playerid, "Þu anda baþka bu obje baþkasý tarafýndan düzenleniyor.");

		EditingID[playerid] = id;
		EditingObject[playerid] = 8;
		FireData[id][f_is_editing] = true;
		EditDynamicObject(playerid, FireData[id][fire_object]);
	}
	else SendErrorMessage(playerid, "Yakýnýnda yangýn ateþi bulunmuyor.");
    return 1;
}

FireCMD_List(const playerid) {

	new
		fire_found,
		liststr[256];

    foreach(new i : Fires)
	{
		fire_found++;
		format(liststr, sizeof(liststr), "%sYangýn Ateþi {AFAFAF}[%s - %s]\n", liststr, FireData[i][fire_placedby], FireData[i][fire_location]);
	}

	if(fire_found) return ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_LIST, "FD: Aktif Yangýn Objeleri", liststr, "Tamam", "<<");
	else ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_LIST, "FD: Aktif Yangýn Objeleri", "Hiç yangýn objesi bulunamadý.", "Tamam", "<<");
	return 1;
}

FireCMD_Help(const playerid) {
	SendClientMessage(playerid, COLOR_ORANGE, "Yangýn Sistemi:");
	SendClientMessage(playerid, COLOR_ORANGE, "/ates ekle - Yakýnýnýza ateþ eklemeyi saðlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/ates kaldir - Yakýnýnýzdaki ateþi kaldýrmayý saðlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/ates duzenle - Yakýnýnýzdaki ateþi düzenlemenizi saðlar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/ates liste - Eklenmiþ ateþleri görmenizi saðlar.");
	return 1;
}
