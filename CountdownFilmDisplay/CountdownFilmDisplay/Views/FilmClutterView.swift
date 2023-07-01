//
//  FilmClutterView.swift
//  CountdownFilmDisplay
//
//  Created by 문상우 on 2023/06/29.
//

import SwiftUI

struct FilmClutterView: View {

    @EnvironmentObject var viewModel: FilmClutterViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                FilmClutterContentView()
                    .frame(height: geometry.height)
                HStack {
                    FilmClutterEdgeView(edgeSide: .left)
                        .offset(y: self.viewModel.isAnimating ? 300 : 0)
                    Spacer()
                    FilmClutterEdgeView(edgeSide: .right)
                        .offset(y: self.viewModel.isAnimating ? 300 : 0)
                }
                    .frame(height: geometry.height, alignment: .center)
                    .clipped()
            }
        }
    }

}

private extension GeometryProxy {

    var landscape: Bool {
        size.width > size.height
    }

    var height: CGFloat {
        landscape ? size.height : size.width * 0.8
    }

}
