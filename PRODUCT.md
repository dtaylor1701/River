I will read the `README.md` and `DESIGN.md` files to gather more context about the project's purpose and design principles.
# PRODUCT.md

## Product Vision & Core Objectives
**River** is an artifact-driven workflow orchestration platform designed to bridge the gap between complex manual processes and rigid automated pipelines. Our vision is to provide a unified environment where users can define, visualize, and execute multi-step projects that require a mix of human input and machine execution.

### Core Objectives:
*   **Visibility:** Provide a clear, visual map of project dependencies and progress.
*   **Structure:** Transform "tribal knowledge" and loose scripts into repeatable, documented `.flow` files.
*   **Flexibility:** Support "Human-in-the-loop" workflows where data collection is as critical as script execution.
*   **Portability:** Ensure workflows are defined in an open format (JSON) that can be run in any environment (CLI or GUI).

### The Problem It Solves:
Modern projects often suffer from "context fragmentation." Knowledge about how to complete a project is split between READMEs, shell scripts, and individual team members' heads. Traditional CI/CD tools are too rigid for local, interactive tasks, while manual checklists are prone to error. River solves this by making the **Artifact** (the result of work) the first-class citizen that drives the flow forward.

---

## Target Audience & User Personas
River is built for professionals who manage repeatable but non-trivial processes.

### 1. The DevOps Engineer (The Architect)
*   **Needs:** To codify complex setup or deployment procedures that can't be fully automated yet.
*   **Usage:** Uses `RiverEditor` to design the master flow and distributes it to the team to run via the `River` CLI.

### 2. The Research Scientist / Data Analyst (The Practitioner)
*   **Needs:** A way to track data processing steps where some stages require manual parameter tuning or data gathering.
*   **Usage:** Uses the CLI to "check in" artifacts and the GUI to see what's left to do in their multi-day processing pipeline.

### 3. The Technical Lead (The Reviewer)
*   **Needs:** High-level visibility into project status without digging into logs.
*   **Usage:** Opens `RiverEditor` to see which artifacts are missing and which steps are blocking the project.

---

## Feature Roadmap

### Phase 1: Foundation (Short-Term)
*   **Core Engine Stability:** Finalize the `RiverKit` dependency resolution logic.
*   **CLI Parity:** Ensure the CLI can perform all actions defined in the JSON spec (Collect, Execute).
*   **Document Support:** Robust `.flow` file handling in `RiverEditor` with Undo/Redo support.
*   **Standard Action Library:** Basic implementation of shell script execution and manual input collection.

### Phase 2: Enhanced Interactivity (Medium-Term)
*   **Rich Inputs:** Support for complex artifact types (Images, Markdown, multi-select lists).
*   **Conditional Logic:** "Branching" paths based on artifact values (e.g., if `test_results` > 80%, proceed to `deploy`).
*   **Template Gallery:** In-app library of common workflow templates (e.g., "New Project Onboarding," "Release Checklist").
*   **CLI Interactive Mode:** A "Guided" CLI experience that walks the user through the flow step-by-step.

### Phase 3: Ecosystem & Automation (Long-Term)
*   **Remote Artifacts:** Support for artifacts stored in S3, GitHub, or internal APIs.
*   **River Hub:** A platform for sharing and versioning flows within an organization.
*   **Webhooks & Triggers:** Allow external events to satisfy artifacts and trigger River steps automatically.
*   **Plugin System:** Enable developers to write custom Action types (e.g., "Slack Notification Action").

---

## Feature Prioritization
We prioritize features based on the **"Path to Completion"** principle:
1.  **Core (Must-Have):** Anything that prevents a user from finishing a flow (Dependency logic, Action execution, Persistence).
2.  **UX (Should-Have):** Improvements to `RiverEditor` that make flow creation faster (Drag-and-drop, visual validation).
3.  **Extensibility (Nice-to-Have):** Features that allow River to integrate with other tools (Plugins, API triggers).

**Why Artifacts come first:** By focusing on the *output* of a step rather than just the *command*, we ensure that River remains resilient. If a script fails but a user provides the artifact manually, the flow can continue. This "resilient execution" is our core value proposition.

---

## Iteration Strategy
Our development is driven by **"Dogfooding"** and **Modular Feedback**:
*   **Internal Usage:** We use River to manage the build and release process of River itself.
*   **Surgical Updates:** The separation of `RiverKit` allows us to iterate on the core logic without breaking the CLI or GUI interfaces simultaneously.
*   **User Interviews:** We target small technical teams to observe how they map their existing "messy" processes into the `.flow` format.

---

## Release Strategy & User Onboarding
*   **Alpha Release:** Distribution of the CLI via Homebrew and the Editor via direct download for early adopters.
*   **Onboarding Goal:** A new user should be able to create and execute their first 3-step workflow in under 5 minutes.
*   **Documentation:** Focus on "Example Flows" (contained in `CopyResources/example.flow`) as the primary teaching tool.

---

## Success Metrics (KPIs)
*   **Flow Completion Rate:** Percentage of started flows that reach the final "Completed" state.
*   **Time-to-Artifact:** Average time elapsed between a step becoming "Ready" and its required artifacts being satisfied.
*   **Tool Cohesion:** Percentage of users who utilize both the CLI (for execution) and the GUI (for planning/review).
*   **Error Recovery Rate:** How often a user successfully resumes a flow after an `ExecuteAction` failure.

---

## Future Opportunities
*   **Enterprise Compliance:** Automated "Audit Logs" generated from flow history to prove that every step of a regulated process was followed.
*   **AI-Assisted Mapping:** Using LLMs to analyze a project directory and suggest a `.flow` structure based on existing scripts and files.
*   **Cross-Platform Core:** Porting `RiverKit` to Linux/Windows to allow the CLI to run in cloud environments while keeping the premium GUI on macOS.
