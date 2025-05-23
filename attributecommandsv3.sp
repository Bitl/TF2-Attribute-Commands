#include <sourcemod>
#include <tf2attributes>
#include <tf_econ_data>

#define MAX_MENU_TIME 120
#define MAX_RUNTIME_ATTRIBUTES 20
//#define _DEBUG

//Plugin Info.
public Plugin:myinfo = 
{
	name = "ATTRIBUTE COMMANDS V3",
	author = "Bitl",
	description = "Allows you to use attributes to your advantage",
	version = "1.0",
	url = ""
}

//Events
public OnPluginStart()
{
	LoadTranslations("core.phrases");
	LoadTranslations("attributecommandsv3.cmd.phrases");
	LoadTranslations("attributecommandsv3.menu.core.phrases");
	LoadTranslations("attributecommandsv3.menu.killstreak.phrases");
	LoadTranslations("attributecommandsv3.menu.projectiles.phrases");
	
	RegConsoleCmd("sm_attribute", Command_Attribute);
	RegConsoleCmd("sm_attmenu", Command_ATTHelpMenu);
	
	HookEvent("player_spawn",event_playerspawn);
}

// Translation Functions
#define TRANSLATION_BUFFERSIZE 255

stock TranslatedChat(int client, const String:translationString[])
{
	PrintToChat(client, "[SM] %t", translationString);
}

stock TranslatedPanelText(Handle:menu, int client, const String:translationString[])
{
	new String:buffer[TRANSLATION_BUFFERSIZE];
	Format(buffer, sizeof(buffer), "%t", translationString, client);
	DrawPanelText(menu, buffer);  
}

stock TranslatedPanelItem(Handle:menu, int client, const String:translationString[])
{
	new String:buffer[TRANSLATION_BUFFERSIZE];
	Format(buffer, sizeof(buffer), "%t", translationString, client);
	DrawPanelItem(menu, buffer);  
}

stock TranslatedIDPanelText(Handle:menu, const String:id[], int client, const String:translationString[])
{
	new String:buffer[TRANSLATION_BUFFERSIZE];
	Format(buffer, sizeof(buffer), "%s - %t", id, translationString, client);
	DrawPanelText(menu, buffer);  
}

stock TranslatedMenuItem(Handle:menu, const String:id[], int client, const String:translationString[])
{
	new String:buffer[TRANSLATION_BUFFERSIZE];
	Format(buffer, sizeof(buffer), "%t", translationString, client);
	AddMenuItem(menu, id, buffer);
}

stock TranslatedMenuTitle(Handle:menu, int client, const String:translationString[])
{
	new String:buffer[TRANSLATION_BUFFERSIZE];
	Format(buffer, sizeof(buffer), "%t", translationString, client);
	SetMenuTitle(menu, buffer);
}

public Action:event_playerspawn(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	TranslatedChat(client, "AttCmds_V3_Ad");
}

//Commands

public Action:Command_Attribute(int client, int args)
{
	if (args < 2)
	{
		ReplyToCommand(client, "[SM] Usage: sm_attribute <clear|add|remove> <#attribute index id> [value]");
		return Plugin_Handled;
	}

	//declare args
	char mode[64];
	GetCmdArg(1, mode, sizeof(mode));
	
	if (!(StrEqual(mode, "clear") || StrEqual(mode, "add") || StrEqual(mode, "remove")))
	{
		ReplyToCommand(client, "[SM] Usage: sm_attribute <clear|add|remove> <#attribute index id> [value]");
		return Plugin_Handled;
	}
	
	new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	
	if (wep > 0)
	{
		if (StrEqual(mode, "clear"))
		{
#if defined _DEBUG
			PrintToChat(client, "[DEBUG] %s", mode);
#endif
			TF2Attrib_RemoveAll(wep);
			TranslatedChat(client, "AttCmds_V3_Clear");
		}
		else
		{
			char attribute[16];
			char value[32];
			GetCmdArg(2, attribute, sizeof(attribute));
			GetCmdArg(3, value, sizeof(value));
		
#if defined _DEBUG
			PrintToChat(client, "[DEBUG] %s %s %s", mode, attribute, value);
#endif
		
			if (StrEqual(mode, "add"))
			{
				TF2Attrib_SetByDefIndex(wep, StringToInt(attribute), StringToFloat(value));
				TranslatedChat(client, "AttCmds_V3_AddFloat");
			}
			else if (StrEqual(mode, "remove"))
			{
				TF2Attrib_RemoveByDefIndex(wep, StringToInt(attribute));
				TranslatedChat(client, "AttCmds_V3_Remove");
			}
		}
		
		TF2Attrib_ClearCache(wep);
	}
	else
	{
		TranslatedChat(client, "AttCmds_V3_NoActive");
	}
}

//Menus
public Action:Command_ATTHelpMenu(int client, int args)
{
	new Handle:menu = CreateMenu(AttributeMenuHandler, MenuAction_Select | MenuAction_End);
	TranslatedMenuTitle(menu, client, "AttCmds_V3_AttMenu_Title")
	
	TranslatedMenuItem(menu, "1", client, "AttCmds_V3_AttMenu_Commands");
	TranslatedMenuItem(menu, "2", client, "AttCmds_V3_AttMenu_UnusualParticles");
	TranslatedMenuItem(menu, "3", client, "AttCmds_V3_AttMenu_KillstreakEffects");
	TranslatedMenuItem(menu, "4", client, "AttCmds_V3_AttMenu_KillstreakSheens");
	TranslatedMenuItem(menu, "5", client, "AttCmds_V3_AttMenu_Projectiles");
	TranslatedMenuItem(menu, "6", client, "AttCmds_V3_AttMenu_AttributeList");
	SetMenuExitButton(menu, true);
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

public AttributeMenuHandler(Handle:menu, MenuAction:action, client, option)
{
	if(action == MenuAction_Select)
	{
		switch(option)
		{
			case 0:
			{
				new Handle:commandList = CreatePanel();
				
				TranslatedPanelText(commandList, client, "AttCmds_V3_AttMenu_Commands");
				DrawPanelText(commandList, "!attribute <clear|add|remove> <#attribute index id> [value]");
				TranslatedPanelText(commandList, client, "AttCmds_V3_CommandMenu_TFWiki");
				DrawPanelText(commandList, "https://wiki.teamfortress.com/wiki/List_of_item_attributes");
				
				TranslatedPanelItem(commandList, client, "Exit");
			 
				SendPanelToClient(commandList, client, Page_Handler, MAX_MENU_TIME);
			}
			case 1:
			{
				new Handle:particleList = CreatePanel();
				
				TranslatedPanelText(particleList, client, "AttCmds_V3_AttMenu_UnusualParticles");
				TranslatedPanelText(particleList, client, "AttCmds_V3_ParticleMenu_BackpackTF");
				DrawPanelText(particleList, "https://backpack.tf/developer/particles");
				
				TranslatedPanelItem(particleList, client, "Exit");
			 
				SendPanelToClient(particleList, client, Page_Handler, MAX_MENU_TIME);
			}
			case 2:
			{
				new Handle:killstreakEffects = CreatePanel();
				
				TranslatedPanelText(killstreakEffects, client, "AttCmds_V3_AttMenu_KillstreakEffects");
				TranslatedIDPanelText(killstreakEffects, "2002", client, "AttCmds_V3_Effects_FireHorns");
				TranslatedIDPanelText(killstreakEffects, "2003", client, "AttCmds_V3_Effects_CerebralDischarge");
				TranslatedIDPanelText(killstreakEffects, "2004", client, "AttCmds_V3_Effects_Tornado");
				TranslatedIDPanelText(killstreakEffects, "2005", client, "AttCmds_V3_Effects_Flames");
				TranslatedIDPanelText(killstreakEffects, "2006", client, "AttCmds_V3_Effects_Singularity");
				TranslatedIDPanelText(killstreakEffects, "2007", client, "AttCmds_V3_Effects_Incinerator");
				TranslatedIDPanelText(killstreakEffects, "2008", client, "AttCmds_V3_Effects_HypnoBeam");
				
				TranslatedPanelItem(killstreakEffects, client, "Exit");
			 
				SendPanelToClient(killstreakEffects, client, Page_Handler, MAX_MENU_TIME);
			}
			case 3:
			{
				new Handle:killstreakSheens = CreatePanel();
				
				TranslatedPanelText(killstreakSheens, client, "AttCmds_V3_AttMenu_KillstreakSheens");
				TranslatedIDPanelText(killstreakSheens, "1", client, "AttCmds_V3_Sheens_TeamShine");
				TranslatedIDPanelText(killstreakSheens, "2", client, "AttCmds_V3_Sheens_DeadlyDaffodil");
				TranslatedIDPanelText(killstreakSheens, "3", client, "AttCmds_V3_Sheens_Manndarin");
				TranslatedIDPanelText(killstreakSheens, "4", client, "AttCmds_V3_Sheens_MeanGreen");
				TranslatedIDPanelText(killstreakSheens, "5", client, "AttCmds_V3_Sheens_AgonizingEmerald");
				TranslatedIDPanelText(killstreakSheens, "6", client, "AttCmds_V3_Sheens_VillainousViolet");
				TranslatedIDPanelText(killstreakSheens, "7", client, "AttCmds_V3_Sheens_HotRod");
				
				TranslatedPanelItem(killstreakSheens, client, "Exit");
			 
				SendPanelToClient(killstreakSheens, client, Page_Handler, MAX_MENU_TIME);
			}
			case 4:
			{
				new Handle:projectileMenu = CreatePanel();
				
				TranslatedPanelText(projectileMenu, client, "AttCmds_V3_AttMenu_Projectiles");
				DrawPanelText(projectileMenu, "#1");
				TranslatedIDPanelText(projectileMenu, "1", client, "AttCmds_V3_Projectiles_Bullet");
				TranslatedIDPanelText(projectileMenu, "2", client, "AttCmds_V3_Projectiles_Rocket");
				TranslatedIDPanelText(projectileMenu, "3", client, "AttCmds_V3_Projectiles_Pipebomb");
				TranslatedIDPanelText(projectileMenu, "4", client, "AttCmds_V3_Projectiles_Sticky");
				TranslatedIDPanelText(projectileMenu, "5", client, "AttCmds_V3_Projectiles_Syringe");
				TranslatedIDPanelText(projectileMenu, "6", client, "AttCmds_V3_Projectiles_Flare");
				TranslatedIDPanelText(projectileMenu, "7", client, "AttCmds_V3_Projectiles_Jarate");
				TranslatedIDPanelText(projectileMenu, "8", client, "AttCmds_V3_Projectiles_Arrow");
				TranslatedIDPanelText(projectileMenu, "9", client, "AttCmds_V3_Projectiles_FlameRocket");
				TranslatedIDPanelText(projectileMenu, "10", client, "AttCmds_V3_Projectiles_MadMilk");
				TranslatedIDPanelText(projectileMenu, "11", client, "AttCmds_V3_Projectiles_CrossbowBolt");
				TranslatedIDPanelText(projectileMenu, "12", client, "AttCmds_V3_Projectiles_ManglerParticle");
				TranslatedIDPanelText(projectileMenu, "13", client, "AttCmds_V3_Projectiles_BisonParticle");
				TranslatedIDPanelText(projectileMenu, "14", client, "AttCmds_V3_Projectiles_StickyPractice");
				
				TranslatedPanelItem(projectileMenu, client, "Next");
			 
				SendPanelToClient(projectileMenu, client, ProjectilePage_Handler, MAX_MENU_TIME);
			}
			case 5:
			{
				new wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
			
				if (wep > 0)
				{
					new Handle:attributeList = CreatePanel();
					
					TranslatedPanelText(attributeList, client, "AttCmds_V3_AttributeList_Title");
					
					int attriblist[MAX_RUNTIME_ATTRIBUTES];
					float valuelist[MAX_RUNTIME_ATTRIBUTES];
					char atts[2048][512]; 
					
					int count = TF2Attrib_ListDefIndices(wep, attriblist, sizeof(attriblist));
					int entVal = 0;
					for (int i = 0; i < count && i < sizeof(attriblist); i++)
					{
						Address pAttrib = TF2Attrib_GetByDefIndex(wep, attriblist[i]);
						
						new String:attributeNameBuffer[128];
						TF2Econ_GetAttributeName(attriblist[i], attributeNameBuffer, sizeof(attributeNameBuffer));
						
						float value = TF2Attrib_GetValue(pAttrib);
						
						entVal = i;
						
						new String:buffer[256];
						Format(buffer, sizeof(buffer), "- %s (ID: %d): %6.2f", attributeNameBuffer, attriblist[i], value);
						
						atts[i] = buffer;  
					}
					
					int count_static = TF2Attrib_GetSOCAttribs(wep, attriblist, valuelist, sizeof(attriblist));
					int socVal = 0;
					for (int i = 0; i < count_static; i++)
					{
						new String:attributeNameBuffer[128];
						TF2Econ_GetAttributeName(attriblist[i], attributeNameBuffer, sizeof(attributeNameBuffer));
						
						socVal = i;
						
						new String:buffer[256];
						Format(buffer, sizeof(buffer), "- %s (ID: %d): %6.2f", attributeNameBuffer, attriblist[i], valuelist[i]);
						
						atts[entVal + (i + 1)] = buffer;
					}
					
					int iDefIndex = GetEntProp(wep, Prop_Send, "m_iItemDefinitionIndex");
					count_static = TF2Attrib_GetStaticAttribs(iDefIndex, attriblist, valuelist);
					for (int i = 0; i < count_static; i++)
					{
						new String:attributeNameBuffer[128];
						TF2Econ_GetAttributeName(attriblist[i], attributeNameBuffer, sizeof(attributeNameBuffer));
						
						new String:buffer[256];
						Format(buffer, sizeof(buffer), "- %s (ID: %d): %6.2f", attributeNameBuffer, attriblist[i], valuelist[i]);
						
						atts[entVal + socVal + (i + 1)] = buffer;
					}
					
					for (int i = 0; i < sizeof(atts); i++)
					{
						DrawPanelText(attributeList, atts[i]);
					}
					
					TranslatedPanelItem(attributeList, client, "Exit");
					
					SendPanelToClient(attributeList, client, Page_Handler, MAX_MENU_TIME);
				}
			}
		}
	}
	else if(action == MenuAction_End)
	{
		CloseHandle(menu);
	}
}

public ProjectilePage_Handler(Handle:menu, MenuAction:action, client, option)
{
	if (action == MenuAction_Select)
	{
		new Handle:projectileMenu = CreatePanel();
		
		TranslatedPanelText(projectileMenu, client, "AttCmds_V3_AttMenu_Projectiles");
		DrawPanelText(projectileMenu, "#2");
		TranslatedIDPanelText(projectileMenu, "15", client, "AttCmds_V3_Projectiles_Cleaver");
		TranslatedIDPanelText(projectileMenu, "16", client, "AttCmds_V3_Projectiles_StickyBall");
		TranslatedIDPanelText(projectileMenu, "17", client, "AttCmds_V3_Projectiles_Cannonball");
		TranslatedIDPanelText(projectileMenu, "18", client, "AttCmds_V3_Projectiles_RangerBolt");
		TranslatedIDPanelText(projectileMenu, "19", client, "AttCmds_V3_Projectiles_FestiveArrow");
		TranslatedIDPanelText(projectileMenu, "20", client, "AttCmds_V3_Projectiles_Throwable");
		TranslatedIDPanelText(projectileMenu, "21", client, "AttCmds_V3_Projectiles_Fireball");
		TranslatedIDPanelText(projectileMenu, "22", client, "AttCmds_V3_Projectiles_FestiveUrine");
		TranslatedIDPanelText(projectileMenu, "23", client, "AttCmds_V3_Projectiles_FestiveCrossbowBolt");
		TranslatedIDPanelText(projectileMenu, "24", client, "AttCmds_V3_Projectiles_BeautyMark");
		TranslatedIDPanelText(projectileMenu, "25", client, "AttCmds_V3_Projectiles_MutatedMilk");
		TranslatedIDPanelText(projectileMenu, "26", client, "AttCmds_V3_Projectiles_GrapplingHook");
		TranslatedIDPanelText(projectileMenu, "27", client, "AttCmds_V3_Projectiles_SentryRocket");
		TranslatedIDPanelText(projectileMenu, "28", client, "AttCmds_V3_Projectiles_BreadMonster");
		TranslatedIDPanelText(projectileMenu, "29", client, "AttCmds_V3_Projectiles_Gas");
		TranslatedIDPanelText(projectileMenu, "30", client, "AttCmds_V3_Projectiles_BallOfFire");
		
		TranslatedPanelItem(projectileMenu, client, "Exit");
	 
		SendPanelToClient(projectileMenu, client, Page_Handler, MAX_MENU_TIME);
	}
}

public Page_Handler(Handle:menu, MenuAction:action, client, option)
{
	if (action == MenuAction_Select)
	{
		CloseHandle(menu)
	}
}