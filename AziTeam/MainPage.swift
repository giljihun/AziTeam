//
//  ContentView.swift
//  AziTeam
//
//  Created by mobicom on 2023/08/23.

import SwiftUI

struct Azit: Identifiable {
    let id = UUID()
    let imageName: String
    let teamName: String
}


struct AzitCardView: View {
    let azit: Azit
        
    var body: some View {
        VStack {
            Image(azit.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: AzitFrameSet(), height: 200)
                .cornerRadius(10)
                .clipped()
            Text(azit.teamName)
                .font(.headline)
                .foregroundColor(.primary)
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

struct MainPage: View {
    
    @State private var searchText = ""
    @State private var isSearchActive = false
    
    let azitData: [Azit] = [
        Azit(imageName: "testimage1", teamName: "Mobicom"),
        Azit(imageName: "testimage2", teamName: "국민의 길"),
        Azit(imageName: "아니개귀엽네하니", teamName: "Team C"),
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

