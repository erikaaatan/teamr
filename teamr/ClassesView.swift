//
//  ClassesView.swift
//  teamr
//
//  Created by Erika Tan on 12/4/21.
//

import SwiftUI

class ActiveClass: ObservableObject {
    @Published var showingClass: Class?
}

struct ClassesView: View {
    @State private var showingAlert = false
    @State private var alertInput = ""
    var classes = [
        Class(name: "CS 371L", owner: User(name: "Dr. Bulko", email: "email", phone: "", role: .instructor)),
        Class(name: "CS 314H", owner: User(name: "Dr. Lin", email: "", phone: "", role: .instructor)),
        Class(name: "CS 331H", owner: User(name: "Dr. Price", email: "", phone: "", role: .instructor)),
        Class(name: "CS 439H", owner: User(name: "Dr. Gheith", email: "", phone: "", role: .instructor)),
        Class(name: "CS 313E", owner: User(name: "Dr. Mitra", email: "", phone: "", role: .instructor))
    ]
    
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
                Button(action: {
                    self.showingAlert = true
                }) {
                    Text("CREATE CLASS")
                }
                .alert(isPresented: $showingAlert, TextAlert(title: "Create Class", placeholder: "Class Name", action: {
                    print("Callback \($0 ?? "<cancel>")")
                }))
                .frame(maxHeight: 50)
                .buttonStyle(FilledButton())
                .padding()
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(classes) {cl in
                            NavigationLink(destination: ClassDetailsView(showingClass: cl)
                                            .navigationBarTitle("", displayMode: .inline)) {
                                ClassText(cl.name)
                                    .padding(.top)
                                    .padding(.leading)
                                    .padding(.trailing)
                            }
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ClassesView_Previews: PreviewProvider {
    static var previews: some View {
        ClassesView()
    }
}
