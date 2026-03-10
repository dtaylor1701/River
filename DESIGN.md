I will begin by examining the core models and package configuration to accurately define the system architecture and data relationships.

I will now examine `Action.swift` to understand the full structure of the actions before I proceed to construct the `DESIGN.md`.

# River Design Document

## 1. High-Level Architecture
River is a modular workflow orchestration system designed to define, manage, and execute structured sequences of tasks. The system follows a clear separation of concerns, split into three primary layers:

- **RiverKit (Core Library):** The foundational engine containing the domain models, business logic, and state management. It provides the `Codable` schemas used by both the CLI and GUI.
- **River (CLI):** A command-line interface for headless execution and programmatic interaction with flows.
- **RiverEditor (macOS GUI):** A SwiftUI-based visual editor for designing, inspecting, and modifying flows through a document-based interface.

## 2. System Design & Technical Stack
- **Language:** Swift 5.8+
- **Platform:** macOS 13+
- **Frameworks:**
  - **SwiftUI:** Used for the `RiverEditor` interface.
  - **Swift Argument Parser:** Powers the `River` CLI tool.
  - **Codable:** Handles all data serialization to JSON.
- **Build System:** Swift Package Manager (SPM) for the core and CLI; Xcode for the macOS application.

## 3. Core Design Philosophies
- **Artifact-Driven Workflow:** Workflows are defined by the data they produce (`Artifacts`) rather than just the actions they perform. A step's readiness is determined by the availability of its required artifacts.
- **Declarative Composition:** Flows are defined as a collection of steps and artifacts, making them portable and reproducible.
- **Portability:** Use of standard JSON for persistence ensures flows can be shared between the CLI and GUI seamlessly.

## 4. Data Models & Relationships
The system revolves around a Directed Acyclic Graph (DAG) structure:

- **Flow:** The root container. Holds a collection of `Steps` and `Artifacts`.
- **Artifact:** A piece of data (Text, URL, Bool, or Number) produced or consumed by the system. Each artifact has a unique ID and a backing file reference.
- **Step:** A unit of work. It specifies `dependencyIDs` (required Artifacts) and contains a sequence of `Actions`.
- **Action:** An atomic operation.
  - `CollectAction`: Prompts for or retrieves an artifact (input-oriented).
  - `ExecuteAction`: Runs an external process/script to transform dependencies into a new artifact.

### Persistence Strategy
Data is persisted as JSON files. The `RiverEditor` uses `ReferenceFileDocument` to provide a native macOS document experience, while the CLI reads and writes these same JSON files via `FileManager` extensions and `RiverKit`'s model layer.

## 5. Technical Specifications

### State Management
- **StepState:** Tracks the lifecycle of steps (e.g., pending, in-progress, completed, failed).
- **FlowManager:** Orchestrates the transition between steps based on dependency availability.

### Error Handling
- **FlowError:** A specialized error enum for domain-specific failures like `undefinedArtifact`, `missingDependency`, or `executionFailed`.
- Errors are propagated through the call stack to be displayed as alerts in the GUI or stderr messages in the CLI.

### Concurrency
- The system leverages Swift's modern concurrency features (`async/await`) for executing actions and managing UI updates in the editor.

## 6. Component Interactions

1. **User Input:** Users define a `Flow` in `RiverEditor`.
2. **Validation:** `RiverKit` validates that there are no circular dependencies and all `Action` outputs are registered as `Artifacts`.
3. **Execution:**
   - The CLI or Editor invokes the execution engine.
   - The engine identifies steps with satisfied dependencies.
   - `ExecuteAction` triggers shell commands (e.g., `assemble.sh`).
   - Output artifacts are stored, triggering the next set of eligible steps.

## 7. Testing Infrastructure
- **Unit Tests (`RiverEditorTests`):** Focus on model validation, dependency graph resolution, and JSON serialization.
- **UI Tests (`RiverEditorUITests`):** Verify the flow creation and editing user experience in the macOS app.
- **Integration Tests:** (Executed via CLI) Verify that `ExecuteAction` correctly interacts with the filesystem and external scripts.

## 8. Security & Performance
- **Sandbox:** The macOS app uses App Sandbox with specific entitlements for file access.
- **Performance:** Since flows are metadata-heavy but usually lightweight in file size, the system uses in-memory graph resolution for high-speed dependency checking.
- **Execution Safety:** External scripts are executed with a clear separation of environment variables to prevent unintended side effects.
