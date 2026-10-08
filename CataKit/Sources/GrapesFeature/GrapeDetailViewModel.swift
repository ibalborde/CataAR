import Domain
import Observation

@MainActor
@Observable
public final class GrapeDetailViewModel {
  public private(set) var state: ViewState<GrapeDetailContent> = .loading

  private let grapeId: String
  private let grapeRepository: GrapeRepository
  private let descriptorRepository: DescriptorRepository

  public init(
    grapeId: String,
    grapeRepository: GrapeRepository,
    descriptorRepository: DescriptorRepository
  ) {
    self.grapeId = grapeId
    self.grapeRepository = grapeRepository
    self.descriptorRepository = descriptorRepository
  }

  public func load() async {
    state = .loading
    do {
      let grape = try await grapeRepository.grape(id: grapeId)
      async let descriptorsTask = descriptorRepository.allDescriptors()
      async let allGrapesTask = grapeRepository.allGrapes()
      let (allDescriptors, allGrapes) = try await (descriptorsTask, allGrapesTask)

      let neededDescriptorIds = Set(grape.aromas.map(\.descriptorId))
      let descriptors = Dictionary(
        uniqueKeysWithValues:
          allDescriptors
          .filter { neededDescriptorIds.contains($0.id) }
          .map { ($0.id, $0) }
      )

      let neededGrapeIds = Set(grape.confusedWith.map(\.grapeId))
      let grapeNames = Dictionary(
        uniqueKeysWithValues:
          allGrapes
          .filter { neededGrapeIds.contains($0.id) }
          .map { ($0.id, $0.names.es) }
      )

      state = .loaded(
        GrapeDetailContent(grape: grape, descriptors: descriptors, grapeNames: grapeNames)
      )
    } catch {
      state = .failed(error)
    }
  }
}
