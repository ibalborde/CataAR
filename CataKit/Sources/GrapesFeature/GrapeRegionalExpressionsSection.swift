import DesignSystem
import Domain
import SwiftUI

struct GrapeRegionalExpressionsSection: View {
  let regionalExpressions: [Grape.RegionalExpression]
  let onSelectRegion: (String) -> Void

  var body: some View {
    if !regionalExpressions.isEmpty {
      VStack(alignment: .leading, spacing: Spacing.s) {
        Text(String(localized: "grapes.detail.regionalExpressions", bundle: .module))
          .font(.title3.bold())
        ForEach(regionalExpressions, id: \.regionId) { expression in
          Button {
            onSelectRegion(expression.regionId)
          } label: {
            Text(expression.notes.es)
              .font(.callout)
          }
          .buttonStyle(.plain)
        }
      }
    }
  }
}
