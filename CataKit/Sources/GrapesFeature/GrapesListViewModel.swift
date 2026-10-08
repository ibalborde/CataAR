import Domain
import Observation

@MainActor
@Observable
public final class GrapesListViewModel {
  public private(set) var state: ViewState<[Grape]> = .loading

  private let repository: GrapeRepository

  public init(repository: GrapeRepository) {
    self.repository = repository
  }

  public func load() async {
    state = .loading
    do {
      let grapes = try await repository.allGrapes()
      state = grapes.isEmpty ? .empty : .loaded(grapes)
    } catch {
      state = .failed(error)
    }
  }
}
