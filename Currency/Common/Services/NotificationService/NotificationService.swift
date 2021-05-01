//
//  NotificationService.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit

final class NotificationService: NotificationServiceProtocol {
	private let center: UNUserNotificationCenter

	init(center: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
		self.center = center
	}

	func setupPush(body: NotificationModel = NotificationModel()) {
		let content = UNMutableNotificationContent()
		content.title = body.title
		content.subtitle = body.subtitle
		content.body = body.body
		content.sound = UNNotificationSound.default

		let trigger = UNTimeIntervalNotificationTrigger(timeInterval:3.0, repeats: false)
		let notification = UNNotificationRequest(identifier: Keys.notificationTask, content: content, trigger: trigger)

		center.add(notification) { (error) in
			if error != nil {
				print("error \(String(describing: error))")
			}
		}
	}
}
