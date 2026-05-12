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
    var titleImage: Image?
    var font: Font
    var tint: Color?
    var leading: NavBarItem? = nil
    var trailing: [NavBarItem] = []
}

struct CustomNavigationBar: ViewModifier {
    
    var config: NavBarConfig
    
    func body(content: Content) -> some View {
        content
//            .navigationBarBackButtonHidden(true)
            .navigationBarBackButtonHidden(config.leading != nil)
            .background(SwipeBackEnabler())
            .navigationTitle(config.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .toolbar {
                
                ToolbarItem(placement: .principal) {
                    if let image = config.titleImage {
                        HStack {
                            image
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text(config.title)
                                .font(config.font)
                                .foregroundStyle(config.tint ?? Color.black)
                        }
                    } else {
                        Text(config.title)
                            .font(config.font)
                            .foregroundStyle(config.tint ?? Color.black)
                    }
                }
                
                if let leading = config.leading,
                   leading.title != nil || leading.image != nil {
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            leading.action?()
                        } label: {
                            HStack {
                                if let image = leading.image {
                                    if leading.isSystemImage == true {
                                        Image(systemName: image)
                                            .renderingMode((leading.tint != nil) ? .template : .original)
                                    } else {
                                        Image(image)
                                            .renderingMode((leading.tint != nil) ? .template : .original)
                                    }
                                }
                                if let title = leading.title {
                                    Text(title)
                                        .font(leading.font)
                                        .foregroundStyle(leading.tint ?? Color.black)
                                }
                            }
                            .foregroundStyle((leading.tint != nil) ? leading.tint! : .black)
                        }
                    }
                }
                
                if !config.trailing.isEmpty {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        ForEach(config.trailing.indices, id: \.self) { index in
                            let item = config.trailing[index]
                            
                            if item.title != nil || item.image != nil {
                                Button {
                                    item.action?()
                                } label: {
                                    HStack {
                                        if let image = item.image {
                                            if item.isSystemImage == true {
                                                Image(systemName: image)
                                                    .renderingMode((item.tint != nil) ? .template : .original)
                                            } else {
                                                Image(image)
                                                    .renderingMode((item.tint != nil) ? .template : .original)
                                            }
                                        }
                                        if let title = item.title {
                                            Text(title)
                                                .font(item.font)
                                        }
                                    }
                                    .foregroundStyle((item.tint != nil) ? item.tint! : .black)
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

struct SwipeBackEnabler: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()

        DispatchQueue.main.async {
            controller.navigationController?
                .interactivePopGestureRecognizer?
                .delegate = nil
        }

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
