//
//  SecondView.swift
//  TryProject
//
//  Created by Iliiah on 24.04.24.
//

import SwiftUI

struct Food: Identifiable, Decodable {
    var id: Int
    var uid: String
    var dish: String
    var description: String
    var ingredient: String
    var measurement: String
}




struct SecondView: View {
    @State private  var food: Food?
    
    
    var body: some View {
        
//        @ObservedObject dish = "";
        var dish = "1";
        
    
        
        
//        .task {
//
//        }
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.black]), startPoint: .leading, endPoint: .trailing/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all)
            
         
            
            VStack {   
                VStack {
                    let val = food?.dish ?? "";
                    Text(val)
                }.font(.system(size: 46, weight: .bold))
                    .padding().task {
                    
                    do {
                        food = try await getRandomFood()
                        print("---FOOD---")
                        print(food?.dish ?? "")
                        print("---FOOD---")
                    } catch {
                        print("Error", error)
                    }
                }
                
                
                Spacer()
                Text("Hurraa! I'm on second view!").foregroundColor(.white).font(.system(size: 46)).padding()
                
                Spacer()
                
                Button(action: {
                 print("HALLO!")
                    
//                    Task {
//                        print("Appear2")
//                        do {
//                            food = try await getRandomFood()
//                        } catch {
//                            print("Error", error)
//                        }
//                        
//                        
//                        
//                    }
                   
//                    do {
//                            try
//                    } catch {
//                            print("Error", error)
//                    }
                }, label: {
                    Text("run GET")
                }).foregroundColor(.blue).font(.system(size: 46, weight: .bold)).frame(width: 200, height: 80).background(Color.white)
                
                Spacer()
                
                Text("Dish is: " + dish).font(.system(size: 46, weight: .bold))
                Spacer()
        
            }
        }
    }
        
    func getRandomFood()   async throws -> Food  {
        guard let url = URL(string: "https://random-data-api.com/api/food/random_food") else { fatalError("Missing URL") }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let decodedFood = try JSONDecoder().decode(Food.self, from: data)
        print("Async decodedFood", decodedFood)
        return decodedFood;
    }
    

}

#Preview {
    SecondView()
}
