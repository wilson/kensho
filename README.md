## Kenshō
**見性 (Kenshō)** *(n)*: An initial flash of insight, followed by training that deepens into enlightenment.

Prototype implementation of the **Hierarchical Morphic Refinement (HMR)** architecture, a full-stack framework for building intelligent agents.

Kenshō synthesizes cognitive science, formal verification theory, and condensed matter physics to try to solve the problem of "Automated Right Action."

The goal is not to simulate human thought, but to physically instantiate the geometry of reasoning.

---

## The Architecture: The Eightfold Model

Current AI architectures conflate "formal competence" (grammar, pattern matching) with "functional competence" (reasoning, planning). In the language of the **Coordination Trilemma**, they prioritize Availability over Consistency, which leads to hallucination.

Kenshō decouples these functions into an 8-layer geometric architecture designed to operate as a **Consistency-First (CP)** system:
* Layers "1-7" represent the preconfigured functional networks observed in biological intelligence.
* Layer "8" provides the constructive "bias" that drives the system toward convergence.

### I. The Ethical Foundation (The Lamplighter)

* **Layer 8: The Lamplighter.** The meta-meta-strategist. It defines the global energy function (the "Anti-Nihilism Bias"). It does not "think" in tokens; it monitors the system's convergence rate. If the system drifts into high variance/instability (the "Marginal Region"), the Lamplighter triggers a context reset. It provides the "will to converge" that distinguishes a conscious agent from a random process.

### II. The Planner (Functional Competence)

* **Layer 7: Default Mode Layer (Simulation).** The internal world model. Runs "fast, flat" rollouts of potential state trajectories before they are committed to memory.
* **Layer 6: Frontoparietal Layer (Control).** The executive planner. Uses **Tree-of-Thoughts** reasoning to select the next target state.
* **Layer 5: Limbic Layer (Valence).** The local energy estimator. Assigns cost/value to transitions in the state graph.

### III. The Refiner (Formal Competence)

* **Layer 4: Ventral Attention Layer (Interrupt).** The runtime monitor. Detects when a hypothesis is diverging from the theoretical convergence bound.
* **Layer 3: Dorsal Attention Layer (Focus).** The spotlight of the **Delta Operator**. Selects which features to project (erase) and which to inject (write).
* **Layer 2: Visual/Spatial Layer (Geometry).** The memory substrate. Uses **Node-Sequence/Graph Memory** rather than linear context windows to store structural relationships (roads, intersections, logic gates).
* **Layer 1: Somatomotor Layer (Action).** The interface to the physical world or the output buffer. Handles embodied constraints and final execution.

The lowest layer relates, perhaps, to "lizard brain" behaviors.

---

## The Mechanisms

### Deep Delta Learning (The Operator)

Standard residual networks use additive updates ($x + F(x)$), which can only accumulate information (and noise). Kenshō uses the **Delta Operator** to explicitly manipulate the state graph:
```math
X_{new} = X_{old} + \beta k (v^T - k^T X_{old})
```

* **Projection ($k^T X_{old}$):** Deliberate forgetting. The Refiner erases features that violate the current hypothesis.
* **Injection ($v^T$):** Writing the new state.
* **Reflection ($\beta \approx 2$):** Flipping the hypothesis.
This allows the system to edit its "mind" rather than just appending to a stream of tokens.

### The Convergence Guarantee (The Dantas Bound)

Kenshō is modeled as a **Sequential Absorbing Markov Chain**. It resolves the **Coordination Trilemma** by accepting the latency cost of reasoning to ensure state consistency. It does not rely on heuristics to know if the model will finish thinking.

Rather, the theoretical bound:
```math
\mathbb{E}[n] \le 4/\delta
```

Where "delta" is the error-reduction probability. If $\delta > 0$ (the system is at least partially competent), the agent is mathematically guaranteed to reach a "Verified" state.

### The Physical Substrate (Dirac Dataflow)

While the initial prototype will operate on "classical" GPU platforms, the overall architecture is designed to run one day on the **Dirac Dataflow Architecture**, a theoretical hardware specification based on **Magic-Angle Twisted Bilayer Graphene (MATBLG)** or similar substrates.

* **Write Mechanism:** The **Inverse Faraday Effect** allows memory states to be written instantaneously using circularly polarized light, eliminating the heat dissipation of electric currents.
* **Logic:** **Valleytronics**. Computation occurs by switching electron orbits (valleys), providing a non-volatile, topological memory substrate.

---

## The Stack

* **Theory:** Cognitive Science (Mahowald), Verification (Dantas), Geometric DL (Zhang), Neurodevelopment (van der Molen).
* **Model:** [kenshō](https://github.com/wilson/kensho). Implements the "Eightfold" architecture and Delta Learning.
* **Utilities:** [ariadne](https://github.com/wilson/ariadne) & [friction](https://github.com/wilson/friction) (Zig). Low-level libraries for memory-safe graph traversal and topological data analysis.
* **Compiler (Future Bridge):** [xotiq](https://github.com/wilson/xotiq). A hardware description language that separates probabilistic fabric (`p_node`) from deterministic control (`d_node`). Targets SPICE netlists for analog verification.

---

## Glossary of Terms

* **Coordination Trilemma:** Known as the CAP Theorem in distributed systems. Biology got there first, however. It dictates that a system cannot maximize Consistency, Availability, and Partition Tolerance simultaneously. Kenshō chooses **Consistency and Partition Tolerance** (CP). By contrast, LLMs are **Available and Partition-Tolerant** (AP) at the cost of consistency, while most biological intelligence maximizes **Consistency and Availability** (CA) at the cost of learning from contradiction.
* **Absorbing State:** A state in a Markov chain that, once entered, cannot be left. In Kenshō, this is the "Verified" or "Done" state.
* **Delta Operator:** A geometric transformation that generalizes residual connections. It allows a network to interpolate between Identity (doing nothing), Projection (erasing data), and Reflection (flipping data).
* **Inverse Faraday Effect:** A physical phenomenon where a static magnetic field is induced by a circularly polarized electromagnetic wave (light). Used here as a non-thermal write mechanism.
* **Marginal Region:** The operational zone where the probability of a successful step ($\delta$) is less than 0.3. In this region, the variance of convergence time explodes, leading to instability.
* **Node-Sequence Memory:** A memory structure that stores a chronological sequence of visited states and their local topology, proven to outperform linear context windows for spatial and structural reasoning.
* **Valleytronics:** A field of electronics that uses the "valley" degree of freedom (electron momentum states in a crystal lattice) to encode information, rather than electric charge.

## Status

**Current Phase:** Architectural definition and tooling.

**Goal:** Validating the "Version 1.0" HMR architecture on established reasoning benchmarks using existing computing hardware.

## Contributing

Contributions are welcome. Please open an issue to discuss potential changes or new features before submitting a pull request.

Consider a thorough review of the referenced literature a necessary prerequisite to understanding this project.

## Foundational Inspiration

This concept loots the treasure vaults of giants, synthesizing research from multiple disciplines.

### Cognitive Architecture (The "Why")

* **Dissociating Language and Thought:** *Dissociating Language and Thought in Large Language Models* (Mahowald et al., 2024). The core justification for separating the **Planner** (Functional Competence) from the **Refiner** (Formal Competence).
    * [arxiv.org/abs/2301.06627](https://arxiv.org/abs/2301.06627)
* **Fast, Flat Simulation:** *People use fast, flat goal-directed simulation to reason about novel problems* (Collins et al., 2025). The model for **Layer 7 (Default Mode)**.
    * [arxiv.org/abs/2510.11503](https://arxiv.org/abs/2510.11503)
* **Spatial Reasoning & Memory:** *Thinking on Maps: How Foundation Model Agents Explore...* (Wei et al., 2025). The empirical proof that **Graph Memory** outperforms linear context for spatial reasoning.
    * [arxiv.org/abs/2512.24504](https://arxiv.org/abs/2512.24504)

### Verification & Mechanisms (The "How")

* **The Convergence Bound:** *The 4/δ Bound: Designing Predictable LLM-Verifier Systems* (Dantas et al., 2025). The mathematical guarantee for the **Lamplighter's** stopping condition.
    * [arxiv.org/abs/2512.02080](https://arxiv.org/abs/2512.02080)
* **Deep Delta Learning:** *Deep Delta Learning* (Zhang et al., 2026). The geometric basis for the **Refiner's** update rule (Projection/Reflection).
    * [arxiv.org/abs/2601.00417](https://arxiv.org/abs/2601.00417)
* **Preconfigured Topology:** *Preconfigured Neuronal Firing in the Human Brain* (van der Molen et al., 2025). Evidence that intelligence requires a pre-wired topological **backbone**, not just a blank slate.
    * [nature.com/articles/s41593-025-02111-0](https://www.nature.com/articles/s41593-025-02111-0)

### Physical Realization (The "Where")

* **Orbital Magnetism:** *Optical control of orbital magnetism in magic-angle twisted bilayer graphene* (2026). The physical mechanism for writing memory with light (Inverse Faraday Effect).
    * [nature.com/articles/s41567-025-03117-y](https://www.nature.com/articles/s41567-025-03117-y)
* **Spintronics:** *Field Free Spin-Orbit Torque Controlled Synapse...* (Lone et al., 2025). The feasibility of **stochastic hardware** for the probabilistic fabric.
    * [arxiv.org/abs/2510.05616](https://arxiv.org/abs/2510.05616)

---
*© 02026 Wilson Bilkovich*
