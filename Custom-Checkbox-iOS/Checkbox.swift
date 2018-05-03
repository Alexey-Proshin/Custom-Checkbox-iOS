//
//  Checkbox.swift
//  Custom-Checkbox-iOS
//
//  Created by Alejandro Donzer on 25/02/2018.
//  Copyright © 2018 Alejandro Donzer. All rights reserved.
//

import UIKit

@IBDesignable class Checkbox: UIButton {
    
    @IBInspectable var checkedIcon: UIImage? {
        didSet {
            setImage(checkedIcon, for: .selected)
        }
    }
    
    @IBInspectable var uncheckedIcon: UIImage? {
        didSet {
            setImage(uncheckedIcon, for: .normal)
        }
    }

    @IBInspectable var isChecked: Bool = false {
        didSet {
            isSelected = isChecked
        }
    }
    
    override open var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
        }
    }
    
    enum CheckboxState {
        case checked
        case unchecked
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    fileprivate func setupUI() {
        self.addTarget(self, action: #selector(changeState), for: .touchUpInside)
        setImages()
    }
    
    fileprivate func setImages() {
        setImage(checkedIcon, for: .selected)
        setImage(uncheckedIcon, for: .normal)
    }
    
    override open func prepareForInterfaceBuilder() {
        setTitle("", for: UIControlState())
        setImages()
    }
    
    func setState(state: CheckboxState) {
        isSelected = !(state == .checked)
        changeState()
    }
    
    @objc fileprivate func changeState() {
        isSelected = !isSelected
    }
}
