import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            SlideToOpen(thumbnailColor: Color.red,
                          didReachEndAction: { view in
                print("reach end!!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.resetState()
                }
            })
            .frame(width: 320, height: 56)
            .background(Color.yellow)
            .cornerRadius(28)
            
            SlideToOpen(thumbnailTopBottomPadding: 4,
                          thumbnailLeadingTrailingPadding: 4,
                          text: "Slide to unlock",
                          textColor: .white,
                          thumbnailColor: Color.white,
                          sliderBackgroundColor: Color.black,
                          didReachEndAction: { view in
                print("reach end!!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.resetState()
                }
            })
            .frame(width: 320, height: 56)
            .background(Color.yellow)
            .cornerRadius(28)
            
            SlideToOpen(thumbnailLeadingTrailingPadding: 10,
                          thumbnailColor:Color.blue,
                          thumbnailBackgroundColor: Color.blue,
                          didReachEndAction: { view in
                print("reach end!!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.resetState()
                }
            })
            .frame(width: 320, height: 56)
            .background(Color.yellow)
            .cornerRadius(28)
            
            SlideToOpen(sliderTopBottomPadding: 4, didReachEndAction: { view in
                print("reach end!!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.resetState()
                }
            })
            .frame(width: 320, height: 56)
            .background(Color.yellow)
            .cornerRadius(28)
            
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
