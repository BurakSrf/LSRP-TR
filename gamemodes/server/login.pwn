Server:OnApplicationCheck(playerid, race_check)
{
	if(race_check != g_MysqlRaceCheck[playerid])
 	{
		SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Hata olu�tu, l�tfen tekrar giri� yap�n�z.");
 	    KickEx(playerid);
 	    return 1;
 	}

	if(!cache_num_rows())
	{
		SendErrorMessage(playerid, "%s ge�erli bir ba�vuru bekleyen karakter ad� de�il.", ReturnName(playerid));
		SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Giri� yapmak i�in bir karakter ad� de�il, (ana) hesap ad�n�z� kulland���n�zdan emin olun!");
		SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Bir hesap olu�turmak i�in l�tfen https://ls-rp.web.tr/ adresini ziyaret edin.");
		KickEx(playerid);
		return 1;
	}

	cache_get_value_name_int(0, "id", PlayerData[playerid][pSQLID]);
	cache_get_value_name_int(0, "AccountID", AccountData[playerid][mSQLID]);
	LoadLoginDialogApp(playerid);
	return 1;
}

LoadLoginDialogApp(playerid, error[] = "")
{
	new
		string[330];

	if(isnull(error)) string = "Merhaba,\n\nKarakter se�imine eri�mek i�in l�tfen a�a��ya �ifrenizi girin.\n\n�u anda kay�tl� bir LS-RP hesab�n bulunmuyorsa, www.ls-rp.web.tr\n\nadresinden yaratman gerekiyor.";
	else format(string, sizeof(string), "Merhaba,\n\nKarakter se�imine eri�mek i�in l�tfen a�a��ya �ifrenizi girin.\n\n�u anda kay�tl� bir LS-RP hesab�n bulunmuyorsa, www.ls-rp.web.tr\n\nadresinden yaratman gerekiyor.\n\n%s", error);
	Dialog_Show(playerid, LOGIN_APP, DIALOG_STYLE_PASSWORD, "Los Santos Roleplay'e Ho�geldin", string, "Giri�", "��k��");
	return 1;
}

Dialog:LOGIN_APP(playerid, response, listitem, inputtext[])
{
    if(!response) {
        return Kick(playerid);
    }

    new query[128 + 129];
    mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM `players` WHERE id = '%d' AND password = '%s'", AccountData[playerid][mSQLID], inputtext);
    mysql_tquery(m_Handle, query, "OnAccountLoginApp", "d", playerid);
    return 1;
}

Server:OnAccountLoginApp(playerid)
{
    new rows;

    cache_get_row_count(rows);
    if (!rows)
    {
		KickEx(playerid);
        return 1;
    }

    SendClientMessageEx(playerid, COLOR_WHITE, "SERVER: Ho�geldin %s.", ReturnName(playerid, 0));
    SendClientMessage(playerid, COLOR_ADM, "NOT: Bir ba�vuru olu�turana ve karakter ba�vurun kabul edilene kadar oynayamayacaks�n.");
    SendClientMessage(playerid, COLOR_ADM, "ZIYARET ET: forum.ls-rp.web.tr");
    SendClientMessage(playerid, COLOR_ADM, "Karakter ba�vurun hen�z kabul edilmedi!");
    SendClientMessage(playerid, COLOR_ADM, "Sayg�lar�m�zla, LS-RP Y�netim Ekibi.");

    new query[354];
    mysql_format(m_Handle, query, sizeof(query), "UPDATE accounts SET reg_hwid = '%e', last_game_time = %i, last_game_ip = '%e' WHERE id = %i", ReturnGPCI(playerid), Time(), ReturnIP(playerid), AccountData[playerid][mSQLID]);
    mysql_tquery(m_Handle, query);

    mysql_format(m_Handle, query, sizeof(query), "UPDATE players SET IsLogged = 1, LastIP = %i, HWID = '%e' WHERE id = %i", ReturnIP(playerid), ReturnGPCI(playerid), PlayerData[playerid][pSQLID]);
    mysql_tquery(m_Handle, query);

    KickEx(playerid);
    return 1;
}

Server:OnAccountCheck(playerid, race_check)
{
	if(race_check != g_MysqlRaceCheck[playerid])
 	{
		SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Hata olu�tu, l�tfen tekrar giri� yap�n�z.");
 	    KickEx(playerid);
 	    return 1;
 	}

	if(!cache_num_rows())
	{
		SendErrorMessage(playerid, "%s ge�erli bir hesap ad� de�il.", ReturnName(playerid));
		SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Giri� yapmak i�in bir karakter ad� de�il, (ana) hesap ad�n�z� kulland���n�zdan emin olun!");
		SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Bir hesap olu�turmak i�in l�tfen https://ls-rp.web.tr/ adresini ziyaret edin.");
		KickEx(playerid);
		return 1;
	}

	new active_id;
	cache_get_value_name_int(0, "active_id", active_id);

	if(active_id == 0)
	{
		SendErrorMessage(playerid, "%s hesab�nda aktif olarak se�ilmi� bir karakter bulunamad�.", ReturnName(playerid));
		SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Giri� yapmak i�in bir panel �zerinden bir karakterinizi se�ti�inizden emin olun!");
		SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Bir hesap olu�turmak i�in l�tfen https://ls-rp.web.tr/ adresini ziyaret edin.");
		KickEx(playerid);
		return 1;
	}

	cache_get_value_name_int(0, "id", AccountData[playerid][mSQLID]);

	new query[125]; 
	mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM bans WHERE ban_ip = '%e' AND active = 1 OR ban_accountid = %i AND active = 1", ReturnIP(playerid), AccountData[playerid][mSQLID]);
	mysql_tquery(m_Handle, query, "OnAttemptLogin", "i", playerid);
	return 1;
}

Server:OnAttemptLogin(playerid)
{
	if(cache_num_rows())
	{
		new char_name[25], reason[35];
		cache_get_value_name(0, "ban_name", char_name, sizeof(char_name));
		cache_get_value_name(0, "reason", reason, sizeof(reason));

	    SendClientMessageEx(playerid, COLOR_RED, "SERVER: %s isimli karakteriniz %s sebebiyle sunucudan yasakl�.", char_name, reason);
		SendClientMessage(playerid, COLOR_GREY, "SERVER: Hatal� yasaklanmalar i�in forumdan konu a�abilirsiniz.");
		KickEx(playerid);
	    return 1;
	}

	LoadLoginDialog(playerid);
	return 1;
}

LoadLoginDialog(playerid, error[] = "")
{
	new
		string[330];

	if(isnull(error)) string = "Merhaba,\n\nKarakter se�imine eri�mek i�in l�tfen a�a��ya �ifrenizi girin.\n\n�u anda kay�tl� bir LS-RP hesab�n bulunmuyorsa, www.ls-rp.web.tr\n\nadresinden yaratman gerekiyor.";
	else format(string, sizeof(string), "Merhaba,\n\nKarakter se�imine eri�mek i�in l�tfen a�a��ya �ifrenizi girin.\n\n�u anda kay�tl� bir LS-RP hesab�n bulunmuyorsa, www.ls-rp.web.tr\n\nadresinden yaratman gerekiyor.\n\n%s", error);
	Dialog_Show(playerid, LOGIN, DIALOG_STYLE_PASSWORD, "Los Santos Roleplay'e Ho�geldin", string, "Giri�", "��k��");
	return 1;
}

Dialog:LOGIN(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return Kick(playerid);
	}

	new query[128 + 129];

	mysql_format(m_Handle, query, sizeof(query), "SELECT last_game_ip FROM accounts WHERE id = %i AND password = '%e'", AccountData[playerid][mSQLID], inputtext);
	mysql_tquery(m_Handle, query, "OnAccountLogin", "i", playerid);
	return 1;
}

Server:OnAccountLogin(playerid)
{
	if(!cache_num_rows())
	{
		if(GetPVarInt(playerid, "LA") == 1) 
		{
			SendClientMessage(playerid, COLOR_ADM, "HATA: {FFFFFF}�ifre denemesinde birden fazla kez ba�ar�s�z oldunuz.");
			KickEx(playerid);
			return 1;
		}

		LoadLoginDialog(playerid, sprintf("{FF0000}Hatal� �ifre girdin, kalan deneme: %i.", (GetPVarInt(playerid, "LA")-1)));
		SetPVarInt(playerid, "LA", GetPVarInt(playerid, "LA") - 1);
	    return 1;
	}

	cache_get_value_name(0, "last_game_ip", AccountData[playerid][mLastIP], 16);

	if(strcmp(ReturnIP(playerid), AccountData[playerid][mLastIP]))
	{
		Dialog_Show(playerid, SECRETWORD, DIALOG_STYLE_PASSWORD, "Los Santos Roleplay: Ho� Geldin!",
		"{FF6347}G�VENL�K �NLEM�:\n\n\
		{FFFFFF}Sistemimiz, hesap ba�lant� ko�ullar�n�zdaki de�i�iklikleri alg�lad�.\n\
		G�venli�inizin ihlal edilmedi�inden emin olmak ve oturuma devam etmek i�in\n\
		kay�t s�ras�nda se�ti�iniz {FF6347}G�VENL�K KEL�MES�N� {FFFFFF}girin.", "Tamam", "�ptal");
		return 1;
	}

	new query[128]; 
	mysql_format(m_Handle, query, sizeof(query), "UPDATE accounts SET last_game_time = %i, last_game_ip = '%e' WHERE id = %i", Time(), ReturnIP(playerid), AccountData[playerid][mSQLID]);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "SELECT players.*, accounts.active_id FROM players INNER JOIN accounts ON accounts.id = players.AccountID WHERE accounts.active_id != 0 AND players.AccountStatus = 1 AND accounts.id = %i", AccountData[playerid][mSQLID]);
	mysql_tquery(m_Handle, query, "OnCharacterList", "i", playerid);
	return 1;
}

Dialog:SECRETWORD(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		SendClientMessage(playerid, COLOR_ADM, "SERVER: G�venlik kelimesini girmedi�in i�in at�ld�n.");
		KickEx(playerid);
		return 1;
	}

	new query[454], hashed_secretword[129];
	WP_Hash(hashed_secretword, sizeof(hashed_secretword), inputtext);
	mysql_format(m_Handle, query, sizeof(query), "SELECT id, secret FROM accounts WHERE id = %i AND memorable_word = '%e'", AccountData[playerid][mSQLID], hashed_secretword);
	mysql_tquery(m_Handle, query, "OnAccountLoginConfirm", "i", playerid);
	return 1;
}

Server:OnAccountLoginConfirm(playerid)
{
	if(!cache_num_rows())
	{
		SendClientMessage(playerid, COLOR_ADM, "SERVER: G�venlik kelimesini hatal� girdi�in i�in at�ld�n.");
		KickEx(playerid);
		return 1;
	}

	new query[128]; 
	mysql_format(m_Handle, query, sizeof(query), "UPDATE accounts SET last_game_time = %i, last_game_ip = '%e' WHERE id = %i", Time(), ReturnIP(playerid), AccountData[playerid][mSQLID]);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM players WHERE accountid = %i AND status = 1", AccountData[playerid][mSQLID]);
	mysql_tquery(m_Handle, query, "OnCharacterList", "i", playerid);

	SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Te�ekk�rler, sunucu ile olan ba�lant�n do�ruland�.");
	return 1;
}

Server:OnCharacterList(playerid)
{
	if(!cache_num_rows())
	{
		SendClientMessage(playerid, COLOR_GREY, "SERVER: Aktif bir karakterin bulunamad�.");
		KickEx(playerid);
		return 1;
	}

	new Float: base_x = 244.000000,
		Float: base_y = 131.000000,
		Float: base_name_x = 246.000000,
		Float: base_name_y = 135.000000;

	new names[3][24], levels[3], skins[3];

	for (new i = 0, j = cache_num_rows(); i < j; i ++)
	{
		cache_get_value_name_int(i, "id", CharacterHolder[playerid][i]);
		
		cache_get_value_name(i, "Name", names[i], 24);
		cache_get_value_name_int(i, "Level", levels[i]);
		cache_get_value_name_int(i, "Skin", skins[i]);

		switch(i)
		{
			case 1: base_x = 74.000000, base_name_x = 76.000000;
			case 2: base_x = 415.000000, base_name_x = 417.000000;
		}

		Character_Preview[playerid][i] = CreatePlayerTextDraw(playerid, base_x, base_y, "_");
	    PlayerTextDrawLetterSize(playerid, Character_Preview[playerid][i], 0.600000, 2.000000);
	    //PlayerTextDrawTextSize(playerid, Character_Preview[playerid][i], 152.000000, 170.000000);
	    PlayerTextDrawTextSize(playerid, Character_Preview[playerid][i], 152.000000, 170.000000);
	    PlayerTextDrawAlignment(playerid, Character_Preview[playerid][i], 1);
	    PlayerTextDrawColor(playerid, Character_Preview[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, Character_Preview[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, Character_Preview[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, Character_Preview[playerid][i], 125);
		PlayerTextDrawFont(playerid, Character_Preview[playerid][i], TEXT_DRAW_FONT_MODEL_PREVIEW);
		PlayerTextDrawSetProportional(playerid, Character_Preview[playerid][i], 0);
		PlayerTextDrawSetPreviewModel(playerid, Character_Preview[playerid][i], skins[i]);
		PlayerTextDrawSetPreviewRot(playerid, Character_Preview[playerid][i], -10.000000, 0.000000, -7.000000, 1.099997);
		PlayerTextDrawSetPreviewVehCol(playerid, Character_Preview[playerid][i], 1, 1);
		PlayerTextDrawSetSelectable(playerid, Character_Preview[playerid][i], 1);
	    PlayerTextDrawBoxColor(playerid, Character_Preview[playerid][i], 0);
		PlayerTextDrawUseBox(playerid, Character_Preview[playerid][i], 0);
	    PlayerTextDrawShow(playerid, Character_Preview[playerid][i]);

		Character_Preview_Name[playerid][i] = CreatePlayerTextDraw(playerid, base_name_x, base_name_y, sprintf("%s~n~Level_%i", names[i], levels[i]));
		PlayerTextDrawFont(playerid, Character_Preview_Name[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, Character_Preview_Name[playerid][i], 0.200000, 1.000000);
		PlayerTextDrawTextSize(playerid, Character_Preview_Name[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, Character_Preview_Name[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, Character_Preview_Name[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, Character_Preview_Name[playerid][i], 1);
		PlayerTextDrawColor(playerid, Character_Preview_Name[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, Character_Preview_Name[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, Character_Preview_Name[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, Character_Preview_Name[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, Character_Preview_Name[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, Character_Preview_Name[playerid][i], 0);
		PlayerTextDrawShow(playerid, Character_Preview_Name[playerid][i]);
	}

	Character_Logo[playerid] = CreatePlayerTextDraw(playerid, 211.000000, 43.000000, "mdl-2001:lsrp-logo");
	PlayerTextDrawFont(playerid, Character_Logo[playerid], 4);
	PlayerTextDrawLetterSize(playerid, Character_Logo[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Character_Logo[playerid], 221.000000, 77.500000);
	PlayerTextDrawSetOutline(playerid, Character_Logo[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Character_Logo[playerid], 0);
	PlayerTextDrawAlignment(playerid, Character_Logo[playerid], 1);
	PlayerTextDrawColor(playerid, Character_Logo[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Character_Logo[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Character_Logo[playerid], 50);
	PlayerTextDrawUseBox(playerid, Character_Logo[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Character_Logo[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Character_Logo[playerid], 0);
	PlayerTextDrawShow(playerid, Character_Logo[playerid]);

	SelectTextDraw(playerid, COLOR_GREY);
	return 1;
}

Selection_Hide(playerid)
{	
	for(new x = 0; x < 3; x++)
	{
	    if(Character_Preview[playerid][x] != PlayerText:INVALID_TEXT_DRAW) 
	    {
			PlayerTextDrawDestroy(playerid, Character_Preview[playerid][x]);
			PlayerTextDrawDestroy(playerid, Character_Preview_Name[playerid][x]);

			Character_Preview[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
			Character_Preview_Name[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
		}
	}

	PlayerTextDrawDestroy(playerid, Character_Logo[playerid]);
    Character_Logo[playerid] = PlayerText:INVALID_TEXT_DRAW;
    SetPVarInt(playerid, "Viewing_CharacterList", 0);
    CancelSelectTextDraw(playerid);
	return 1;
}

LoadPlayerData(playerid, sqlid)
{
	new query[70];
	mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM players WHERE id = %i LIMIT 1", sqlid);
	mysql_tquery(m_Handle, query, "SQL_LoadPlayerData", "i", playerid);
	return 1;
}
