//
//  Extensions.swift
//  TapIt
//
//  Created by Akshay Jangir on 05/07/21.
//  Copyright © 2021 Akshay Jangir. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public var width: CGFloat{ return frame.size.width}
    public var height: CGFloat{ return frame.size.height}
    public var top: CGFloat{ return frame.origin.y}
    public var bottom: CGFloat{ return frame.origin.y + height}
    public var left: CGFloat{ return frame.origin.x}
    public var right: CGFloat{ return frame.origin.x + width}
    func addBackground(_ imgname: String) {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: imgname)

        imageViewBackground.contentMode = .scaleAspectFill

        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
