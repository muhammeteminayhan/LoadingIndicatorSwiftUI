//
//  ContentView.swift
//  LoadingIndicatorSwiftUI
//  Hello
//  Created by Muhammet Emin Ayhan on 17.10.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.black.opacity(0.9).edgesIgnoringSafeArea(.all)
            LoadingIndicator()
        }
    }
}

#Preview {
    ContentView()
}

struct LoadingIndicator: View {
    @State private var isAnimating = false
    @State private var colors: [Color] = Array(repeating: .blue, count: 12)
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 4)
                    .fill(Color.clear)
                    .frame(width: 100, height: 100)
                    .overlay(
                        Circle()
                            .stroke(Color.gray.opacity(0.1), lineWidth: 4)
                    )
                ForEach(0..<12) { i in
                    Circle()
                        .fill(colors[1])
                        .frame(width: 10, height: 10)
                        .offset(y: -50)
                        .rotationEffect(.degrees(Double(i) * 30))
                        .opacity(isAnimating ? 1 : 0.2)
                        .animation(
                            Animation.easeInOut(duration: 0.6)
                                .repeatForever(autoreverses: true)
                                .delay(Double(i) * 0.05),
                            value: isAnimating
                        )
                }
            }
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(
                Animation.linear(duration: 1)
                    .repeatForever(autoreverses: false),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
                startColorChange()
            }
            Text("Loading")
                .font(.title2)
                .opacity(isAnimating ? 1 : 0.3)
                .animation(
                    Animation.easeInOut(duration: 0.8)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
                .padding(.top, 20)
                .foregroundColor(.white)
        }
    }
    func startColorChange() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            for i in 0..<colors.count {
                colors[i] = Color(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1)
                )
            }
        }
    }
}
