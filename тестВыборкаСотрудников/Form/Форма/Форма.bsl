﻿
&НаСервере
Процедура кмдОтобратьНаДатуНаСервере(Дата)
	// Вставить содержимое обработчика.
	Сотрудник = Справочники.Сотрудники.ПустаяСсылка();
	тзСотрудники = ПроверитьНаличиеПодработки(Сотрудник, Дата, "Сотрудник,ТекущийФОТ,ТарифнаяСтавка,Должность,Подразделение");
	ЭтотОбъект.тчВсеАктуальные.Загрузить(тзСотрудники.Скопировать(,"Сотрудник,ТекущийФОТ, ТарифнаяСтавка"));
	Запрос = Новый Запрос("ВЫБРАТЬ ВТТ.Сотрудник, ВТТ.ТекущийФОТ, ВТТ.ТарифнаяСтавка, ВТТ.Должность, ВТТ.Подразделение ПОМЕСТИТЬ ВТ_С ИЗ &тчАктуальные КАК ВТТ ГДЕ ВТТ.ТекущийФОТ > 100000 ИЛИ ВТТ.ТарифнаяСтавка > 100000; ВЫБРАТЬ * ИЗ ВТ_С; УНИЧТОЖИТЬ ВТ_С;");
	Запрос.УстановитьПараметр("тчАктуальные", тзСотрудники);
	тзБольшеСта = Запрос.Выполнить().Выгрузить();
	ЭтотОбъект.тчБольшеСта.Загрузить(тзБольшеСта.Скопировать(,"Сотрудник,ТекущийФОТ,ТарифнаяСтавка,Должность,Подразделение"));
КонецПроцедуры

&НаСервере
Функция ПроверитьНаличиеПодработки(Сотрудник, ДатаНазначения, СтрокаКадровыеДанные = "Сотрудник,ТекущийФОТ")
	ПараметрыПолучения = ПолучитьПараметры();
	ПараметрыПолучения.Организация = ЭтотОбъект.Организация;
	ПараметрыПолучения.ВключаяУволенныхНаНачалоПериода = ЛОЖЬ;
	ПараметрыПолучения.НачалоПериода = КонецДня(ДатаНазначения);
	ПараметрыПолучения.ОкончаниеПериода = КонецДня(ДатаНазначения);
	ПараметрыПолучения.ПодработкиРаботниковПоТрудовымДоговорам = Истина;
	ПараметрыПолучения.РаботникиПоДоговорамГПХ = Ложь;	
	ПараметрыПолучения.КадровыеДанные = СтрокаКадровыеДанные;
	ТаблицаСотрудников = КадровыйУчет.СотрудникиОрганизации(Истина, ПараметрыПолучения);	
	Возврат ТаблицаСотрудников;	
КонецФункции

&НаСервере
Функция ПолучитьПараметры()
	Возврат КадровыйУчет.ПараметрыПолученияСотрудниковОрганизацийПоСпискуФизическихЛиц();	
КонецФункции

&НаКлиенте
Процедура кмдОтобратьНаДату(Команда)
	кмдОтобратьНаДатуНаСервере(ДатаВыборки);
КонецПроцедуры
