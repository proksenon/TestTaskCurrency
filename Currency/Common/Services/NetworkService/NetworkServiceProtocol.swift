//
//  NetworkServiceProtocol.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation

protocol NetworkServiceProtocol {
	func getLastCurse(completion: @escaping ComplitionValueCurse)
	func getMonthlyCurs(firstDate: String, secondDate: String, completion: @escaping ComplitionValueCurse)
	func cancel()
}
