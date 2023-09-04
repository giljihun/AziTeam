//
//  JoinTeamView_modal.swift
//  AziTeam
//
//  Created by mobicom on 2023/09/04.
//

import SwiftUI

struct JoinTeamView_alert: View {
    @State private var teamCode = ""
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            Button(action: {
                isPresented = true
            }) {
                Text("커스텀 Alert 열기")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}


