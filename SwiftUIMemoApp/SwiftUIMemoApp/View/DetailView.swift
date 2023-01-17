import SwiftUI

struct DetailView: View {
    @ObservedObject var memo: Memo
    
    @EnvironmentObject var store: MemoStore
    
    @State private var showComposer = false
    @State private var showDeleteAlert = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(memo.content)
                            .padding()
                        Spacer(minLength: 0)
                    }
                    Text(memo.insertDate, style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("My Memo")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }.foregroundColor(.red)
                    .alert("Delete", isPresented: $showDeleteAlert) {
                        Button(role: .destructive) {
                            store.delete(memo: memo)
                            dismiss()
                        } label: {
                            Text("Delete")
                        }
                        
                    } message: {
                        Text("Do you want to delete this memo?")
                    }
                Button {
                    showComposer = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
                
            }
        }
        .sheet(isPresented: $showComposer) {
            ComposeView(memo: memo)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(memo: Memo(content: "HELLO"))
                .environmentObject(MemoStore())
        }
    }
}
