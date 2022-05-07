CMD:not(playerid, params[])
{
	Note_RouteCommands(playerid, params);
	return 1;
}

Note_FreeSlot(playerid)
{
	for(new i = 0; i < MAX_PLAYER_NOTES; i++)
	{
		if(!NoteData[playerid][i][NoteID]) return i;
	}
	return -1;
}

Note_RouteCommands(playerid, cmdtext[])
{
    new command[10], parameters[128];
    sscanf(cmdtext, "s[10]s[128]", command, parameters);

	if(strlen(command) == 0) {
		SendClientMessage(playerid, COLOR_ACTION, "____________________________________________________");
		SendClientMessage(playerid, COLOR_ACTION, "KULLANIM: /not [komut]");
		SendClientMessage(playerid, COLOR_ACTION, "/not yarat - Yeni bir not yarat�r.");
		SendClientMessage(playerid, COLOR_ACTION, "/not goruntule - T�m notlar�n� g�r�nt�ler.");
		SendClientMessage(playerid, COLOR_ACTION, "/not goster - Notlar�n� ba�kas�na g�sterir.");
		SendClientMessage(playerid, COLOR_ACTION, "/not duzenle - Varolan notunu d�zenler.");
		SendClientMessage(playerid, COLOR_ACTION, "/not sil - Varolan notunu siler.");
		SendClientMessage(playerid, COLOR_ACTION, "____________________________________________________");
		return 1;
	}

    if(strcmp("yarat", command) == 0) NoteCMD_Create(playerid, parameters);
    else if(strcmp("goruntule", command) == 0) NoteCMD_List(playerid);
	else if(strcmp("goster", command) == 0) NoteCMD_Show(playerid, parameters);
    else if(strcmp("duzenle", command) == 0) NoteCMD_Edit(playerid, parameters);
    else if(strcmp("sil", command) == 0) NoteCMD_Delete(playerid, parameters);
	return 1;
}

NoteCMD_Create(const playerid, const parameters[]) 
{
	new note_txt[128];
	if(sscanf(parameters, "s[128]", note_txt)) {
		SendUsageMessage(playerid, "/not yarat [i�erik]");
		return 1;
	}

	if(strlen(note_txt) < 1 || strlen(note_txt) > 128) {
		SendErrorMessage(playerid, "Notun i�eri�i en az 1 karakter en fazla 128 karakter olmal�d�r.");
		return 1;
	}

	new id = Note_FreeSlot(playerid);
	if(id == -1) {
		SendErrorMessage(playerid, "Daha fazla not eklemeyezsin, defterinde yer kalmam��.");
		return 1;
	}

	new query[454];
	mysql_format(m_Handle, query, sizeof(query), "INSERT INTO player_notes (playersqlid, details, time) VALUES (%i, '%e' %i)", PlayerData[playerid][pSQLID], note_txt, Time());
	new Cache:cache = mysql_query(m_Handle, query);
	
	NoteData[playerid][id][NoteID] = cache_insert_id();
	format(NoteData[playerid][id][NoteDetails], 128, "%s", note_txt);
	NoteData[playerid][id][NoteTime] = Time();

	SendClientMessageEx(playerid, COLOR_ACTION, "[Not(%i)] %s", id+1, note_txt);
	cmd_ame(playerid, "cebinden ka��t par�as� ��kartarak �st�ne bir �eyler yazar.");
	cache_delete(cache);
    return 1;
}

NoteCMD_List(const playerid) 
{
	new has_notes = 0;
	for(new i = 0; i < MAX_PLAYER_NOTES; i++) if(NoteData[playerid][i][NoteID])
	{
		SendClientMessageEx(playerid, COLOR_ACTION, "[Not(%i)] %s...", i+1, NoteData[playerid][i][NoteDetails]);
		SendClientMessageEx(playerid, COLOR_ACTION, "...Tarih: %s", GetFullTime(NoteData[playerid][i][NoteTime]));
		has_notes++;
	}

	if(!has_notes) return SendErrorMessage(playerid, "Hi� not almam��s�n.");
	return 1;
}	

NoteCMD_Show(const playerid, const parameters[]) 
{
	new id, not_id;
	if(sscanf(parameters, "ui", id, not_id)) {
		SendUsageMessage(playerid, "/not goster [oyuncu ID/isim] [not ID]");
		return 1;
	}
	if(playerid == id) return SendErrorMessage(playerid, "Bu komutu kendi �zerinde kullanamazs�n.");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	if(!GetDistanceBetweenPlayers(playerid, id, 4.5)) return SendErrorMessage(playerid, "Belirtti�in ki�iye yak�n de�ilsin.");
	if(!NoteData[playerid][not_id][NoteID]) return SendErrorMessage(playerid, "B�yle bir notun yok.");

	SendClientMessageEx(id, COLOR_ACTION, "[Not(%i)] %s...", not_id+1, NoteData[playerid][not_id][NoteDetails]);
	SendClientMessageEx(id, COLOR_ACTION, "...Tarih: %s", GetFullTime(NoteData[playerid][not_id][NoteTime]));
	cmd_ame(playerid, sprintf("cebinden bir ka��t par�as� ��kar�r ve %s isimli ki�iye g�sterir.", ReturnName(id, 0)));
	return 1;
}

NoteCMD_Edit(const playerid, const parameters[]) 
{
	new not_id, note_txt[128];
	if(sscanf(parameters, "is[128]", not_id, note_txt)) {
		SendUsageMessage(playerid, "/not duzenle [not ID] [yeni i�erik]");
		return 1;
	}

	if(!NoteData[playerid][not_id][NoteID]) {
		SendErrorMessage(playerid, "B�yle bir notun yok.");
		return 1;
	}

	if(strlen(note_txt) < 1 || strlen(note_txt) > 128) {
		SendErrorMessage(playerid, "Notun i�eri�i en az 1 karakter en fazla 128 karakter olmal�d�r.");
		return 1;
	}

	NoteData[playerid][not_id][NoteTime] = Time();
	format(NoteData[playerid][not_id][NoteDetails], 128, "%s", note_txt);

	SendClientMessageEx(playerid, COLOR_ACTION, "[Not(%i)] %s...", not_id+1, NoteData[playerid][not_id][NoteDetails]);
	SendClientMessageEx(playerid, COLOR_ACTION, "...Tarih: %s (olarak g�ncellendi)", GetFullTime(NoteData[playerid][not_id][NoteTime]));

	new query[354];
	mysql_format(m_Handle, query, sizeof(query), "UPDATE player_notes SET details = '%e', time = %i WHERE id = %i", NoteData[playerid][not_id][NoteDetails], Time(), NoteData[playerid][not_id][NoteID]);
	mysql_tquery(m_Handle, query);
	return 1;
}	

NoteCMD_Delete(const playerid, const parameters[])
{
	new not_id;
	if(sscanf(parameters, "i", not_id)) {
		SendUsageMessage(playerid, "/not sil [not ID]");
		return 1;
	}

	if(!NoteData[playerid][not_id][NoteID]) {
		SendErrorMessage(playerid, "B�yle bir notun yok.");
		return 1;
	}

	SendClientMessageEx(playerid, COLOR_ACTION, "[Not(%i)] %s...", not_id+1, NoteData[playerid][not_id][NoteDetails]);
	SendClientMessageEx(playerid, COLOR_ACTION, "...Tarih: %s (silindi)", GetFullTime(NoteData[playerid][not_id][NoteTime]));
	cmd_ame(playerid, "elindeki not par�as�n� y�rtar ve yere do�ru atar.");

	new query[90];
	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM player_notes WHERE id = %i", NoteData[playerid][not_id][NoteID]);
	mysql_tquery(m_Handle, query);

	NoteData[playerid][not_id][NoteID] = 0;
	return 1;
}