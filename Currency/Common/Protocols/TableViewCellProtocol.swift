//
//  TableViewCellProtocol.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

/// Протокол ячейки
protocol TableViewCellProtocol: UITableViewCell {
	/// Конфигурирует ячейку
	/// - Parameter item: Модель данных для конфигурации ячейки
	func configureCell(with item: CellItemProtocol)
}
