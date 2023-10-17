//
//  AzitCardView.swift
//  AziTeam
//
//  Created by mobicom on 2023/10/17.
//
import SwiftUI

struct AzitCardView: View {
    let azit: Azit
    
    var body: some View {
        VStack {
            azit.image
                .resizable()
                .frame(height: 150) // 이미지 높이 조절
                .cornerRadius(10)
                .padding(.horizontal, 10) // 이미지의 좌우 여백 설정
                .padding(.vertical, 10)
            
            Text(azit.teamName)
                .font(.title)
                .fontWeight(.bold)
                .frame(width: AzitCardView_FrameSet())
            
            Text(azit.teamDescription)
                .font(.body)
                .foregroundColor(.secondary) // 팀 설명 텍스트 스타일 추가
                .padding(.bottom, 6)
                .frame(width: AzitCardView_FrameSet())
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5) // 그림자 추가
        .padding(10) // 카드 간 여백 설정
        .frame(width: AzitCardView_FrameSet())
    }
}

func AzitCardView_FrameSet() -> CGFloat {
    let deviceWidth = UIScreen.main.bounds.width
    
    // 디바이스 크기에 따라 적절한 폰트 크기 반환
    // * se3 -> 375
    if deviceWidth <= 375 { // iPhone 6/7/8, SE (3nd generation)
        return 350
    } else if deviceWidth < 500 { // iPhone 6/7/8 Plus, XR, 11, iPhone 12 Pro Max, 13 Pro Max, 14 Plus
        return 450
    } else { // pad
        return 700
    }
}
