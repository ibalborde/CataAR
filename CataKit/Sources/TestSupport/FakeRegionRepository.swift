import Domain

public struct FakeRegionRepository: RegionRepository {
  private let result: Result<[Region], ContentError>

  public init(result: Result<[Region], ContentError>) {
    self.result = result
  }

  public func allRegions() async throws -> [Region] {
    try result.get()
  }

  public func region(id: String) async throws -> Region {
    let regions = try result.get()
    guard let match = regions.first(where: { $0.id == id }) else {
      throw ContentError.notFound(id: id)
    }
    return match
  }
}
