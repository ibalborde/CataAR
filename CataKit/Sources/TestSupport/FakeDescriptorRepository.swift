import Domain

public struct FakeDescriptorRepository: DescriptorRepository {
  private let result: Result<[Descriptor], ContentError>

  public init(result: Result<[Descriptor], ContentError>) {
    self.result = result
  }

  public func allDescriptors() async throws -> [Descriptor] {
    try result.get()
  }

  public func descriptor(id: String) async throws -> Descriptor {
    let descriptors = try result.get()
    guard let match = descriptors.first(where: { $0.id == id }) else {
      throw ContentError.notFound(id: id)
    }
    return match
  }
}
