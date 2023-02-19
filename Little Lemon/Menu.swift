//
//  Menu.swift
//  Little Lemon
//
//  Created by Hasan Hayder on 2023-02-15.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext)private var viewContext
    @State var searchText = ""
    var body: some View {
        NavigationView{
          
                VStack{
                    ZStack{
                        Color(red: 73/255, green: 94/255, blue: 87/255)
                        VStack(alignment: .leading){
                            Text("Little Lemon")
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 244/255, green: 206/255, blue: 20/255))
                            Text("Chicago")
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
                            Spacer()

                            
                            
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .padding([.leading, .trailing])
                        
                    }
                    VStack{
                        Text("ORDER FOR DELIVERY!")
                            .font(.custom("Karla", size:20))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        HStack{
                            Button{
                                
                            } label:{
                                Text("Starters")
                                    .foregroundColor(.gray)
                            }
                            .buttonStyle(.bordered)
                            Button{
                                
                            } label:{
                                Text("Mains")
                                    .foregroundColor(.gray)
                            }
                            .buttonStyle(.bordered)
                            Button{
                                
                            } label:{
                                Text("Desserts")
                                    .foregroundColor(.gray)
                            }
                            .buttonStyle(.bordered)
                            Button{
                                
                            } label:{
                                Text("Drinks")
                                    .foregroundColor(.gray)
                            }
                            .buttonStyle(.bordered)
                        }
                        
                    }
                    HStack {
                        TextField("Search menu", text: $searchText)
                    }
                            .background(.white.opacity(0.2))
                            .foregroundColor(.white)
                        .padding()
                    
                    
                    FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) {(dishes: [Dish]) in
                        List{
                            ForEach(dishes, id:\.self.title){ dish in
                                Text(dish.title!)
                                HStack{
                                    VStack{
                                        let price = "$\(dish.price!)"

                                        Text("")
                                        Text(price)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    
                                    let url = URL(string: dish.image!)
                                    AsyncImage(url: url,  transaction: Transaction(animation: .easeIn(duration: 0.5))){  phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        case .failure:
                                            switch dish.title{
                                            case "Greek Salad":
                                                Image("Greek salad")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                
                                            case "Lemon Desert":
                                                Image("Lemon dessert")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                
                                            case "Bruschetta":
                                                Image("Bruschetta")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                
                                            case "Pasta":
                                                Image("Pasta")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                
                                            case "Grilled Fish":
                                                Image("Grilled fish")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                
                                            default:
                                                HStack{
                                                    Text("Unknown Error")
                                                    Image(systemName: "xmark.octagon")
                                                }.foregroundColor(.red)
                                            }
                                        default:
                                            ZStack{
                                                
                                                Color.gray
                                                Text("Loading...")
                                                    .foregroundColor(.blue)
                                            }
                                        }
                                        
                                    }
                                    .frame(width: 100, height: 100)
                                }
                            }
                        }
                        
                    }
                    
                }
                .onAppear{
                    getMenuData()
                }
                .padding(.top)
                .toolbar{
                    ToolbarItemGroup(placement: .navigation){
                        
                        HStack{
                            Image("Logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                            Spacer()
                            Image("Profile")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                        }
                    }
                }
            }

       
        
    }
    func getMenuData(){
        let address = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: address)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest){data, response, error in
            if let data {
               //Inside the if block, start by declaring a new constant and initialize it with a new JSONDecoder instance.
                let fullMenu = try? JSONDecoder().decode(MenuList.self, from: data)
                if let fullMenu {
                    for item in fullMenu.menu {
            if !isAlreadyInDatabase(title: item.title, context: viewContext){
                            
                            var dish = Dish(context: viewContext)
                            dish.title = item.title
                            dish.image = item.image
                            dish.price = item.price
                        }
                    }
                    try? viewContext.save()
                   
                }
            }
        }
        task.resume()
    }
    /*Inside the array literal, initialize an NSSortDescriptor. Use "title" for the key argument, true for the ascending argument and #selector(NSString.localizedStandardCompare) for the selector argument.
    The function now returns an array with one sort descriptor that will sort the Dish data by title in ascending order.*/
    func buildSortDescriptors()-> [NSSortDescriptor] {
        
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
    }
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        }else{
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    func isAlreadyInDatabase(title: String, context: NSManagedObjectContext)->Bool {
        let request: NSFetchRequest<Dish> = Dish.fetchRequest()
     
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", title)
        do{
            let numberOfRecords = try context.count(for: request)
          
            if numberOfRecords == 0 {
                return false
            }else{
                return true
            }
        }catch{
            return true
        }
    }
    func getImageAlternative(urlString: String) async-> UIImage {
        let url = URL(string: urlString)
        do {
            let (data, _) = try await URLSession.shared.data(from: url!)
            let image = UIImage(data: data)!
            return image
        }catch{
            return UIImage(systemName: "xmark.octagon")!
        }
       
    }
     
       
}


struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
