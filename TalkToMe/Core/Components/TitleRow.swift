//
//  TitleRow.swift
//  TalkToMe
//
//  Created by Амир Кайдаров on 3/11/23.
//

import SwiftUI


struct TitleRow: View {
    var name = "French"
    
    var body: some View {
        HStack(spacing: 20) {
            Image("France")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .cornerRadius(50)
            
                Text(name)
                    .font(.title).bold()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow()
            .background(Color("Peach"))
    }
}
