//
//  Utils.swift
//  Memo
//
//  Created by 정기욱 on 21/02/2019.
//  Copyright © 2019 Kiwook. All rights reserved.
//

import Foundation

extension UIViewController {
    var tutorialSB: UIStoryboard {
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    func instanceTutorialVC(name: String) -> UIViewController? {
        return self.tutorialSB.instantiateViewController(withIdentifier: name)
    }
}
