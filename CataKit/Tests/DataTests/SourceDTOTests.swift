import Domain
import Foundation
import Testing

@testable import Data

@Suite("SourceDTO")
struct SourceDTOTests {
  @Test("maps a well-formed url")
  func mapsWellFormedURL() throws {
    let dto = SourceDTO(title: "INV 2025", url: "https://inv.gob.ar", accessed: "2026-10-07")
    let source = try dto.toDomain()
    #expect(source.title == "INV 2025")
    #expect(source.url.absoluteString == "https://inv.gob.ar")
    #expect(source.accessed == "2026-10-07")
  }

  @Test("throws decodingFailed for a malformed url")
  func throwsForMalformedURL() {
    let dto = SourceDTO(title: "Bad", url: "", accessed: "2026-10-07")
    #expect(throws: ContentError.decodingFailed("invalid source url: ")) {
      try dto.toDomain()
    }
  }
}
