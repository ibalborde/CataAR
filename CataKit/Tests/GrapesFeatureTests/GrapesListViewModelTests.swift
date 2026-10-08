import Domain
import TestSupport
import Testing

@testable import GrapesFeature

@Suite("GrapesListViewModel")
@MainActor
struct GrapesListViewModelTests {
  @Test("starts in loading state")
  func startsLoading() {
    let viewModel = GrapesListViewModel(repository: FakeGrapeRepository(result: .success([])))
    guard case .loading = viewModel.state else {
      Issue.record("expected .loading, got \(viewModel.state)")
      return
    }
  }

  @Test("load() populates loaded state with non-empty results")
  func loadPopulatesLoadedState() async {
    let grapes = [GrapeFixture.make(id: "malbec"), GrapeFixture.make(id: "bonarda")]
    let viewModel = GrapesListViewModel(repository: FakeGrapeRepository(result: .success(grapes)))
    await viewModel.load()
    guard case .loaded(let loadedGrapes) = viewModel.state else {
      Issue.record("expected .loaded, got \(viewModel.state)")
      return
    }
    #expect(loadedGrapes.map(\.id) == ["malbec", "bonarda"])
  }

  @Test("load() maps an empty result to the empty state")
  func loadMapsEmptyResult() async {
    let viewModel = GrapesListViewModel(repository: FakeGrapeRepository(result: .success([])))
    await viewModel.load()
    guard case .empty = viewModel.state else {
      Issue.record("expected .empty, got \(viewModel.state)")
      return
    }
  }

  @Test("load() maps a repository error to the failed state")
  func loadMapsRepositoryError() async {
    let viewModel = GrapesListViewModel(
      repository: FakeGrapeRepository(result: .failure(.notFound(id: "grapes")))
    )
    await viewModel.load()
    guard case .failed = viewModel.state else {
      Issue.record("expected .failed, got \(viewModel.state)")
      return
    }
  }
}
