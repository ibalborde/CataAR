import DesignSystem
import Domain
import SwiftUI

struct GrapeTastingSection: View {
  let palate: LocalizedText
  let blindTastingKeys: [LocalizedText]

  var body: some View {
    VStack(alignment: .leading, spacing: Spacing.s) {
      Text(String(localized: "grapes.detail.palate", bundle: .module))
        .font(.title3.bold())
      Text(palate.es)
      if !blindTastingKeys.isEmpty {
        Text(String(localized: "grapes.detail.blindTastingKeys", bundle: .module))
          .font(.headline)
          .padding(.top, Spacing.xs)
        ForEach(Array(blindTastingKeys.enumerated()), id: \.offset) { _, key in
          Label(key.es, systemImage: "checkmark.circle")
            .font(.callout)
        }
      }
    }
  }
}
