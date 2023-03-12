//
//  TitleRow.swift
//  TalkToMe
//
//  Created by Амир Кайдаров on 3/11/23.
//

import SwiftUI


//struct TitleRow: View {
//    let language : Language
//    let purpleColor = Color(red: 115/255, green: 113/255, blue:252/255)
//
//    var body: some View {
//        VStack {
//
//            Image(language.flag)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 50, height: 50)
//                .cornerRadius(50)
//
//            Text(language.title)
//                .font(.headline).bold().foregroundColor(Color.white)
//
//
//            .padding()
//            .background(purpleColor)
//            .navigationBarBackButtonHidden(true)
//        }
//    }
//}
struct TitleRow: View {
    let language : Language
    let purpleColor = Color(red: 115/255, green: 113/255, blue:252/255)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            HStack{
                Button(action: {
                     self.presentationMode.wrappedValue.dismiss()
                 }, label: {
                     Image(systemName: "arrow.left")
                         .foregroundColor(purpleColor)
                     
                 })
                Spacer()

            }.padding(.horizontal)
                .padding(.top)
            HStack(spacing:10){
                Image(language.flag)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)

                    

                Text(language.title)
                    .font(.body).bold().foregroundColor(Color.black)
            }.padding()
        
        }.navigationBarBackButtonHidden(true).shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
    }
}

        


struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow(language: Language(title: "French", flag: "", code: ""))
    }
}
