//
//  UIViewExtension.swift
//  Weather App
//
//  Created by Felipe Teles on 12/04/25.
//

import Foundation
import UIKit

extension UIView{
    func setConstraintsToParent(_ parent: UIView){
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: parent.topAnchor),
                self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
                self.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
            ]);
    }
}
