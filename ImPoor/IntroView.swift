//
//  IntroView.swift
//  ImPoor
//
//  Created by Filip Pokłosiewicz on 02/08/2024.
//

import SwiftUI

struct IntroView: View {
    
    @State private var showR = false
    @State private var showDot = false
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        
        if isActive {
            ContentView()
        } else {
            
            VStack {
                        VStack {
                            Image("neutral-face")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            HStack(spacing: 0) {
                                
                                
                                Text("I'm poor.")
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 50))
                                    .fontWeight(.heavy)
                                
                //                Text("r")
                //                    .multilineTextAlignment(.leading)
                //                    .font(.system(size: 30))
                //                    .fontWeight(.heavy)
                //                    .opacity(showR ? 1 : 0)
                //                    .animation(.easeInOut(duration: 1).delay(2), value: showR)
                //
                //                Text(".")
                //                                .multilineTextAlignment(.leading)
                //                                .font(.system(size: 30))
                //                                .fontWeight(.heavy)
                //                                .opacity(showDot ? 1 : 0)
                //                                .animation(.easeInOut(duration: 1).delay(3), value: showDot)
                            }
                            
                        }
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.2)) {
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                    }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.spring) {
                                self.isActive = true
                            }
                        }
                    }
        }
        
    }
}

#Preview {
    IntroView()
}
