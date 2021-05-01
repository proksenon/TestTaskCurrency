//
//  ValCurs.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 01.05.2021.
//

import XMLCoder

struct ValCurs: Codable, DynamicNodeEncoding {
	var date: String?
	var valutes: [Valute]?
	var record: [Record]?

	enum CodingKeys: String, CodingKey {
		case valutes = "Valute"
		case date = "Date"
		case record = "Record"
	}

	static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
		switch key {
		case ValCurs.CodingKeys.date: return .both
		default: return .element
		}
	}
}
