//
//  ActivityHistoryView.swift
//  EcoStep
//
//  Created by admin on 2024/11/19.
//

import SwiftUI

struct ActivityHistoryView: View {
    @State private var activities: [Activity] = []
    //private let manager = ActivityManager()

    var body: some View {
        List(activities, id: \.date) { activity in
            VStack(alignment: .leading) {
                Text(activity.type)
                Text("Distance: \(activity.distance, specifier: "%.2f") meters")
                Text("Date: \(activity.date, style: .date)")
            }
        }
//        .onAppear {
//            self.activities = manager.fetchActivities()
//        }
    }
}

#Preview {
    ActivityHistoryView()
}
