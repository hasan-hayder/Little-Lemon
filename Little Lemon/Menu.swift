//
//  Menu.swift
//  Little Lemon
//
//  Created by Hasan Hayder on 2023-02-15.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text("Little Lemon")
                .font(.largeTitle)
                .foregroundColor(Color.yellow)
                .multilineTextAlignment(.center)
            Text("Chicago")
                .font(.subheadline)
                .foregroundColor(Color.white)
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                .font(.body)
                .foregroundColor(Color.white)
                .frame(height: 100.0, alignment: .center)
            
            
        }
        .padding(.vertical, 100.0)
        
        .background(Color(hue: 0.237, saturation: 0.365, brightness: 0.478))
       
        
    }
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
