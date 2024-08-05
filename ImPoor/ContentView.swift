//
//  ContentView.swift
//  ImPoor
//
//  Created by Filip Pokłosiewicz on 02/08/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ImPoorViewModel()
    @State private var animateGradient = false
    @State private var useGradient = false

    
    var body: some View {
        
        VStack {
            Image("neutral-face")
                .resizable()
                .frame(width: 30, height: 30)
            Spacer()
            Text(vm.todaysText)
                .padding()
                .multilineTextAlignment(.leading)
                .font(.system(size: 50))
                .fontWeight(.heavy)
                .foregroundStyle(
                    useGradient ? AnyShapeStyle(LinearGradient(colors: [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                : AnyShapeStyle(Color.primary)
                                )
                .onTapGesture {
                    withAnimation(.snappy()) {
                        useGradient.toggle()
                    }
                }
            
            
            Spacer()
            
            Link("I'm poor too", destination: URL(string: "https://www.kopiujwklej.net")!)
                .padding(.bottom, 10)
                .foregroundColor(.gray.opacity(0.5))
            
            
        }
        .padding()
    }
    
}

#Preview {
    ContentView()
}
