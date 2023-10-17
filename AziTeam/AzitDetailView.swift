//
//  AzitDetailView.swift
//  AziTeam
//
//  Created by mobicom on 2023/08/23.
//

import SwiftUI

struct AzitDetailView: View {
    let azit: Azit // 전달된 아지트 정보
    
    var body: some View {
        VStack {
            azit.image
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(10)
                .padding(.vertical, 20)
            
            Text(azit.teamName)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Button(action: {
                // 아지트 내부 페이지로 이동하는 액션 구현
            }) {
                Text("Enter Azit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AzitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let previewAzit = Azit(image: Image(systemName: "person.3.fill"), teamName: "Team A", teamDescription: "1")
        AzitDetailView(azit: previewAzit)
    }
}
