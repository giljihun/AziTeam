//
//  TeamCreationView.swift
//  AziTeam
//
//  Created by mobicom on 2023/09/01.
//

import SwiftUI

struct TeamCreationView: View {
    @State private var teamName: String = ""
    @State private var teamDescription: String = ""
    @State private var openPhoto = false
    @State private var image = UIImage()
    @State private var selected = false
    
    let defaultImage: Image = Image(systemName: "person")
    var isInputValid: Bool {
        !teamName.isEmpty && !teamDescription.isEmpty
    }
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .center){
                Text("아지트 등록하기")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.bottom, 30)
                
                Text("Azit Name")
                    .font(.footnote)
                
                TextField("", text: $teamName)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .shadow(color: .gray, radius: 3)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .frame(width: 300)
                
                Text("Azit Description")
                    .font(.footnote)
                TextField("", text: $teamDescription)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .shadow(color: .gray, radius: 3)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .frame(width: 300)
                
                Text("Azit Image")
                    .font(.footnote)
                    .padding(.bottom, 5)
                
                GeometryReader { geometry in
                    VStack {
                        if self.image == UIImage() {
                            HStack {
                                Spacer()
                                defaultImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.3)
                                    .shadow(color: .gray, radius: 5)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        } else {
                            HStack {
                                Spacer()
                                Image(uiImage: self.image)
                                    .resizable()
                                    .cornerRadius(radius: 7)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.3,
                                           height: geometry.size.height > 150 ? 150 : nil)
                                
                                    .shadow(color: .gray, radius: 10)
                                Spacer()
                            }
                        }
                        HStack {
                            Button(action: {
                                self.openPhoto = true
                            }) {
                                Text("이미지 등록")
                                    .font(.footnote)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .shadow(color: .gray, radius: 3, x: 0, y: 2)
                            }
                            .sheet(isPresented: $openPhoto) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                            }
                            if self.image != UIImage() {
                                Button(action: {
                                    self.image = UIImage() // 이미지 상태를 초기화하여 이미지를 제거
                                }) {
                                    Text("이미지 제거")
                                        .font(.footnote)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .shadow(color: .gray, radius: 3, x: 0, y: 2)
                                        .padding(.leading, 20)
                                }
                            }
                        }
                        
                        Button(action: {
                            
                        }){
                            NavigationLink(destination: LocationInputView()) {
                                Image(systemName: "arrow.right.square")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding(.top, 25)
                                    .foregroundColor(isInputValid ? Color.blue : Color.gray)
                            }
                            .disabled(!isInputValid)
                        }
                    }
                }
                Spacer()
                Spacer()
            }
        }
    }
}

struct TeamCreationView_Previews: PreviewProvider {
    static var previews: some View {
        TeamCreationView()
    }
}
