//
//  PickerAlert.swift
//  teamr
//
//  Created by Erika Tan on 12/7/21.
//

import SwiftUI

struct PickerAlert<Presenting>: View where Presenting: View {
    @Binding var isShowing: Bool
    let presenting: Presenting
    @State private var number = 1

    var body: some View {
        ZStack {
            self.presenting
                .disabled(isShowing)
            VStack(alignment: .center) {
                Text("Make Groups")
                    .font(.system(size: 18))
                    .padding(.top)
                Text("Randomly put students into groups of a specific size.")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)
                CustomPicker()
                .clipped()
                .compositingGroup()
//                .allowsHitTesting(isShowing)
                Button(action: {
                    withAnimation {
                        self.isShowing.toggle()
                    }
                }) {
                    Text("OK")
                        .padding()
                }
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color("cedarChest"))
            }
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                ).fill(Color.white)
                .shadow(color: .gray, radius: 2, x: 4, y: 4)
            )
//            .disabled(!isShowing)
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .opacity(self.isShowing ? 1 : 0)
//            .allowsHitTesting(isShowing)
        }
//        .disabled(!self.isShowing ? true : false)
//        .opacity(self.isShowing ? 1 : 0)
//        .allowsHitTesting(self.isShowing ? true : false)
    }

}
