//
//  LayoutAnchors.swift
//  GenericCollections
//
//  Created by Mac on 6.12.2020.
//

import Foundation
import UIKit

enum LayoutError : String, Error{
    case needToSuperView = "This view has no superview for constraint.That's illegal"
}


extension UIView {
    
    //MARK:-> Fill all
    func layoutFillAllToSuperView(){
        guard let superView = self.superview else {fatalError(LayoutError.needToSuperView.rawValue)}
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: superView.heightAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: superView.widthAnchor).isActive = true
    }
    
    
    //MARK:-> Center To Object
    func layoutCenterToSuperView(height : CGFloat? = nil, width : CGFloat? = nil) {
        guard let superView = self.superview else {fatalError(LayoutError.needToSuperView.rawValue)}
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        if let height = height {self.heightAnchor.constraint(equalToConstant: height).isActive = true}else {
            self.heightAnchor.constraint(equalTo: superView.heightAnchor).isActive = true
        }
        if let width = width {self.widthAnchor.constraint(equalToConstant: width).isActive = true}else {
            self.widthAnchor.constraint(equalTo: superView.widthAnchor).isActive = true
        }
    }
    
    func setAnchor(leftAnchor : NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil , leftConstant : CGFloat? = nil , rightAnchor : NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil , rigthConstant : CGFloat? = nil , topAnchor : NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil , topConstant : CGFloat? = nil , bottomAnchor : NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil , bottomConstant : CGFloat? = nil , centerX : NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil , centerXConstant : CGFloat? = nil , centerY : NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil , centerYConstant : CGFloat? = nil){
        guard self.superview != nil else {fatalError(LayoutError.needToSuperView.rawValue)}
        self.translatesAutoresizingMaskIntoConstraints = false
        if let left = leftAnchor {
            self.leftAnchor.constraint(equalTo: left , constant: leftConstant == nil ? 0 : leftConstant!).isActive = true
        }
        if let rigth = rightAnchor {
            self.rightAnchor.constraint(equalTo: rigth , constant: rigthConstant == nil ? 0 : rigthConstant!).isActive = true
        }
        if let top = topAnchor {
            self.topAnchor.constraint(equalTo: top , constant: topConstant == nil ? 0 : topConstant!).isActive = true
        }
        if let bottom = bottomAnchor {
            self.bottomAnchor.constraint(equalTo: bottom , constant: bottomConstant == nil ? 0 : bottomConstant!).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY , constant: centerYConstant == nil ? 0 : centerYConstant!).isActive = true
        }
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX , constant: centerXConstant == nil ? 0 : centerXConstant!).isActive = true
        }
        
        
    }
}
