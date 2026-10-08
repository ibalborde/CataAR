import DesignSystem
import Domain
import SwiftUI

struct GrapeAromasSection: View {
  let aromas: [Grape.AromaReference]
  let descriptors: [String: Descriptor]

  var body: some View {
    VStack(alignment: .leading, spacing: Spacing.s) {
      Text(String(localized: "grapes.detail.aromas", bundle: .module))
        .font(.title3.bold())
      AromaGroupRow(labelKey: "grapes.detail.aromas.primary", names: names(for: .primary))
      AromaGroupRow(labelKey: "grapes.detail.aromas.secondary", names: names(for: .secondary))
      AromaGroupRow(labelKey: "grapes.detail.aromas.tertiary", names: names(for: .tertiary))
    }
  }

  private func names(for kind: AromaKind) -> [String] {
    aromas
      .filter { $0.kind == kind }
      .map { descriptors[$0.descriptorId]?.names.es ?? $0.descriptorId }
  }
}

private struct AromaGroupRow: View {
  let labelKey: String.LocalizationValue
  let names: [String]

  var body: some View {
    if !names.isEmpty {
      VStack(alignment: .leading, spacing: Spacing.xs) {
        Text(String(localized: labelKey, bundle: .module))
          .font(.subheadline.weight(.semibold))
        Text(names.joined(separator: ", "))
      }
    }
  }
}
