//
//  ComparingDates.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation

extension Date {
	func isBefore(_ date: Date = Date())->Bool {
		let selfCompanents = Calendar.current.dateComponents([.year, .month, .day], from: self)
		let rightCompanents = Calendar.current.dateComponents([.year, .month, .day], from: date)

		guard selfCompanents.year ?? 0 >= rightCompanents.year ?? 0 else { return true }
		guard selfCompanents.month ?? 0 >= rightCompanents.month ?? 0 else { return true }
		guard selfCompanents.day ?? 0 >= rightCompanents.day ?? 0 else { return true }
		return false
	}
}
