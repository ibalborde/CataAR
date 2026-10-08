import Domain
import TestSupport
import Testing

@testable import GrapesFeature

@Suite("GrapeDetailViewModel")
@MainActor
struct GrapeDetailViewModelTests {
  @Test("starts in loading state")
  func startsLoading() {
    let viewModel = makeViewModel(grapeId: "malbec", grapes: [], descriptors: [])
    guard case .loading = viewModel.state else {
      Issue.record("expected .loading, got \(viewModel.state)")
      return
    }
  }

  @Test("load() populates loaded state with the matching grape and its aroma descriptors")
  func loadPopulatesLoadedState() async {
    let grape = GrapeFixture.make(
      id: "malbec",
      aromas: [Grape.AromaReference(descriptorId: "ciruela", kind: .primary)]
    )
    let ciruela = DescriptorFixture.make(id: "ciruela", family: .blackFruit)
    let viewModel = makeViewModel(grapeId: "malbec", grapes: [grape], descriptors: [ciruela])

    await viewModel.load()

    guard case .loaded(let content) = viewModel.state else {
      Issue.record("expected .loaded, got \(viewModel.state)")
      return
    }
    #expect(content.grape.id == "malbec")
    #expect(content.descriptors["ciruela"]?.id == "ciruela")
  }

  @Test("load() resolves confusedWith grape ids into display names")
  func loadResolvesConfusedWithNames() async {
    let bonarda = GrapeFixture.make(
      id: "bonarda",
      names: LocalizedText(values: ["es": "Bonarda"])
    )
    let malbec = GrapeFixture.make(
      id: "malbec",
      confusedWith: [
        Grape.ConfusedWithReference(
          grapeId: "bonarda",
          howToTell: LocalizedText(values: ["es": "Diferencia"])
        )
      ]
    )
    let viewModel = makeViewModel(
      grapeId: "malbec",
      grapes: [malbec, bonarda],
      descriptors: []
    )

    await viewModel.load()

    guard case .loaded(let content) = viewModel.state else {
      Issue.record("expected .loaded, got \(viewModel.state)")
      return
    }
    #expect(content.grapeNames["bonarda"] == "Bonarda")
  }

  @Test("load() maps notFound to the failed state")
  func loadMapsNotFoundToFailedState() async {
    let viewModel = makeViewModel(
      grapeId: "unknown-grape",
      grapes: [GrapeFixture.make(id: "malbec")],
      descriptors: []
    )

    await viewModel.load()

    guard case .failed = viewModel.state else {
      Issue.record("expected .failed, got \(viewModel.state)")
      return
    }
  }

  private func makeViewModel(
    grapeId: String,
    grapes: [Grape],
    descriptors: [Descriptor]
  ) -> GrapeDetailViewModel {
    GrapeDetailViewModel(
      grapeId: grapeId,
      grapeRepository: FakeGrapeRepository(result: .success(grapes)),
      descriptorRepository: FakeDescriptorRepository(result: .success(descriptors))
    )
  }
}
