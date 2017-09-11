function tp1(event)
    local unit = event.activator
    local  wws= "pnt1" -- вот та сама точка, куда мы будем телепортировать героя, мы её указали в скрипте

    local ent = Entities:FindByName( nil, wws) --строка ищет как раз таки нашу точку pnt1
    local point = ent:GetAbsOrigin() --эта строка выясняет где находится pnt1 и получает её координаты
    event.activator:SetAbsOrigin( point ) -- получили координаты, теперь меняем место героя на pnt1
    FindClearSpaceForUnit(event.activator, point, false) --нужно чтобы герой не застрял
    event.activator:Stop() --приказываем ему остановиться, иначе он побежит назад к предыдущей точке
	PlayerResource:SetCameraTarget(event.activator:GetPlayerOwnerID(), event.activator)
    Timers:CreateTimer(0.1, function()
        PlayerResource:SetCameraTarget(event.activator:GetPlayerOwnerID(), nil) -- Чтобы камера разблочилась, т.к. она начинает следовать за игроком постоянно.
        return nil
    end)
end