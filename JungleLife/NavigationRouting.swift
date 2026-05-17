//
//  NavigationRouting.swift
//  JungleLife
//

import UIKit

extension UIViewController {
    func dismissToMenu(animated: Bool = true) {
        var presenter = presentingViewController
        while let current = presenter {
            if current is MenuViewController {
                current.dismiss(animated: animated, completion: nil)
                return
            }
            presenter = current.presentingViewController
        }

        if presentingViewController != nil {
            dismiss(animated: animated, completion: nil)
            return
        }

        guard presentedViewController == nil,
              let menuViewController = storyboard?.instantiateViewController(withIdentifier: "menu") as? MenuViewController else { return }
        present(menuViewController, animated: animated, completion: nil)
    }

    func dismissCurrentPage(animated: Bool = true) {
        if presentingViewController != nil {
            dismiss(animated: animated, completion: nil)
        } else if let navigationController = navigationController {
            navigationController.popViewController(animated: animated)
        }
    }
}
