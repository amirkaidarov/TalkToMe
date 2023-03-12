//
//  HomeView.swift
//  TalkToMe
//
//  Created by Амир Кайдаров on 3/11/23.
//

import SwiftUI

struct HomeView: View {
    @State private var search : String  = ""
    @EnvironmentObject var authVM: AuthViewModel
    
    
    private let languages = [Language(title: "French", flag: "France", code: "fr-FR"),
                             Language(title: "Russian", flag: "Russia", code: "ru-RU"),
                             Language(title: "Spanish", flag: "Spain", code: "es-ES")]
    
    let purpleColor = Color(red: 115/255, green: 113/255, blue:252/255)
    let whiteSmoke = Color(red: 245/255, green: 245/255, blue:245/255)

//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading) {
//                    HomeNavBarView()
//
//                    Text("What would you like to practice today?")
//                        .font(.title)
//                        .fontWeight(.bold)
//
//                    SearchBar(search: $search)
//
//                    SectionTitleView(title: "Languages")
//
//
//                    languagesView
//
//                    Spacer()
//            }
//            .padding()
//        }
//    }
    
        var body: some View {
            NavigationView {
                VStack(spacing: -50){
                    VStack(alignment: .leading){
                        Spacer().frame(height: 50)
                        HomeNavBarView()
                        Text("What would you like to practice today?")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)


                        SearchBar(search: $search)


                    }.padding(10).background(RoundedRectangle(cornerRadius: 20).fill(purpleColor).shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10))
                        .edgesIgnoringSafeArea(.top)
                    
                    VStack{
                        SectionTitleView(title: "Languages")

                        languagesView.shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)


                    }.padding()

                }.background(whiteSmoke)

            }
        }

  
    private var languagesView : some View {
        ScrollView {
            ForEach(languages) { language  in
                NavigationLink {
                    ChatView(messagesService: MessagesService(language: language))
                } label: {
                    Group {
                        HStack (spacing : 16){
                            Text(language.title)
                                .font(.system(size: 20, weight: .semibold))
                            Spacer()
                            Image(language.flag)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20)
                                .padding(.horizontal)
                                .shadow(radius: 5)
                        }
                        .padding()
                        
                    }
                    .padding(.leading)
                    .foregroundColor(Color(.label))
                    .background(Color.white)
                    .cornerRadius(18.0)
                    
                }
            }
            .padding(.bottom, 50)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct HomeNavBarView: View {
    @State private var shouldShowLogoutOptions = false
    
    @EnvironmentObject var vm: AuthViewModel
    
    var body: some View {
        HStack (alignment: .center){
            Spacer()
            Button {
                shouldShowLogoutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.white)
            }
        }
        .confirmationDialog(
            Text("Settings"),
            isPresented: $shouldShowLogoutOptions
        ) {
            Button("Exit", role: .destructive) {
                vm.toggle()
            }
            Button("Cancel", role: .cancel) {
                
            }
        } message: {
            Text("What do you want to do?")
        }

    }
}

struct SearchBar: View {
    @Binding var search : String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search for Languages", text: $search)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct SectionTitleView: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("See All")
                .foregroundColor(Color("PrimaryColor"))
                .onTapGesture {
                    
                }
        }
        .padding(.vertical)
    }
}


