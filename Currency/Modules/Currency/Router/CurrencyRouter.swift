//
//  CurrencyRouter.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

final class CurrencyRouter: CurrencyRouterInput {

	weak var viewController: UIViewController?

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	func showAlert(error: ErrorModel) {
		let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//			обработка действия
		}))
		viewController!.present(alert, animated: true, completion: nil)
	}

}
