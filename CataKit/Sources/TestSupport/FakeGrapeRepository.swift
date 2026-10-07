import Domain

public struct FakeGrapeRepository: GrapeRepository {
  private let result: Result<[Grape], ContentError>

  public init(result: Result<[Grape], ContentError>) {
    self.result = result
  }

  public func allGrapes() async throws -> [Grape] {
    try result.get()
  }

  public func grape(id: String) async throws -> Grape {
    let grapes = try result.get()
    guard let match = grapes.first(where: { $0.id == id }) else {
      throw ContentError.notFound(id: id)
    }
    return match
  }
}
