//
//  CurrencyTableViewDataSourceOutput.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation

/// Протокол output кастомной DataSource
protocol CurrencyTableViewDataSourceOutput: AnyObject {
	func section()-> Int
	func numberOfRows(section: Int)-> Int
	func itemFor(indexPath: IndexPath)-> CellItemProtocol
}
