//
//  ContentView.swift
//  WatchLandmarks Watch App
//
//  Created by 문상우 on 2023/05/17.
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
