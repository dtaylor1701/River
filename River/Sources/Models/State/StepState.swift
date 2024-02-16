import Foundation

public struct StepState {
  public let step: Step
  public var existingDependencies: [Artifact]
  public var allDependencies: [Artifact]
  // As determined by the resulting artifacts.
  public var completedActions: [Action]

  public var canBegin: Bool {
    existingDependencies == allDependencies
  }

  public var isComplete: Bool {
    step.actions == completedActions
  }
}
