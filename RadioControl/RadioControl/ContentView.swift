//
//  ContentView.swift
//  RadioControl
//
//  Created by Iliiah on 28.08.24.
//

import SwiftUI

struct ContentView: View {
    @State private var dragOffset: CGSize = .zero
    @State private var position: CGSize = .zero
    
    @State private var aaCurrent: CGSize = .zero
    @State private var aaSaved: CGSize = .zero
    
    @State var isChanging: Int = 0;
    
    @State var currentY: Double = .zero;
    @State var savedY: Double = .zero;
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.red)
                .shadow(radius: 20)
                .frame(width: 100)
                .offset(x: dragOffset.width + position.width, y: dragOffset.height + position.height)
                .gesture(DragGesture()
                    .onChanged({ (value) in
                        self.dragOffset = value.translation
                    })
                        .onChanged({
//                            (value) in aaCurrent.height = value.translation.height
                            
                            (value) in currentY = value.translation.height
                            
                            
                            isChanging = 1;
                        })
                        .onEnded({ (value) in
                            isChanging = 0;
                            
                            self.position.width += value.translation.width
                            
                            self.position.height += value.translation.height
                            
                            self.dragOffset = .zero
                            
                            aaSaved.height = aaCurrent.height + value.translation.height
                            
                            aaCurrent.height = .zero
                            
                            savedY = savedY + currentY;
                            
                            currentY = .zero
                        })
                )
            
            Text("Horizontal Swift: \(dragOffset.width, specifier: "%.2f")°")
                .padding()
            
            Text("Current Y: \(currentY)")
                .padding()
            
            Text("Saved Y: \(savedY)")
                .padding()
            
            Text("Result Y: \(savedY + currentY)")
                .padding()
            
            Text("isChanging1: \(isChanging)")
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
