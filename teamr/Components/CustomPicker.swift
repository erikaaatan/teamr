//
//  CustomPicker.swift
//  teamr
//
//  Created by Erika Tan on 12/7/21.
//

import SwiftUI

var data = Array((1...10).map({ "\($0)"}))
struct CustomPicker: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return CustomPicker.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<CustomPicker>) -> UIPickerView {
        let picker = UIPickerView()
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: UIViewRepresentableContext<CustomPicker>) {
        
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        var parent: CustomPicker
        init(parent1: CustomPicker) {
            parent = parent1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return data.count
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 60))
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
            label.text = data[row]
            label.textAlignment = .center
            label.textColor = UIColor(Color("cedarChest"))
            label.font = .systemFont(ofSize: 18, weight: .bold)
            view.addSubview(label)
            return view
        }

        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return UIScreen.main.bounds.width - 100
        }

        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 60
        }
    }
}
