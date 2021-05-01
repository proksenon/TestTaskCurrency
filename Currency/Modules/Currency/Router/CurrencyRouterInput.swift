//
//  CurrencyRouterInput.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import Foundation

protocol CurrencyRouterInput: AnyObject {
	func showAlert(error: ErrorModel)
}
