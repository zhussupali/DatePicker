//
//  UIScrollView+Extensions.swift
//  DatePicker
//
//  Created by zhussupali on 04.03.2024.
//

import UIKit

extension UIScrollView {
    func scrollToTop(animated: Bool) {
        setContentOffset(CGPoint(x: 0, y: -contentInset.top), animated: animated)
    }
    
    func scrollToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    func scrollTo(view: UIView, animated: Bool) {
        let rect = convert(view.bounds, from: view)
        scrollRectToVisible(rect, animated: animated)
    }
}
