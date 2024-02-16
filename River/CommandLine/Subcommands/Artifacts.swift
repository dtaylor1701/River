import ArgumentParser
import RiverKit

extension River {
  struct Artifacts: AsyncParsableCommand {
    mutating func run() async throws {
      print("All the artifacts")
    }
  }
}
