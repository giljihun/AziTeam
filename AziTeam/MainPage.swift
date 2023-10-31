//
//  ContentView.swift
//  AziTeam
//
//  Created by mobicom on 2023/08/23.

import SwiftUI

struct Azit: Identifiable {
    let id = UUID()
    let image: Image
    let teamName: String
    let teamDescription : String
}

struct MainPage: View {
    @State private var searchText = ""
    @State private var isSearchActive = false
    @State private var showModal = false
    
    @State private var azitData: [Azit] = [
        Azit(image: Image(systemName: "person.3.fill"), teamName: "Mobicom", teamDescription: "Mobile & Network Computing Lab"),
        Azit(image: Image(systemName: "person.3.fill"), teamName: "오명진팀", teamDescription: "오명진의 특수부대"),
        Azit(image: Image(systemName: "person.3.fill"), teamName: "Telkom Univ", teamDescription: "'23년 인도네시아 글로벌 캡스톤 팀"),
    ]
    
    private var filteredAzitData: [Azit] {
        if searchText.isEmpty {
            return azitData
        } else {
            return azitData.filter { azit in
                azit.teamName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(filteredAzitData) { azit in
                        NavigationLink(destination: AzitDetailView(azit: azit)) {
                            AzitCardView(azit: azit)
                                .padding(.top)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "number")
                            .fontWeight(.black)
                            .bold()
                            .cornerRadius(50)
                        Text("AziTeam ").font(.headline)
                            .fontWeight(.black)
                            .bold()
                            .kerning(-2)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    SearchBar(text: $searchText, isSearchActive: $isSearchActive)
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.showModal = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.gray)
                    }
                    .sheet(isPresented: self.$showModal) {
                        CreateAzitView_modal()
                            .cornerRadius(30)
                    }
                }
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearchActive: Bool
    
    var body: some View {
        HStack {
            // 검색창 활성화
            if isSearchActive {
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0.01)) {
                        self.isSearchActive.toggle()
                        self.text = ""
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.gray)
                        .padding(.leading, 8)
                }
                TextField("Search", text: $text)
                    .padding(8)
                //                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .frame(width: isSearchActive ? 150 : 0)
                    .overlay(
                        HStack {
                            if isSearchActive {
                                Spacer()
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0.01)) {
                                        self.text = ""
                                    }
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 5)
                                }
                            }
                        })
                
            } else {
                // 검색창이 비활성화된 경우
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0.01)) {
                        self.isSearchActive.toggle()
                        self.text = ""
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.gray)
                        .padding(.leading, 8)
                }
            }
        }
    }
}


func AzitFrameSet() -> CGFloat {
    let deviceWidth = UIScreen.main.bounds.width
    
    // 디바이스 크기에 따라 적절한 폰트 크기 반환
    if deviceWidth < 375 { // iPhone 6/7/8, SE (2nd generation)
        return 250
    } else if deviceWidth < 430 { // iPhone 6/7/8 Plus, XR, 11, iPhone 12 Pro Max, 13 Pro Max, 14 Plus
        return 350
    } else if deviceWidth < 500 { // more than upS..
        return 400
    } else { // pad
        return 500
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

