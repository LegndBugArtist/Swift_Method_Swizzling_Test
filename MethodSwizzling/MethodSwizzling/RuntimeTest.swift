//
//  RuntimeTest.swift
//  MethodSwizzling
//
//  Created by 刘喆 on 2022-03-04.
//

import Foundation
import UIKit


//向所有UIViewcontroller中添加一个属性
extension UIViewController {
    private struct AssociatedKeys {
        static var DescriptiveName = "nsh_DescriptiveName"
    }

    var descriptiveName: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.DescriptiveName,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

