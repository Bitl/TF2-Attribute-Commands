#include <sourcemod>
#include <tf2_stocks>
#include <tf2attributes>

new Handle:sm_attcommands_autoregen;

public Plugin:myinfo = 
{
	name = "ATTRIBUTE COMMANDS V2",
	author = "Bitl",
	description = "Allows you to use attributes to your advantage",
	version = "1.0",
	url = ""
}

public OnPluginStart()
{
	LoadTranslations("common.phrases");
	sm_attcommands_autoregen = CreateConVar("sm_attcommands_autoregen", "0", "Should the player automatically regenerate after applying the attribute?", FCVAR_NOTIFY);
	RegConsoleCmd("sm_attremoveall", Command_RemoveAttributes);
	RegConsoleCmd("sm_attremove", Command_RemoveAttribute);
	RegConsoleCmd("sm_attadd", Command_AddAttribute);
	RegConsoleCmd("sm_attdamage", Command_AddDamageBonus);
	RegConsoleCmd("sm_attclipsize", Command_AddClipSizeBonus);
	RegConsoleCmd("sm_attfirerate", Command_AddFireRateBonus);
	RegConsoleCmd("sm_attkillstreak", Command_AddKillstreak);
	RegConsoleCmd("sm_attaustralium", Command_AddAustralium);
	RegConsoleCmd("sm_attgold", Command_AddGold);
	RegConsoleCmd("sm_attparticle", Command_AddParticle);
	RegConsoleCmd("sm_attprojspeed", Command_AddProjectileSpeed);
	RegConsoleCmd("sm_attprojspread", Command_AddProjectileSpread);
	RegConsoleCmd("sm_attprojtype", Command_AddProjectileType);
	RegConsoleCmd("sm_attrandom", Command_AddRandom);
	RegConsoleCmd("sm_attstreaktier", Command_AddTier);
	RegConsoleCmd("sm_attstreaksheen", Command_AddSheen);
	RegConsoleCmd("sm_attstreakeffect", Command_AddEffect);
	RegConsoleCmd("sm_attspeed", Command_AddSpeed);
	RegConsoleCmd("sm_attreload", Command_AddReload);
	RegConsoleCmd("sm_attmaxhealth", Command_AddMaxHealth);
	RegConsoleCmd("sm_attplasma", Command_AddPlasma);
	RegConsoleCmd("sm_attash", Command_AddAsh);
	RegConsoleCmd("sm_attactive", Command_AddActive);
	RegConsoleCmd("sm_attnorandomcrits", Command_AddNoRandomCrits);
	RegConsoleCmd("sm_attdamagepenalty", Command_AddDamagePenalty);
	RegConsoleCmd("sm_attclipsizepenalty", Command_AddClipSizePenalty);
	RegConsoleCmd("sm_attfireratepenalty", Command_AddFireRatePenalty);
	RegConsoleCmd("sm_attprojspeedpenalty", Command_AddProjectileSpeedPenalty);
	RegConsoleCmd("sm_atthealthregen", Command_AddHealthRegen);
	RegConsoleCmd("sm_attammoregen", Command_AddAmmoRegen);
	RegConsoleCmd("sm_attkillcrits", Command_AddCritsOnKill);
	RegConsoleCmd("sm_attreloadpenalty", Command_AddReloadPenalty);
	RegConsoleCmd("sm_attmaxhealthpenalty", Command_AddMaxHealthPenalty);
	RegConsoleCmd("sm_attgive", Command_AddAttributeToPlayer);
	RegConsoleCmd("sm_attgivestreak", Command_AddKillstreakToPlayer);
	RegConsoleCmd("sm_attregen", Command_Regen);
	RegConsoleCmd("sm_attmenu", Command_ATTHelpMenu);
	
	HookEvent("player_spawn",event_playerspawn);
}

public Action:event_playerspawn(Handle:event,const String:name[],bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	PrintToChat(client, "Type !attmenu in chat to open the Attribute Menu.");
}

public Action:Command_RemoveAttributes(client, args)
{
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_RemoveAll(wep);
	PrintToChat(client, "[SM] Removed all Attributes on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_RemoveAttribute(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_RemoveByName(wep, arg1);
	PrintToChat(client, "[SM] Removed the Attribute on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddAttribute(client, args)
{
	decl String:arg1[64];
	decl String:arg2[128];
	GetCmdArg(1, arg1, sizeof(arg1));
	GetCmdArg(2, arg2, sizeof(arg2));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, arg1, StringToFloat(arg2));
	PrintToChat(client, "[SM] Added a custom Attribute on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddDamageBonus(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "damage bonus", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added a Damage Bonus on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddClipSizeBonus(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "clip size bonus", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added a Clip Size Bonus on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddFireRateBonus(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "fire rate bonus", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added a Fire Rate Bonus on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddKillstreak(client, args)
{
	decl String:arg1[64];
	decl String:arg2[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	GetCmdArg(2, arg2, sizeof(arg2));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	if (args < 2)
	{
		TF2Attrib_SetByName(wep, "killstreak effect", GetRandomFloat(2002.0, 2008.0));
		TF2Attrib_SetByName(wep, "killstreak idleeffect", GetRandomFloat(1.0, 7.0));
		TF2Attrib_SetByName(wep, "killstreak tier", 1.0);
		PrintToChat(client, "[SM] Added a Random Killstreak on the current weapon");
	}
	else
	{
		TF2Attrib_SetByName(wep, "killstreak effect", StringToFloat(arg1));
		TF2Attrib_SetByName(wep, "killstreak idleeffect", StringToFloat(arg2));
		TF2Attrib_SetByName(wep, "killstreak tier", 1.0);
		PrintToChat(client, "[SM] Added a Custom Killstreak on the current weapon");
	}
	
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddAustralium(client, args)
{
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "is australium item", 1.0);
	TF2Attrib_SetByName(wep, "loot rarity", 1.0);
	TF2Attrib_SetByName(wep, "item style override", 1.0);
	PrintToChat(client, "[SM] Added Australium on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddGold(client, args)
{
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_RemoveByName(wep, "ragdolls plasma effect");
	TF2Attrib_RemoveByName(wep, "ragdolls become ash");
	TF2Attrib_SetByName(wep, "turn to gold", 1.0);
	PrintToChat(client, "[SM] Added Gold Effect on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddParticle(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "attach particle effect", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added a Particle on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddProjectileSpeed(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "Projectile speed increased", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added Projectile Speed Bonus on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddProjectileSpread(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "projectile spread angle penalty", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added Projectile Spread on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddProjectileType(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "override projectile type", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added Projectile Type on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddRandom(client, args)
{
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");

	TF2Attrib_SetByName(wep, "damage bonus", GetRandomFloat(1.1, 9.9));
	TF2Attrib_SetByName(wep, "clip size bonus", GetRandomFloat(1.1, 9.9));
	TF2Attrib_SetByName(wep, "fire rate bonus", GetRandomFloat(0.1, 0.9));
	TF2Attrib_SetByName(wep, "move speed bonus", GetRandomFloat(1.1, 9.9));
	TF2Attrib_SetByName(wep, "Reload time decreased", GetRandomFloat(0.1, 0.9));
	TF2Attrib_SetByName(wep, "max health additive bonus", GetRandomFloat(10.0, 999.0));
	PrintToChat(client, "[SM] Added Random Attributes on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddTier(client, args)
{
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "killstreak tier", 1.0);
	PrintToChat(client, "[SM] Added a Killstreak Tier on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddSheen(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	if (args < 1)
	{
		TF2Attrib_SetByName(wep, "killstreak idleeffect", GetRandomFloat(1.0, 7.0));
		PrintToChat(client, "[SM] Added a Random Killstreak Sheen on the current weapon");
	}
	else
	{
		TF2Attrib_SetByName(wep, "killstreak idleeffect", StringToFloat(arg1));
		PrintToChat(client, "[SM] Added a Custom Killstreak Sheen on the current weapon");
	}
	
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddEffect(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	if (args < 1)
	{
		TF2Attrib_SetByName(wep, "killstreak effect", GetRandomFloat(2002.0, 2008.0));
		PrintToChat(client, "[SM] Added a Random Killstreak Effect on the current weapon");
	}
	else
	{
		TF2Attrib_SetByName(wep, "killstreak effect", StringToFloat(arg1));
		PrintToChat(client, "[SM] Added a Custom Killstreak Effect on the current weapon");
	}
	
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddSpeed(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "move speed bonus", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added Speed Bonus on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddReload(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "Reload time decreased", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added Reload Bonus on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddMaxHealth(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "max health additive bonus", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added Max Health Bonus on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddPlasma(client, args)
{
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_RemoveByName(wep, "turn to gold");
	TF2Attrib_RemoveByName(wep, "ragdolls become ash");
	TF2Attrib_SetByName(wep, "ragdolls plasma effect", 1.0);
	PrintToChat(client, "[SM] Added Plasma Effect on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddAsh(client, args)
{
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_RemoveByName(wep, "turn to gold");
	TF2Attrib_RemoveByName(wep, "ragdolls plasma effect");
	TF2Attrib_SetByName(wep, "ragdolls become ash", 1.0);
	PrintToChat(client, "[SM] Added Ash Effect on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddActive(client, args)
{
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "provide on active", 1.0);
	PrintToChat(client, "[SM] Added Provide on Active on the current weapon. All Attributes added after will only be used when the weapon is active.");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddNoRandomCrits(client, args)
{
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "crit mod disabled", 1.0);
	PrintToChat(client, "[SM] Added No Random Crits on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddDamagePenalty(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "damage penalty", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added a Damage Penalty on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddClipSizePenalty(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "clip size penalty", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added a Clip Size Penalty on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddFireRatePenalty(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "fire rate penalty", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added a Fire Rate Penalty on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddProjectileSpeedPenalty(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "Projectile speed decreased", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added Projectile Speed Penalty on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddHealthRegen(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "health regen", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added Health Regen on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddAmmoRegen(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "ammo regen", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added Ammo Regen on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddCritsOnKill(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "critboost on kill", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added Crits On Kill on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddReloadPenalty(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "Reload time increased", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added Reload Penalty on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddMaxHealthPenalty(client, args)
{
	decl String:arg1[64];
	GetCmdArg(1, arg1, sizeof(arg1));
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	TF2Attrib_SetByName(wep, "max health additive penalty", StringToFloat(arg1));
	PrintToChat(client, "[SM] Added Max Health Penalty on the current weapon");
	if (GetConVarBool(sm_attcommands_autoregen))
	{
		TF2_RegeneratePlayer(client);
	}
}

public Action:Command_AddAttributeToPlayer(client, args)
{
	new String:arg1[128];
	GetCmdArg(1, arg1, 128);
	//Create strings
	decl String:buffer[64];
	decl String:target_name[MAX_NAME_LENGTH];
	decl target_list[MAXPLAYERS];
	decl target_count;
	decl bool:tn_is_ml;
		
	//Get target arg
	GetCmdArg(1, buffer, sizeof(buffer));
		
	//Process
	if ((target_count = ProcessTargetString(
			buffer,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE,
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
		
	for (new i = 0; i < target_count; i ++)
	{
		new String:attribute[32], String:value[64];
		for (new l = 2; l <= args; l += 2)
		{
			GetCmdArg(l, attribute, sizeof(attribute));
			GetCmdArg(l+1, value, sizeof(value));
			new wep = GetEntPropEnt(target_list[i], Prop_Send, "m_hActiveWeapon");
			if (StrEqual(attribute, "damagebonus"))
			{
				TF2Attrib_SetByName(wep, "damage bonus", StringToFloat(value));
			}
			else if (StrEqual(attribute, "clipsizebonus"))
			{
				TF2Attrib_SetByName(wep, "clip size bonus", StringToFloat(value));
			}
			else if (StrEqual(attribute, "fireratebonus"))
			{
				TF2Attrib_SetByName(wep, "fire rate bonus", StringToFloat(value));
			}
			else if (StrEqual(attribute, "particle"))
			{
				TF2Attrib_SetByName(wep, "attach particle effect", StringToFloat(value));
			}
			else if (StrEqual(attribute, "projspeed"))
			{
				TF2Attrib_SetByName(wep, "Projectile speed increased", StringToFloat(value));
			}
			else if (StrEqual(attribute, "projspread"))
			{
				TF2Attrib_SetByName(wep, "projectile spread angle penalty", StringToFloat(value));
			}
			else if (StrEqual(attribute, "projtype"))
			{
				TF2Attrib_SetByName(wep, "override projectile type", StringToFloat(value));
			}
			else if (StrEqual(attribute, "speedbonus"))
			{
				TF2Attrib_SetByName(wep, "move speed bonus", StringToFloat(value));
			}
			else if (StrEqual(attribute, "reloadbonus"))
			{
				TF2Attrib_SetByName(wep, "Reload time decreased", StringToFloat(value));
			}
			else if (StrEqual(attribute, "maxhealthbonus"))
			{
				TF2Attrib_SetByName(wep, "max health additive bonus", StringToFloat(value));
			}
			else if (StrEqual(attribute, "healthregenbonus"))
			{
				TF2Attrib_SetByName(wep, "health regen", StringToFloat(value));
			}
			else if (StrEqual(attribute, "ammoregenbonus"))
			{
				TF2Attrib_SetByName(wep, "ammo regen", StringToFloat(value));
			}
			else if (StrEqual(attribute, "killcrits"))
			{
				TF2Attrib_SetByName(wep, "critboost on kill", StringToFloat(value));
			}
			
			PrintToChat(client, "[SM] You added Attributes on %N's current weapon!", target_list[i]);
			
			if (GetConVarBool(sm_attcommands_autoregen))
			{
				TF2_RegeneratePlayer(target_list[i]);
			}
		}	
	}

	return Plugin_Handled;
}

public Action:Command_AddKillstreakToPlayer(client, args)
{
	new String:arg1[128];
	GetCmdArg(1, arg1, 128);
	//Create strings
	decl String:buffer[64];
	decl String:target_name[MAX_NAME_LENGTH];
	decl target_list[MAXPLAYERS];
	decl target_count;
	decl bool:tn_is_ml;
		
	//Get target arg
	GetCmdArg(1, buffer, sizeof(buffer));
		
	//Process
	if ((target_count = ProcessTargetString(
			buffer,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE,
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
		
	for (new i = 0; i < target_count; i ++)
	{
		new String:effect[32], String:sheen[32];
		GetCmdArg(2, effect, sizeof(effect));
		GetCmdArg(3, sheen, sizeof(sheen));
		new wep = GetEntPropEnt(target_list[i], Prop_Send, "m_hActiveWeapon");
		if (StrEqual(effect, "1"))
		{
			TF2Attrib_SetByName(wep, "killstreak effect", 2002.0);
		}
		else if (StrEqual(effect, "2"))
		{
			TF2Attrib_SetByName(wep, "killstreak effect", 2003.0);
		}
		else if (StrEqual(effect, "3"))
		{
			TF2Attrib_SetByName(wep, "killstreak effect", 2004.0);
		}
		else if (StrEqual(effect, "4"))
		{
			TF2Attrib_SetByName(wep, "killstreak effect", 2005.0);
		}
		else if (StrEqual(effect, "5"))
		{
			TF2Attrib_SetByName(wep, "killstreak effect", 2006.0);
		}
		else if (StrEqual(effect, "6"))
		{
			TF2Attrib_SetByName(wep, "killstreak effect", 2007.0);
		}
		else if (StrEqual(effect, "7"))
		{
			TF2Attrib_SetByName(wep, "killstreak effect", 2008.0);
		}

		if (StrEqual(sheen, "1"))
		{
			TF2Attrib_SetByName(wep, "killstreak idleeffect", 1.0);
		}
		else if (StrEqual(sheen, "2"))
		{
			TF2Attrib_SetByName(wep, "killstreak idleeffect", 2.0);
		}
		else if (StrEqual(sheen, "3"))
		{
			TF2Attrib_SetByName(wep, "killstreak idleeffect", 3.0);
		}
		else if (StrEqual(sheen, "4"))
		{
			TF2Attrib_SetByName(wep, "killstreak idleeffect", 4.0);
		}
		else if (StrEqual(sheen, "5"))
		{
			TF2Attrib_SetByName(wep, "killstreak idleeffect", 5.0);
		}
		else if (StrEqual(sheen, "6"))
		{
			TF2Attrib_SetByName(wep, "killstreak idleeffect", 6.0);
		}
		else if (StrEqual(sheen, "7"))
		{
			TF2Attrib_SetByName(wep, "killstreak idleeffect", 7.0);
		}

		TF2Attrib_SetByName(wep, "killstreak tier", 1.0);
			
		PrintToChat(client, "[SM] You added a Killstreak on %N's current weapon!", target_list[i]);
		
		if (GetConVarBool(sm_attcommands_autoregen))
		{
			TF2_RegeneratePlayer(target_list[i]);
		}
	}

	return Plugin_Handled;
}

public Action:Command_Regen(client, args)
{
	TF2_RegeneratePlayer(client);
	PrintToChat(client, "[SM] You are now regenerated.");
}

public Action:Command_ATTHelpMenu(client, args)
{
	HelpMenu(client);
}

stock HelpMenu(client)
{
	new Handle:menu = CreateMenu(AttributeMenuHandler, MenuAction_Select | MenuAction_End);
	SetMenuTitle(menu, "Attribute Menu");

	AddMenuItem(menu, "particlelist", "Particle List");
	AddMenuItem(menu, "killstreakeffectslist", "Killstreak Effect List");
	AddMenuItem(menu, "killstreaksheenlist", "Killstreak Sheen List");
	AddMenuItem(menu, "attributelist", "Attribute List");
	AddMenuItem(menu, "attgivelist", "!attgive List");
	AddMenuItem(menu, "commandlist", "Command List");
	AddMenuItem(menu, "projlist", "Projectile List");

	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

public AttributeMenuHandler(Handle:menu, MenuAction:action, param1, param2)
{
	switch (action)
	{
		case MenuAction_Select:
		{
			//param1 is client, param2 is item

			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));

			if (StrEqual(item, "particlelist"))
			{
				ParticleList(param1);
			}
			else if (StrEqual(item, "killstreakeffectslist"))
			{
				KillstreakEffects(param1);
			}
			else if (StrEqual(item, "killstreaksheenlist"))
			{
				KillstreakSheens(param1);
			}
			else if (StrEqual(item, "attributelist"))
			{
				AttributeList(param1);
			}
			else if (StrEqual(item, "attgivelist"))
			{
				AttGiveList(param1);
			}
			else if (StrEqual(item, "commandlist"))
			{
				CommandList(param1);
			}
			else if (StrEqual(item, "projlist"))
			{
				ProjectileList(param1);
			}
		}

		case MenuAction_End:
		{
			//param1 is MenuEnd reason, if canceled param2 is MenuCancel reason
			CloseHandle(menu);

		}

	}
}

stock CommandList(client)
{
	new Handle:menu = CreateMenu(CommandListHandler, MenuAction_Select | MenuAction_End);
	SetMenuTitle(menu, "Command List");

	AddMenuItem(menu, "page1", "Page 1");
	AddMenuItem(menu, "page2", "Page 2");
	AddMenuItem(menu, "page3", "Page 3");

	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

public CommandListHandler(Handle:menu, MenuAction:action, param1, param2)
{
	switch (action)
	{
		case MenuAction_Select:
		{
			//param1 is client, param2 is item

			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));

			if (StrEqual(item, "page1"))
			{
				CommandListPage1(param1);
			}
			else if (StrEqual(item, "page2"))
			{
				CommandListPage2(param1);
			}
			else if (StrEqual(item, "page3"))
			{
				CommandListPage3(param1);
			}
		}

		case MenuAction_End:
		{
			//param1 is MenuEnd reason, if canceled param2 is MenuCancel reason
			CloseHandle(menu);

		}

	}
}

stock ParticleList(client)
{
	ShowMOTDPanel(client, "Particle List", "http://optf2.com/440/particles",  MOTDPANEL_TYPE_URL)
}

stock AttributeList(client)
{
	ShowMOTDPanel(client, "Attribute List", "http://optf2.com/440/attributes",  MOTDPANEL_TYPE_URL)
}

stock AttGiveList(client)
{
	new Handle:menu = CreatePanel();
	DrawPanelText(menu, "Please note that these are ONLY used with the !attgive command.");
	DrawPanelText(menu, "damagebonus <value>");
	DrawPanelText(menu, "clipsizebonus <value>");
	DrawPanelText(menu, "fireratebonus <inverted value>");
	DrawPanelText(menu, "particle <particle ID>");
	DrawPanelText(menu, "projspeed <value>");
	DrawPanelText(menu, "projspread <number>");
	DrawPanelText(menu, "projtype <projectile ID>");
	DrawPanelText(menu, "speedbonus <value>");
	DrawPanelText(menu, "reloadbonus <inverted value>");
	DrawPanelText(menu, "maxhealthbonus <number>");
	DrawPanelText(menu, "healthregenbonus <number>");
	DrawPanelText(menu, "ammoregenbonus <value>");
	DrawPanelText(menu, "killcrits <number>");
	DrawPanelItem(menu, "Close");
 
	SendPanelToClient(menu, client, Page_Handler, 20);
 
	CloseHandle(menu);
}

stock KillstreakEffects(client)
{
	new Handle:menu = CreatePanel();
	DrawPanelText(menu, "1 - Fire Horns ID: 2002");
	DrawPanelText(menu, "2 - Cerebral Discharge ID: 2003");
	DrawPanelText(menu, "3 - Tornado ID: 2004");
	DrawPanelText(menu, "4 - Flames ID: 2005");
	DrawPanelText(menu, "5 - Singularity ID: 2006");
	DrawPanelText(menu, "6 - Incinerator ID: 2007");
	DrawPanelText(menu, "7 - Hypno-Beam ID: 2008");
	DrawPanelItem(menu, "Close");
 
	SendPanelToClient(menu, client, Page_Handler, 20);
 
	CloseHandle(menu);
}

stock KillstreakSheens(client)
{
	new Handle:menu = CreatePanel();
	DrawPanelText(menu, "1 - Team Shine");
	DrawPanelText(menu, "2 - Deadly Daffodil");
	DrawPanelText(menu, "3 - Manndarin");
	DrawPanelText(menu, "4 - Mean Green");
	DrawPanelText(menu, "5 - Agonizing Emerald");
	DrawPanelText(menu, "6 - Villainous Violet");
	DrawPanelText(menu, "7 - Hot Rod");
	DrawPanelItem(menu, "Close");
 
	SendPanelToClient(menu, client, Page_Handler, 20);
 
	CloseHandle(menu);
}

stock ProjectileList(client)
{
	new Handle:menu = CreatePanel();
	DrawPanelText(menu, "1 - Bullet");
	DrawPanelText(menu, "2 - Rocket");
	DrawPanelText(menu, "3 - Pipebomb");
	DrawPanelText(menu, "4 - Stickybomb");
	DrawPanelText(menu, "5 - Syringe");
	DrawPanelText(menu, "6 - Flare");
	DrawPanelText(menu, "8 - Huntsman Arrow");
	DrawPanelText(menu, "11 - Crusader's Crossbow Arrow");
	DrawPanelText(menu, "12 - Cow Mangler Particle");
	DrawPanelText(menu, "13 - Righteous Bison Particle");
	DrawPanelText(menu, "14 - Sticky Jumper Stickybomb");
	DrawPanelText(menu, "17 - Cannonball");
	DrawPanelText(menu, "18 - Rescue Ranger Bolt");
	DrawPanelText(menu, "19 - Festive Huntsman Arrow");
	DrawPanelItem(menu, "Close");
 
	SendPanelToClient(menu, client, Page_Handler, 20);
 
	CloseHandle(menu);
}

stock CommandListPage1(client)
{
	new Handle:menu = CreatePanel();
	DrawPanelText(menu, "!attremoveall");
	DrawPanelText(menu, "!attremove <name of attribute>");
	DrawPanelText(menu, "!attadd <name of attribute> <custom value>");
	DrawPanelText(menu, "!attdamage <value>");
	DrawPanelText(menu, "!attclipsize <value>");
	DrawPanelText(menu, "!attfirerate <inverted value>");
	DrawPanelText(menu, "!attkillstreak <effect ID> <sheen ID>");
	DrawPanelText(menu, "!attaustralium");
	DrawPanelText(menu, "!attgold");
	DrawPanelText(menu, "!attparticle <particle ID>");
	DrawPanelText(menu, "!attprojspeed <value>");
	DrawPanelText(menu, "!attprojspread <number>");
	DrawPanelText(menu, "!attprojtype <projectile ID>");
	DrawPanelText(menu, "!attrandom");
	DrawPanelItem(menu, "Close");
 
	SendPanelToClient(menu, client, Page_Handler, 20);
 
	CloseHandle(menu);
}

stock CommandListPage2(client)
{
	new Handle:menu = CreatePanel();
	DrawPanelText(menu, "!attstreaktier");
	DrawPanelText(menu, "!attstreaksheen <sheen ID>");
	DrawPanelText(menu, "!attstreakeffect <effect ID>");
	DrawPanelText(menu, "!attspeed <value>");
	DrawPanelText(menu, "!attreload <inverted value>");
	DrawPanelText(menu, "!attmaxhealth <number>");
	DrawPanelText(menu, "!attplasma");
	DrawPanelText(menu, "!attash");
	DrawPanelText(menu, "!attactive");
	DrawPanelText(menu, "!attnorandomcrits");
	DrawPanelText(menu, "!attdamagepenalty <value>");
	DrawPanelText(menu, "!attclipsizepenalty <value>");
	DrawPanelText(menu, "!attfireratepenalty <inverted value>");
	DrawPanelText(menu, "!attprojspeedpenalty <value>");
	DrawPanelItem(menu, "Close");
 
	SendPanelToClient(menu, client, Page_Handler, 20);
 
	CloseHandle(menu);
}

stock CommandListPage3(client)
{
	new Handle:menu = CreatePanel();
	DrawPanelText(menu, "!atthealthregen <number>");
	DrawPanelText(menu, "!attammoregen <value>");
	DrawPanelText(menu, "!attkillcrits <number>");
	DrawPanelText(menu, "!attreloadpenalty <value>");
	DrawPanelText(menu, "!attmaxhealthpenalty <number>");
	DrawPanelText(menu, "!attgive <client> <attribute> <value>");
	DrawPanelText(menu, "!attgivestreak <client> <effect number (1-7)> <sheen number (1-7)>");
	DrawPanelText(menu, "!attregen");
	DrawPanelItem(menu, "Close");
 
	SendPanelToClient(menu, client, Page_Handler, 20);
 
	CloseHandle(menu);
}

public Page_Handler(Handle:menu, MenuAction:action, param1, param2)
{
	//null
}