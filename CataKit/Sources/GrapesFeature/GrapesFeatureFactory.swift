import Domain
import SwiftUI

@MainActor
public struct GrapesFeatureFactory {
  private let grapeRepository: GrapeRepository
  private let descriptorRepository: DescriptorRepository
  private let onSelectRegion: (String) -> Void

  public init(
    grapeRepository: GrapeRepository,
    descriptorRepository: DescriptorRepository,
    onSelectRegion: @escaping (String) -> Void
  ) {
    self.grapeRepository = grapeRepository
    self.descriptorRepository = descriptorRepository
    self.onSelectRegion = onSelectRegion
  }

  public func makeRoot(onSelectGrape: @escaping (String) -> Void) -> some View {
    GrapesListView(
      viewModel: GrapesListViewModel(repository: grapeRepository),
      onSelectGrape: onSelectGrape
    )
  }

  public func makeDetail(grapeId: String, onSelectGrape: @escaping (String) -> Void) -> some View {
    GrapeDetailView(
      viewModel: GrapeDetailViewModel(
        grapeId: grapeId,
        grapeRepository: grapeRepository,
        descriptorRepository: descriptorRepository
      ),
      onSelectGrape: onSelectGrape,
      onSelectRegion: onSelectRegion
    )
  }
}
