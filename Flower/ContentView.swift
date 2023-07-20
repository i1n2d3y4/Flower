//
//  ContentView.swift
//  Flower
//
//  Created by Vikas Bhandari on 20/7/2023.
//

import SwiftUI

struct Flower: Shape {
    // how much to move this petal away from the center
    var petalOffset: Double = -20
    
    //How wide each petal should be
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        //count from 0 to pi * 2 (full circle, because 1pi = 1/2 circle, 2*pi = full circle), moving up pi / 8 each time. Essentially 8 petals in each 1/2 of the flower
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            //rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)
            //move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            //create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            //apply our rotation / position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)
            //add it to our main path
            path.addPath(rotatedPetal)
        }
        return path
    }
}

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(.purple, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
        .frame(width: .infinity, height: 500)
        .padding()
    }
}

#Preview {
    ContentView()
}
