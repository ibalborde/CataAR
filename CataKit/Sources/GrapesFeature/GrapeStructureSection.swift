import DesignSystem
import Domain
import SwiftUI

struct GrapeStructureSection: View {
  let structure: Grape.Structure

  private var rows: [(key: String, labelKey: String.LocalizationValue, value: Int)] {
    [
      ("body", "grapes.detail.structure.body", structure.body),
      ("tannin", "grapes.detail.structure.tannin", structure.tannin),
      ("acidity", "grapes.detail.structure.acidity", structure.acidity),
      ("alcohol", "grapes.detail.structure.alcohol", structure.alcohol),
      ("colorIntensity", "grapes.detail.structure.colorIntensity", structure.colorIntensity),
    ]
  }

  var body: some View {
    VStack(alignment: .leading, spacing: Spacing.s) {
      Text(String(localized: "grapes.detail.structure", bundle: .module))
        .font(.title3.bold())
      ForEach(rows, id: \.key) { row in
        StructureRow(labelKey: row.labelKey, value: row.value)
      }
    }
  }
}

private struct StructureRow: View {
  let labelKey: String.LocalizationValue
  let value: Int

  var body: some View {
    HStack {
      Text(String(localized: labelKey, bundle: .module))
        .frame(width: 140, alignment: .leading)
      StructureScaleView(value: value)
    }
  }
}

private struct StructureScaleView: View {
  let value: Int

  var body: some View {
    HStack(spacing: Spacing.xs) {
      ForEach(1...5, id: \.self) { step in
        Circle()
          .fill(step <= value ? Color.accentColor : Color.secondary.opacity(0.25))
          .frame(width: 10, height: 10)
      }
    }
  }
}
