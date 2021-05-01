//
//  AppDelegate.swift
//  Currency
//
//  Created by Nikita Zabludovskiy on 30.04.2021.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	private let configuratorNotification = ConfiguratorNotification()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		accessNotification()
		UIApplication.shared.setMinimumBackgroundFetchInterval(BackgroundTime.minimum)
		registerBackgroundTaks()
		return true
	}

	// MARK: UISceneSession Lifecycle
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		configuratorNotification.backGroundTask { (isSuccess) in
			completionHandler(isSuccess ? .newData : .failed)
		}
	}

	// MARK: -Private Background Methods
	private func registerBackgroundTaks() {
		BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.Nikita.id", using: nil) { task in
			 self.handleAppRefresh(task: task as! BGAppRefreshTask)
		}
	}


	private func scheduleAppRefresh() {
		let request = BGAppRefreshTaskRequest(identifier: "com.Nikita.id")
		request.earliestBeginDate = Date(timeIntervalSinceNow: BackgroundTime.minimum)

		do {
			try BGTaskScheduler.shared.submit(request)
		} catch {
			print("Could not schedule app refresh: \(error)")
		}
	}

	private func handleAppRefresh(task: BGAppRefreshTask) {
		scheduleAppRefresh()
		configuratorNotification.backGroundTask { (isSuccess) in
			task.setTaskCompleted(success: isSuccess)
		}

		task.expirationHandler = { [weak self] in
			self?.configuratorNotification.cancel()
			task.setTaskCompleted(success: false)
		}
	 }

	private func accessNotification() {
		let center =  UNUserNotificationCenter.current()
		center.requestAuthorization(options: [.alert, .sound, .badge]) { (result, error) in
		}
	}

}

