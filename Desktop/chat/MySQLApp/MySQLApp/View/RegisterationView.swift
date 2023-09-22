//
//  RegisterationView.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/07.
//

import SwiftUI

struct RegisterationView: View {
    
    // MARK: - PROPERTY
    
    @State private var id: String = ""
    @State private var password: String = ""
    @EnvironmentObject private var model: LoginModel
    // define this in your Detail view
    @Environment(\.presentationMode) var presentationMode
    
    let inputWidth: CGFloat = UIScreen.main.bounds.width / 1.6
    
    private var isFormValid: Bool {
        !id.isEmpty && !password.isEmpty && (password.count >= 6 && password.count <= 10)
    }
    
    
    private let httpClient = HTTPClient()
    
    // MARK: - FUNCTION
    
    private func register() async {
        
        do {
            print("타입체크:\(type(of: id)), \(type(of: password))")
            let registered = try await model.register(userid: id, password: password)
            if registered.error {
                
            } else {
                // 에러 발생
            }
        } catch {
            dump(error)
        }
        
    }
    
    // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
//                Spacer()
                Image(systemName: "person.circle.fill")
                    .foregroundColor(.accentColor)
                    
                
                TextField("아이디를 입력하세요", text: $id)
                        .padding(.horizontal, 6)
                        .border(.blue, width: 1)
                        .frame(width: inputWidth, alignment: .center)
                        .fixedSize()
                        .textInputAutocapitalization(.never) // 첫문자 대문자 안되게 해준다.
            }
            
            HStack {
                Image(systemName: "key.fill")
                    .foregroundColor(.accentColor)
                
                SecureField("비밀번호를 입력하세요", text: $password)
                    .padding(.horizontal, 6)
                    .border(.blue, width: 1)
                    .frame(width: inputWidth, alignment: .center)
                    .fixedSize()
                    
            }

            Button {
                print("회원가입")
                Task {
                    await register()
                    self.presentationMode.wrappedValue.dismiss()
                }
                
            } label: {
                Text("회원가입")
                    .font(.system(size: 20))
                    .fontWeight(.light)
                    .foregroundColor(.accentColor)
                    
            }
            .padding()
            .disabled(!isFormValid)
        }
        .navigationTitle("회원가입")
    }
}

struct RegisterationView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterationView()
            .environmentObject(LoginModel())
    }
}
