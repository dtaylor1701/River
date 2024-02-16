import ArgumentParser
import Foundation
import RiverKit
import Twigs

@main
struct River: AsyncParsableCommand {
  static var configuration = CommandConfiguration(
    abstract: "A utility to help complete projects which have multiple steps.",
    subcommands: [Next.self, Steps.self, Artifacts.self, New.self],
    defaultSubcommand: Next.self
  )

  static var currentDirectoryPath: URL {
    URL(filePath: FileManager.default.currentDirectoryPath)
  }

  static func setupFlowManager() throws -> FlowManager {
    return try FlowManager(directory: currentDirectoryPath)
  }
}
