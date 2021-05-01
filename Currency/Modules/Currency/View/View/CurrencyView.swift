//
//  CurrencyView.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

final class CurrencyView: UIView {

	let tableView = CurrencyTableView()
	let activityView = ActivityView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupTableView()
		setupActivity()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func startLoading() {
		activityView.isHidden = false
		activityView.startActivity()
	}

	func stopLoading() {
		activityView.isHidden = true
		activityView.stopActivity()
	}

	private func setupTableView() {
		addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: topAnchor),
									 tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
									 tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
									 tableView.trailingAnchor.constraint(equalTo: trailingAnchor)])
	}

	private func setupActivity() {
		addSubview(activityView)
		activityView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([activityView.topAnchor.constraint(equalTo: topAnchor),
									 activityView.bottomAnchor.constraint(equalTo: bottomAnchor),
									 activityView.leadingAnchor.constraint(equalTo: leadingAnchor),
									 activityView.trailingAnchor.constraint(equalTo: trailingAnchor)])
		activityView.isHidden = true
	}
}
