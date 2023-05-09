import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        WebView()
            .background(Color.init(red: 34 / 255, green: 34 / 255, blue: 34 / 255).ignoresSafeArea(.all))
    }
}

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let url = URL(string: "https://wkwebview.run.goorm.site/")!
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
