import Foundation

enum FlowError: Error {
  case malformedArtifact
  case missingDependencies
  case malformedInput
  case undefinedArtifact
}

public class FlowManager {
  let directory: URL
  let flow: Flow
  let fileManager = FileManager.default

  static let fileName = "flow.river"

  public static func create(directory: URL, name: String) throws -> URL {
    // let storedFlow = StoredFlow(name: name, steps: [], artifacts: [])
    // let data = try JSONEncoder().encode(storedFlow)
    let path = directory.appending(path: fileName)
    // try data.write(to: path)

    let exampleFileName = "example.river"
    let examplePath = directory.appending(path: exampleFileName)

    if let exampleURL = Bundle.module.resourceURL?.appending(path: exampleFileName) {
      print("here")
      let text = try String(contentsOf: exampleURL, encoding: .utf8)
      print("there")

      try text.write(to: examplePath, atomically: true, encoding: .utf8)
    }

    return path
  }

  public init(directory: URL) throws {
    self.directory = directory
    let data = try Data(contentsOf: directory.appending(path: Self.fileName))
    self.flow = try JSONDecoder().decode(Flow.self, from: data)
  }

  public func steps() throws -> [StepState] {
    try flow.steps.map { step in
      try state(for: step)
    }
  }

  public func next() throws -> StepState? {
    return try steps().first { $0.canBegin && !$0.isComplete }
  }

  public func perform(collectAction: CollectAction, in step: Step, input: String) throws {
    let artifact = try collectAction.outputArtifact(in: flow)
    try write(value: input, for: artifact)
  }

  public func perform(executeAction: ExecuteAction, in step: Step) throws {
    let dependencies = try step.dependencies(in: flow).map { artifact in
      try writtenValue(for: artifact)
    }

    let process = Process()
    let pipe = Pipe()
    process.standardOutput = pipe
    process.executableURL = URL(filePath: executeAction.executablePath)
    process.arguments = executeAction.arguments + dependencies

    try process.run()
    let output = pipe.fileHandleForReading.readDataToEndOfFile()
    guard let value = String(data: output, encoding: .utf8) else {
      throw FlowError.malformedInput
    }
    try write(value: value, for: executeAction.outputArtifact(in: flow))
  }

  public func state(for step: Step) throws -> StepState {
    let stepArtifacts = try step.dependencies(in: flow)
    var state = StepState(
      step: step,
      existingDependencies: [],
      allDependencies: stepArtifacts,
      completedActions: [])

    for artifact in stepArtifacts {
      if artifactExists(artifact) {
        state.existingDependencies.append(artifact)
      }
    }

    for action in step.actions {
      let outputArtifact = try action.outputArtifact(in: flow)

      if artifactExists(outputArtifact) {
        state.completedActions.append(action)
      }
    }

    return state
  }

  // MARK:- Utilities.

  func write(value: String, for artifact: Artifact) throws {
    var content: String
    switch artifact.contentType {
    case .bool:
      guard let inputBool = InputCollection.boolValue(value) else {
        throw FlowError.malformedInput
      }
      content = "\(inputBool)"
    case .number:
      guard let inputDouble = Double(value) else {
        throw FlowError.malformedInput
      }
      content = "\(inputDouble)"
    case .url:
      guard let inputURL = URL(string: value) else {
        throw FlowError.malformedInput
      }
      content = "\(inputURL.absoluteString)"
    case .text:
      content = value
    }

    let path = path(for: artifact)
    try content.write(to: path, atomically: true, encoding: .utf8)
  }

  func path(for artifact: Artifact) -> URL {
    directory.appending(component: artifact.fileName)
  }

  func artifactExists(_ artifact: Artifact) -> Bool {
    fileManager.fileExists(atPath: path(for: artifact))
  }

  func writtenValue(for artifact: Artifact) throws -> String {
    let path = path(for: artifact)
    guard fileManager.fileExists(atPath: path) else {
      throw FlowError.missingDependencies
    }

    let data = try Data(contentsOf: path)

    guard let value = String(data: data, encoding: .utf8) else {
      throw FlowError.malformedArtifact
    }

    return value
  }
}
