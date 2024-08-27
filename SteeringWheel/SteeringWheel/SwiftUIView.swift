//
//  SwiftUIView.swift
//  SteeringWheel
//
//  Created by Iliiah on 27.08.24.
//

import SwiftUI

struct RotationGestureExample: View {
    @State private var currentRotation = Angle.zero
    @GestureState private var twistAngle = Angle.zero
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.red)
                .shadow(radius: 20)
                .frame(width: 300, height: 300)
                .rotationEffect(currentRotation + twistAngle)
                .gesture(RotationGesture().updating($twistAngle, body: {(value, state, _) in state = value}).onChanged{self.currentRotation += $0})
            
 
            
            Text("Twist Angle: \(twistAngle.degrees, specifier: "%.2f")°")
                .padding()
        }
    }
}

struct RotationGestureExample_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureExample()
    }
}
