//FD Commands:
CMD:opbitir(playerid, params[])
{
	if(!IsMedicFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pMEDduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak i�in i�ba��nda olman gerekiyor.");

	new
		playerb,
		str[128];

	if(sscanf(params, "u", playerb)) return SendClientMessage(playerid, COLOR_GREY, "KULLANIM: /opbitir [oyuncuID/isim]");
	if(!IsPlayerConnected(playerb)) return SendClientMessage(playerid, COLOR_GREY, "HATA: Girdi�in oyuncu ID veya isim aktif de�il.");
	if(playerb == playerid) return SendClientMessage(playerid, COLOR_GREY, "HATA: Kendi kendini iyile�tiremezsin.");
	if(!GetDistanceBetweenPlayers(playerid, playerb, 6.0)) return SendClientMessage(playerid, COLOR_GREY, "SERVER: Bu ki�iye yak�n de�ilsin..");
	if(GetPlayerTeam(playerb) != STATE_WOUNDED) return SendClientMessage(playerid, COLOR_GREY, "SERVER: Ki�inin yaral� olmas� gerek.");

	PlayerData[playerb][pBrutallyWounded] = 0;

	SetPlayerTeam(playerb, STATE_ALIVE);
	SetPlayerHealth(playerb, 50);

	format(str, sizeof(str), "** HQ: %s %s, %s �st�nde operasyonunu bitirdi! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0), ReturnName(playerb));
	SendFDMessage(COLOR_EMT, str);

	format(str, sizeof(str), "%s revived %s with \"/opbitir\".", ReturnName(playerid), ReturnName(playerb));
	adminWarn(1, str);

	SendClientMessageEx(playerid, COLOR_EMT, "SERVER: %s �zerinde operasyonunu bitirdin.", ReturnName(playerb, 0));
	SendClientMessageEx(playerb, COLOR_EMT, "SERVER: %s taraf�ndan iyile�tirildin.", ReturnName(playerid, 0));
	return 1;
}

CMD:ates(playerid, params[])
{
	if(!IsMedicFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pMEDduty]) return SendErrorMessage(playerid, "Bu komutu kullanmak i�in i�ba��nda olman gerekiyor.");

    Fire_RouteCommands(playerid, params);
	return 1;
}

Fire_RouteCommands(playerid, cmdtext[])
{
    new command[6];
    sscanf(cmdtext, "s[8]", command);

	if(strlen(command) == 0) {
		SendClientMessage(playerid, COLOR_GREY, "KULLANIM: /ates [komut]");
		SendClientMessage(playerid, COLOR_GREY, "�pucu: '/ates yardim' yazarak t�m listeyi g�rebilirsin.");
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
	if(EditingObject[playerid]) return SendErrorMessage(playerid, "�u anda ba�ka bir obje d�zenliyorsun.");
	Fire_Create(playerid);
    return 1;
}

FireCMD_Delete(const playerid)
{
	if(EditingObject[playerid]) return SendErrorMessage(playerid, "�u anda ba�ka bir obje d�zenliyorsun.");

	new id;
	if((id = Fire_Nearest(playerid)) != -1)
	{
		ConfirmDialog(playerid, "Onay", "{FFFFFF}Yak�n�ndaki '{ADC3E7}yang�n ate�i{FFFFFF}' objesini kald�rmak konusunda emin misin?", "OnFireDisband", id);
	}
	else SendErrorMessage(playerid, "Yak�n�nda yang�n ate�i bulunmuyor.");
    return 1;
}

Server:OnFireDisband(playerid, response, id)
{
	if(response)
	{
		SendFDMessage(COLOR_EMT, sprintf("** HQ: %s %s, %s konumundaki yang�n ate�ini kald�rd�! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0), FireData[id][fire_location]));
		Fire_Destroy(id);
	}
	return 1;
}

FireCMD_Edit(const playerid)
{
	if(EditingObject[playerid]) return SendErrorMessage(playerid, "�u anda ba�ka bir obje d�zenliyorsun.");

	new id;
	if((id = Fire_Nearest(playerid)) != -1)
	{
	    if(FireData[id][f_is_editing]) return SendErrorMessage(playerid, "�u anda ba�ka bu obje ba�kas� taraf�ndan d�zenleniyor.");

		EditingID[playerid] = id;
		EditingObject[playerid] = 8;
		FireData[id][f_is_editing] = true;
		EditDynamicObject(playerid, FireData[id][fire_object]);
	}
	else SendErrorMessage(playerid, "Yak�n�nda yang�n ate�i bulunmuyor.");
    return 1;
}

FireCMD_List(const playerid) {

	new
		fire_found,
		liststr[256];

    foreach(new i : Fires)
	{
		fire_found++;
		format(liststr, sizeof(liststr), "%sYang�n Ate�i {AFAFAF}[%s - %s]\n", liststr, FireData[i][fire_placedby], FireData[i][fire_location]);
	}

	if(fire_found) return ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_LIST, "FD: Aktif Yang�n Objeleri", liststr, "Tamam", "<<");
	else ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_LIST, "FD: Aktif Yang�n Objeleri", "Hi� yang�n objesi bulunamad�.", "Tamam", "<<");
	return 1;
}

FireCMD_Help(const playerid) {
	SendClientMessage(playerid, COLOR_ORANGE, "Yang�n Sistemi:");
	SendClientMessage(playerid, COLOR_ORANGE, "/ates ekle - Yak�n�n�za ate� eklemeyi sa�lar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/ates kaldir - Yak�n�n�zdaki ate�i kald�rmay� sa�lar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/ates duzenle - Yak�n�n�zdaki ate�i d�zenlemenizi sa�lar.");
	SendClientMessage(playerid, COLOR_ORANGE, "/ates liste - Eklenmi� ate�leri g�rmenizi sa�lar.");
	return 1;
}
