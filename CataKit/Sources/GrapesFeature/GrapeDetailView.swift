import DesignSystem
import Domain
import SwiftUI

public struct GrapeDetailView: View {
  @State private var viewModel: GrapeDetailViewModel
  private let onSelectGrape: (String) -> Void
  private let onSelectRegion: (String) -> Void

  public init(
    viewModel: GrapeDetailViewModel,
    onSelectGrape: @escaping (String) -> Void,
    onSelectRegion: @escaping (String) -> Void
  ) {
    _viewModel = State(initialValue: viewModel)
    self.onSelectGrape = onSelectGrape
    self.onSelectRegion = onSelectRegion
  }

  public var body: some View {
    content
      .task { await viewModel.load() }
  }

  @ViewBuilder
  private var content: some View {
    switch viewModel.state {
    case .loading:
      ProgressView()
    case .loaded(let detail):
      GrapeDetailContentView(
        detail: detail,
        onSelectGrape: onSelectGrape,
        onSelectRegion: onSelectRegion
      )
    case .empty, .failed:
      ContentUnavailableView(
        String(localized: "grapes.detail.error", bundle: .module),
        systemImage: "exclamationmark.triangle"
      )
    }
  }
}

private struct GrapeDetailContentView: View {
  let detail: GrapeDetailContent
  let onSelectGrape: (String) -> Void
  let onSelectRegion: (String) -> Void

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: Spacing.l) {
        Text(detail.grape.visual.es)
          .font(.body)
        GrapeStructureSection(structure: detail.grape.structure)
        GrapeAromasSection(aromas: detail.grape.aromas, descriptors: detail.descriptors)
        GrapeTastingSection(
          palate: detail.grape.palate,
          blindTastingKeys: detail.grape.blindTastingKeys
        )
        GrapeEvolutionSection(evolution: detail.grape.evolution)
        GrapeConfusedWithSection(
          confusedWith: detail.grape.confusedWith,
          grapeNames: detail.grapeNames,
          onSelectGrape: onSelectGrape
        )
        GrapeRegionalExpressionsSection(
          regionalExpressions: detail.grape.regionalExpressions,
          onSelectRegion: onSelectRegion
        )
        GrapeSourcesSection(sources: detail.grape.sources)
      }
      .padding(Spacing.m)
    }
    .navigationTitle(detail.grape.names.es)
  }
}
