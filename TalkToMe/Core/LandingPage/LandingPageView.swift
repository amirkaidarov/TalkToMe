//
//  LandingPageView.swift
//  TalkToMe
//
//  Created by Амир Кайдаров on 3/11/23.
//

import SwiftUI

struct LandingPageView: View {
    
    @EnvironmentObject var vm: AuthViewModel
    
    var body: some View {
        VStack (spacing: 20) {
            Spacer()
            Text("Home")
                .font(.largeTitle)
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

        }
    }
    
    
   

}


struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
