//
//  IconClass.swift
//  TestIcon
//
//  Created by bruno chen chih ying on 19/12/20.
//

import UIKit

// MARK: - IconsName
enum IconsName: String {
    case
        redEvent = "Icon-red",
        blueEvent = "Icon-blue"
}

class ChangeAppIcon {

    class func setIconIfNeeded() {
        // MARK: - Events
        setIconEvent(start: "15/11/2020", finish: "27/12/2020", icon: .redEvent)
        setIconEvent(start: "28/12/2020", finish: "30/12/2020", icon: .blueEvent)

        if !hasEventNow {
            setDefaultIcon(name: .blueEvent)
        }
    }

    private static var hasEventNow: Bool = false

    // MARK: - Functions
    private static func setIconEvent(start: String, finish: String, icon: IconsName) {
        if hasEventNow { return }
        let now = Date()
        guard let startDate = parseData(string: start), let finishDate = parseData(string: finish)  else { return }

        if now >= startDate && now <= finishDate {
            setAppIcon(name: icon.rawValue)
            hasEventNow = true
        }
    }

    private static func parseData(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: string)
        return date
    }

    private static func setAppIcon(name: String) {
        if UIApplication.shared.alternateIconName != name {
            delay(1.0) {
                if UIApplication.shared.supportsAlternateIcons {
                    UIApplication.shared.setAlternateIconName(name) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        return
                    }
                } else {
                    print("Nao permitido")
                }
            }
        }
    }

    private static func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }

    private static func setDefaultIcon(name: IconsName) {
        setAppIcon(name: name.rawValue)
    }
}
