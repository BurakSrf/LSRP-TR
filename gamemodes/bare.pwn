#include <a_samp>
#include <PAWN.Raknet>

#pragma tabsize 0


main()
{
	print("\n----------------------------------");
	print("  Bare Script\n");
	print("----------------------------------\n");
}

public OnPlayerConnect(playerid) 
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid,0);
	TogglePlayerClock(playerid,0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
   	return 1;
}

SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	return 1;
}

public OnGameModeInit()
{
	SetGameModeText("Bare Script");
	ShowPlayerMarkers(1);
	ShowNameTags(1);

	AddPlayerClass(265,2800.7026,-2417.7759,23.2186,243.5323,0,0,0,0,0,0); //
	return 1;
}

const PLAYER_SYNC = 207;

IPacket:PLAYER_SYNC(playerid, BitStream:bs)
{
    new onFootData[PR_OnFootSync];

    BS_IgnoreBits(bs, 8);
    BS_ReadOnFootSync(bs, onFootData);

    printf(
        "PLAYER_SYNC[%d]:\nlrKey %d \nudKey %d \nkeys %d \nposition: %.2f %.2f %.2f \nquaternion %.2f %.2f %.2f %.2f \nhealth %d \narmour %d \nadditionalKey %d \nweaponId %d \nspecialAction %d \nvelocity %.2f %.2f %.2f \nsurfingOffsets %.2f %.2f %.2f \nsurfingVehicleId %d \nanimationId %d \nanimationFlags %d",
        playerid,
        onFootData[PR_lrKey],
        onFootData[PR_udKey],
        onFootData[PR_keys],
        onFootData[PR_position][0],
        onFootData[PR_position][1],
        onFootData[PR_position][2],
        onFootData[PR_quaternion][0],
        onFootData[PR_quaternion][1],
        onFootData[PR_quaternion][2],
        onFootData[PR_quaternion][3],
        onFootData[PR_health],
        onFootData[PR_armour],
        onFootData[PR_additionalKey],
        onFootData[PR_weaponId],
        onFootData[PR_specialAction],
        onFootData[PR_velocity][0],
        onFootData[PR_velocity][1],
        onFootData[PR_velocity][2],
        onFootData[PR_surfingOffsets][0],
        onFootData[PR_surfingOffsets][1],
        onFootData[PR_surfingOffsets][2],
        onFootData[PR_surfingVehicleId],
        onFootData[PR_animationId],
        onFootData[PR_animationFlags]
    );


	if(onFootData[PR_velocity][1] > 0.1)
	{
		onFootData[PR_velocity][1] = 0; 
		BS_SetWriteOffset(bs, 8);
        BS_WriteOnFootSync(bs, onFootData);
	}

    BS_ResetReadPointer(bs);
    return 1;
}