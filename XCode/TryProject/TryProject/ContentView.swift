//
//  ContentView.swift
//  TryProject
//
//  Created by Iliiah on 24.04.24.
//

import SwiftUI

struct ContentView: View {
//    private let tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return table
//    }
    
    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.black]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack {
                    Image("ILIA")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 250, height: 340)
                        .foregroundStyle(.tint)
                        .imageScale(.small)
                    
                    Text("Tap the button!").foregroundColor(.white).font(.system(size: 46)).padding()
                
                    NavigationLink(destination: SecondView()) {
                        Text("Button").foregroundColor(.blue).font(.system(size: 46, weight: .bold)).frame(width: 200, height: 80).background(Color.white)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
