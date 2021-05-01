//
//  CornerRadiusDecorator.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

/// Закругляет углы
struct CornerRadiusDecorator: ViewDecorator {
	/// Радиус закругления
	let cornerRadius: CGFloat

	func decorate(view: UIView) {
		view.clipsToBounds = true
		view.layer.cornerRadius = cornerRadius
	}
}
