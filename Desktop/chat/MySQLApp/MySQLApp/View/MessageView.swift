//
//  MessageView.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/10.
//

import SwiftUI


struct MessageView: View {
    // MARK: - PROPERTIES

    var message: Message
    var chat: Chat
    
    @AppStorage("userId") var userid: String = ""
    @State private var messageHeight: CGFloat = 0.0
    @State private var time: String = ""
    
    var releaseDateString: String? {
        // 서버에서 주는 형태 (ISO규약에 따른 문자열 형태)
        guard let isoDate = ISO8601DateFormatter().date(from: time) else {
            return ""
        }
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd-HH:mm"
        let dateString = myFormatter.string(from: isoDate)
        return dateString
    }
    
    // MARK: - FUNCTION
    
    
    // MARK: - BODY
    
    var body: some View {
        if message.isFromCurrentUser(currentUser: userid) {
            HStack {
                Text(releaseDateString!)//.timeIntervalSince1970.description)
                    .frame(height: messageHeight, alignment: .bottom)
                
                HStack {
                    Text(message.message)
                        .padding(.all, 8)
                }
                .frame(maxWidth: 260, alignment: .trailing)
                .background(Color.blue)
                .cornerRadius(20)
                .fixedSize()
                
                Image(systemName: "person")
                    .frame(maxHeight: 32, alignment: .top)
                    .padding(.bottom, 16)
                    .padding(.trailing, 4)
            }
            .frame(maxWidth: 360, alignment: .trailing)
            .background(GeometryReader { proxy in
                Color.clear.onAppear {
                    messageHeight = proxy.size.height
                    // 이제 'height' 변수에 HStack의 높이가 저장됩니다.
//                    print("HStack의 높이는 \(height)입니다.")
                }
            })
            .onAppear {
                time = message.createdAt?.description ?? ""
            }
        } else {
            HStack {
                Image(systemName: "person")
                    .frame(maxHeight: 32, alignment: .top)
                    .padding(.bottom, 16)
                    .padding(.trailing, 4)
                HStack {
                    Text(message.message)
                        .padding(.all, 8)
                }
                .frame(idealWidth: 260, alignment: .leading)
                .background(Color.blue)
                .cornerRadius(20)
//                .fixedSize()
                
                Text(releaseDateString!)//.timeIntervalSince1970.description)
                    .frame(height: messageHeight, alignment: .bottom)

            }
            .frame(maxWidth: 360, alignment: .leading)
            .background(GeometryReader { proxy in
                Color.clear.onAppear {
                    messageHeight = proxy.size.height
                    // 이제 'height' 변수에 HStack의 높이가 저장됩니다.
//                    print("HStack의 높이는 \(height)입니다.")
                }
            })
            .onAppear {
                
                time = message.createdAt?.description ?? ""
                print("gg")
            }
        }
    }


}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: messages[0], chat: tmpChat[0])
            .previewLayout(.sizeThatFits)
    }
}
