//
//  CustomCircle.swift
//  teamr
//
//  Created by Erika Tan on 12/4/21.
//

import SwiftUI

struct CustomCircle: View {
    var color = Color("rawSienna")
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(#colorLiteral(red: 0.7686274647712708, green: 0.7686274647712708, blue: 0.7686274647712708, alpha: 0)))

            Circle()
                .stroke(color, lineWidth: 2)
        }
    }
}

struct CustomSemiCircle: View {
    var color = Color("rawSienna")
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(#colorLiteral(red: 0.7686274647712708, green: 0.7686274647712708, blue: 0.7686274647712708, alpha: 0)))
                .rotationEffect(.degrees(180))

            Circle()
                .trim(from: 0.5, to: 1)
                .stroke(color, lineWidth: 2)
                .rotationEffect(.degrees(180))
                
        }
    }
}
