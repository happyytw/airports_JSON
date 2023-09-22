//
//  LoginView.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/07.
//

import SwiftUI

struct LoginView: View {
    // MARK: - PROPERTY
    
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var isPressed: Bool = false
    @State private var showAlert: Bool = false // 로그인 실패 정보
    @State private var loginFail: String = ""
    @AppStorage("userId") var userid = User(user_id: "", user_password: "").encode()!
    
    let inputWidth: CGFloat = UIScreen.main.bounds.width / 1.6
    
    private var model = LoginModel()
    
    // MARK: - FUNCTION
    
    func login() async {
        do {
            let login = try await model.login(userid: id, password: password)
            if login.error {
                switch login.reason {
                    case "Bad Request":
                        loginFail = "존재하지 않는 아이디입니다."
                    case "Unauthorized":
                        loginFail = "비밀번호가 틀렸습니다."
                    case "Not Found":
                        loginFail = "존재하지 않는 아이디입니다."
                    default:
                        print(login.reason?.description)
                        print("없는사람")
                }
                self.showAlert.toggle()
            } else {
                userid = login.user.encode()!
                self.isPressed.toggle()
            }
        } catch {
            dump(error)
        }
    }
    
    // MARK: - BODY
    
    var body: some View {

        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.accentColor)
                    
                    TextField("아이디를 입력하세요", text: $id)
                            .padding(.horizontal, 6)
                            .border(.blue, width: 1)
                            .frame(width: inputWidth, alignment: .center)
                            .fixedSize()
                            .textInputAutocapitalization(.never) // 소문자로 시작하기
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
                
                HStack {
                    Button {
                        print("로그인")
                        Task {
                            print("체크111")
                            await self.login()
                            print("체크222")
                        }
                    } label: {
                        Text("로그인")
                            .font(.system(size: 20))
                            .fontWeight(.light)
                            .frame(height: 2)
                    }
                    .padding()
                    .fullScreenCover(isPresented: $isPressed) {
                        AppView()
                    }

                    NavigationLink(destination: RegisterationView(), label: {
                        Text("회원가입")
                            .font(.system(size: 20))
                            .fontWeight(.light)
                            .foregroundColor(.accentColor)
                    })

                    .padding()
                    
                }
                
                
                    
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("로그인 실패"), message: Text(loginFail), dismissButton: .default(Text("확인")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            
    }
}
