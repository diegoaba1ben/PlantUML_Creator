# AGENT CONTEXT — EgidaCP Framework

## 1. System Identity

Project: EgidaCP
Nature: Structural SaaS Framework for Cybersecurity & Compliance
Architecture Style: Modular Monolith
Design Philosophy: Local-First

EgidaCP is **not an application**.

It is a **framework** that defines:

* architectural structure
* orchestration mechanisms
* execution model
* extension contracts

The framework does **not define business domains**.

Business capabilities are implemented as modules.

---

## 2. Architectural Invariants

The following rules **cannot be violated**:

* CyberCore is structurally invariant.
* The system has **a single internal entry point**: Components Orchestrator.
* External boundary cannot access the core directly.
* Capabilities do **not interact directly** with each other.
* All capability interaction occurs through orchestration.
* Extensions interact **only through explicit contracts**.
* Structural architecture cannot be redefined by technical implementation.
* Technology choices do not define architecture.

If a decision violates any invariant → the decision is invalid.

---

## 3. Core Architecture Layers

EgidaCP follows a strict layered architecture:

External Boundary
→ Components Orchestrator
→ CyberCore
→ Capability Layer
→ Extension Layer

### CyberCore Composition

CyberCore

* Core Runtime
* Domain & State Model

Responsibilities:

* framework structural execution
* domain model of framework invariants
* system state coherence
* enforcement of architectural invariants

---

## 4. Architectural Principle

### **Vertical Coherence**

All architectural decisions must maintain alignment between:

* conceptual principles
* structural architecture
* technical implementation
* governance mechanisms

Loss of alignment between these layers breaks architectural coherence.

---

## 5. Architecture Memory

The project uses two architectural continuity artifacts.

### FBCA

Architectural continuity memory.

Contains:

* system identity
* invariants
* architecture layers
* architectural governance rules

### FASA

Architecture state snapshot.

Contains:

* current architecture maturity
* active design phase
* recent architectural adjustments

---

## 6. Current Architecture State (FASA Snapshot)

CyberCore → stable
Orchestration → stable
Capability Layer → stable
Extension Model → stable

Dynamic Model → stabilized
Contextual Persistence → defined

Technical dependency rules → defined (DDS Chapter 9.6)

Operational diagrams → in development (DDS Chapter 10)

---

## 7. DDS Status

Architecture documentation follows IEEE-1016.

Current state:

Chapters 1–9 → closed
Chapter 10 → in development

Chapter 10 goal:
Define operational behavior of the framework through UML interaction diagrams.

---

## 8. Active Work Area

DDS Chapter 10 — Operational Diagrams

Planned diagrams:

* Basic capability query interaction
* Capability execution flow
* Multi-capability orchestration
* Concurrent multi-tenant interaction
* State-changing operation with event emission

---

## 9. Agent Operating Rules

When analyzing or proposing architectural changes:

Always verify:

* Does the change violate an invariant?
* Does it introduce premature technical decisions?
* Does it duplicate existing structural concepts?
* Does it confuse structural and variable elements?

Prefer:

* elegant structural decisions
* minimal components
* clear orchestration
* preservation of architectural invariants
