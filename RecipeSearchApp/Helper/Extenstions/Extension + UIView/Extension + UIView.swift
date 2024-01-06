//
//  Extension + UIView.swift
//  MarvelApp
//
//  Created by karim  on 27/12/2023.
//

import UIKit

extension UIView {
    
    func setGradientBackground(bottomColor: UIColor, centerColor: UIColor) {
        let colorCenter =  centerColor.cgColor
        let colorBottom = bottomColor.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            let gradient: CAGradientLayer = CAGradientLayer()
            
            gradient.colors = [colorCenter, colorBottom]
            gradient.locations = [0.0 , 1.0]
            gradient.startPoint = CGPoint(x: 0, y: 0.2)
            gradient.endPoint = CGPoint(x: 0, y: 1)
            gradient.frame =  CGRect(origin: CGPoint(x: 0, y: 0.0), size: CGSize(width: self.bounds.size.width, height: self.frame.height))
            self.layer.sublayers = nil
            self.layer.insertSublayer(gradient, at: 0)
        }
    }
}
