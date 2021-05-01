//
//  CurrencyViewInput.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation

protocol CurrencyViewInput: AnyObject {
	func reloadTableView()
	func startLoading()
	func stopLoading()
}
