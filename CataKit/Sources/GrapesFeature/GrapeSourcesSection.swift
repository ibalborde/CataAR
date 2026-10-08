import DesignSystem
import Domain
import SwiftUI

struct GrapeSourcesSection: View {
  let sources: [Source]

  var body: some View {
    if !sources.isEmpty {
      VStack(alignment: .leading, spacing: Spacing.s) {
        Text(String(localized: "grapes.detail.sources", bundle: .module))
          .font(.title3.bold())
        ForEach(sources, id: \.url) { source in
          Link(source.title, destination: source.url)
            .font(.caption)
        }
      }
    }
  }
}
