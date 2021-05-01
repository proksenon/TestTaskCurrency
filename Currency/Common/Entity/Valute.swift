//
//  Valute.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 01.05.2021.
//

import Foundation

struct Valute: Codable {
	var charCode: String?
	var value: String?

	enum CodingKeys: String, CodingKey {
		case charCode = "CharCode"
		case value = "Value"
	}
}
