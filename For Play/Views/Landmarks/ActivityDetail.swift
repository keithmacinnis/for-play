//
//  ActivityDetail.swift
//  For Play
//
//  Created by Keith MacInnis on 2021-04-21.
//

import SwiftUI

struct ActivityDetail: View {
    let activity: Activity
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetail(activity: Activity( id: "1", title: "String"))
    }
}
