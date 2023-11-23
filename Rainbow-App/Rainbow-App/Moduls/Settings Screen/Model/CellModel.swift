import Foundation

enum SettingsCellType {
    case gameTime
    case gameSpeed
    case wordsColor
    case fontSize
    case letterOrBackground
    case checkGame
    case backgroundGameColor
}

struct CellModel {
    var title: String
    var type: SettingsCellType
    var value: Int


    static func makeCells() -> [CellModel] {
        var cells = [CellModel]()

        cells.append(CellModel(title: "Время игры, мин",
                               type: .gameTime,
                               value: 0))

        cells.append(CellModel(title: "Скорость смены заданий, сек",
                               type: .gameSpeed,
                               value: 0))

        cells.append(CellModel(title: "Цвета слов",
                               type: .wordsColor,
                               value: 0))

        cells.append(CellModel(title: "Размер букв",
                                type: .fontSize,
                                value: 0))

        cells.append(CellModel(title: "Подложка для букв",
                               type: .letterOrBackground,
                               value: 0))

        cells.append(CellModel(title: "Проверка голосом",
                               type: .checkGame,
                               value: 0))

        cells.append(CellModel(title: "Цвет фона",
                               type: .backgroundGameColor,
                               value: 0))

        return cells 
    }
}
