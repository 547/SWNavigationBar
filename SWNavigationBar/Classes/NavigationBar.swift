//
//  NavigationBar.swift
//  SWNavigationBar
//
//  Created by 547 on 09/04/2019.
//  Copyright (c) 2019 547. All rights reserved.
//
import UIKit
import Foundation
public extension UIViewController {
    func navigationBarBackgroudColor(_ color:UIColor) -> () {
        navBarBarTintColor = color
    }
    func navigationBarBackgroudImage(_ image:UIImage) -> () {
        navBarBackgroundImage = image
    }
    func navigationBarBackgroudAlpha(_ alpha:CGFloat) -> () {
        navBarBackgroundAlpha = alpha
    }
    func navigationBarTitleColor(_ color:UIColor) -> () {
        navBarTitleColor = color
    }
    func navigationBarTintColor(_ color:UIColor) -> () {
        navBarTintColor = color
    }
    func navigationBarShadowHidden(_ hidden:Bool) -> () {
        navBarShadowImageHidden = hidden
    }
    func statusBarStyle(_ style:UIStatusBarStyle) -> () {
        statusBarStyle = style
    }
    func backBarButtonItem(_ buttonItem:UIBarButtonItem) -> () {
        navigationItem.leftBarButtonItem = buttonItem
    }
}
public extension UIViewController {
    @objc
    func tapedCustomBackButtonItem(_ sender:UIButton) -> () {
        let count = navigationController?.children.count ?? 0
        if count > 1 {
            navigationController?.popViewController(animated: true)
        }else if count == 1, let _ = presentingViewController {
            dismiss(animated: true, completion: nil)
        }
    }
}


public extension UINavigationBar {
    /*竖直方向上移动NavigationBar
     *progress: 位移的进度，范围0~1
     *
     */
    @discardableResult
    func verticalDisplacementWith(progress:CGFloat) -> UINavigationBar {
        var progressValue = progress
        if progress > 1 {
            progressValue = 1
        }
        if progress < 0 {
            progressValue = 0
        }
        alpha = 1 - progressValue
        if progressValue > 0 {
            let trans = CGAffineTransform.identity.translatedBy(x: 0, y: -(bounds.height + UIApplication.shared.statusBarFrame.height) * progressValue)
            transform = trans
        }else {
            let trans = CGAffineTransform.identity.translatedBy(x: 0, y: 0)
            transform = trans
        }
        for item in subviews {
            let itemType = type(of: item)
            if itemType.description() == "_UIBarBackground" || itemType.description() == "_UINavigationBarBackground" {
                if item.frame.minY != -(UIApplication.shared.statusBarFrame.height) {
                    item.frame.origin.y = -(UIApplication.shared.statusBarFrame.height)
                }
                break
            }
        }
        return self
    }
}

private extension UIViewController {
    var isRootViewController: Bool{
        var result = false
        if let _ = navigationController, let viewControllers = navigationController?.viewControllers, viewControllers.count > 0, viewControllers[0].description == self.description{
            result = true
        }
        return result
    }
}
