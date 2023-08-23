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
                .foregroundColor(.black)
        }
    }
}
    
struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass") // 돋보기 이미지
                .foregroundColor(Color.gray)
                .padding(.leading, 8)
            
            TextField("Search", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
    }
}

struct MainPage: View {
    
    @State private var searchText = ""
    
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
                        Image("hany")
                            .resizable()
                            .frame(width:40, height:40)
                            .cornerRadius(30)
                        Text("AziTeam").font(.headline)
                            .fontWeight(.black)
                            .bold()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack{
                        SearchBar(text: $searchText)
                            .frame(width: 200)
                        Button(action: {
                            // 버튼이 클릭되었을 때 실행되는 코드를 여기에 작성
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(Color.gray)
                        }
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

