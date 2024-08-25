//
//  ContentView.swift
//  GreetingIOS
//
//  Created by M Alfin Syahruddin on 25/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text(getMessage())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
