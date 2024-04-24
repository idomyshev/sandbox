//
//  ContentView.swift
//  Scheduler
//
//  Created by Iliiah on 23.04.24.
//

import SwiftUI

struct ContentView: View {
    var slotsNumberToday = 0;
    
    var body: some View {
        ZStack {
            VStack {
                Image("ILIA")
                    .resizable()
                    .cornerRadius(20)
                    .aspectRatio(contentMode: .fit)
                    .padding(50)
                
                Button(action: {
                    deal()
                }, label: {
                    Text("HI! (" + String(slotsNumberToday) + ")")
                })
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.semibold)
                    Spacer()
            }
        }
    }
    
    func deal() {
        print(slotsNumberToday)
    }
}



#Preview {
    ContentView()
}
