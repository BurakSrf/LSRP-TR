CMD:testername(playerid, params[])
{
	if(!PlayerData[playerid][pTester]) return UnAuthMessage(playerid);
	if(isnull(params)) return SendUsageMessage(playerid, "/testername [ad�n�z]");
	if(strlen(params) > 24) return SendErrorMessage(playerid, "Tester ad�n�z en fazla 24 karakter olabilir.");

	format(PlayerData[playerid][pAdminName], 24, "%s", params);
	SendClientMessageEx(playerid, COLOR_ADM, "[!] Tester ad�n�z� \"%s\" olarak g�ncellediniz. ", params);

	new query[128];
	mysql_format(m_Handle, query, sizeof(query), "UPDATE players SET TesterName = '%e' WHERE id = %i", params, PlayerData[playerid][pSQLID]);
	mysql_tquery(m_Handle, query);
	return 1;
}
