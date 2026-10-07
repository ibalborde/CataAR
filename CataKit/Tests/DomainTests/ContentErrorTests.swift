import Domain
import Testing

@Suite("ContentError")
struct ContentErrorTests {
  @Test("equal cases with equal payloads are equal")
  func equalCasesAreEqual() {
    #expect(ContentError.notFound(id: "malbec") == ContentError.notFound(id: "malbec"))
  }

  @Test("same case with different payloads are not equal")
  func differentPayloadsAreNotEqual() {
    #expect(ContentError.notFound(id: "malbec") != ContentError.notFound(id: "bonarda"))
  }

  @Test("different cases are not equal")
  func differentCasesAreNotEqual() {
    #expect(ContentError.notFound(id: "malbec") != ContentError.decodingFailed("malbec"))
  }
}
