# Пример автоматически удаляемоего регламентного задания

## Назначение

 Позволяет "поставить отложенное задание" и гарантированно его выполнить.
 Задание будет выполняться в течении дня пока не выполнится, а когда выполнится, автоматически удалится

## Окружение

**Платформа:** 8.3.18

**Режим совместимости:** 8.3.10

## Шаги воспроизведения

* Открыть обработку Генерация отложенных заданий
* Заполнить даты начала/окончания
* Выбрать элемент справочника
* Нажать кнопку Отложить
* Открыть обработку Консоль заданий 2019
* В списке активных регламентных заданий должно быть новое Регламентное задание с ключом "Отложенная запись <Название Номенклатуры>"
* Запустить регламентное задание
* Если задание завершено с ошибкой - изменить значение константы "ЗапрещатьПерезапись" в Ложь
* После успешного выполнения задание должно удалить себя 

[Описание процесса](https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1&title=Untitled%20Diagram.drawio#R7VhZc5swEP41fmwGkMH40WePSSeZSWd6vHRkEEcjEBUitvvrK0ACyWDHaew4k%2BmLrD10sLvf7soDMEs27ynMos%2FER3hgGf5mAOYDyzIN4PKfkrOtOfZwVDNCGvtCqWXcxX9QzRTLwiL2Ua7pMUIwizOd6ZE0RR7TeJBSstbVAoL1QzMYog7jzoO4y%2F0a%2BywSXNMZt4IPKA4jebRjD2tJAqW2UTPyCPpkrbDAYgBmlBBWz5LNDOHSeNIu9brlHmlzM4pSdsyCm%2BGn8ej%2BbvQxyK7B8kt6s7n98U44I2db%2BcXI5wYQJKEsIiFJIV603CklReqjcleDU%2Fk9Yl75pSYn2gXXhGSC%2BQsxthWehQUjnBWxBAtpY5aSqG9TXmHvRwpWTgrqoQNfZotogTRE7ICe07iCxzAiCWJ0y9dRhCGLH%2FR7QBFNYaPX2ptPhMmfYH5xyQeIC3HSgBt1vCzH6aIapwNuGXdWzUcKv9KcGpW0ntua%2Fq5fuZ2zclokeOIxQrm1HxBlMY%2F1a7hC%2BJbkMYtJylVWhDGSKAoTHIelgJU%2BVZ1HCobjFM0a9BlafHT8G2KY51KgBo6wAz8PbQ67vusqucAVQBOZZizIdYtbIFiRgljHOJNvxxeHFjcc3X4Tm1XE95K4siU536jC%2BVaeeyZIOkdC0r0kJJ1%2BSAIFYnM550AzFBg61dyt5ku%2Bh0Rrg9Cpgl%2Bns%2BG80qzxa8vlI7k%2FH4fKfC7P4mM30nQIrqOYobsMVs5Z8zp9IAPvRWgQYyyDN4JeVFAkuDOCy3TCzwU%2BRG7glUsZJfdIkTiei1bBaZAOwBFIf0mom2bHA2%2BljLpHYtY0%2Bl32MqB1%2B0H7JOw10idhr1K2nN9F2cZVZ4yHyu513V78rATqIbPOFSbKNZuyzkeg5Zn2qNeC%2BSAILK8X876zcmznNJi3LR3zTbVXQW%2FaLwl60B90lkzj3F87jZxaO5Sgu3TuaPqEhrhsn2AaxyYd65JJx9zTvc%2F1LPJ24sF69QHx3M6xWjqhFG4VhYzEKcuVnW9LRpuaXNvWUhPYfYg%2Fom%2BO7Z1YrG%2FQRmbzKc8IVqMbrJ0KEpFkVeSPV49%2FeeH115ITVAYHjK50g1o9tcHt6Qfds5UGqzczTECnlZgqTwZLvtz%2Fdx9NxKh9huuh%2Fj5j5dpD2zhnjFlDvfvoe3JY9mmeHJxs%2FxSs4d%2F%2BtQoWfwE%3D)


``` bsl 

Процедура ОтложенноеЗадание( _Параметры = Неопределено ) Экспорт
	
	Если _Параметры = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	Попытка
		
		НоменклатураОбъект = _Параметры["Ссылка"].ПолучитьОбъект();
		НоменклатураОбъект.Используется = Истина;
		НоменклатураОбъект.Записать();
		
	Исключение
		
		_ТекстОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		
		ЗаписьЖурналаРегистрации(
			Событие(),
			УровеньЖурналаРегистрации.Ошибка,
			_Параметры["Ссылка"].Метаданные(),
			_Параметры["Ссылка"], _ТекстОшибки);
			
		ВызватьИсключение _ТекстОшибки;	
		
	КонецПопытки;  
	
	УдалитьРегламентноеЗадание( _Параметры["Ссылка"] );
	
КонецПроцедуры


Функция НовыйОтборРегламентногоЗадания(КлючПоиска)
	
	Отбор = Новый Структура;
	Отбор.Вставить("Ключ", КлючПоиска);
	Отбор.Вставить("Метаданные", Метаданные.РегламентныеЗадания.ОтложенноеЗадание);
	Отбор.Вставить("Предопределенное", Ложь);
	Отбор.Вставить("Использование", Истина);
	Отбор.Вставить("Наименование", "Отложенное выполнение");

	Возврат Отбор;
	
КонецФункции


Процедура УдалитьРегламентноеЗадание(Знач Ссылка)
	
	Отбор = НовыйОтборРегламентногоЗадания(КлючЗадания(Ссылка));
	НайденныеРегламентныеЗадания  = РегламентныеЗадания.ПолучитьРегламентныеЗадания(Отбор);	
	
	Если НайденныеРегламентныеЗадания.Количество() Тогда
		
		Для каждого ЭлементКоллекции Из НайденныеРегламентныеЗадания Цикл
			
			ЭлементКоллекции.Удалить();
			
		КонецЦикла; 
		
	КонецЕсли;	
	
КонецПроцедуры

```
