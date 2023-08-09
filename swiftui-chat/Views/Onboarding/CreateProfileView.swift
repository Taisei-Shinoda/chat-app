//
//  CreateProfileView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/24.
//

import SwiftUI

struct CreateProfileView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var firstName  = ""
    @State var lastName  = ""
    
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    @State var isSaveButtonDisabled = false
    
    @State var isErrorLabelVisible = false
    @State var errorMessage = ""
    
    
    var body: some View {
        
        VStack {
            Text("プロフィールを編集")
                .font(.titleText)
                .padding(.top, 52)
            
            Text("詳細")
                .font(.bodyParagraph)
                .padding(.top, 12)
            
            Spacer()
            
            Button {
                isSourceMenuShowing = true
            } label: {
                ZStack {
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .foregroundColor(.white)
                        Image(systemName: "camera.fill")
                            .tint(Color("icons-input"))
                    }
                    Circle()
                        .stroke(Color("create-profile-border"), lineWidth: 2)
                    
                }
                .frame(width: 134, height: 134)
            }
            
            Spacer()
            
            TextField("Given Name", text: $firstName)
                .textFieldStyle(CreateProfileTextfieldStyle())
                .placeholder(when: firstName.isEmpty) {
                    Text("Given Name")
                        .foregroundColor(Color("text-textfield"))
                        .font(.bodyParagraph)
                }
            
            TextField("Last Name", text: $lastName)
                .textFieldStyle(CreateProfileTextfieldStyle())
                .placeholder(when: lastName.isEmpty) {
                    Text("Last Name")
                        .foregroundColor(Color("text-textfield"))
                        .font(.bodyParagraph)
                }
            
            // エラーラベル
            Text(errorMessage)
                .foregroundColor(.red)
                .font(.smallText)
                .padding(.top, 20)
                .opacity(isErrorLabelVisible ? 1 : 0)
            
            
            Spacer()
            
            Button {
                
                isErrorLabelVisible = false
                
                guard !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
                        !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    
                    errorMessage = "有効な名字と名前を入力してください"
                    isErrorLabelVisible = true
                    return
                    
                }
                
                isSaveButtonDisabled = true
                //TODO: データのセーブ
                DatabaseService().setUserProfile(firstName: firstName,
                                                 lastName: lastName,
                                                 image: selectedImage,
                                                 completion: { isSuccess in
                    if isSuccess {
                        currentStep = .contacts
                    } else {
                        // TODO: ユーザーにエラーメッセージを見せます
                        errorMessage = "エラーが発生しました。もう一度試してください。"
                        isErrorLabelVisible = true
                    }
                    isSaveButtonDisabled = false
                })
            } label: {
                Text(isSaveButtonDisabled ? "Uploading" : "Save")
            }
            .buttonStyle(OnboardingButtonStyle())
            .disabled(isSaveButtonDisabled)
            .padding(.bottom, 87)
        }
        .padding(.horizontal)
        .confirmationDialog("From Where", isPresented: $isSourceMenuShowing, actions: {
        
            Button {
                // Set the SOORCE
                self.source = .photoLibrary
                isPickerShowing = true
            } label: {
                Text("Photo Library")
            }
            
            /// シミュレーターにはカメラ機能がないので、クラッシュ防止のためこのメソッドを書きました
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                Button {
                    // Set the SOORCE
                    self.source = .camera
                    isPickerShowing = true
                } label: {
                    Text("写真を使用")
                }
            }
        })
        .sheet(isPresented: $isPickerShowing) {
            // TODO: ImagePicker を表示します
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, source: self.source)
        }
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(currentStep: .constant(.profile))
    }
}
