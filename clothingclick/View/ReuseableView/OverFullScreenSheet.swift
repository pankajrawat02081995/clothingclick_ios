//
//  OverFullScreenSheet.swift
//  clothingclick
//
//  Created by DavidBisht on 27/04/26.
//

import SwiftUI

struct OverFullScreenSheet<Content: View>: View {
    
    @Binding var isPresented: Bool
    let content: Content
    @State private var safeAreaInsets: EdgeInsets = EdgeInsets()
    
    init(isPresented: Binding<Bool>,
         @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            if isPresented {
                
                // Background dim
                AppColor.blackColor.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
                
                // Bottom sheet
                GeometryReader { geo in
                    VStack {
                        Spacer()
                        
                        content
                            .background(AppColor.whiteColor)
                            .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
                            .transition(.move(edge: .bottom))
                    }
                    .onAppear {
                        safeAreaInsets = geo.safeAreaInsets
                    }
                    .onChange(of: geo.safeAreaInsets) { oldInsets,newInsets in
                        safeAreaInsets = newInsets
                    }
                }
                
                VStack{
                    Spacer()
                    Rectangle()
                        .fill(AppColor.whiteColor)
                        .frame(height: safeAreaInsets.bottom)
                }
                .ignoresSafeArea()
                
            }
        }
        .animation(.easeInOut, value: isPresented)
    }
}

//#Preview {
//    OverFullScreenSheet()
//}
