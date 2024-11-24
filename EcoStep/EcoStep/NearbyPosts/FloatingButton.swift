//
//  FloatingButton.swift
//  EcoStep
//
//  Created by admin on 2024/11/20.
//

import SwiftUI

struct FloatingButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
                .shadow(radius: 5)
        }
        .padding()
    }
}



