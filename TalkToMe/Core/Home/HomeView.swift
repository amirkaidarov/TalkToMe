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
    
    private let languages = [Language(title: "French", flag: "France"),
                             Language(title: "Russian", flag: "Russia"),
                             Language(title: "Spanish", flag: "Spain")]
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                    HomeNavBarView()
                    
                    Text("What would you like to practice today?")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    SearchBar(search: $search)
                    
                    SectionTitleView(title: "Languages")
                    
                    
                    languagesView
                    
                    Spacer()
                }
            .padding()
        }
    }
    
    private var languagesView : some View {
        ScrollView {
            ForEach(languages) { language  in
                NavigationLink {
                    ChatView(language: language.title)
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
                    .background(Color.gray.opacity(0.2))
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
                    .foregroundColor(Color(.label))
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
        .background(Color.gray.opacity(0.1))
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


