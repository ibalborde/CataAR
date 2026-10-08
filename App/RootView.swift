import SwiftUI

struct RootView: View {
  let container: AppContainer

  var body: some View {
    NavigationStack {
      Text("CataAR")
        .navigationTitle("CataAR")
    }
  }
}

#Preview {
  RootView(container: AppContainer())
}
