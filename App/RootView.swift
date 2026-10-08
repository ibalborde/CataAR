import GrapesFeature
import SwiftUI

struct RootView: View {
  let container: AppContainer

  @State private var path: [GrapesRoute] = []

  var body: some View {
    NavigationStack(path: $path) {
      factory.makeRoot(onSelectGrape: { path.append(.detail(grapeId: $0)) })
        .navigationDestination(for: GrapesRoute.self) { route in
          switch route {
          case .list:
            factory.makeRoot(onSelectGrape: { path.append(.detail(grapeId: $0)) })
          case .detail(let grapeId):
            factory.makeDetail(
              grapeId: grapeId,
              onSelectGrape: { path.append(.detail(grapeId: $0)) }
            )
          }
        }
    }
  }

  private var factory: GrapesFeatureFactory {
    // RegionsFeature doesn't exist yet; taps on a regional expression are a
    // no-op until /feature scaffolds it and this closure can push its route.
    container.makeGrapesFeatureFactory(onSelectRegion: { _ in })
  }
}

#Preview {
  RootView(container: AppContainer())
}
