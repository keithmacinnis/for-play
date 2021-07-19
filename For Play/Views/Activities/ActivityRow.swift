//
//  ActivityRow.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import SwiftUI

struct ActivityRow: View {
    let currentActivity: Activity
    var body: some View {
        HStack {
            Image(systemName: "figure.walk.diamond.fill")
                .resizable()
                .frame(width: 50, height: 50)
            Text(currentActivity.title)
            Spacer()
        }
    }
}
