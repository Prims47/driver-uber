//
//  ViewDriverInfo.swift
//  driverUber
//
//  Created by IlanB on 15/03/2017.
//  Copyright © 2017 IlanB. All rights reserved.
//

import UIKit

@IBDesignable class ViewDriverInfo: UIView {
    
    @IBInspectable var shadowOpacity:CGFloat = 0.7 {
        didSet {
            self.layer.shadowOpacity = Float(shadowOpacity)
        }
    }

    @IBInspectable var shadowRadius:CGFloat = 5 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOffset:CGSize = CGSize(width: 4, height: 4) {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
