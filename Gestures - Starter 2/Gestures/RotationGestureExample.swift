//
//  RotationGestureExample.swift
//  Gestures
//
//  Created by Stewart Lynch on 2020-06-16.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct RotationGestureExample: View {
    @State private var currentRotation = Angle.zero
    @GestureState private var twistAngle = Angle.zero
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.red)
                .shadow(radius: 20)
                .frame(width: 200, height: 200)
                .rotationEffect(currentRotation + twistAngle)
                .gesture(RotationGesture().updating($twistAngle, body: {(value, state, _) in state = value}).onChanged{self.currentRotation += $0})
            
            Text("Current Angle: \(currentRotation.degrees, specifier: "%.2f")°")
                .padding()
        }
    }
}

struct RotationGestureExample_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureExample()
    }
}
