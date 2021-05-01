//
//  Record.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 01.05.2021.
//

import Foundation

struct Record: Codable, CellItemProtocol {
	var identifier: String = CellsID.currency
	var date: String?
	var value: String?

	enum CodingKeys: String, CodingKey {
		case value = "Value"
		case date = "Date"
	}
}
