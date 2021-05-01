//
//  DecorateView.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

extension UIView {

	/// Decorate view
	/// - Parameter decorator: decorator for view
	func decorate(with decorator: ViewDecorator) {
		decorator.decorate(view: self)
	}

	/// Decorate view with Array View Decorators
	/// - Parameter decorators: Array View Decorators
	func decorate(with decorators: [ViewDecorator]) {
		decorators.forEach { $0.decorate(view: self) }
	}
}
