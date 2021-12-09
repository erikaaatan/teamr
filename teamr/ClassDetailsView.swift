//
//  ClassDetailsView.swift
//  teamr
//
//  Created by Erika Tan on 12/6/21.
//

import SwiftUI

struct OverviewView: View {
    var body: some View {
        VStack(spacing: 40) {
            VStack {
                Text("X7H3N8")
                    .font(.custom("JosefinSans-Regular", size: 48))
                Text("Class Code")
            }
            VStack {
                Text("Dr. Prof")
                    .font(.custom("JosefinSans-Regular", size: 48))
                Text("Class Owner")
            }
            VStack {
                Text("36")
                    .font(.custom("JosefinSans-Regular", size: 48))
                Text("Students Enrolled")
            }
        }
        .padding()
    }
}

struct GroupView: View {
    let grouped: [String] = []
    let ungrouped = (1...100).map { "Item \($0)" }
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Grouped students")
                    .padding()
                if grouped.count == 0 {
                    VStack(alignment: .center) {
                        Image("UnboxingDoodle")
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0,
                                   maxWidth: UIScreen.main.bounds.width * 0.5,
                                   minHeight: 0,
                                   maxHeight: UIScreen.main.bounds.width * 0.5)
                            .padding()
                        Text("No groups yet")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                } else {
                    // TODO: show grouped students
                }
                Text("Ungrouped students")
                    .padding()
                ScrollView {
                    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-views-in-a-grid-using-lazyvgrid-and-lazyhgrid
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(ungrouped, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(minHeight: 0, maxHeight: 100)
                VStack(alignment: .leading) {
                    Text("Make Groups")
                        .padding()
                    VStack(alignment: .center) {
                        Text("Randomly put students into groups of a specific size.")
                            .multilineTextAlignment(.center)
                            .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.7)
                            .fixedSize(horizontal: false, vertical: true)
                        CustomPicker()
                        Button("MAKE GROUPS") {
                        }
                            .buttonStyle(FilledButton())
                            .padding()
                    }
                }
            }
        }
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var searching: Bool
    
     var body: some View {
         ZStack {
             Rectangle()
                 .foregroundColor(Color("lightGray"))
             HStack {
                 Image(systemName: "magnifyingglass")
                 TextField("Search ..", text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                    }
                }
             }
             .foregroundColor(.gray)
             .padding(.leading, 13)
         }
             .frame(height: 40)
             .cornerRadius(13)
             .padding()
     }
 }

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}

struct StudentsView: View {
    @State var searchText = ""
    @State var searching = false
    let myFruits = [
             "Apple ", "Banana ", "Blueberry ", "Strawberry ", "Avocado ", "Cherries ", "Mango ", "Watermelon ", "Grapes ", "Lemon "
         ]
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText, searching: $searching)
                .modifier(DismissingKeyboard())
            List {
                ForEach(myFruits.filter({ (fruit: String) -> Bool in
                         return fruit.hasPrefix(searchText) || searchText == ""
                     }), id: \.self) { fruit in
                         Text(fruit)
                     }
             }
                .listStyle(GroupedListStyle())
            
        }
        // TODO: check if this is working
        // https://blckbirds.com/post/how-to-create-a-search-bar-with-swiftui/
        // might need this link to resign the keyboard
        .toolbar {
                     if searching {
                         Button("Cancel") {
                             searchText = ""
                             withAnimation {
                                 searching = false
                             }
                         }
                     }
                 }
    }
}

struct ClassDetailsView: View {
    @State private var selected = 0
    
    var body: some View {
        ZStack {
            Color("lavenderBlush")
            VStack(alignment: .leading) {
                Spacer()
                Text("CS 371L\nFall 2021")
                    .font(.custom("JosefinSans-Regular", size: 48))
                    .padding()
//                    .padding(.top)
//                    .padding(.top)
//                    .padding(.top)
                Spacer()
                ZStack {
                    VStack {
                        Picker("test", selection: $selected) {
                            Text("Overview").tag(0)
                            Text("Groups").tag(1)
                            Text("Students").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        if selected == 0 {
                            OverviewView()
                        } else if selected == 1 {
                            GroupView()
                        } else {
                            StudentsView()
                        }
                    }
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                           maxHeight: .infinity,
                           alignment: .topLeading)
                }
                .background( Rectangle()
                                .fill(Color.white)
                                .cornerRadius(radius: 40, corners: [.topLeft, .topRight]))
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                       maxHeight: .infinity,
                       alignment: .center)
            }
            
        }
//        .pickerAlert(isShowing: $makeGroup)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
//        .edgesIgnoringSafeArea(.top)
    }
}

struct ClassDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ClassDetailsView()
    }
}
