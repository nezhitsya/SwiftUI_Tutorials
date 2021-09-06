//
//  ContentView.swift
//  WatchLandmarks Extension
//
//  Created by 이다영 on 2021/09/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
