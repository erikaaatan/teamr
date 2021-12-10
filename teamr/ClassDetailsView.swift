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
    let ungrouped = [
        User(name: "Erika Tan", email: "email", phone: "phone", role: .student),
        User(name: "Lily Chen", email: "email", phone: "phone", role: .student),
        User(name: "Michael Bond", email: "email", phone: "phone", role: .student),
        User(name: "Rachel Zhu", email: "email", phone: "phone", role: .student),
        User(name: "Ishika Nevatia", email: "email", phone: "phone", role: .student),
        User(name: "Grace Dwyer", email: "email", phone: "phone", role: .student)
         ]
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
                Text("Ungrouped students (\(ungrouped.count))")
                    .padding()
                ScrollView {
                    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-views-in-a-grid-using-lazyvgrid-and-lazyhgrid
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(ungrouped) { student in
                            VStack(alignment: .center) {
                                UserNameText(student)
                                Text(student.name)
                                    .font(.system(size: 10))
                            }
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
    let students: [User] = [
        User(name: "Erika Tan", email: "email", phone: "phone", role: .student),
        User(name: "Lily Chen", email: "email", phone: "phone", role: .student),
        User(name: "Michael Bond", email: "email", phone: "phone", role: .student)
         ]
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText, searching: $searching)
            if students.count == 0 {
                Image("MessyDoodle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .padding()
                Text("Oops!")
                    .font(.custom("JosefinSans-Regular", size: 48))
                Text("No students have signed up for your class yet. Give them your class code to sign up!")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                    .padding()
            } else {
                VStack(alignment: .leading) {
                    ForEach(students.filter({ (student: User) -> Bool in
                        return student.name.hasPrefix(searchText) || searchText == ""
                         })) { student in
                            UserText(student)
                         }
                        .listStyle(GroupedListStyle())
                }
            }
        }
        .modifier(DismissingKeyboard())
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
        // sadge
//        .pickerAlert(isShowing: $makeGroup)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
    }
}

struct ClassDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ClassDetailsView()
    }
}
