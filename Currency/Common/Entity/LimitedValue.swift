//
//  LimitedValue.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation

struct LimitedValue: CellItemProtocol {
	var identifier: String = CellsID.limitedCell
	var value: String = "100"
	var valute: String = "RUB"
	var actionBlock: ((String?)->Void)?
}
