//
//  ConcentraitionThemeChooserViewController.swift
//  Concentration
//
//  Created by Евгений Трофимов on 19/03/2020.
//  Copyright © 2020 Евгений Трофимов. All rights reserved.
//

import UIKit

class ConcentraitionThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    let themes = [
        "Sports": "⚽️🏀🏈🏓🥊⛳️🤼‍♂️🏋️‍♂️",
        "Animals": "🐶🐬🦊🐻🐘🦅🐰🐒",
        "Faces": "👮‍♂️🎅👳‍♂️🕵️‍♂️👨‍⚕️👩‍🌾🧝‍♀️👨‍🚒"
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        if let cvc = secondaryViewController as? ConcentraitionViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }

    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentraitionViewController? {
        return splitViewController?.viewControllers.last as? ConcentraitionViewController
    }
    
    private var lastSeguedToConcentrationViewController: ConcentraitionViewController?
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentraitionViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }
    

}
