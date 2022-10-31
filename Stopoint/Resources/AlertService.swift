//
//  AlertService.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 31/10/22.
//

import Foundation
import UIKit

class AlertService {
    var alertActionDelegate: alertDelegate?
    var warning: Warning?

    init(_ warning: Warning? = nil) {
        self.warning = warning
    }

    public func generateAlert() -> UIAlertController {
        let alert = UIAlertController(title: warning?.title == "" ? nil : warning?.title,
                                      message: warning?.message,
                                      preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,
                                   handler: ({ _ in self.alertActionDelegate?.alertAction()}))
        alert.addAction(action)
        return alert
    }
}
