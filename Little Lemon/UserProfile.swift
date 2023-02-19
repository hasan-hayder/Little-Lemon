//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Hasan Hayder on 2023-02-16.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: kFirstName)
    let lastName = UserDefaults.standard.string(forKey: kSecondName)
    let email = UserDefaults.standard.string(forKey: kEmail)
    
    @Environment(\.presentationMode) var presentation
    //This will automatically reference the presentation environment in SwiftUI which will allow you to reach the navigation logic.
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            List{
                Section(header: Text("First name")){
                    Text(firstName ?? "")
                }
                Section(header: Text("Last name")){
                    Text(lastName ?? "")
                }
                Section(header: Text("Email")){
                    Text(email ?? "")
                }
            }
            
            Button(action: {
                //Open the UserProfile file again, and inside the logout button trailing closure first access the standard property of the UserDefaults and set false value using the login constant as a key that you defined at the top of the Onboarding file. Then on the following line add the following code self.presentation.wrappedValue.dismiss(). When executed, it will automatically tell the NavigationView to go back to the previous screen which is Onboarding simulating logout.
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Text("Logout")
            })
            
            .padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(20)
            .padding(.top, 10)
            Spacer()
            
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
