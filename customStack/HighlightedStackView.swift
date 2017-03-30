//
//  HighlightedStackView.swift
//  customStack
//
//  Created by Karol on 30/03/2017.
//  Copyright © 2017 Karol Bukowski. All rights reserved.
//

import UIKit

class HighlightedStackView: UIStackView, UIGestureRecognizerDelegate {
    private lazy var gestures = [UIView : UIGestureRecognizer]()
    
    private func add(_ view: UIView) -> UIView {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        gestures[view] = tap
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        return view
    }
    
    private func remove(_ view: UIView) -> UIView {
        guard let tap = gestures[view] else {
            return view
        }
        
        view.removeGestureRecognizer(tap)
        
        return view
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        guard let viewTapped = sender.view else {
            return
        }
        
        UIView.animate(withDuration: 1, animations: {
            self.arrangedSubviews.filter{$0 != viewTapped}.map{$0.isHidden = $0.isHidden.getOpposite()}
        })
        
    }
    
    override func addArrangedSubview(_ view: UIView) {
        super.addArrangedSubview(add(view))
    }
    
    override func removeArrangedSubview(_ view: UIView) {
        super.removeArrangedSubview(remove(view))
    }
    
    
}

