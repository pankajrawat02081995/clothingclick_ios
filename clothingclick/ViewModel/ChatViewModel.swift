//
//  ChatViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 07/05/26.
//

import Combine
import SwiftUI

class ChatViewModel: ObservableObject {
    
    @Published var chatID: String
    @Published var titleImage: Image?
    @Published var chatMessages: [Chat] = []
    @Published var inputMessage: String = ""

    private var loader = ImageLoader()

    init(chatID: String) {
        self.chatID = chatID
        self.titleImage = titleImage
    }

    func getTitleImage() {
        guard let  url: URL = URL(string: "https://picsum.photos/500") else { return }
        Task {
            await loader.load(from: url)
        }
        guard let image = loader.image else { return }
        titleImage = Image(uiImage: image)
    }
    
    func sendMessage() {
        guard inputMessage.isEmpty == false else {
            return
        }
        let id: Int = (chatMessages.last?.id ?? 0) + 1
        chatMessages.append(Chat(id: id, message: inputMessage, date: "\(Date().toTimeString())", isSeen: false, userId: 45))
        inputMessage = ""
        print(chatMessages.count)
    }
    
}

extension ChatViewModel {
    func mockData() {
        chatMessages = Chat.sampleChats
    }
}
