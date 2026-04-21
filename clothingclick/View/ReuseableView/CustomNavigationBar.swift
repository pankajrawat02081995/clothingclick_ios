//
//  CustomNavigationBar.swift
//  clothingclick
//
//  Created by DavidBisht on 20/04/26.
//

import SwiftUI

struct NavBarItem {
    var title: String?
    var font: Font
    var image: String?
    var isSystemImage: Bool
    var tint: Color?
    var action: (() -> Void)?
}

struct NavBarConfig {
    var title: String
    var font: Font
    var leading: NavBarItem? = nil
    var trailing: [NavBarItem] = []
}

struct CustomNavigationBar: ViewModifier {
    
    var config: NavBarConfig
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationTitle(config.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .toolbar {
                
                ToolbarItem(placement: .principal) {
                    Text(config.title)
                        .font(config.font)
                }
                
                if let leading = config.leading,
                   leading.title != nil || leading.image != nil {
                    
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            if let image = leading.image {
                                if leading.isSystemImage == true {
                                    Image(systemName: image)
                                } else {
                                    Image(image)
                                }
                            }
                            if let title = leading.title {
                                Text(title)
                            }
                        }
                        .onTapGesture {
                            leading.action?()
                        }
                    }
                }
                
                if !config.trailing.isEmpty {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        ForEach(config.trailing.indices, id: \.self) { index in
                            let item = config.trailing[index]
                            
                            if item.title != nil || item.image != nil {
                                HStack {
                                    if let image = item.image {
                                        if item.isSystemImage == true {
                                            Image(systemName: image)
                                        } else {
                                            Image(image)
                                        }
                                    }
                                    if let title = item.title {
                                        Text(title)
                                    }
                                }
                                .onTapGesture {
                                    item.action?()
                                }
                            }
                        }
                    }
                }
            }
    }
}


extension View {
    func customNavigationBar(config: NavBarConfig) -> some View {
        self.modifier(CustomNavigationBar(config: config))
    }
}
