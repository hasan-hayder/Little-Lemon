//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Hasan Hayder on 2023-02-15.
//

import SwiftUI


let kFirstName = "first name key"
let kSecondName = "second name key"
let kEmail = "email key"
//Open the Onboarding file, and add another constant at the top of the file near the other 3 registration constants to store the login status, for example:
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                ZStack{
                    Color(red: 73/255, green: 99/255, blue: 90/255)
                    VStack(alignment: .leading){
                        Text("Little Lemon")
                            .font(.largeTitle)
                            .foregroundColor(Color(red: 244/255, green: 206/255, blue: 20/255))
                        Text("New York")
                            .font(.subheadline)
                            .foregroundColor(Color.white)
                        Spacer()
                        HStack{
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                .font(.body)
                                .foregroundColor(Color.white)
                            
                            Image("Hero image")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .cornerRadius(15)
                                                            .frame(width: 160, height: 140)
                            
                            
                        }
                        
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .padding([.leading, .trailing])
                }
                .frame(height: 300)
                NavigationLink(destination: Home(), isActive: $isLoggedIn){
                    EmptyView()
                }
                Group{
                    TextField( "First Name",
                               text: $firstName
                    ) .textFieldStyle(.roundedBorder)
                    TextField( "Last Name",
                               text: $lastName
                    ) .textFieldStyle(.roundedBorder)
                    TextField("Email",
                              text: $email
                    ) .textFieldStyle(.roundedBorder)
                }
                    .padding([.leading, .trailing])
                Button(action: {
                    if firstName.isEmpty == false &&
                        lastName.isEmpty == false &&
                        email.isEmpty == false {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kSecondName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        isLoggedIn = true
                        //Below, inside the register button closure, inside the if statement add another call to the UserDefaults and set true for the constant key defined in the previous step. This will store a flag that user is already logged in and should not see the Onboarding screen again the next time app launches.
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                    }
                }, label: {
                    Text("Register")
                }
                )
                .padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
                .padding([.top, .leading], 16.0)
                //At the end of the VStack, the first view inside the NavigationView call an onAppear method with a trailing closure. Inside the closure, add an if check, and access the standard property of the UserDefaults, and call a bool method with a logged in key that you defined at the top of the file in the previous step. This will check if the key is set to true.
                .onAppear() {
                    if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                        isLoggedIn = true
                    }
                }
                
            }
        }

        
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
