//
//  CreateAzitView.swift
//  AziTeam
//
//  Created by mobicom on 2023/08/29.
//

import SwiftUI

struct CreateAzitView_modal: View {
    @Environment(\.presentationMode) var mode
    @State private var isAnimating1 = false
    @State private var isAnimating2 = false
    @State private var isAnimating3 = false
    @State private var isAnimating4 = false
    @State private var isAnimating5 = false
    @State private var buttonTag1 = false
    @State private var buttonTag2 = false
    @State private var showModal = false
    	
    var body: some View {

        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                            .foregroundColor(Color(.systemBlue))
                            .bold()
                        }
                        Spacer()
                    }
                    .padding()
                    
                    Text("당신의 팀을 만드세요.")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                        .opacity(isAnimating1 ? 1.0 : 0.0) // 처음에는 숨겨놓음
                        .onAppear {
                            withAnimation(.easeInOut(duration: 3.0)) {
                                isAnimating1 = true // 등장 애니메이션 시작
                            }
                        }
                        .shadow(color: Color.gray, radius: 1, x: 0, y: 1) // 그림자 효과 추가
                    
                    Spacer()
                        .frame(height: 50)
                    
                    Text("혹은")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                        .opacity(isAnimating2 ? 1.0 : 0.0) // 처음에는 숨겨놓음
                        .onAppear {
                            withAnimation(.easeInOut(duration: 4.0)) {
                                isAnimating2 = true // 등장 애니메이션 시작
                            }
                        }
                        .shadow(color: Color.gray, radius: 1, x: 0, y: 1) // 그림자 효과 추가
                    Spacer()
                        .frame(height: 50)
                    Text("가입하세요.")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                        .opacity(isAnimating3 ? 1.0 : 0.0) // 처음에는 숨겨놓음
                        .onAppear {
                            withAnimation(.easeInOut(duration: 6.0)) {
                                isAnimating3 = true // 등장 애니메이션 시작
                            }
                        }
                        .shadow(color: Color.gray, radius: 1, x: 0, y: 1) // 그림자 효과 추가
                    Spacer()
                        .frame(height: 50)
                    
                    Image(systemName: "person.3.sequence")
                        .font(.system(size: 48))
                        .opacity(isAnimating3 ? 1.0 : 0.0) // 처음에는 숨겨놓음
                        .rotation3DEffect(
                            .degrees(isAnimating4 ? 360 : 0),
                            axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                        .onAppear {
                            withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                                isAnimating4 = true // 애니메이션 시작 시에만 true로 설정
                            }
                        }
                        .shadow(color: Color.gray, radius: 1, x: 0, y: 2) // 그림자 효과 추가
                        .padding(.bottom, 60)
                    
                    NavigationLink(destination: TeamCreationView()) {
                        Text("기존 팀 가입하기")
                            .frame(width: 130)
                            .fixedSize(horizontal: true, vertical: true) // 텍스트 크기 고정
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .opacity(isAnimating5 ? 1 : 0)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 4.0)) {
                                    isAnimating5 = true // 등장 애니메이션 시작
                                }
                            }
                    }
                    .shadow(color: Color.gray, radius: 1, x: 0, y: 2) // 그림자 효과 추가
                    .padding(.bottom, 30)
                    
                    NavigationLink(destination: TeamCreationView()) {
                        Text("새로운 팀 생성하기")
                            .frame(width: 130)
                            .fixedSize(horizontal: true, vertical: true) // 텍스트 크기 고정
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .opacity(isAnimating5 ? 1 : 0)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 4.0)) {
                                    isAnimating5 = true
                                }
                            }
                            .onTapGesture {
                                self.showModal = true
                            }
                    }
                    .shadow(color: Color.gray, radius: 1, x: 0, y: 2)
                    .padding(.bottom, 30)
                    .sheet(isPresented: self.$showModal) {
                        JoinTeamView_alert()
                            .frame(width: 300, height: 200)
                            .cornerRadius(30)
                    }
                        
                }
            }
        }
    }
}

struct CreateAzitView_modal_Previews: PreviewProvider {
    static var previews: some View {
        CreateAzitView_modal()
    }
}
