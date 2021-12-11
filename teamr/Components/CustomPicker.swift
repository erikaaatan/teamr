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

public struct CustomSegmentedPicker: View {
    @Binding var selected: Int
    let titles = ["LOG IN", "REGISTER"]
    @State var frames = Array<CGRect>(repeating: .zero, count: 2)
    
    public var body: some View {
        VStack {
            ZStack {
                HStack(spacing: 10) {
                    ForEach(self.titles.indices, id: \.self) { index in
                        Button(action: { self.selected = index }) {
                            Text(self.titles[index])
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(self.selected == index ? .white : Color("cedarChest"))
                        .padding()
                        .background(
                            GeometryReader { geo in
                                Color.clear.onAppear { self.setFrame(index: index, frame: geo.frame(in: .global)) }
                            }
                        )
                    }
                }
                .background(
                    RoundedRectangle(
                        cornerRadius: 8,
                        style: .continuous
                    )
                        .fill(Color("cedarChest"))
                        .frame(width: self.frames[self.selected].width,
                               height: self.frames[self.selected].height, alignment: .topLeading)
                        .offset(x: self.frames[self.selected].minX - self.frames[0].minX)
                    , alignment: .leading
                )
            }
            .animation(.default)
        }
    }
    
    func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}
