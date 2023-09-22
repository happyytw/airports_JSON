//
//  BackButton.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/21.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        VStack {
            Button {
                print("")
            } label: {
                Text("뒤로가기")
                    .padding()
                Spacer()
            }
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
