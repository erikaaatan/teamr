//
//  ClassesView.swift
//  teamr
//
//  Created by Erika Tan on 12/4/21.
//

import SwiftUI

struct ClassesView: View {
    @State private var showingSheet = false
    
    var body: some View {
        ZStack {
            Color("lavenderBlush")
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(radius: 40, corners: [.bottomLeft, .bottomRight])
                        .frame(height: 400)
                    Image("SitReadingDoodle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    Text("Classes")
                        .offset(x: -80, y: 160)
                        .font(.custom("JosefinSans-Regular", size: 48))
                }
                
                Spacer()
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(0..<5) {num in
                            Button(action: {
                                showingSheet.toggle()
                            }) {
                                Text("Class \(num)")
                            }
                            .buttonStyle(ClassButton())
                            .padding(.bottom)
                            .padding(.trailing)
                            .padding(.leading)
                        }
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $showingSheet) {
            ClassDetailsView()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ClassesView_Previews: PreviewProvider {
    static var previews: some View {
        ClassesView()
    }
}
