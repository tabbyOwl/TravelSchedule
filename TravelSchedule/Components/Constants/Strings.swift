//
//  Strings.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/15.
//

enum Strings {
    enum Filters {
        static let showOptionsWithTransfers = "Показывать варианты с пересадками"
        static let yes = "Да"
        static let no = "Нет"
        static let departureTime = "Время отправления"
        static let applyFilters = "Применить"
        static let selectTime = "Уточнить время"
    }
    
    enum MainSearch {
        static let to = "Куда"
        static let from = "Откуда"
        static let search = "Найти"
    }
    
    enum CarrierInfo {
        static let email = "E-mail"
        static let phone = "Телефон"
        static let title = "Информация о перевозчике"
    }
    
    enum StationSearch {
        static let stationSelection = "Выбор станции"
        static let stationNotFound = "Станция не найдена"
        
    }
    
    enum CitySearch {
        static let citySelection = "Выбор города"
        static let cityNotFound = "Город не найден"
    }
    
    enum RouteSearch {
        static let routesNotFound = "Вариантов нет"
        static let transfer = "С пересадкой"
    }
    
    enum Common {
        static let enterSearchText = "Введите запрос"
        static let loading = "Идет загрузка..."
    }
    
    enum Settings {
        static let darkMode = "Темная тема"
        static let version = "Версия 1.0 (beta)"
        static let appUsesYandexAPI = "Приложение использует API «Яндекс.Расписания»"
    }
    
    enum Terms {
        static let terms = "Пользовательское соглашение"
        static let invalidUrl = "Не возможно открыть страницу"
    }
    
    enum TimeIntervals {
        static let morning = "Утро"
        static let day = "День"
        static let evening = "Вечер"
        static let night = "Ночь"
    }
    
    static func hours(_ count: Int) -> String {
        let remainder10 = count % 10
        let remainder100 = count % 100
        let word: String
        
        if remainder10 == 1 && remainder100 != 11 {
            word = "час"
        } else if (2...4).contains(remainder10) &&
                    !(12...14).contains(remainder100) {
            word = "часа"
        } else {
            word = "часов"
        }
        
        return "\(count) \(word)"
    }
}

