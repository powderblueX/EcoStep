//
//  MyTreeView.swift
//  EcoStep
//
//  Created by admin on 2024/11/19.
//

import SwiftUI

struct MyTreeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("这里是我的树页面")
                    .font(.title)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("我的树")
        }
    }
}

#Preview {
    MyTreeView()
}
