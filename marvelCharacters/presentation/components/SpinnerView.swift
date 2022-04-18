//
//  SpinnerView.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 13/4/22.
//

import UIKit

class SpinnerView: UIView {
    
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        indicator.style = .large
        indicator.color = .white
            
        // The indicator should be animating when
        // the view appears.
        indicator.startAnimating()
            
        // Setting the autoresizing mask to flexible for all
        // directions will keep the indicator in the center
        // of the view and properly handle rotation.
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
            
        return indicator
    }()
        
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.alpha = 0.2
        
        // Setting the autoresizing mask to flexible for
        // width and height will ensure the blurEffectView
        // is the same size as its parent view.
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
        return blurEffectView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
      }
      
      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
      }
      
      private func setupView() {
          backgroundColor = UIColor.black.withAlphaComponent(0.3)
          // Add the blurEffectView with the same
          // size as view
          blurEffectView.frame = self.bounds
          insertSubview(blurEffectView, at: 0)
          
          // Add the loadingActivityIndicator in the
          // center of view
          loadingActivityIndicator.center = CGPoint(
              x: bounds.midX,
              y: bounds.midY
          )
          addSubview(loadingActivityIndicator)
      }
}
