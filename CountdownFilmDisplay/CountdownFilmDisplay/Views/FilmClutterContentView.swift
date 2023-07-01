//
//  FilmClutterContentView.swift
//  CountdownFilmDisplay
//
//  Created by 문상우 on 2023/06/29.
//

import SwiftUI

struct FilmClutterContentView: View {

    @EnvironmentObject var viewModel: FilmClutterViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                FilmClutterProgressView()
                SightShape()
                    .stroke(lineWidth: 3)
                    .fill(Color.sight)
                Text(String(self.viewModel.countdownNumber))
                    .foregroundColor(Color.fontColor)
                    .fontWeight(.medium)
                    .font(.system(size: 160))
            }.background(RadialGradient(
                gradient: self.gradient,
                center: .center,
                startRadius: 0,
                endRadius: max(geometry.size.height * 0.75, geometry.size.width * 0.75))
            )
                .padding([.top, .bottom], 2.5)
                .background(Color.filmEdges)
        }
    }


    private var gradient: Gradient {
        Gradient(stops: colorStops)
    }

    private var colorStops: [Gradient.Stop] {
        [
            .init(color: .sight, location: 0),
            .init(color: .black, location: 1)
        ]
    }

}
