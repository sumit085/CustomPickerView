import UIKit

protocol PickerViewDelegate: AnyObject{
    func didSelectPickerView(index: Int)
}

protocol PickerViewDataSource: AnyObject{
    func getTitle(titleForRow row: Int, forComponent component: Int) -> String
    func getCount(numberOfRowsInComponent component: Int) -> Int
}

class PickerView: NSObject {
    
    var picker: UIPickerView?
    weak var delegate: PickerViewDelegate?
    weak var view: UIView?
    var overlayView: UIView?
    var doneButtonView: UIView!
    var dateSource: PickerViewDataSource?
    var selectedDictionaryValue: Int = 0
    
    init(view: UIView, delegate: PickerViewDelegate, dateSource: PickerViewDataSource) {
        super.init()
        self.view = view
        self.delegate = delegate
        self.dateSource = dateSource
    }
    
    func show() {
        if picker == nil {
            picker = UIPickerView()
            picker?.frame = CGRect(x: 0, y: (self.view?.frame.size.height)! - 240, width: (self.view?.frame.size.width)!, height: 240)
            picker?.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
            picker?.delegate = self
            picker?.dataSource = self
            
            doneButtonView = UIView()
            doneButtonView.backgroundColor = .lightGray
            doneButtonView?.frame = CGRect(x: 0, y: (self.view?.frame.size.height)! - 280, width: (self.view?.frame.size.width)!, height: 40)
            
            let toolBar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: (doneButtonView?.frame.size.width)!, height: (doneButtonView?.frame.size.height)!))
            toolBar.barStyle = .blackTranslucent
            toolBar.isTranslucent = true
            toolBar.backgroundColor = UIColor.lightGray
            toolBar.tintColor = UIColor.white
            toolBar.sizeToFit()
            
            // Adding Button ToolBar
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonAction))
            toolBar.setItems([cancelButton, space, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            
            doneButtonView?.addSubview(toolBar)
            
            var rect_overlay = (self.view?.frame)!
            rect_overlay.origin.y = 0
            overlayView = UIView(frame: (rect_overlay))
            overlayView?.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
            self.view?.addSubview(overlayView!)
            self.view?.addSubview(doneButtonView!)
            self.view?.addSubview(picker!)
        }
    }
    
    @objc func doneButtonAction() {
        self.hide()
        self.delegate?.didSelectPickerView(index: selectedDictionaryValue)
    }
    
    @objc func cancelButtonAction() {
        self.hide()
    }
    
    func hide() {
        self.overlayView?.removeFromSuperview()
        picker?.removeFromSuperview()
        doneButtonView?.removeFromSuperview()
    }
}

extension PickerView: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dateSource!.getCount(numberOfRowsInComponent: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dateSource?.getTitle(titleForRow: row, forComponent: component)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDictionaryValue  = row
    }
}
