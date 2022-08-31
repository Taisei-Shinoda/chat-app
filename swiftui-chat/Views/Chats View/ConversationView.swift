//
//  ConversationView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/31.
//

import SwiftUI

struct ConversationView: View {
    
    @Binding var isChatShowing: Bool
    @State var chatMessage = ""
    
    var body: some View {
        VStack {
            
            //TODO: チャットヘッダー
            HStack {
                VStack(alignment: .leading) {
                    Button {
                        isChatShowing = false
                    } label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color("text-header"))
                    }
                    .padding(.bottom, 16)
                    
                    Text("Taisei Shinoda")
                        .font(.chatHeading)
                        .foregroundColor(Color("text-header"))

                }
                
                Spacer()
                
                ProfilePicView(user: User())
            }
            .padding(.horizontal)
            .frame(height: 104)
            
            //TODO: チャットログ
            ScrollView {
                
                VStack (spacing: 24){
                    
                    // 相手のメッセージ
                    HStack {
                        Text("相手のメッセージ")
                            .font(.bodyParagraph)
                            .foregroundColor(Color("text-primary"))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            .background(Color("bubble-secondary"))
                            .cornerRadius(30, corners: [.topLeft, .topRight, .bottomRight])
                        
                        Spacer()
                        
                        Text("9:41")
                            .font(.smallText)
                            .foregroundColor(Color("text-timestamp"))
                            .padding(.leading)
                    }
                    
                    // あなたのメッセージ
                    HStack {
                        Text("9:41")
                            .font(.smallText)
                            .foregroundColor(Color("text-timestamp"))
                            .padding(.trailing)
                        
                            Spacer()
                        
                        Text("あなたのメッセージ")
                            .font(.bodyParagraph)
                            .foregroundColor(Color("text-button"))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            .background(Color("bubble-primary"))
                            .cornerRadius(30, corners: [.topLeft, .topRight, .bottomLeft])

                    }
                }
                .padding(.horizontal)
                .padding(.top, 24)
            }
            .background(Color("background"))
            
            //TODO: メッセージバー
            ZStack {
                Color("background")
                    .ignoresSafeArea()
        
                HStack {
                    Button {
                        // TODO: ピッカー
                    } label: {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-secondary"))
                    }
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color("date-pill"))
                            .cornerRadius(50)
                        
                        TextField("Aa", text: $chatMessage)
                            .foregroundColor(Color("text-input"))
                            .font(.bodyParagraph )
                            .padding(10)
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                //
                            } label: {
                                Image(systemName: "face.smiling")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color("text-input"))
                            }
                        }
                        .padding(.trailing, 12)
                        
                    }
                    .frame(height: 44)
                    
                    HStack {
                    Button {
                        //TODO: SEND MESSE
                    } label: {
                        Image(systemName: "paperplane")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-secondary"))
                    }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 76)
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(false))
    }
}
