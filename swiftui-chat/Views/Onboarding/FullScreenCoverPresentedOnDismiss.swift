//
//  hello.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/24.
//

import SwiftUI

struct FullScreenCoverPresentedOnDismiss: View {
    @State private var isPresenting = false
    var body: some View {
        Button("Present Full-Screen Cover") {
            isPresenting.toggle()
        }
        .fullScreenCover(isPresented: $isPresenting,
                         onDismiss: didDismiss) {
            VStack {
                Text("モーダルビューです！！！")
                Text("Tap to Dismiss")
            }
            .onTapGesture {
                isPresenting.toggle()
            }
        }
    }
    
    func didDismiss() {
        // Handle the dismissing action.
    }
}

struct hello_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenCoverPresentedOnDismiss()
    }
}
