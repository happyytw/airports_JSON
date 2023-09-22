//
//  Inquiry.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/14.
//

import SwiftUI

struct InquiryView: View {
    @State private var title: String = ""
    @State private var summery: String = ""
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("문의")
                        .padding()
                    TextField(text: $title) {
                        Text("dd")
                    }
                    .textFieldStyle(PlainTextFieldStyle())
                    
                }
//                .padding()
                .navigationTitle("문의하기")
                .navigationBarTitleDisplayMode(.large)
                
                TextEditor(text: $summery)
                    .padding()
                    .border(Color.black, width: 1)
                    
                
                Spacer()
            }

        }
        .padding()

    }
}

struct Inquiry_Previews: PreviewProvider {
    static var previews: some View {
        InquiryView()
    }
}
