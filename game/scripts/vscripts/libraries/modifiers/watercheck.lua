--объявляем наш модификатор как объект-класс
watercheck = class({})

--возвращаем false (лож) на вопросы о скрывании модификатора с глаз
--мы ведь хотим видеть красивую иконочку над показателями здоровья
function watercheck:IsHidden()
	return true
end

--эта штука будет на любые распросы о типе нашего модификатора
--говорить, что он на скорость атаки
--все типы можете в офф документации глянуть
function watercheck:DeclareFunctions()
	return { MODIFIER_PROPERTY_MANA_REGEN_CONSTANT  }
end

--тут возвращаем имя иконочки
--не буду рассказывать, как делать иконочку
--можете использовать тут имена стандартных абилок
--например вместо моего "one_punch_man" взять "brewmaster_drunken_haze"
function watercheck:GetTexture()
    return "brewmaster_drunken_haze"
end

--когда нас спросят, а сколько скорости то плюсануть
--мы ответим 99999
function watercheck:GetModifierConstantManaRegen()
		return -0.4
end

--возвращаем true на любые вопросы о том
--удалять ли модификатор, если носитель умрет
--можете и false поставить, чтобы он не пропадал после смерти
--как хотите
function watercheck:RemoveOnDeath()
	return true
end

