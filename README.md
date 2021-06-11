# Пример автоматически удаляемоего регламентного задания

[![Статус порога качества](https://sonarqube.samokhval.com/api/project_badges/measure?project=autoRemove-Scheduled-jobs&metric=alert_status)](https://sonarqube.samokhval.com/dashboard?id=autoRemove-Scheduled-jobs)
[![Рейтинг безопасности](https://sonarqube.samokhval.com/api/project_badges/measure?project=autoRemove-Scheduled-jobs&metric=security_rating)](https://sonarqube.samokhval.com/dashboard?id=autoRemove-Scheduled-jobs)
[![Технический долг](https://sonarqube.samokhval.com/api/project_badges/measure?project=autoRemove-Scheduled-jobs&metric=sqale_index)](https://sonarqube.samokhval.com/dashboard?id=autoRemove-Scheduled-jobs) [![Уязвимости](https://sonarqube.samokhval.com/api/project_badges/measure?project=autoRemove-Scheduled-jobs&metric=vulnerabilities)](https://sonarqube.samokhval.com/dashboard?id=autoRemove-Scheduled-jobs)
![downloads](https://img.shields.io/github/downloads/maximsamokhval/autoRemove-Scheduled-jobs/total?style=plastic)
![last commit](https://img.shields.io/github/last-commit/maximsamokhval/autoRemove-Scheduled-jobs?style=plastic)
![build](https://img.shields.io/github/workflow/status/maximsamokhval/autoRemove-Scheduled-jobs/CI?style=plastic)
![forks](https://img.shields.io/github/forks/maximsamokhval/autoRemove-Scheduled-jobs?style=plastic)
![stars](https://img.shields.io/github/stars/maximsamokhval/autoRemove-Scheduled-jobs?style=plastic)
![license](https://img.shields.io/github/license/maximsamokhval/autoRemove-Scheduled-jobs?style=plastic)
[![telegram](https://img.shields.io/badge/telegram-group-brightgreen?style=plastic&logo=telegram)](https://t.me/joinchat/FUSfJawJFHE0OGY6)

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

![image](https://user-images.githubusercontent.com/24194977/121185190-7b912680-c86e-11eb-9a0f-91a30195181f.png)

[Примеры кода в Wiki](https://github.com/maximsamokhval/autoRemove-Scheduled-jobs/wiki/%D0%9F%D1%80%D0%B8%D0%BC%D0%B5%D1%80%D1%8B-%D0%BA%D0%BE%D0%B4%D0%B0)
