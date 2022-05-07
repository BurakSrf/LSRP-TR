CMD:animler(playerid, params[]) return cmd_animasyonlar(playerid, params);
CMD:anims(playerid, params[]) return cmd_animasyonlar(playerid, params);
CMD:animasyonlar(playerid, params[])
{
	new sub_str[15], primary_str[335];

	for(new i; i < sizeof(g_aAnimList); i++)
	{
		format(sub_str, sizeof(sub_str), "%s\n", g_aAnimList[i]);
		strcat(primary_str, sub_str);
	}

	Dialog_Show(playerid, ANIM_LIST, DIALOG_STYLE_LIST, "Animasyonlar", primary_str, "Seç", "Kapat");
	return 1;
}

Dialog:ANIM_LIST(playerid, response, listitem, inputtext[])
{
	if(response) 
	{
		new 
			anim_str[128];

		switch(listitem)
		{
			case 0:
			{
				strcat(anim_str, "Yere Oturma\n");
				strcat(anim_str, "sit, sit2, fsit");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "3 Adet Yere Oturma Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 1:
			{
				strcat(anim_str, "Sandalyeye Oturma\n");
				strcat(anim_str, "seat, deskbored, deskmad, deskdrink\n desksit");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "5 Adet Sandalyeye Oturma Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 2:
			{
				strcat(anim_str, "Yatma / Uzanma\n");
				strcat(anim_str, "injured, crack, crack2, crack3\n crack4, cover, crawl, flip\n frontfall, fallover, dive, lay\n flaydown, sleep, getshot");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "15 Adet Yatma / Uzanma Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 3:
			{
				strcat(anim_str, "El\n");
				strcat(anim_str, "mourn, priest, washhands, sword\n dishes, crossarm, crossarm2, crossarm3\n crossarm4, flex, strecth, stretch2\n rifleready, robcash\n robno");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "15 Adet El Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 4:
			{
				strcat(anim_str, "Yaslanma\n");
				strcat(anim_str, "tired, exhausted, lean, lean2");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "4 Adet Yaslanma Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 5:
			{
				strcat(anim_str, "Çete Ýþaretleri\n");
				strcat(anim_str, "gsign1, gsign2, gsign3, gsign4\n gsign5, gsign6, gsign7, gsign8\n gsign9");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "9 Adet Çete Ýþaret Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 6:
			{
				strcat(anim_str, "Ýletiþim / Etkileþim\n");
				strcat(anim_str, "punch, fallkick, bitchslap, riotpunch\n kickdoor, getback, kickhim, followme");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "8 Adet Ýletiþim / Etkileþim Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 7:
			{
				strcat(anim_str, "Selamlaþma / El Salla\n");
				strcat(anim_str, "greet1, greet2, greet3, greet4\n greet5, greet6, greet7, kiss\n salute, forwardpanic, forwardlook, forwardwave\n wave, waveback");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "14 Adet Selamlaþma Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 8:
			{
				strcat(anim_str, "El Hareketi\n");
				strcat(anim_str, "fuckyou, fuckyou2, wave, argue\n argue2, no, agree, facepalm\n slapass, what, bat, bat2\n riot1, riot2 riot3, comecross\n comeon, shoutat, provoke, chant\n putdown, push, getsearched");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "23 Adet El Hareket Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 9:
			{
				strcat(anim_str, "Hareket\n");
				strcat(anim_str, "sipdrink, claphand, cry, dropflag\n spray, spray2, cpr, leftride\n rightride, shouts, laugh, scared\n idle, old, scratchballs, roadcross\n uturn openleft, openright, checkout\n payshop, crossroad, sneak, comready2\n wuzi");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "21 Adet Hareket Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 10:
			{
				strcat(anim_str, "Ýþaret\n");
				strcat(anim_str, "aim, taxil, taxir, rifleup");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "4 Adet Ýþaret Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 11:
			{
				strcat(anim_str, "Çömelme\n");
				strcat(anim_str, "camera1, camera2, camera3, crouchrifle\n kneel1, kneel2, crouchpicture");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "7 Adet Çömelme Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 12:
			{
				strcat(anim_str, "Silah Doldurma\n");
				strcat(anim_str, "shotgun, shottyreload, creload, crouchreload\n reload, aimfast");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "6 Adet Silah Doldurma Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 13:
			{
				strcat(anim_str, "Silah Ateþleme\n");
				strcat(anim_str, "aimshoot, aimshoot2, crouchshoot, aimfast");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "4 Adet Silah Ateþleme Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 14:
			{
				strcat(anim_str, "Tezahürat\n");
				strcat(anim_str, "win1, win2, lose, crosswin2");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "4 Adet Tezahürat Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 15:
			{
				strcat(anim_str, "Basketbol\n");
				strcat(anim_str, "camshot1, dunk, defense, defensel\n defenser, dunk2, blockshot, fakeshot\n jumpshot, pickupball, throw, dribble\n dribble2, dribble3");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "14 Adet Basketbol Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 16:
			{
				strcat(anim_str, "Mekanik\n");
				strcat(anim_str, "fixcar, fixcarout");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "2 Adet Mekanik Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 17:
			{
				strcat(anim_str, "Boks\n");
				strcat(anim_str, "box1, box2, shadowbox, dodge");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "4 Adet Boks Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 18:
			{
				strcat(anim_str, "Kung Fu\n");
				strcat(anim_str, "kungfu1, kungfu2, kungfu3, kungfublock\n kungfustomp, flykick");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "6 Adet Kung Fu Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 19:
			{
				strcat(anim_str, "Sallanma\n");
				strcat(anim_str, "rap1, rap2, rap3, deal\n lookout, lookout2, lookout3, dealerstance\n dealerstance2, dealerstance3, dealerstance4");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "11 Adet Sallanma Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 20:
			{
				strcat(anim_str, "Ayaða Kalkma\n");
				strcat(anim_str, "getupf, getuob");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "2 Adet Ayaða Kalkma Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 21:
			{
				strcat(anim_str, "Dans\n");
				strcat(anim_str, "dance1, danc2, dance3, dance4\n dance5, danc6, dance7, dance8\n dance9, danc10, dance11, dance12\n dance13, dance14\n");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "14 Adet Dans Animasyonu Mevcut", anim_str, "O", "K");
			}
			case 22:
			{
				strcat(anim_str, "Duruþ\n");
				strcat(anim_str, "riflestance");
				Dialog_Show(playerid, ANIM_LIST_DETAIL, DIALOG_STYLE_LIST, "1 Adet Duruþ Animasyonu Mevcut", anim_str, "O", "K");
			}
		}
	}
	return 1;
}

Dialog:ANIM_LIST_DETAIL(playerid, response, listitem, inputtext[])
{
	cmd_animasyonlar(playerid, "");
	return 1;
}

CMD:animdurdur(playerid, params[])return cmd_stopanim(playerid, params);
CMD:sa(playerid, params[])return cmd_stopanim(playerid, params);
CMD:stopanim(playerid, params[])
{
	if (!AnimationCheck(playerid)) return SendServerMessage(playerid, "Þu anda bu komutu kullanamazsýn.");

	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4, 0, 0, 0, 0, 0, 1);

	if (!PlayerData[playerid][pHandcuffed] && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DRINK_BEER && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DRINK_WINE && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DRINK_SPRUNK)
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

	PlayerData[playerid][pPlayingAnimation] = false;
	return 1;
}

CMD:walk(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Bu komutu þu anda kullanamazsýn.");

	switch (PlayerData[playerid][pWalkstyle])
	{
		case 0: PlayAnimation(playerid, "PED", "WALK_player", 4.1, 1, 1, 1, 1, 1, 1);
		case 1: PlayAnimation(playerid, "PED", "WALK_walksexy", 4.1, 1, 1, 1, 1, 1, 1);
		case 2: PlayAnimation(playerid, "PED", "WALK_fat", 4.1, 1, 1, 1, 1, 1, 1);
		case 3: PlayAnimation(playerid, "PED", "WALK_fatold", 4.1, 1, 1, 1, 1, 1, 1);
		case 4: PlayAnimation(playerid, "PED", "WALK_gang1", 4.1, 1, 1, 1, 1, 1, 1);
		case 5: PlayAnimation(playerid, "PED", "WALK_gang2", 4.1, 1, 1, 1, 1, 1, 1);
		case 6: PlayAnimation(playerid, "PED", "WALK_old", 4.1, 1, 1, 1, 1, 1, 1);
		case 7: PlayAnimation(playerid, "PED", "WALK_armed", 4.1, 1, 1, 1, 1, 1, 1);
		case 8: PlayAnimation(playerid, "PED", "WALK_civi", 4.1, 1, 1, 1, 1, 1, 1);
		case 9: PlayAnimation(playerid, "PED", "WALK_DRUNK", 4.1, 1, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:handsup(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	if(PlayerData[playerid][pHandcuffed]) return SendClientMessage(playerid, COLOR_ADM, "Þu anda bunu yapamazsýn.");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	return 1;
}

CMD:caranim(playerid, params[])
{
	if(PlayerData[playerid][pBrutallyWounded]) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");

	new anim[6];
	if(sscanf(params, "s[6]", anim)) return SendUsageMessage(playerid, "/caranim [relax/tap]");

	if(!strcmp(anim, "relax")) 
	{
		PlayAnimation(playerid, "LOWRIDER", "SIT_RELAXED", 4.1, 0, 0, 0, 1, 0, 1);
	}
	else if(!strcmp(anim, "tap")) 
	{
		PlayAnimation(playerid, "LOWRIDER", "TAP_HAND", 4.1, 1, 0, 0, 1, 0, 1);
	}
	else SendUsageMessage(playerid, "/caranim [relax/tap]");
	return 1;
}

CMD:sit(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:sit2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GANGS", "leanIN", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:fsit(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"GANGS","leanOUT",4.0,1,1,1,1,1);
	return 1;
}

CMD:seat(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "SEAT_down", 4.0, 0, 1, 1, 1, 0);
	return 1;
}

CMD:deskbored(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"INT_OFFICE","OFF_Sit_Bored_Loop", 4.0, 0, 1, 1, 1, -1);
	return 1;
}

CMD:deskmad(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"INT_OFFICE","OFF_Sit_Crash", 4.0, 0, 1, 1, 1, -1);
	return 1;
}

CMD:deskdrink(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"FOOD","FF_Sit_Loop", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:desksit(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"INT_OFFICE","OFF_Sit_Idle_Loop", 4.0, 0, 1, 1, 1, -1);
	return 1;
}

CMD:injured(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CRACK", "crckidle1", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:crack(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CRACK", "Bbalbat_Idle_01", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:crack2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CRACK", "crckdeth2", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:crack3(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CRACK", "crckdeth3", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:crack4(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CRACK", "crckdeth4", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:cover(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:crawl(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "SWAT", "Rail_fall_crawl", 4.1, 0, 1, 1, 1,1,1);
	return 1;
}

CMD:flip(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "FLOOR_HIT", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:frontfall(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "FLOOR_HIT_F", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:fallover(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "parachute", "FALL_skyDive_DIE", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:dive(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "SWIM", "Swim_Dive_Under", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:lay(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:flaydown(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:sleep(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CRACK", "crckdeth4", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:getshot(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"PED","FLOOR_hit_f",4.1,0,1,1,1,0);
	return 1;
}

CMD:mourn(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GRAVEYARD", "MRNM_LOOP", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:priest(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "OTB", "wtchrace_cmon", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:washhands(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BD_FIRE", "wash_up", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:sword(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "SWORD", "sword_1", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:dishes(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BD_FIRE", "wash_up", 4.0, 0, 0, 0, 0, 0);
	return 1;
}


CMD:crossarm(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "OTB", "WTCHRACE_IN", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:crossarm2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "OTB", "WTCHRACE_LOOP", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:crossarm3(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:crossarm4(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "COP_AMBIENT", "Coplook_nod", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:flex(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PLAYIDLES", "shldr", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:strecth(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PLAYIDLES", "stretch", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:strecth2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PLAYIDLES", "strleg", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:rifleready(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "RIFLE", "RIFLE_load", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:robcash(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "SHOP", "SHP_Rob_GiveCash", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:robno(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "SHOP", "SHP_Rob_React", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:tired(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "FAT", "IDLE_tired", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:exhausted(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "IDLE_tired", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:lean(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GANGS","leanIDLE", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:lean2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"MISC", "Plyrlean_loop", 4.0, 0, 1, 1, 1, -1);
	return 1;
}

CMD:gsign1(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GHANDS", "GSIGN1", 4.0, 1, 1, 0, 1, 1, 1);
	return 1;
}

CMD:gsign2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GHANDS", "GSIGN1LH", 4.0, 1, 1, 0, 1, 1, 1);
	return 1;
}

CMD:gsign3(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GHANDS", "GSIGN2", 4.0, 1, 1, 0, 1, 1, 1);
	return 1;
}

CMD:gsign4(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GHANDS", "GSIGN2LH", 4.0, 1, 1, 0, 1, 1, 1);
	return 1;
}

CMD:gsign5(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GHANDS", "GSIGN3", 4.0, 1, 1, 0, 1, 1, 1);
	return 1;
}

CMD:gsign6(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GHANDS", "GSIGN3LH", 4.0, 1, 1, 0, 1, 1, 1);
	return 1;
}

CMD:gsign7(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GHANDS", "GSIGN4", 4.0, 1, 1, 0, 1, 1, 1);
	return 1;
}

CMD:gsign8(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GHANDS", "GSIGN4LH", 4.0, 1, 1, 0, 1, 1, 1);
	return 1;
}

CMD:gsign9(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GHANDS", "GSIGN5", 4.0, 1, 1, 0, 1, 1, 1);
	return 1;
}

CMD:punch(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"FIGHT_B","FightB_G",4.0,0,0,0,0,0);
	return 1;
}

CMD:fallkick(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"FIGHT_D","FightD_G",4.0,0,0,0,0,0);
	return 1;
}

CMD:bitchslap(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "MISC", "bitchslap", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:kickdoor(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"POLICE","Door_Kick",4.0,0,0,0,0,0);
	return 1;
}

CMD:getback(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"PED","gas_cwr",4.1,1,1,1,1,1);
	return 1;
}

CMD:kickhim(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"GANGS","shake_carK",4.0,0,0,0,0,0);
	return 1;
}

CMD:followme(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"WUZI","Wuzi_follow",4.1,0,1,1,1,1);
	return 1;
}

CMD:greet1(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GANGS", "hndshkaa", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:greet2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GANGS", "hndshkba", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:greet3(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GANGS", "hndshkca", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:greet4(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GANGS", "hndshkcb", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:greet5(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GANGS", "hndshkda", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:greet6(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GANGS", "hndshkea", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:greet7(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GANGS", "hndshkfa", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:kiss(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "KISSING", "Grlfrd_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:salute(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GHANDS", "GSIGN5LH", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:forwardpanic(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "ON_LOOKERS", "lkup_in", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:forwardlook(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "ON_LOOKERS", "lkup_loop", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:forwardwave(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "ON_LOOKERS", "lkup_out", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:wave(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "ENDCHAT_03", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:waveback(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "ENDCHAT_01", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:fuckyou(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "fucku", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:fuckyou2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"RIOT","RIOT_FUKU",4.1,1,1,1,1,1);
	return 1;
}

CMD:argue(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "KISSING", "GF_CarArgue_01", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:argue2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "KISSING", "GF_CarArgue_02", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:no(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GANGS", "INVITE_NO", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:agree(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GANGS", "INVITE_YES", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:facepalm(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"MISC","plyr_shkhead",4.0,0,0,0,0,0);
	return 1;
}

CMD:slapass(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"SWEET","sweet_ass_slap",4.0,0,0,0,0,0);
	return 1;
}

CMD:what(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "RIOT", "RIOT_ANGRY", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:bat(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"CRACK","Bbalbat_Idle_01", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:bat2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"CRACK","Bbalbat_Idle_02", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:riot1(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "RIOT", "RIOT_ANGRY", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:riot2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"RIOT","RIOT_CHANT",4.1,1,1,1,1,1);
	return 1;
}

CMD:riot3(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"RIOT","RIOT_PUNCHES",4.1,1,1,1,1,1);
	return 1;
}

CMD:comecross(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "OTB", "WTCHRACE_CMON", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:comeon(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "POLICE", "CopTraf_Come", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:shouts(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"RIOT","RIOT_shout",4.1,1,1,1,1,1);
	return 1;
}

CMD:provoke(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "RIOT", "RIOT_CHALLENGE", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:chant(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"RIOT","RIOT_CHANT",4.1,1,1,1,1,1);
	return 1;
}

CMD:putdown(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CARRY", "putdwn", 3.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:push(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"GANGS","shake_cara",4.0,0,0,0,0,0);
	return 1;
}

CMD:getsearched(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"ROB_BANK","CAT_Safe_Rob",4.0,1,0,0,0,0);
	return 1;
}

CMD:sipdrink(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BAR", "DNK_STNDM_LOOP", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:claphand(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DANCING", "bd_clap", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:cry(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GRAVEYARD", "MRNF_LOOP", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:dropflag(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CAR", "flag_drop", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:spray(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "SPRAYCAN", "spraycan_fire", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:spray2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "SPRAYCAN", "spraycan_full", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:cpr(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "MEDIC", "CPR", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:leftride(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "FOOD", "FF_Dam_Left", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:rightride(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "FOOD", "FF_Dam_Right", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:laugh(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "RAPPING", "Laugh_01", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:scared(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "sprint_panic", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:idle(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GANGS", "DEALER_IDLE", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:old(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "idlestance_old", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:scratchballs(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"MISC","scratchballs_01",4.0,0,0,0,0,0);
	return 1;
}

CMD:roadcross(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "roadcross", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:openleft(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "CAR_open_LHS", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:openright(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "CAR_open_RHS", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:checkout(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GRAFFITI", "graffiti_Chkout", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:payshop(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "INT_SHOP", "shop_pay", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:crossroad(playerid, params[])
{
	if (!AnimationCheck(playerid))return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	
	new animid;
   	if(sscanf(params,"d",animid)) return SendServerMessage(playerid, "/crossroad [1 (klasik), 2 (kadýn), 3 (çete), 4 (yaþlý)]");
	switch(animid)
	{
  		case 1: PlayAnimation(playerid, "PED", "roadcross", 4.1, 0, 1, 1, 1, 1, 1);
        case 2: PlayAnimation(playerid, "PED", "roadcross_female", 4.1, 0, 1, 1, 1, 1, 1);
        case 3: PlayAnimation(playerid, "PED", "roadcross_gang", 4.1, 0, 1, 1, 1, 1, 1);
        case 4: PlayAnimation(playerid, "PED", "roadcross_old", 4.1, 0, 1, 1, 1, 1, 1);
  		default: SendServerMessage(playerid, "/crossroad [1 (klasik), 2 (kadýn), 3 (çete), 4 (yaþlý)]");
   	}
	return 1;
}

CMD:sneak(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "Player_Sneak_walkstart", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:comready2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "WALK_armed", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:wuzi(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "Walk_Wuzi", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:aim(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "SHOP", "SHP_Gun_Aim", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:taxil(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"MISC","Hiker_Pose_L",4.0,0,1,1,1,0);
	return 1;
}

CMD:taxir(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"MISC","Hiker_Pose",4.0,0,1,1,1,0);
	return 1;
}

CMD:rifleup(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "MISC", "PASS_Rifle_Ped", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:camera1(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CAMERA", "CAMCRCH_CMON", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:camera2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CAMERA", "CAMCRCH_IDLELOOP", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:camera3(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CAMERA", "CAMSTND_TO_CAMCRCH", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:kneel1(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "SHOTGUN", "shotgun_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:kneel2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "SHOTGUN", "shotgun_fire_poor", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:crouchrifle(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PYTHON", "python_fire", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:crouchpicture(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CAMERA", "camstnd_to_camcrch", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:shotgun(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "SHOTGUN", "shotgun_fire", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:shottyreload(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "COLT45", "sawnoff_reload", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:creload(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "SILENCED", "CrouchReload", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:crouchreload(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PYTHON", "PYTHON_CROUCHRELOAD", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:reload(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PYTHON", "PYTHON_RELOAD", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:aimfast(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "SNIPER", "WEAPON_SNIPER", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:aimshoot(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "HEIST9", "swt_wllshoot_in_L", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:aimshoot2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "HEIST9", "swt_wllshoot_in_R", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:crouchshoot(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PYTHON", "PYTHON_CROUCHFIRE", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:win1(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"OTB","wtchrace_win",4.1,0,1,1,1,0);
	return 1;
}

CMD:win2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"OTB","wtchrace_cmon",4.1,0,1,1,1,0);
	return 1;
}

CMD:lose(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"OTB","wtchrace_lose",4.1,0,1,1,1,0);
	return 1;
}

CMD:camshot1(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BSKTBALL", "BBALL_def_jump_shot", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:dunk(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BSKTBALL", "BBALL_Dnk", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:defense(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BSKTBALL", "BBALL_def_loop", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:defensel(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BSKTBALL", "BBALL_def_stepL", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:defenser(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BSKTBALL", "BBALL_def_stepR", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:dunk2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BSKTBALL", "BBALL_Dnk_Gli", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:clockshot(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BSKTBALL", "BBALL_idle", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:fakeshot(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BSKTBALL", "BBALL_Jump_Cancel", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:jumpshot(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BSKTBALL", "BBALL_Jump_Shot", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:pickupball(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:throw(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid,"GRENADE","WEAPON_throwu",3.0,0,0,0,0,0);
	return 1;
}

CMD:dribble(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BSKTBALL", "BBALL_run", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:dribble2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BSKTBALL", "BBALL_walk", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:dribble3(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BSKTBALL", "BBALL_walk_start", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:fixcar(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:fixcarout(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CAR", "Fixn_Car_Out", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:box1(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GYMNASIUM", "GYMshadowbox", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:box2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "BOX", "boxhipin", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:shadowbox(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "GYMNASIUM", "GYMSHADOWBOX", 4.1, 1, 0, 0, 1, 0, 1);
	return 1;
}

CMD:dodge(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "FightA_block", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:kungfu1(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "FIGHT_B", "FightB_1", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:kungfu2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "FIGHT_B", "FightB_2", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:kungfu3(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "FIGHT_B", "FightB_3", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:kungfublock(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "FIGHT_B", "FightB_block", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:kungfustomp(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "FIGHT_B", "FightB_G", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:flykick(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "FIGHT_B", "FightB_IDLE", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:rap1(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "RAPPING", "RAP_A_LOOP", 4.1, 1, 0, 0, 1, 0, 1);
	return 1;
}

CMD:rap2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "RAPPING", "RAP_B_LOOP", 4.1, 1, 0, 0, 1, 0, 1);
	return 1;
}

CMD:rap3(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "RAPPING", "RAP_C_LOOP", 4.1, 1, 0, 0, 1, 0, 1);
	return 1;
}

CMD:deal(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:lookout(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "COP_AMBIENT", "Coplook_in", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:lookout2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:lookout3(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "COP_AMBIENT", "Coplook_nod", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:dealerstance(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:dealerstance2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DEALER", "DEALER_IDLE_01", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:dealerstance3(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DEALER", "DEALER_IDLE_02", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:dealerstance4(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DEALER", "DEALER_IDLE_03", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:getupf(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "getup", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:getupb(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "getup_front", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:dance1(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
	return 1;
}

CMD:dance2(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
	return 1;
}

CMD:dance3(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
	return 1;
}

CMD:dance4(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
	return 1;
}

CMD:dance5(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DANCING", "dance_loop", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:dance6(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DANCING", "DAN_Left_A", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:dance7(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DANCING", "DAN_Right_A", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:dance8(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DANCING", "DAN_Loop_A", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:dance9(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DANCING", "DAN_Up_A", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:dance10(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DANCING", "DAN_Down_A", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:dance11(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DANCING", "dnce_M_a", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:dance12(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DANCING", "dnce_M_e", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:dance13(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DANCING", "dnce_M_b", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:dance14(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "DANCING", "dnce_M_c", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:riflestance(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "PED", "IDLE_ARMED", 4.0, 1, 1, 0, 1, 1, 1);
	return 1;
}

CMD:liftup(playerid, params[])
{
	if(!AnimationCheck(playerid)) return SendErrorMessage(playerid, "Bu animasyonu þu anda kullanamazsýn.");
	PlayAnimation(playerid, "CARRY", "liftup", 3.0, 0, 0, 0, 0, 0);
	return 1;
}