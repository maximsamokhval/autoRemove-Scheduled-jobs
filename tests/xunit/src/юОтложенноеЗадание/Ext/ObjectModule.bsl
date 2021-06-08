﻿#Область ОписаниеПеременных

Перем КонтекстЯдра;
Перем Ожидаем;

#КонецОбласти

#Область Основные_процедуры_теста

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	
	КонтекстЯдра = КонтекстЯдраПараметр;
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
	
КонецПроцедуры

Процедура ЗаполнитьНаборТестов(НаборТестов, КонтекстЯдраПараметр) Экспорт
	
	КонтекстЯдра = КонтекстЯдраПараметр;	
	НаборТестов.Добавить("Тест_Должен_ПоставитьЗаданиеВОчередь");
	НаборТестов.Добавить("Тест_Должен_ЗапуститьЗаданиеИУдалиться"); // Константа выключена
	НаборТестов.СтрогийПорядокВыполнения();
	
КонецПроцедуры

#КонецОбласти

#Область События_юнит_тестирования

Процедура ПередЗапускомТеста() Экспорт
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт

	Если ТранзакцияАктивна() Тогда
		ОтменитьТранзакцию();
	КонецЕсли;		
	
КонецПроцедуры

#КонецОбласти

#Область ЮнитТесты

Процедура Тест_Должен_ПоставитьЗаданиеВОчередь() Экспорт 
	
	_Контекст = Новый Структура;
	_Контекст.Вставить("Артефакт", Неопределено);
	_Контекст.Вставить("УИД_Задания", Неопределено);
	
	_Артефакт = НовыйСправочникНоменклатура();
	
	ПараметрыРегламентногоЗадания = _Регламенты.НовыеПараметрыРегламентногоЗадания();
	ПараметрыРегламентногоЗадания.Ключ = _Регламенты.КлючЗадания(_Артефакт);
	
	_РасписаниеРегламентногоЗадания = _Регламенты.НовоеРасписаниеРегламентногоЗадания(
		ТекущаяДатаСеанса(),
		Неопределено, 
		30);
	 
	УИД_Задания = _Регламенты.СгенерироватьОтложенноеЗадание( _Артефакт, ПараметрыРегламентногоЗадания, _РасписаниеРегламентногоЗадания );
	
	_Контекст.Артефакт = _Артефакт;
	_Контекст.УИД_Задания = УИД_Задания;
	
	КонтекстЯдра.СохранитьКонтекст(_Контекст);
	
	НайденноеРегламентноеЗадание = РегламентныеЗадания.НайтиПоУникальномуИдентификатору(УИД_Задания);  
	
	Ожидаем.Что(НайденноеРегламентноеЗадание).Не_().ЭтоНеопределено();
	
КонецПроцедуры

Процедура Тест_Должен_ЗапуститьЗаданиеИУдалиться() Экспорт 
	
	Константы.ЗапрещатьПерезапись.Установить(Ложь); // блокировка записи
	
	_Контекст = КонтекстЯдра.ПолучитьКонтекст();
	
	_Параметры = Новый Структура;
	_Параметры.Вставить("Ссылка", _Контекст.Артефакт);
	
	_Регламенты.ОтложенноеЗадание(_Параметры);
	
	НайденноеРегламентноеЗадание = РегламентныеЗадания.НайтиПоУникальномуИдентификатору(_Контекст["УИД_Задания"]);  
	
	Ожидаем.Что(НайденноеРегламентноеЗадание).ЭтоНеопределено();
	 	
КонецПроцедуры

#КонецОбласти 

#Область Служебные

Функция НовыйСправочникНоменклатура() Экспорт 
	
	Константы.ЗапрещатьПерезапись.Установить(Ложь); // блокировка записи

	
	Артефакт = Справочники.Номенклатура.СоздатьЭлемент();
	Артефакт.Заполнить(Неопределено);
	Артефакт.Наименование = Строка(Новый УникальныйИдентификатор);
	Артефакт.Записать();
	
	Возврат Артефакт.Ссылка;
	
КонецФункции

#КонецОбласти  

