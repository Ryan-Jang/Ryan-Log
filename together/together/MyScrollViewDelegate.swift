//
//  MyScrollViewDelegate.swift
//  together
//
//  Created by admin on 2016. 10. 28..
//  Copyright © 2016년 장윤호. All rights reserved.
//

import Foundation
import UIKit

class MyScrollViewDelegate: NSObject, UIScrollViewDelegate {
    
    var toolbar: UIToolbar!
    var lastOffsetY: CGFloat = 0
    var main: MainViewController!
    
    public func setToolBar(bar: UIToolbar, Main: MainViewController) {
        self.toolbar = bar
        self.main = Main
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        lastOffsetY = scrollView.contentOffset.y
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView){
        let hide = scrollView.contentOffset.y > self.lastOffsetY
        toolbar.isHidden = hide
        main.reSizeToolBar(bool: hide)
    }
}
