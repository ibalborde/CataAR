import DesignSystem
import Domain
import SwiftUI

public struct GrapesListView: View {
  @State private var viewModel: GrapesListViewModel
  private let onSelectGrape: (String) -> Void

  public init(viewModel: GrapesListViewModel, onSelectGrape: @escaping (String) -> Void) {
    _viewModel = State(initialValue: viewModel)
    self.onSelectGrape = onSelectGrape
  }

  public var body: some View {
    content
      .navigationTitle(String(localized: "grapes.list.title", bundle: .module))
      .task { await viewModel.load() }
  }

  @ViewBuilder
  private var content: some View {
    switch viewModel.state {
    case .loading:
      ProgressView()
    case .loaded(let grapes):
      List(grapes) { grape in
        GrapeRow(grape: grape)
          .contentShape(Rectangle())
          .onTapGesture { onSelectGrape(grape.id) }
      }
    case .empty:
      ContentUnavailableView(
        String(localized: "grapes.list.empty", bundle: .module),
        systemImage: "wineglass"
      )
    case .failed:
      ContentUnavailableView(
        String(localized: "grapes.list.error", bundle: .module),
        systemImage: "exclamationmark.triangle"
      )
    }
  }
}

private struct GrapeRow: View {
  let grape: Grape

  var body: some View {
    VStack(alignment: .leading, spacing: Spacing.xs) {
      Text(grape.names.es)
        .font(.headline)
      Text(String(localized: grape.color.displayNameKey, bundle: .module))
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
  }
}
