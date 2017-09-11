if not craft_menu then
	craft_menu = class({})
end

items = LoadKeyValues("scripts/kv/items.txt")                                 ---------ЗАГРУЖАЕМ КВ ФАЙЛЫ
costs = LoadKeyValues("scripts/kv/itemscosts.txt")
ingredients = LoadKeyValues("scripts/kv/itemsingredients.txt")

function craft_menu:FillingNetTables()                                         ----------НАПОЛНЯЕМ ТАБЛИЦЫ ДЛЯ ИСПОЛЬЗОВАНИЯ В ПАНОРАМЕ ВЫЗЫВАТЬ ЭТУ ФУНЦИЮ НУЖНО В ОНКОННЕКТФУЛЛ
    for shop, item in pairs(items) do
        CustomNetTables:SetTableValue("items",shop,item)
    end
    for item, cost in pairs(costs) do
        CustomNetTables:SetTableValue("itemscost",item,cost)
    end
    for item, ingredient in pairs(ingredients) do
        CustomNetTables:SetTableValue("itemsingredients",item,ingredient)
    end
end

function craft_menu:StartGame()                        -----------ЭТА ФУНКЦИЯ У МЕНЯ ВЫЗЫВАЕТСЯ ПРИ ПОДКЛЮЧЕНИИ САМОГО ПЕРВОГО ИГРОКА
  CustomGameEventManager:RegisterListener("BuyItem", Dynamic_Wrap(craft_menu, 'BuyItem'))          ---------ПОДКЛЮЧАЕМ ФУНКЦИЮ ПОКУПКИ АЙТЕМОВ
--[[	local blacksmith = CreateUnitByName("blacksmith", Vector(672,-224,160), false, nil, nil, DOTA_TEAM_GOODGUYS)  -----СОЗДАЕМ ПРОДАВЦА
  blacksmith:AddNewModifier(blacksmith, nil, "modifier_shopkeeper", {})
  blacksmith:SetModel("models/props_gameplay/shopkeeper_fountain/shopkeeper_fountain.vmdl")
  blacksmith:SetOriginalModel("models/props_gameplay/shopkeeper_fountain/shopkeeper_fountain.vmdl")
  blacksmith:StartGesture(ACT_DOTA_IDLE)
  blacksmith:SetAngles(0,-90,0)
  blacksmith:AddNewModifier(blacksmith,nil,"modifier_shop",{}) ]]                          ------КИДАЕМ МОДИФИКАТОР ПРОДАВЦА, МОЖЕШЬ ЗАПИЛИТЬ СВОЙ И СО СВОЕЙ РЕНЖОЙ АУРЫ

  -- ХЗ РАБОТАЕТ ИЛИ НЕТ
  Timers:CreateTimer(1,function()
  local heroes = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
       centr,
       nil,
       99999,
       DOTA_UNIT_TARGET_TEAM_FRIENDLY,
       DOTA_UNIT_TARGET_HERO,
       DOTA_UNIT_TARGET_FLAG_NONE,
       FIND_ANY_ORDER,
       false)
         for k,v in pairs(heroes) do
           local inventory = {v:GetItemInSlot(9), v:GetItemInSlot(10), v:GetItemInSlot(11), v:GetItemInSlot(12), v:GetItemInSlot(13), v:GetItemInSlot(14),}
           for s,i in pairs(inventory) do
             local name = i:GetName()
             local charges = i:GetCurrentCharges()
             local item = CreateItem(name,v,v)
             i:RemoveSelf()
             item:SetCurrentCharges(charges)
             if not item:IsNull() then
               item:SetPurchaseTime(0)
             end
             if item:HasSlotForIt(v) then
               v:AddItem(item)
             else
               CreateItemOnPositionSync( v:GetAbsOrigin(), item )
             end
          end
       end
    return 1
  end)
end

function craft_menu:BuyItem(t)                                               -----ФУНКЦИЯ ПОКУПКИ
  local item = items[t.shop][t.itemid]                                            -----ПОЛУЧАЕМ НАЗВАНИЕ АЙТЕМА ИЗ КВ, НИ В КОЕМ СЛУЧАЕ НЕ ПЕРЕДАВАЙ НИЧЕГО ИЗ ПАНОРАМЫ, ИГРОК МОЖЕТ ПОДМЕНИТЬ ПЕРЕМЕННЫЕ ЧЕРЕЗ ЧИТЕНЖИН КАКОЙ НИБУДЬ
  local cost = costs[tostring(item .. "_" .. t.itemid)] or nil                    -----ПОЛУЧЕМ ТАБЛИЦУ С ЦЕНАМИ ДЛЯ ОДИНАКОВЫХ АЙТЕМОВ
  if cost == nil and costs[item] ~= nil then                                      -----ЕСЛИ АЙТЕМ ОДИН И БЕЗ ПРИСТАВКИ С АЙДИ, ТО ИЩЕМ ЗАНОВО УЖЕ ОДИН АЙТЕМ
    cost = costs[item]
  elseif cost == nil and costs[item] == nil then
    cost = {}
    cost["gold"] = 0
    cost["howmany"] = 0
  end
  local pid = t.PlayerID                                                          ----ПРОСТО АЙДИ ИЗ ПАНОРАМЫ
  local hero = PlayerResource:GetSelectedHeroEntity(t.PlayerID)                   ----ГЕРОЙ ИГРОКА
  local currentgold = PlayerResource:GetGold(pid)                     			  ----ПОЛУЧЕНИЕ ГОЛДЫ И КАСТОМНОГО РЕСУРСА
  local needingredients = ingredients[tostring(item .. "_" .. t.itemid)] or nil   ----ТО ЖЕ САМОЕ, ЧТО С ЦЕНАМИ, НО С ИНГРЕДИЕНТАМИ

 local pos = hero:GetAbsOrigin()
 
 if needingredients == nil then
    needingredients = ingredients[item] or nil
  end
 if cost["gold"] or 0 <= currentgold then    										-----ЕСЛИ ДЕНЕГ ХВАТАЕТ, ТО
    if needingredients then                                                         ----ЕСЛИ ИНГРЕДИЕНТЫ НУЖНЫ, ТО
      local ing = {}
      for i=0,2 do
        ing[i] = ing[i] or true                                                     ----ОБЪЯВЛЯЕМ ПЕРЕМЕННЫЕ ИНГРЕДИЕННТОВ(МАКСИМУМ 3, МОЖНО И БОЛЬШЕ, НО В ПАНОРАМЕ НАДО ПОДГОНЯТЬ)
      end
      local ingid = 0
      for ingredient,value in pairs(needingredients) do                             ----ДЛЯ КАЖДОГО ИНГРЕДИЕНТА ЧЕКАЕМ, ХВАТАЕТ ЛИ ЕГО
        ing[ingid] = craft_menu:enoughingrediens(hero,ingredient,value)
        ingid = ingid + 1
      end
      if ing[0] == true and ing[1] == true and ing[2] == true then                  -----ЕСЛИ ВСЕХ ИНГРЕДИЕНТОВ ХВАТАЕТ, ТО ЗАБИРАЕМ ИХ У ИГРОКА
        for ingredient,value in pairs(needingredients) do
          craft_menu:spendingredient(hero,ingredient,value)
        end
        for i=0,cost["howmany"]-1 or 0 do                                           -----ДАЕМ ИГРОКУ НУЖНОЕ КОЛИЧЕСТВО КУПЛЕННЫХ ИМ ВЕЩЕЙ
          local purchaseditem = CreateItem(item, hero, hero)
			
		
            if purchaseditem:HasSlotForIt(hero) then
              hero:AddItem(purchaseditem)
            else
              CreateItemOnPositionSync( pos, purchaseditem )
			  purchaseditem:LaunchLoot(false, 100, 0.75, pos + RandomVector(RandomFloat(80, 100)))	
            end
         
		-- hero:AddItem(purchaseditem)
          if not purchaseditem:IsNull() then
            purchaseditem:SetPurchaseTime(0)
          end
        end
        hero:SpendGold(cost["gold"] or 0, DOTA_ModifyGold_Unspecified)              -----СПИСЫВАЕМ ГОЛДУ И РЕСУРС
      end
    else
      for i=0,cost["howmany"]-1 or 0 do                                         ----ЕСЛИ ИНГРЕДИЕНТЫ НЕ НУЖНЫ, ТО ВСЕ КУДА ПРОЩЕ)
        local purchaseditem = CreateItem(item, hero, hero)
            if purchaseditem:HasSlotForIt(hero) then
              hero:AddItem(purchaseditem)
            else
              CreateItemOnPositionSync( pos, purchaseditem )
			  purchaseditem:LaunchLoot(false, 100, 0.75, pos + RandomVector(RandomFloat(80, 100)))		
            end
        --hero:AddItem(purchaseditem)
        if not purchaseditem:IsNull() then
          purchaseditem:SetPurchaseTime(0)
        end
      end
      hero:SpendGold(cost["gold"] or 0, DOTA_ModifyGold_Unspecified)
    end
  end
end

function CDOTA_Item:HasSlotForIt(hero)
  local slots = 9
  local inventory = { hero:GetItemInSlot(0), hero:GetItemInSlot(1), hero:GetItemInSlot(2), hero:GetItemInSlot(3), hero:GetItemInSlot(4), hero:GetItemInSlot(5), hero:GetItemInSlot(6), hero:GetItemInSlot(7), hero:GetItemInSlot(8),}
  for k,v in pairs(inventory) do
    if v:GetName() == self:GetName() and v:GetCurrentCharges() ~= 0 then
      slots = slots + 1
    end
    slots = slots - 1
  end
  if slots > 0 then
    return true
  end
  return false
end

function craft_menu:enoughingrediens(hero,ingredient,value)            ------------ФУНКЦИЯ ПРОВЕРКИ, ХВАТАЕТ ЛИ АЙТЕМОВ
  local inventory = { hero:GetItemInSlot(0), hero:GetItemInSlot(1), hero:GetItemInSlot(2), hero:GetItemInSlot(3), hero:GetItemInSlot(4), hero:GetItemInSlot(5), hero:GetItemInSlot(6), hero:GetItemInSlot(7), hero:GetItemInSlot(8),}
  for k,v in pairs(inventory) do
    if v:GetName() == ingredient then
      if v:GetCurrentCharges() >= value then
        return true
      end
    end
  end
  return false
end

function craft_menu:spendingredient(hero,ingredient,value)            ------------ФУНКЦИЯ ОТДАЧИ АЙТЕМОВ
  local inventory = { hero:GetItemInSlot(0), hero:GetItemInSlot(1), hero:GetItemInSlot(2), hero:GetItemInSlot(3), hero:GetItemInSlot(4), hero:GetItemInSlot(5), hero:GetItemInSlot(6), hero:GetItemInSlot(7), hero:GetItemInSlot(8),}
  for k,v in pairs(inventory) do
    if v:GetName() == ingredient then
      if v:GetCurrentCharges() >= value then
        if v:GetCurrentCharges() == value then
          v:RemoveSelf()
        else
          v:SetCurrentCharges(v:GetCurrentCharges() - value)
        end
      end
    end
  end
end

