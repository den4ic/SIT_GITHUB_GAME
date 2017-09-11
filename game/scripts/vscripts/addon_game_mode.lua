require('internal/util')
require('gamemode')
require('dropkill')
require('craft_menu')
-- RegisterCustomAnimationScriptForModel( "models/heroes/medusa/medusa.vmdl", "animation/heroes/medusa/medusa_custom.lua" )

function Precache( context )
  -- HEROES
  -- for i=1, 8, 1 do
  --   print(i)
  --   PrecacheUnitByNameSync("npc_dota_hero_omniknight", context,i-1)
  -- end
  -- PrecacheUnitByNameSync("npc_dota_hero_brewmaster", context)

  PrecacheUnitByNameSync("npc_dota_hero_omniknight", context)
  PrecacheUnitByNameSync("npc_dota_hero_wisp", context)
  PrecacheUnitByNameSync("npc_bear", context)
  PrecacheUnitByNameSync("north_sheep", context)
  PrecacheUnitByNameSync("Northern_Wolf", context)
  PrecacheUnitByNameSync("Northern_Bear", context)
  PrecacheUnitByNameSync("Brown_Bear", context)
  PrecacheUnitByNameSync("npc_boar", context)
  PrecacheUnitByNameSync("Snow_Wolf", context)
  PrecacheUnitByNameSync("npc_spider", context)
  PrecacheUnitByNameSync("npc_fish", context)
  PrecacheUnitByNameSync("npc_deer", context)
  PrecacheUnitByNameSync("snap_trap", context)
  PrecacheUnitByNameSync("npc_walls", context) 
  PrecacheUnitByNameSync("npc_check_attack_medium", context) 
  PrecacheUnitByNameSync("npc_check_attack_hard", context) 
  PrecacheUnitByNameSync("npc_check_attack_extreme", context)
  PrecacheUnitByNameSync("npc_petri_sawmill", context)
  PrecacheUnitByNameSync("npc_petri_tower_basic", context)

  PrecacheResource("soundfile", "soundevents/game_sounds_custom.vsndevts", context )
  PrecacheResource("soundfile", "soundevents/sound_of_winter.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_elder_titan.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context)

  PrecacheResource("model", "models/props_gameplay/red_box.vmdl", context)
  PrecacheResource("model", "custom_models/meat.vmdl", context)
  PrecacheResource("model", "custom_models/meat_cook.vmdl", context)
  PrecacheResource("particle", "particles/dropped_item_normal.vpcf", context) 
  
  -- ITEMS
  PrecacheItemByNameSync("item_fire_effect", context)
  PrecacheItemByNameSync("item_canned_goods", context)
  PrecacheItemByNameSync("item_meat", context)
  PrecacheItemByNameSync("item_cooked_meat", context)
  PrecacheItemByNameSync("item_fat", context)
  PrecacheItemByNameSync("item_blueberry", context)
  PrecacheItemByNameSync("item_cowberry", context)
  PrecacheItemByNameSync("item_warm_bear_armor", context)
  PrecacheItemByNameSync("item_rough_bear_armor", context)
  PrecacheItemByNameSync("item_shield_of_heaven", context)
  PrecacheItemByNameSync("item_northern_wolf_shield", context)
  PrecacheItemByNameSync("item_resistance_to_cold", context)
  PrecacheItemByNameSync("item_northern_mushroom", context)
  PrecacheItemByNameSync("item_die_spider", context)
  PrecacheItemByNameSync("item_wood_damage", context)
  PrecacheItemByNameSync("item_claws_bear", context)
  PrecacheItemByNameSync("item_claws_wolf", context)
  PrecacheItemByNameSync("item_snap_trap", context)
  PrecacheItemByNameSync("item_net_hunting", context)
  PrecacheItemByNameSync("item_fishing_rod", context)
  PrecacheItemByNameSync("item_woods", context)
  PrecacheItemByNameSync("item_skin_bear", context)
  PrecacheItemByNameSync("item_skin_wolf", context)
  PrecacheItemByNameSync("item_tendon", context)
  PrecacheItemByNameSync("item_axe_tree", context)
  PrecacheItemByNameSync("item_axe_iron", context)
  PrecacheItemByNameSync("item_bone", context)
  PrecacheItemByNameSync("item_iron", context)
  PrecacheItemByNameSync("item_scalp", context)
  PrecacheItemByNameSync("item_wea", context)
  PrecacheItemByNameSync("item_bow", context)
  PrecacheItemByNameSync("item_quiver", context)
  PrecacheItemByNameSync("item_sword_damage", context)
  PrecacheItemByNameSync("item_bone_sharpening_heavy", context)
  PrecacheItemByNameSync("item_bone_sharpening_easy", context)
  PrecacheItemByNameSync("item_rocket", context)

  -- UNITS AND BUILDINGS 
 PrecacheResource("model", "models/heroes/clinkz/clinkz.vmdl", context)
 PrecacheResource("model", "models/props_structures/tent_dk_small.vmdl", context)
 PrecacheResource("model", "models/campfire.vmdl", context)
 PrecacheResource("model", "custom_models/hut.vmdl", context)
 PrecacheResource("model", "models/items/hex/sheep_hex/sheep_hex.vmdl", context)
 PrecacheResource("model", "models/heroes/lone_druid/spirit_bear.vmdl", context)
 PrecacheResource("model", "models/items/lycan/ultimate/alpha_trueform9/alpha_trueform9.vmdl", context)
 PrecacheResource("model", "models/items/lone_druid/bear/spirit_of_the_atniw/spirit_of_the_atniw.vmdl", context)
 PrecacheResource("model", "models/heroes/lone_druid/spirit_bear.vmdl", context)
 PrecacheResource("model", "models/items/beastmaster/boar/beast_deming/beast_deming.vmdl", context)
 PrecacheResource("model", "models/items/lycan/wolves/alpha_summon_01/alpha_summon_01.vmdl", context)
 PrecacheResource("model", "models/heroes/broodmother/spiderling.vmdl", context)
 PrecacheResource("model", "models/items/hex/fish_hex/fish_hex.vmdl", context)
 PrecacheResource("model", "custom_models/deer.vmdl", context)
 PrecacheResource("model", "models/items/bounty_hunter/back_jawtrap.vmdl", context)
 PrecacheResource("model", "models/development/invisiblebox.vmdl", context)
 PrecacheResource("model", "models/props_structures/gate_entrance002.vmdl", context)
  

  PrecacheResource("model", "models/props_structures/tent_dk_med.vmdl", context)
  PrecacheResource("model", "models/props_structures/tent_dk_large.vmdl", context)
  PrecacheModel("models/campfire.vmdl", context) -- костёр
  PrecacheResource("model", "models/particle/net.vmdl", context)
  
  -- PARTICLES
  PrecacheResource("particle_folder", "particles/buildinghelper", context)
  PrecacheResource("particle", "particles/econ/events/nexon_hero_compendium_2014/teleport_end_ground_flash_nexon_hero_cp_2014.vpcf", context)
  PrecacheResource("particle", "particles/econ/items/lion/fish_stick/fish_stick_splash.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_thirst_owner_b.vpcf", context)

	PrecacheResource("particle", "particles/econ/items/zeus/arcana_chariot/zeus_arcana_blink_bolt_down.vpcf", context)
	
  PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_base_attack_fire.vpcf", context)
  PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_ready.vpcf", context)
  PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_explosion.vpcf", context)
  PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf", context)

  PrecacheResource("particle", "particles/units/heroes/hero_rattletrap/rattletrap_rocket_flare_explosion_flash_c.vpcf", context)
  
  PrecacheResource("particle",  "particles/econ/courier/courier_cluckles/courier_cluckles_ambient_rocket_sparks.vpcf", context)
  PrecacheResource("particle", 	"particles/econ/items/clockwerk/clockwerk_paraflare/clockwerk_para_rocket_flare_illumination.vpcf", context)
  PrecacheResource("particle", 	"particles/econ/courier/courier_cluckles/courier_cluckles_ambient_rocket_explosion.vpcf", context)
  PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_elder_titan.vsndevts", context)
  
  PrecacheResource("particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_thirst_owner_b.vpcf", context)
  PrecacheResource("particle", "particles/dire_fx/fire_barracks.vpcf", context)
  PrecacheResource("particle", "particles/generic_gameplay/dropped_item.vpcf", context)
  PrecacheResource("model", "models/items/bounty_hunter/reaper_sword.vmdl", context)
  PrecacheResource("model", "models/props_gameplay/status_disarm.vmdl", context)
  PrecacheResource("model", "models/props_gameplay/quelling_blade.vmdl", context)
  PrecacheResource("particle", "particles/units/heroes/hero_meepo/meepo_earthbind.vpcf", context)
  PrecacheResource("particle", "particles/units/heroes/hero_meepo/meepo_earthbind_flash.vpcf", context)
  PrecacheResource("particle", "particles/units/heroes/hero_meepo/meepo_earthbind_projectile_fx.vpcf", context)
  PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_meepo.vsndevts", context)
  PrecacheResource("model", "models/heroes/lone_druid/lone_druid_claw_fx.vmdl", context)
  PrecacheResource("particle", "particles/units/heroes/hero_treant/treant_overgrowth_vine_glows_corerope.vpcf", context)
  PrecacheResource("model", "models/props_wildlife/wildlife_spider001.vmdl", context)
  PrecacheResource("model", "models/props_gameplay/salve_red.vmdl", context)
    --models/props_nature/fern002.vmdl ???
  
  
  PrecacheResource("particle", "particles/generic_gameplay/dropped_item.vpcf", context)
  PrecacheResource("particle", "particles/units/heroes/hero_lycan/lycan_claw_blur_b.vpcf", context)
  PrecacheResource("particle", "particles/units/heroes/hero_lycan/lycan_claw_blur.vpcf", context) -- wolf
  PrecacheModel("models/items/bounty_hunter/back_jawtrap.vmdl", context) -- item_snap_trap
  PrecacheResource("particle", "particles/units/heroes/hero_mirana/mirana_spell_arrow.vpcf", context)
  -- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
  -- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
 
  print('[Precache] Start')
  local wearables = LoadKeyValues("scripts/items/items_game.txt") -- загружаем весь файл

  local wearablesList = {} --(для всех героев)
  local precacheWearables = {} --только для шмоток нужного героя
  local precacheParticle = {}
  for k, v in pairs(wearables) do
    if k == 'items' then
      wearablesList = v
    end
  end
  local counter = 0
  local counter_particle = 0
  local value
  for k, v in pairs(wearablesList) do -- выбираем из списка предметов
if IsForHero("npc_dota_hero_omniknight", wearablesList[k]) then
      if wearablesList[k]["model_player"] then
        value = wearablesList[k]["model_player"] 
        precacheWearables[value] = true
      end
      if wearablesList[k]["particle_file"] then -- прекеш частицы
        value = wearablesList[k]["particle_file"] 
        precacheParticle[value] = true
      end
    end
  end

  for wearable,_ in pairs( precacheWearables ) do --прекеширование всех занесенных в список шмоток
    print("Precache model: " .. wearable)
    PrecacheResource( "model", wearable, context )
    counter = counter + 1
  end

  for wearable,_ in pairs( precacheParticle) do
    print("Precache particle: " .. wearable)
    PrecacheResource( "particle", wearable, context )
    counter_particle = counter_particle + 1

  end

  wearables = nil
  wearablesList = {0}
  precacheWearables = {0} 
  precacheParticle = {0}

  print('[Precache]' .. counter .. " models loaded and " .. counter_particle .." particles loaded")
  print('[Precache] End')
end

function IsForHero(str, tbl)
  if type(tbl["used_by_heroes"]) ~= type(1) and tbl["used_by_heroes"] then
    if tbl["used_by_heroes"][str] then
      return true
    end
  end
  return false
end

function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:InitGameMode()
end