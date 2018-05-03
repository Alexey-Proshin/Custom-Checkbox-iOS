//
//  ViewController.swift
//  Custom-Checkbox-iOS
//
//  Created by Alejandro Donzer on 25/02/2018.
//  Copyright © 2018 Alejandro Donzer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var userReadCheckbox: Checkbox!
    @IBOutlet weak var othersReadCheckbox: Checkbox!
    @IBOutlet weak var groupExecCheckbox: Checkbox!
    @IBOutlet weak var othersExecCheckbox: Checkbox!
    @IBOutlet weak var groupWriteCheckbox: Checkbox!
    @IBOutlet weak var groupReadCheckbox: Checkbox!
    @IBOutlet weak var othersWriteCheckbox: Checkbox!
    @IBOutlet weak var userExecCheckbox: Checkbox!
    @IBOutlet weak var userWriteCheckbox: Checkbox!
    
    @IBOutlet weak var userPickerView: UIPickerView!
    @IBOutlet weak var othersPickerView: UIPickerView!
    @IBOutlet weak var groupPickerView: UIPickerView!
    
    fileprivate var checkboxes: [Checkbox]
    
    fileprivate enum CheckboxIndex {
        static let userRead = 0
        static let userWrite = 1
        static let userExec = 2
        static let othersRead = 3
        static let othersWrite = 4
        static let othersExec = 5
        static let groupRead = 6
        static let groupWrite = 7
        static let groupExec = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        checkboxes = []
        super.init(coder: aDecoder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerViews = [userPickerView!, othersPickerView!, groupPickerView!]
        
        checkboxes = [userReadCheckbox!, userWriteCheckbox!, userExecCheckbox!, othersReadCheckbox!, othersWriteCheckbox!, othersExecCheckbox!,
            groupReadCheckbox!, groupWriteCheckbox!, groupExecCheckbox!]
        
        for pickerView in pickerViews {
            pickerView.delegate = self
            pickerView.dataSource = self
        }
        
        for checkbox in checkboxes {
            checkbox.addTarget(self, action: #selector(changeMode), for: .touchUpInside)
        }
    }
    
    @objc fileprivate func changeMode(sender: Checkbox) {
        switch sender {
        case userReadCheckbox, userWriteCheckbox, userExecCheckbox:
            selectPickerViewRow(pickerView: userPickerView, readCheckbox: userReadCheckbox, writeCheckbox: userWriteCheckbox, execCheckbox: userExecCheckbox)
            break
        case othersReadCheckbox, othersWriteCheckbox, othersExecCheckbox:
            selectPickerViewRow(pickerView: othersPickerView, readCheckbox: othersReadCheckbox, writeCheckbox: othersWriteCheckbox, execCheckbox: othersExecCheckbox)
            break
        case groupReadCheckbox, groupWriteCheckbox, groupExecCheckbox:
            selectPickerViewRow(pickerView: groupPickerView, readCheckbox: groupReadCheckbox, writeCheckbox: groupWriteCheckbox, execCheckbox: groupExecCheckbox)
            break
        default:
            break
        }
    }
    
    fileprivate func selectPickerViewRow(pickerView: UIPickerView, readCheckbox: Checkbox, writeCheckbox: Checkbox, execCheckbox: Checkbox) {
        let first = readCheckbox.isSelected.hashValue
        let second = writeCheckbox.isSelected.hashValue
        let third = execCheckbox.isSelected.hashValue
        let source = String(String(first) + String(second) + String(third))
        let value = Int(source, radix: 2)!
        pickerView.selectRow(value, inComponent: 0, animated: false)
    }
    
    fileprivate func setCheckboxStates(row: Int, indexes: [Int]) {
        var binaryRow = String(row, radix: 2)
        var length = binaryRow.count
        
        while length < 3 {
            binaryRow = "0" + binaryRow
            length = binaryRow.count
        }
        
        var j = 0
        
        for i in indexes {
            checkboxes[i].setState(state: binaryRow[binaryRow.index(binaryRow.startIndex, offsetBy: j)] == "1" ? .checked : .unchecked)
            j += 1
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 8
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: String(row), attributes: [.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case userPickerView:
            setCheckboxStates(row: row, indexes: [CheckboxIndex.userRead, CheckboxIndex.userWrite, CheckboxIndex.userExec])
            break
        case othersPickerView:
            setCheckboxStates(row: row, indexes: [CheckboxIndex.othersRead, CheckboxIndex.othersWrite, CheckboxIndex.othersExec])
            break
        case groupPickerView:
            setCheckboxStates(row: row, indexes: [CheckboxIndex.groupRead, CheckboxIndex.groupWrite, CheckboxIndex.groupExec])
            break
        default:
            break
        }
    }
}
