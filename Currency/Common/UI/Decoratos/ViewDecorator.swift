//
//  ViewDecorate.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

/// View Decorator Protocol
protocol ViewDecorator {
	/// Декорирует
	/// - Parameter view: Вью, которую декорирует функция
	func decorate(view: UIView)
}
