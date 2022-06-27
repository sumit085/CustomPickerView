//
//  ViewController.swift
//  CustomPickerView
//
//  Created by Admin on 01/06/20.
//

import UIKit

struct PickerViewDataSourceModel {
    let name : String
    let id : Int
}

class ViewController: UIViewController {
    
    var pickerView : PickerView?
    
    private let pickerView_DataSource = [PickerViewDataSourceModel(name: "Option 1", id: 0), PickerViewDataSourceModel(name: "Option 2", id: 2)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTapPicker(_ sender: UIButton) {
        pickerView = PickerView(view: self.view, delegate: self, dateSource: self)
        pickerView?.show()
    }
}

extension ViewController: PickerViewDataSource {
    func getTitle(titleForRow row: Int, forComponent component: Int) -> String {
        return pickerView_DataSource[row].name
    }
    
    func getCount(numberOfRowsInComponent component: Int) -> Int {
        return pickerView_DataSource.count
    }
}

extension ViewController: PickerViewDelegate {
    func didSelectPickerView(index: Int) {
        print(index)
    }
}
