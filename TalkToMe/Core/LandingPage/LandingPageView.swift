//
//  LandingPageView.swift
//  TalkToMe
//
//  Created by Амир Кайдаров on 3/11/23.
//

import SwiftUI

struct LandingPageView: View {
    
    @EnvironmentObject var vm: AuthViewModel
    let purpleColor = Color(red: 115/255, green: 113/255, blue:252/255)
    
    var body: some View {
        VStack (spacing: 20) {
            Spacer()
            Text("TALK2ME")
                .font(.largeTitle)
                .foregroundColor(purpleColor).bold()
            Image("home-screen-image")
                .resizable()
                .scaledToFit()
                .padding()
            Text("Learn new languages with me!")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Button {
                vm.toggle()
            } label: {
                Text("Start")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(purpleColor)
        }
    }
    
    
   

}


struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
