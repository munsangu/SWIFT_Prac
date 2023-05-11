import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Let's go SwiftUI!")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.blue)
            HStack {
                Text("Come on!")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(.brown)
                Spacer()
                Text("Get Out!")
                    .font(.subheadline)
                    .foregroundColor(.cyan)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
