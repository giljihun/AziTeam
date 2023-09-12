//
//  Created by Artem Novichkov on 20.05.2021.
//

import SwiftUI

struct NamePopupView: View {
    
    @Binding var isPresented: Bool
    @State var text = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Enter Team Code")
                    .font(.system(size: 25, weight: .bold, design: .default))
                    .foregroundColor(.black)
                    .lineLimit(1)
                Spacer()
                Button(action: {
                        isPresented = false
                }, label: {
                    Image(systemName: "xmark")
                        .imageScale(.small)
                        .frame(width: 32, height: 32)
                        .background(Color.black.opacity(0.06))
                        .cornerRadius(16)
                        .foregroundColor(.black)
                })
            }
            TextField("#", text: $text)
                .frame(height: 36)
                .padding([.leading, .trailing], 10)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .autocapitalization(.none) // 입력된 텍스트를 자동으로 대문자로 바꾸지 않음
                .disableAutocorrection(true) // 자동 교정 기능 비활성화
                .textContentType(.none) // 텍스트의 유형을 지정하지 않음
                .keyboardType(.default) // 기본 키보드 사용
                .textCase(.lowercase) // 입력된 텍스트를 소문자로 유지
            
            HStack {
                Spacer()
                Button(action: {
                    isPresented = false
                }, label: {
                    Text("Done")
                })
                .frame(width: 80, height: 36)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct NamePopupView_Previews: PreviewProvider {
    static var previews: some View {
        NamePopupView(isPresented: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
