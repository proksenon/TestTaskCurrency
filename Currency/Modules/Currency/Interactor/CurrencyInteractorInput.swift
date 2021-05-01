//
//  CurrencyInteractorInput.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation

protocol CurrencyInteractorInput: AnyObject {
	func getMonthlyCurs(completion: @escaping ComplitionValueCurse)
	func getLimitedValue()->String?
	func setLimitedValue(value: String)
	func getCahchedMonthly() -> [Record]?
	func setCahchedMonthly(records: [Record])
}
