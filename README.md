I will start by reading `River/Package.swift` and `River/CommandLine/River.swift` to understand the project's core functionality and dependencies, followed by a quick look at `RiverEditor/RiverEditorApp.swift` to confirm the relationship between the CLI and the GUI editor.
I will read `River/Sources/Models/Flow.swift` and `River/Sources/Models/Step.swift` to better define the core concepts of Flows and Steps for the README.
# River

**River** is a comprehensive workflow management tool designed to help users complete multi-step projects by organizing tasks into logical "Flows." Whether you are automating a build process or managing a complex set of manual tasks, River provides the structure to track progress, handle dependencies, and execute actions.

## Overview

The River project is composed of three primary components:

1.  **River (CLI)**: A powerful command-line interface for interacting with and executing flows directly from your terminal.
2.  **RiverKit**: The core Swift library containing the domain models, logic, and state management that powers both the CLI and the GUI.
3.  **RiverEditor**: A native macOS application (SwiftUI) providing a visual environment for creating, editing, and managing `.flow` files.

---

## Key Concepts

-   **Flow**: The top-level container for a project, defining a sequence of steps, required artifacts, and the overall workflow name.
-   **Step**: A discrete unit of work within a flow. Steps can have dependencies on specific artifacts and contain multiple actions.
-   **Artifact**: A resource (file, data, or physical object) that is either required by a step or produced as the output of an action.
-   **Action**:
    *   **Collect Action**: Prompts the user to provide or identify a specific artifact.
    *   **Execute Action**: Runs a script or executable (e.g., `assemble.sh`) to transform dependencies into new artifacts.

---

## Installation

### Prerequisites
-   macOS 13.0 or later
-   Swift 5.8+ / Xcode 14.3+

### Building the CLI
To build the `River` command-line tool:
```bash
cd River
swift build -c release
```
The executable will be available at `.build/release/River`.

### Building the Editor
Open the `RiverEditor/RiverEditor.xcodeproj` file in Xcode and build the `RiverEditor` target for your Mac.

---

## Usage

### Command Line Interface
The `River` CLI supports several subcommands to manage your progress:

-   `River next`: Identifies and prompts for the next logical step in the current flow.
-   `River steps`: Lists all steps in the flow and their current status.
-   `River artifacts`: Displays the state of all artifacts defined in the project.
-   `River new`: Scaffolds a new flow configuration.

### Graphical Editor
Use **RiverEditor** to visually map out your workflow:
-   Drag and drop to reorder steps.
-   Define dependencies between artifacts and steps using the intuitive UI.
-   Configure executable paths and arguments for automation scripts.
-   Export and save your progress as `.flow` files (JSON-backed).

---

## Dependencies

River leverages the following open-source libraries:
-   [swift-argument-parser](https://github.com/apple/swift-argument-parser): Powers the CLI's robust command-line interface.
-   [Twigs](https://github.com/dtaylor1701/Twigs): Used for internal data structures and graph management.

---

## Project Structure

```text
.
├── River/                  # CLI and Core Logic
│   ├── CommandLine/        # River CLI implementation
│   ├── Sources/            # RiverKit (Models, Logic, FlowManager)
│   └── Package.swift       # Swift Package Manager configuration
└── RiverEditor/            # macOS SwiftUI Application
    ├── RiverEditor/        # Views, ViewModels, and App Delegate
    └── RiverEditor.xcodeproj # Xcode Project
```
