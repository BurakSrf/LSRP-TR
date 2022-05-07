Clothing_Menu(playerid, listitem)
{
	SetPVarInt(playerid, "ClothingID", listitem);

	new 
		primary[600], sub[128];

	new id = GetPVarInt(playerid, "ClothingID");

	format(sub, sizeof(sub), "�sim De�i�tir:\t[{FFFF00}%s{FFFFFF}]\n", ClothingData[playerid][id][ClothingName]);
	strcat(primary, sub);

	format(sub, sizeof(sub), "Kemik De�i�tir:\t[{FFFF00}%s{FFFFFF}]\n", Clothing_Bone(ClothingData[playerid][id][ClothingBoneID]));
	strcat(primary, sub);

	format(sub, sizeof(sub), "Slot De�i�tir:\t[{FFFF00}%i{FFFFFF}]\n", ClothingData[playerid][id][ClothingSlotID]);
	strcat(primary, sub);

	strcat(primary, "Rengini De�i�tir\n");
	strcat(primary, "�kincil Rengini De�i�tir\n");
	strcat(primary, "Aksesuar D�zenle\n");

	format(sub, sizeof(sub), "Aksesuar� {FFFF00}%s\n", IsPlayerAttachedObjectSlotUsed(playerid, ClothingData[playerid][id][ClothingSlotID]) ? "��kar" : "Giy");
	strcat(primary, sub);

	format(sub, sizeof(sub), "Her Giri�te Otomatik\t{FFFF00}%s\n", ClothingData[playerid][id][ClothingAutoWear] ? "Giy" : "Giyme");
	strcat(primary, sub);

	strcat(primary, "�o�alt");

	Dialog_Show(playerid, CLOTHING_EDIT, DIALOG_STYLE_TABLIST, ClothingData[playerid][id][ClothingName], primary, "Se�", "<< Kapat");
	return 1;
}

Dialog:CLOTHING_EDIT(playerid, response, listitem, inputtext[])
{
	if(!response) return cmd_aksesuar(playerid, "");

	new id = GetPVarInt(playerid, "ClothingID");
	switch(listitem)
	{
		case 0:
		{
			new primary[600];
			strcat(primary, "{FFFF00}Aksesuar�n�za �zel bir ad ekleme olana��n�z bulunuyor.\n");
			strcat(primary, "Bu �zellik, sahip olabilece�iniz bir �ok aksesuar� kolayca bulman�z� sa�lamak i�indir.\n\n");

			strcat(primary, "Aksesuar�n�z� g�r�nmesini istedi�iniz yeni ad�n� girin. Maksimum s�n�r 20 karakterdir.\n");
			strcat(primary, "Ayarlanm�� bir aksesuara sahipseniz, kald�rmak istiyorsan�z kutucu�u bo� b�rak�p ENTER tu�una bas�n.\n\n");

			strcat(primary, "{FF6347}[ ! ] UYARI: Bu �zelli�in k�t�ye kullan�lmas� cezaland�r�labilir. K�t�ye kullanma.\n");
			strcat(primary, "[ ! ] NOT: Bu aksesuar ad� sadece sizin taraf�n�zdan g�r�lebilir.");

			Dialog_Show(playerid, CLOTHING_NAME, DIALOG_STYLE_INPUT, "Aksesuar Ad�n� De�i�tir", primary, "Tamam", "<< Kapat");
		}
		case 1:
		{
			new 
				primary[454], sub[60];

			for(new j = 1; j <= 18; j++) 
			{
				format(sub, sizeof(sub), "%s %s\n", Clothing_Bone(j), ClothingData[playerid][id][ClothingBoneID] == j ? "({FFFF00}SE��L�{FFFFFF})" : "");
				strcat(primary, sub);
			}

			Dialog_Show(playerid, CLOTHING_BONE, DIALOG_STYLE_LIST, "Aksesuar Kemi�ini De�i�tir", primary, "Tamam", "<< Kapat");
		}
		case 2:
		{
			new 
				primary[200], sub[45];

			for(new j = 0; j <= 4; j++)
			{
				format(sub, sizeof(sub), "Index %i %s\n", j, ClothingData[playerid][id][ClothingSlotID] == j ? "({FFFF00}SE��L�{FFFFFF})" : "");
				strcat(primary, sub);
			}

			Dialog_Show(playerid, CLOTHING_INDEX, DIALOG_STYLE_LIST, "Aksesuar Slotunu De�i�tir", primary, "Tamam", "<< Kapat");
		}
		case 3:
		{
			new primary[350];
			strcat(primary, "{FFFFFF}�stedi�iniz rengin onalt�l�k de�erini girin.\n");
			strcat(primary, "\"{FFFF00}https://www.color-hex.com/{FFFFFF}\" websitesinden de�erlere bakabilirsin.\n");
			strcat(primary, "-Bi�im �u �ekilde olmal�d�r. \"{FFFF00}FFFF00{FFFFFF}\" (t�rnaklar hari�)\n");
			strcat(primary, "-Rengi s�f�rlamak i�in s�f�r (0) girebilirsiniz.\n\n");
			strcat(primary, "{FF6347}[ ! ] Aksesuar�n�z�n birincil rengini de�i�tirme olana��n�z bulunuyor.");
			Dialog_Show(playerid, CLOTHING_MAINCOLOR, DIALOG_STYLE_INPUT, "Aksesuar Rengini De�i�tir", primary, "Tamam", "<< Kapat");
		}
		case 4:
		{
			new primary[350];
			strcat(primary, "{FFFFFF}�stedi�iniz rengin onalt�l�k de�erini girin.\n");
			strcat(primary, "\"{FFFF00}https://www.color-hex.com/{FFFFFF}\" websitesinden de�erlere bakabilirsin.\n");
			strcat(primary, "-Bi�im �u �ekilde olmal�d�r. \"{FFFF00}FFFF00{FFFFFF}\" (t�rnaklar hari�)\n");
			strcat(primary, "-Rengi s�f�rlamak i�in s�f�r (0) girebilirsiniz.\n\n");
			strcat(primary, "{FF6347}[ ! ] Aksesuar�n�z�n birincil rengini de�i�tirme olana��n�z bulunuyor.");
			Dialog_Show(playerid, CLOTHING_SECONDARYCOLOR, DIALOG_STYLE_INPUT, "Aksesuar �kincil Rengini De�i�tir", primary, "Tamam", "<< Kapat");
		}
		case 5:
		{
	        if(PlayerData[playerid][pEditingClothing]) return SendServerMessage(playerid, "Aksesuar d�zenlemeyi bitirdikten sonra yeni bir tanesini d�zenleyebilirsin.");

	        //new slot_id = Clothing_IsSlotFree(playerid, ClothingData[playerid][id][ClothingSlotID]);
			//if(slot_id == -1) return SendServerMessage(playerid, "Bu aksesuar� d�zenleyebilmek i�in ilk �nce ayn� slotta bulunan� �st�nden ��karman gerekiyor.");

	        new slot_id = ClothingData[playerid][id][ClothingSlotID];

			if(!IsPlayerAttachedObjectSlotUsed(playerid, slot_id))
			{
				SetPlayerAttachedObject(playerid, slot_id, ClothingData[playerid][id][ClothingModelID], ClothingData[playerid][id][ClothingBoneID], ClothingData[playerid][id][ClothingPos][0], ClothingData[playerid][id][ClothingPos][1], ClothingData[playerid][id][ClothingPos][2], ClothingData[playerid][id][ClothingRot][0], ClothingData[playerid][id][ClothingRot][1], ClothingData[playerid][id][ClothingRot][2], ClothingData[playerid][id][ClothingScale][0], ClothingData[playerid][id][ClothingScale][1], ClothingData[playerid][id][ClothingScale][2], ClothingData[playerid][id][ClothingColor], ClothingData[playerid][id][ClothingColor2]);
			}

			PlayerData[playerid][pEditingClothing] = true;
			EditAttachedObject(playerid, slot_id);
			return 1;
		}
		case 6:
		{
	        if(PlayerData[playerid][pEditingClothing]) return SendServerMessage(playerid, "Aksesuar d�zenlemeyi bitirdikten sonra sonra giyebilirsin.");

	        //new slot_id = Clothing_IsSlotFree(playerid, ClothingData[playerid][id][ClothingSlotID]);
			//if(slot_id == -1) return SendServerMessage(playerid, "Bu aksesuar� giyebilmek i�in ilk �nce ayn� slotta bulunan� �st�nden ��karman gerekiyor.");

	        new slot_id = ClothingData[playerid][id][ClothingSlotID];

			if(IsPlayerAttachedObjectSlotUsed(playerid, slot_id)) RemovePlayerAttachedObject(playerid, slot_id);
			else SetPlayerAttachedObject(playerid, slot_id, ClothingData[playerid][id][ClothingModelID], ClothingData[playerid][id][ClothingBoneID], ClothingData[playerid][id][ClothingPos][0], ClothingData[playerid][id][ClothingPos][1], ClothingData[playerid][id][ClothingPos][2], ClothingData[playerid][id][ClothingRot][0], ClothingData[playerid][id][ClothingRot][1], ClothingData[playerid][id][ClothingRot][2], ClothingData[playerid][id][ClothingScale][0], ClothingData[playerid][id][ClothingScale][1], ClothingData[playerid][id][ClothingScale][2], ClothingData[playerid][id][ClothingColor], ClothingData[playerid][id][ClothingColor2]);
			Clothing_Menu(playerid, id);
			return 1;
		}
	}
    return 1;
}

Dialog:CLOTHING_NAME(playerid, response, listitem, inputtext[])
{
	if(!response) {
		Clothing_Menu(playerid, GetPVarInt(playerid, "ClothingID"));
		return 1;
	}

	if(strlen(inputtext) < 1 || strlen(inputtext) > 20) {
		SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}Aksesuar ad� maksimum 20 karakter olabilir.");
		Clothing_Menu(playerid, GetPVarInt(playerid, "ClothingID"));
		return 1;
	}

	new id = GetPVarInt(playerid, "ClothingID");

	SendClientMessageEx(playerid, COLOR_WHITE, "{FFFF00}%s {FFFFFF}adl� aksesuar�n yeni ad�n� {FFFF00}%s {FFFFFF}olarak de�i�tirdiniz.", ClothingData[playerid][id][ClothingName], inputtext);
	format(ClothingData[playerid][id][ClothingName], 20, "%s", inputtext);

	Clothing_Save(playerid, id), Clothing_Menu(playerid, id);
    return 1;
}

Dialog:CLOTHING_BONE(playerid, response, listitem, inputtext[])
{
	new id = GetPVarInt(playerid, "ClothingID");

	if(!response) {
		Clothing_Menu(playerid, id);
		return 1;
	}

	SendClientMessageEx(playerid, COLOR_WHITE, "{FFFF00}%s {FFFFFF}adl� aksesuar�n yeni kemi�ini {FFFF00}%s {FFFFFF}olarak ayarlad�n.", ClothingData[playerid][id][ClothingName], Clothing_Bone(listitem+1));
	ClothingData[playerid][id][ClothingBoneID] = listitem+1;

	Clothing_Save(playerid, id), Clothing_Menu(playerid, id);
	return 1;
}

Dialog:CLOTHING_INDEX(playerid, response, listitem, inputtext[])
{	
	new id = GetPVarInt(playerid, "ClothingID");

	if(!response) {
		Clothing_Menu(playerid, id);
		return 1;
	}

	SendClientMessageEx(playerid, COLOR_WHITE, "{FFFF00}%s {FFFFFF}adl� aksesuar�n yeni slotunu {FFFF00}%i {FFFFFF}olarak ayarlad�n.", ClothingData[playerid][id][ClothingName], listitem);
	ClothingData[playerid][id][ClothingSlotID] = listitem;

	Clothing_Save(playerid, id), Clothing_Menu(playerid, id);
	return 1;
}

Dialog:CLOTHING_MAINCOLOR(playerid, response, listitem, inputtext[])
{
	new id = GetPVarInt(playerid, "ClothingID");

	if(!response) {
		Clothing_Menu(playerid, id);
		return 1;
	}

	if(!strcmp(inputtext, "0")) 
	{
		ClothingData[playerid][id][ClothingColor] = 0xFFFFFFFF;
		SendClientMessageEx(playerid, COLOR_WHITE, "{FFFF00}%s {FFFFFF}adl� aksesuar�n birincil rengini s�f�rlad�n.", ClothingData[playerid][id][ClothingName]);
		
		new slot_id = ClothingData[playerid][id][ClothingSlotID];
		if(IsPlayerAttachedObjectSlotUsed(playerid, slot_id)) {
			RemovePlayerAttachedObject(playerid, slot_id);
			SetPlayerAttachedObject(playerid, slot_id, ClothingData[playerid][id][ClothingModelID], ClothingData[playerid][id][ClothingBoneID], ClothingData[playerid][id][ClothingPos][0], ClothingData[playerid][id][ClothingPos][1], ClothingData[playerid][id][ClothingPos][2], ClothingData[playerid][id][ClothingRot][0], ClothingData[playerid][id][ClothingRot][1], ClothingData[playerid][id][ClothingRot][2], ClothingData[playerid][id][ClothingScale][0], ClothingData[playerid][id][ClothingScale][1], ClothingData[playerid][id][ClothingScale][2], ClothingData[playerid][id][ClothingColor], ClothingData[playerid][id][ClothingColor2]);
		}

		Clothing_Save(playerid, id), Clothing_Menu(playerid, id);
		return 1;
	}

	if(strlen(inputtext) != 6) {
		SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}Hatal� renk kodu girdin. (�rnek: FFFF00)");
		Clothing_Menu(playerid, id);
		return 1;
	}

	if(sscanf(inputtext, "x", ClothingData[playerid][id][ClothingColor])) {
		SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}Hatal� renk kodu girdin. (�rnek: FFFF00)");
		Clothing_Menu(playerid, id);
		return 1;
	}

	ClothingData[playerid][id][ClothingColor] = ((ClothingData[playerid][id][ClothingColor] << 8) | 0xFF); 
	SendClientMessageEx(playerid, COLOR_WHITE, "{FFFF00}%s {FFFFFF}adl� aksesuar�n birincil rengini {%s}%s {FFFFFF}olarak ayarlad�n.", ClothingData[playerid][id][ClothingName], inputtext, inputtext);

	new slot_id = ClothingData[playerid][id][ClothingSlotID];
	if(IsPlayerAttachedObjectSlotUsed(playerid, slot_id)) {
		RemovePlayerAttachedObject(playerid, slot_id);
		SetPlayerAttachedObject(playerid, slot_id, ClothingData[playerid][id][ClothingModelID], ClothingData[playerid][id][ClothingBoneID], ClothingData[playerid][id][ClothingPos][0], ClothingData[playerid][id][ClothingPos][1], ClothingData[playerid][id][ClothingPos][2], ClothingData[playerid][id][ClothingRot][0], ClothingData[playerid][id][ClothingRot][1], ClothingData[playerid][id][ClothingRot][2], ClothingData[playerid][id][ClothingScale][0], ClothingData[playerid][id][ClothingScale][1], ClothingData[playerid][id][ClothingScale][2], ClothingData[playerid][id][ClothingColor], ClothingData[playerid][id][ClothingColor2]);
	}

	Clothing_Save(playerid, id), Clothing_Menu(playerid, id);
	return 1;
}

Dialog:CLOTHING_SECONDARYCOLOR(playerid, response, listitem, inputtext[])
{
	new id = GetPVarInt(playerid, "ClothingID");

	if(!response) {
		Clothing_Menu(playerid, id);
		return 1;
	}

	if(!strcmp(inputtext, "0")) 
	{
		ClothingData[playerid][id][ClothingColor2] = 0xFFFFFFFF;
		SendClientMessageEx(playerid, COLOR_WHITE, "{FFFF00}%s {FFFFFF}adl� aksesuar�n ikincil rengini s�f�rlad�n.", ClothingData[playerid][id][ClothingName]);

		new slot_id = ClothingData[playerid][id][ClothingSlotID];
		if(IsPlayerAttachedObjectSlotUsed(playerid, slot_id)) {
			RemovePlayerAttachedObject(playerid, slot_id);
			SetPlayerAttachedObject(playerid, slot_id, ClothingData[playerid][id][ClothingModelID], ClothingData[playerid][id][ClothingBoneID], ClothingData[playerid][id][ClothingPos][0], ClothingData[playerid][id][ClothingPos][1], ClothingData[playerid][id][ClothingPos][2], ClothingData[playerid][id][ClothingRot][0], ClothingData[playerid][id][ClothingRot][1], ClothingData[playerid][id][ClothingRot][2], ClothingData[playerid][id][ClothingScale][0], ClothingData[playerid][id][ClothingScale][1], ClothingData[playerid][id][ClothingScale][2], ClothingData[playerid][id][ClothingColor], ClothingData[playerid][id][ClothingColor2]);
		}

		Clothing_Save(playerid, id), Clothing_Menu(playerid, id);
		return 1;
	}

	if(strlen(inputtext) != 6) {
		SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}Hatal� renk kodu girdin. (�rnek: FFFF00)");
		Clothing_Menu(playerid, id);
		return 1;
	}

	if(sscanf(inputtext, "x", ClothingData[playerid][id][ClothingColor2])) {
		SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}Hatal� renk kodu girdin. (�rnek: FFFF00)");
		Clothing_Menu(playerid, id);
		return 1;
	}

	ClothingData[playerid][id][ClothingColor2] = ((ClothingData[playerid][id][ClothingColor2] << 8) | 0xFF); 
	SendClientMessageEx(playerid, COLOR_WHITE, "{FFFF00}%s {FFFFFF}adl� aksesuar�n ikincil rengini {%s}%s {FFFFFF}olarak ayarlad�n.", ClothingData[playerid][id][ClothingName], inputtext, inputtext);

	new slot_id = ClothingData[playerid][id][ClothingSlotID];
	if(IsPlayerAttachedObjectSlotUsed(playerid, slot_id)) {
		RemovePlayerAttachedObject(playerid, slot_id);
		SetPlayerAttachedObject(playerid, slot_id, ClothingData[playerid][id][ClothingModelID], ClothingData[playerid][id][ClothingBoneID], ClothingData[playerid][id][ClothingPos][0], ClothingData[playerid][id][ClothingPos][1], ClothingData[playerid][id][ClothingPos][2], ClothingData[playerid][id][ClothingRot][0], ClothingData[playerid][id][ClothingRot][1], ClothingData[playerid][id][ClothingRot][2], ClothingData[playerid][id][ClothingScale][0], ClothingData[playerid][id][ClothingScale][1], ClothingData[playerid][id][ClothingScale][2], ClothingData[playerid][id][ClothingColor], ClothingData[playerid][id][ClothingColor2]);
	}

	Clothing_Save(playerid, id), Clothing_Menu(playerid, id);
	return 1;
}

Clothing_FreeSlot(playerid)
{
	for(new i = 0; i < MAX_CLOTHING_ITEMS; i++)
	{
		if(!ClothingData[playerid][i][ClothingID]) return i;
	}
	return -1;
}

Clothing_GetLimit(playerid)
{
	switch(PlayerData[playerid][pDonator])
	{
	    case 0: return 6;
		case 1: return 8;
		case 2: return 10;
		case 3: return 15;
	}
	return -1;
}

FreeAttachmentSlot(playerid)
{
	for(new i = 1; i < MAX_PLAYER_ATTACHED_OBJECTS; i++)
	{
		if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
			return i;
	}
	return -1;
}

Clothing_Bone(id)
{
	new 
		bone[20];

	switch(id)
	{
		case 1: bone = "G���s";
		case 2: bone = "Kafa";
		case 3: bone = "Sol �st Kol";
		case 4: bone = "Sa� �st Kol";
		case 5: bone = "Sol Kol";
		case 6: bone = "Sa� Kol";
		case 7: bone = "Sol Kal�a";
		case 8: bone = "Sa� Kal�a";
		case 9: bone = "Sol Ayak";
		case 10: bone = "Sa� Ayak";
		case 11: bone = "Sa� Bald�r";
		case 12: bone = "Sol Bald�r";
		case 13: bone = "Sol �n Kol";
		case 14: bone = "Sa� �n Kol";
		case 15: bone = "Sol Omuz";
		case 16: bone = "Sa� Omuz";
		case 17: bone = "Boyun";
		case 18: bone = "�ene";
	}
	return bone;
}

Clothing_Create(playerid, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	new
		id = Clothing_FreeSlot(playerid);

	if(id == -1)
	{
		SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}Bir hata olu�tu, bo� slotun yok.");
		RemovePlayerAttachedObject(playerid, index);

		PlayerData[playerid][pBuyingClothing] = false;
		return 1;
	}

	ClothingData[playerid][id][ClothingOwnerID] = PlayerData[playerid][pSQLID];
	format(ClothingData[playerid][id][ClothingName], 20, "%s", PlayerData[playerid][pClothingName]);
	ClothingData[playerid][id][ClothingSlotID] = id, ClothingData[playerid][id][ClothingModelID] = modelid, ClothingData[playerid][id][ClothingBoneID] = boneid;
	ClothingData[playerid][id][ClothingPos][0] = fOffsetX, ClothingData[playerid][id][ClothingPos][1] = fOffsetY, ClothingData[playerid][id][ClothingPos][2] = fOffsetZ;
	ClothingData[playerid][id][ClothingRot][0] = fRotX, ClothingData[playerid][id][ClothingRot][1] = fRotY, ClothingData[playerid][id][ClothingRot][2] = fRotZ;
	ClothingData[playerid][id][ClothingScale][0] = fScaleX, ClothingData[playerid][id][ClothingScale][1] = fScaleY, ClothingData[playerid][id][ClothingScale][2] = fScaleZ;
	ClothingData[playerid][id][ClothingColor] = ClothingData[playerid][id][ClothingColor2] = 0xFFFFFFFF, ClothingData[playerid][id][ClothingAutoWear] = false;
	SendClientMessageEx(playerid, COLOR_WHITE, "SERVER: %s aksesuar�n�n keyfini ��kar!", ClothingData[playerid][id][ClothingName]);
	RemovePlayerAttachedObject(playerid, index);

	mysql_tquery(m_Handle, "INSERT INTO player_clothing (slot_id) VALUES(0)", "OnPlayerClothingCreated", "ii", playerid, id);
	return 1;
}

Server:OnPlayerClothingCreated(playerid, id)
{
	ClothingData[playerid][id][ClothingID] = cache_insert_id();
	Clothing_Save(playerid, id);
	return 1;
}

Clothing_Save(playerid, id)
{
	new
	    query[354];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE player_clothing SET player_dbid = %i, clothing_name = '%e', slot_id = %i, model_id = %i, bone_id = %i WHERE id = %i",
        ClothingData[playerid][id][ClothingOwnerID],
        ClothingData[playerid][id][ClothingName],
        ClothingData[playerid][id][ClothingSlotID],
        ClothingData[playerid][id][ClothingModelID],
		ClothingData[playerid][id][ClothingBoneID],
	   	ClothingData[playerid][id][ClothingID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE player_clothing SET pos_x = %f, pos_y = %f, pos_z = %f, rot_x = %f, rot_y = %f, rot_z = %f WHERE id = %i",
		ClothingData[playerid][id][ClothingPos][0],
		ClothingData[playerid][id][ClothingPos][1],
		ClothingData[playerid][id][ClothingPos][2],
		ClothingData[playerid][id][ClothingRot][0],
		ClothingData[playerid][id][ClothingRot][1],
		ClothingData[playerid][id][ClothingRot][2],
		ClothingData[playerid][id][ClothingID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE player_clothing SET scale_x = %f, scale_y = %f, scale_x = %f WHERE id = %i",
		ClothingData[playerid][id][ClothingScale][0],
	    ClothingData[playerid][id][ClothingScale][1],
	    ClothingData[playerid][id][ClothingScale][2],
	    ClothingData[playerid][id][ClothingID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

Clothing_List(playerid, type, page = 1)
{
	SetPVarInt(playerid, "clothing_type", type);

	new lookupQuery[200];
	mysql_format(m_Handle, lookupQuery, sizeof lookupQuery, "SELECT * FROM clothings WHERE clothing_type = %i", type);
	mysql_tquery(m_Handle, lookupQuery, "SQL_ClothingList", "ii", playerid, page);
	return 1;
}

Server:SQL_ClothingList(playerid, page)
{
	if(!IsPlayerConnected(playerid)) {
        return 0;
    }
        
    if(!cache_num_rows()) {
        return 0;
    }

	new bool: secondPage, count;
	new primary_str[1400], sub_str[400];

	new secPage = page;
	SetPVarInt(playerid, "clothing_idx", page);

	page--;

	strcat(primary_str, "#\t�sim\tFiyat\n");

	new id, clothing_name[32], price;

	for(new i = page*MAX_CLOTHING_SHOW, j = cache_num_rows(); i < j; i++)
	{
		count++;

		if(count == MAX_CLOTHING_SHOW + 1)
		{
			secondPage = true;
			break;
		}
		else
		{
			cache_get_value_name_int(i, "id", id);
	        cache_get_value_name_int(i, "clothing_price", price);
	        cache_get_value_name(i, "clothing_name", clothing_name, sizeof(clothing_name));

			format(sub_str, sizeof(sub_str), "{FFFFFF}%i\t%s\t{33AA33}$%s\n", id, clothing_name, MoneyFormat(price));
			strcat(primary_str, sub_str);
		}
	}

	if(secPage != 1)
		format(primary_str, 1110, "%s{FFFF00}�nceki Sayfa <<\n", primary_str);

	if(secondPage)
		format(primary_str, 1110, "%s{FFFF00}Sonraki Sayfa >>\n", primary_str);

	Dialog_Show(playerid, ACCESSORY_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Aksesuar Listesi", primary_str, "Tamam", "<< Kapat");
	return 1;
}

Clothing_GetPrice(id)
{
	new query[75], price;
	mysql_format(m_Handle, query, sizeof(query), "SELECT clothing_price FROM clothings WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name_int(0, "clothing_price", price);
	cache_delete(cache);
	return price;
}

Clothing_GetModel(id)
{
	new query[75], model_id;
	mysql_format(m_Handle, query, sizeof(query), "SELECT clothing_model FROM clothings WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name_int(0, "clothing_model", model_id);
	cache_delete(cache);
	return model_id;
}

Clothing_GetName(id)
{
	new query[75], clothing_name[32];
	mysql_format(m_Handle, query, sizeof(query), "SELECT clothing_name FROM clothings WHERE id = %i LIMIT 1", id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name(0, "clothing_name", clothing_name);
	cache_delete(cache);
	return clothing_name;
}

Dialog:ACCESSORY_LIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new type = GetPVarInt(playerid, "clothing_type"),
			page = GetPVarInt(playerid, "clothing_idx");

		if(!strcmp(inputtext, "�nceki Sayfa <<")) return Clothing_List(playerid, type, page-1);
		if(!strcmp(inputtext, "Sonraki Sayfa >>")) return Clothing_List(playerid, type, page+1);
	    
	    new id;
		if(!sscanf(inputtext, "i", id))
		{
			new clothing_id = FreeAttachmentSlot(playerid);

			SendClientMessage(playerid, COLOR_WHITE, "�PUCU: {FFFF00}SPACE{FFFFFF} basarak bak�nabilirsin. �ptal etmek i�in {FFFF00}ESC{FFFFFF} basabilirsin.");
			SetPlayerAttachedObject(playerid, clothing_id, Clothing_GetModel(id), 2);
			EditAttachedObject(playerid, clothing_id);
			// was -1

			format(PlayerData[playerid][pClothingName], 20, "%s", Clothing_GetName(id));
			PlayerData[playerid][pClothingPrice] = Clothing_GetPrice(id);
			PlayerData[playerid][pBuyingClothing] = true;
		}
	}
    return 1;
}