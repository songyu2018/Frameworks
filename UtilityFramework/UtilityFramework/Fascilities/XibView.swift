//
//  NibView.swift
//  UtilityFramework
//
//  //https://medium.com/flawless-app-stories/reusable-uiviews-in-swift-3f9dca63eaf4
//https://stackoverflow.com/questions/28495016/custom-view-xib-not-visible-on-storyboard
//

import UIKit

// Step1 to make the view visible in storyboard.
@IBDesignable
open class XibView : UIView {
    
    // Step2 to make the view visible in storyboard.
    var contentView:UIView?
    
    override public init(frame: CGRect) { // For using custom view from code
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder: NSCoder) { // For using custom view from IB
        super.init(coder: coder)
        commonInit()
    }
    
    /*
     // Seems this is doing the same work as the initWithCoder method.
    open override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    */
    
    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    open func loadViewFromNib() -> UIView? {
        //guard let nibName = nibName else { return nil }
        let nib = UINib(nibName: String(describing: XibView.self), bundle: Bundle(for: type(of: self)))
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
    
    // Step3 to make the view visible in storyboard.
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
        contentView?.prepareForInterfaceBuilder()
    }
}
