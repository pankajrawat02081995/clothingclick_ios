//
//  CustomSwitch.swift
//  clothingclick
//
//  Created by DavidBisht on 06/05/26.
//

import SwiftUI

struct CustomSwitch: View {
    @Binding var isOn: Bool
    
    var body: some View {
        ZStack(alignment: isOn ? .trailing : .leading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(isOn ? Color.black : Color.gray.opacity(0.3))
                .frame(width: 50, height: 30)
            
            Circle()
                .fill(Color.white)
                .frame(width: 26, height: 26)
                .padding(2)
        }
        .animation(.easeInOut(duration: 0.2), value: isOn)
        .onTapGesture {
            isOn.toggle()
        }
    }
}

//#Preview {
//    CustomToggle()
//}
