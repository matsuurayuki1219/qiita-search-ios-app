//
//  UIImageView+Util.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/07.
//

import Foundation
import UIKit

extension UIImageView{

    func roundCorner() -> UIImageView {
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = self.frame.size.width / 2
        return self
    }
    
}
