﻿
Процедура ПередЗаписью(Отказ)
	
	Если Константы.ЗапрещатьПерезапись.Получить() Тогда
		// специально запрещаем
		Отказ = Истина;
		ЗаписьЖурналаРегистрации("ПередЗаписью", УровеньЖурналаРегистрации.Ошибка, Метаданные(), Ссылка, "Запрещено записывать");
		
	КонецЕсли; 
	
КонецПроцедуры
