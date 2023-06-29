//
//  ContentView.swift
//  CardAnimation
//
//  Created by 문상우 on 2023/06/29.
//

import SwiftUI

struct ContentView: View {
    
    @State var backViewSize: CGFloat = 80
    @State var size: CGSize = .zero
    @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                VStack {
                    Color.blue
                }
                .frame(width: reader.size.width - 160, height: 300)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(y: -30)
                
                VStack {
                    Color.orange
                }
                .frame(width: reader.size.width - self.backViewSize, height: 300)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(y: -15)
                
                VStack {
                    Color.red
                }
                .frame(width: reader.size.width - 50, height: 300)
                .cornerRadius(20)
                .shadow(radius: 20)
                .gesture(DragGesture().onChanged({ value in
                    self.size = value.translation
                    self.backViewSize = 50
                })
                    .onEnded({ value in
                        self.size = .zero
                        self.backViewSize = 80
                    })
                )
                .offset(self.size)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .position(x: reader.size.width / 2, y: reader.size.height / 2)
        }
        .animation(.interpolatingSpring(stiffness: 100, damping: 10), value: isAnimating)
        .onTapGesture {
            withAnimation {
                isAnimating.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
