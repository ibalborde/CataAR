import DesignSystem
import Domain
import SwiftUI

struct GrapeEvolutionSection: View {
  let evolution: Grape.Evolution

  var body: some View {
    VStack(alignment: .leading, spacing: Spacing.s) {
      Text(String(localized: "grapes.detail.evolution", bundle: .module))
        .font(.title3.bold())
      EvolutionRow(titleKey: "grapes.detail.evolution.young", text: evolution.young.es)
      EvolutionRow(titleKey: "grapes.detail.evolution.aged", text: evolution.aged.es)
      Text(agingPotentialText)
        .font(.callout)
        .foregroundStyle(.secondary)
    }
  }

  private var agingPotentialText: String {
    let label = String(localized: "grapes.detail.agingPotential", bundle: .module)
    let years = String(localized: "grapes.detail.years", bundle: .module)
    let min = evolution.agingPotentialYears.min
    let max = evolution.agingPotentialYears.max
    return "\(label): \(min)–\(max) \(years)"
  }
}

private struct EvolutionRow: View {
  let titleKey: String.LocalizationValue
  let text: String

  var body: some View {
    VStack(alignment: .leading, spacing: Spacing.xs) {
      Text(String(localized: titleKey, bundle: .module))
        .font(.headline)
      Text(text)
    }
  }
}
