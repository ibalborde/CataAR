/// Reads aroma/taste descriptor taxonomy. Implementations live in the Data layer.
public protocol DescriptorRepository: Sendable {
  func allDescriptors() async throws -> [Descriptor]
  func descriptor(id: String) async throws -> Descriptor
}
