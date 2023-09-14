//
//  TeamCreationView.swift
//  AziTeam
//
//  Created by mobicom on 2023/09/01.
//

import SwiftUI

struct TeamCreationView: View {
    @State private var teamName = ""
    @State private var teamDescription = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Text("  팀 정보 입력")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding(.bottom, 30)
                
            Text("     Team Name")
                .font(.footnote)
    
            TextField("", text: $teamName)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .shadow(color: .blue, radius: 3)
                .padding(.horizontal)
                .padding(.bottom, 10)
                .frame(width: 250)
            
            Text("     Team Description")
                .font(.footnote)
            TextEditor(text: $teamDescription)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.bottom, 20)
                .shadow(color: .blue, radius: 3)
                .frame(height: 200)
            
            Spacer()
        }
    }
}

struct TeamCreationView_Previews: PreviewProvider {
    static var previews: some View {
        TeamCreationView()
    }
}
