# pagespeed-swift

## Development rules

1. Use **SwiftLint** and defined rules.
2. Write code according specified **Swift Style Guide** (see https://github.com/raywenderlich/swift-style-guide).
3. Classes and structures should have informative and explicitly defined names.
4. All IBOutlets, objects of classes and subclasses should have suffix according to their type (e.g. NewTaskViewController for UIViewController).
5. Create separate folders (groups) for separate application features (e.g. **Test** folder for all logic regarding sending, processing requests to API for a site testing and displaying views regarding this feature, **History** folder - for all logic regarding displaying saved tests). But TargetTypes and structures for processing API responses should be saved in separate folders named accordingly (e.g. **Google** folder - for Google APIs TargetTypes and structures, **GTMetrix** folder - for GTMetrix APIs TargetTypes and structures).
6. **All storyboards** should be placed in **Base.lproj** and belongs to **PageSpeed group**.
7. All extensions and supporting classes should be stored at **Helpers** folder in a proper file (e.g. **String** extensions in **Helpers/StringHelpers.swift**).
8. `CREATE SEPARATE STORYBOARD FOR A FLOWS/VIEWS THAT YOU'RE DEVELOPING AND RESPONSIBLE FOR`.
9. `MAKE CHANGES TO YOUR STORYBOARDS ONLY TO DECREASE MERGE CONFLICTS`.

## Правила разработки

1. Использовать **SwiftLint** и придерживаться определенных правил.
2. Придерживаться общего **Swift Style Guide** (см. https://github.com/raywenderlich/swift-style-guide).
3. Классы и структуры должны иметь наиболее информативные и однозначные названия.
4. Все IBOutlets, объекты классов и подклассы должны иметь соответствующий суффикс (например, NewTaskViewController для UIViewController).
5. Создавать отдельные папки (группы) для функциональных единиц приложения (например, папка **Test** для всей логики касающейся отправления, обработки запросов к API и отображения соответствующих представлений, **History** - для логики отображения сохраненных тестов). TargetTypes и структуры для обработки API-запросов должны храниться в отдельных папках с соответствующими названиями (например, папка **Google** - для Google APIs TargetTypes и структур, папка **GTMetrix** -  для GTMetrix APIs TargetTypes и структур).
6. **Все storyboards** должны находиться в папке **Base.lproj** и принадлежать группе **PageSpeed**.
7. Все расширения и сопутствующие классы должны храниться в папке **Helpers** в отдельном файле, который соответствует тому или иному классу (например, расширения для **String** должны храниться в **Helpers/StringHelpers.swift**).
8. `ИСПОЛЬЗОВАТЬ ОТДЕЛЬНЫЙ STORYBOARD ДЛЯ СВОИХ ОТОБРАЖЕНИЙ`.
9. `ВНОСИТЬ ИЗМЕНЕНИЯ ТОЛЬКО В СВОИ STORYBOARDS ДЛЯ МИНИМИЗАЦИИ КОНФЛИКТОВ В РЕПОЗИТОРИИ`.
