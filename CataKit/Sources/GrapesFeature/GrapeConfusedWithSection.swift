import DesignSystem
import Domain
import SwiftUI

struct GrapeConfusedWithSection: View {
  let confusedWith: [Grape.ConfusedWithReference]
  let grapeNames: [String: String]
  let onSelectGrape: (String) -> Void

  var body: some View {
    if !confusedWith.isEmpty {
      VStack(alignment: .leading, spacing: Spacing.s) {
        Text(String(localized: "grapes.detail.confusedWith", bundle: .module))
          .font(.title3.bold())
        ForEach(confusedWith, id: \.grapeId) { entry in
          Button {
            onSelectGrape(entry.grapeId)
          } label: {
            VStack(alignment: .leading, spacing: Spacing.xs) {
              Text(grapeNames[entry.grapeId] ?? entry.grapeId)
                .font(.headline)
              Text(entry.howToTell.es)
                .font(.callout)
                .foregroundStyle(.secondary)
            }
          }
          .buttonStyle(.plain)
        }
      }
    }
  }
}
