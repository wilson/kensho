## Kenshō  
**見性 (Kenshō)** _(n)_: An initial flash of insight, followed by training that deepens into enlightenment.  

Prototype implementation of the **Hierarchical Morphic Refinement (HMR)** architecture, a novel framework for building intelligent agents.  
Kenshō is designed to explore a new paradigm of computation that is efficient, structured, and deeply probabilistic.  

This work synthesizes breakthroughs in recursive reasoning with cutting-edge models from computational neuroscience, generative AI, and geometric deep learning.  

## The Vision: A New Foundation

Modern "AI" has been defined by scaling large, monolithic models. While powerful, this paradigm is power-intensive and struggles with tasks requiring deep, structured reasoning or principled uncertainty management.  

Kenshō explores an alternative path. The next frontier lies not in greater scale, but in superior architectural principles grounded in how both natural and artificial systems efficiently process information.  

This approach is built on three pillars:  
1.  **Cognitive Plausibility (The "Why"):** Inspiration comes from cognitive science models of human reasoning, which suggest that people approach novel problems using fast, shallow, goal-directed mental simulations, not exhaustive search. The **Planner** module embodies this principle of resource-rationality.
2.  **Probabilistic Propagation (The "How"):** Computation is modeled as a probabilistic process of information propagation. The **Refiner** module is based on the **Propagator Model**, a class of generative models (like Schrödinger Bridges) that learn to efficiently transform an incomplete or low-resolution state into a refined, high-resolution state through a learned diffusion process.
3.  **Hardware Realization (The "Where"):** This probabilistic, energy-based approach aligns directly with emerging neuromorphic hardware, such as spintronic (or perhaps valleytronic) devices that can perform in-hardware sampling, promising radical gains in energy efficiency over traditional silicon.

## The HMR Architecture: Propagator-Based Agent

The HMR architecture is initially a two-level system designed to explicitly model the interaction between goal-directed planning and mechanistic, probabilistic refinement.

1.  **The Planner (Active Inference):** The high-level Planner acts as a probabilistic world model, guided by the Free Energy Principle (FEP). It performs **active inference** to handle uncertainty, seek information, and select policies (sequences of sub-goals) that are expected to minimize future surprise. It embodies the "fast and flat" reasoning of a resource-rational agent.

2.  **The Refiner (Probabilistic Propagator):** The low-level Refiner is the mechanistic substrate that executes the Planner's policies. This is implemented as a **probabilistic propagator** using the state-of-the-art framework of **Discrete Schrödinger Bridges (SB)**. This approach formally recasts the refinement process as an **Entropic Optimal Transport (EOT)** problem: finding the most efficient probabilistic path to transform the current solution distribution into the target distribution proposed by the Planner. This aligns perfectly with the FEP's objective of minimizing surprise. The iterative refinement loop becomes a series of learned diffusion steps, efficiently guiding the solution state toward a stable, low-energy attractor. The recent introduction of efficient solvers like **DLightSB** provides a validated, concrete implementation path for this core module.

## Architectural Roadmap

Kenshō is a multi-phase research program to progressively increase the sophistication of the Refiner's computational substrate. The Schrödinger Bridge framework is general enough to serve as the implementation for each stage.

*   **Version 1.0: Algorithmic Refinement:** The initial implementation establishes the core HMR framework with a Transformer-based Refiner, validating the baseline iterative refinement process.
*   **Version 1.5: Geometric Refinement - Sheaf Neural Networks:** The Refiner is upgraded to a **Sheaf Neural Network (SNN)**, transforming Kenshō into a graph-native reasoning engine. The refinement process becomes a form of **Neural Sheaf Diffusion**, allowing the model to reason over complex relational data.
*   **Version 2.0: Higher-Order Dynamics - Simplicial Message Passing:** The Refiner is extended to operate on **simplicial complexes**, enabling Kenshō to reason about systems with complex, multi-way constraints.

## Principled Training and Analysis

The Kenshō framework integrates modern techniques to guide the learning process and, crucially, to understand the resulting models.

*   **Training the Model: Topological Regularization:** Loss functions are derived from Topological Data Analysis (TDA). By adding terms that penalize or encourage specific topological features (e.g., the number of loops or connected components) in the model's output, we can directly teach the model to produce solutions with the correct global structure.
*   **Analyzing the Model: Microscope for Emergent Cognition:** To understand *how* Kenshō learns to process information, advanced analysis techniques are used: they are **explicitly separate from the model's architecture and training loop**. These are post-hoc interpretability tools, not components of the model itself. By treating the iterative refinement process as a discrete dynamical system, we can use methods from TDA, such as persistent homology, to map the trajectories of the model's internal states. This serves as a "microscope" to visualize the "shape" of the learned dynamics, identify stable attractors, and diagnose the model's reasoning process, providing unprecedented insight into its emergent cognitive strategies.

## High-Performance Implementation

This agenda is made feasible by a modern tech stack:

*   **Performance on the GPU:** Custom compute kernels for the core morphic refiners are written in **Triton**, a Python-based language that compiles to highly efficient GPU code.
*   **Safety and Speed on the CPU:** Data loading pipelines and the main training loop are driven by **Rust**, providing memory safety and C-like performance for data orchestration.
*   **Seamless Integration:** The system is built on **PyTorch**, with **PyO3** and **Maturin** creating a single, easy-to-install Python package that bridges the Python ML ecosystem and the high-performance Rust core.

## Foundational Inspiration

If this architecture stands at all, it is upon the shoulders of giants.  

  * **Hierarchical & Recursive Reasoning (HRM):**
      * *A Neuroscience-Inspired, Parameter-Efficient Artificial Intelligence Architecture for Enhanced Reasoning Performance on Complex Benchmarks with Minimal Training Data.*
      * [https://arxiv.org/abs/2506.21734](https://arxiv.org/abs/2506.21734)

  * **Hierarchical & Recursive Reasoning (TRM):**
      * *Less is More: Recursive Reasoning with Tiny Networks* by Alexia Jolicoeur-Martineau.
      * [https://arxiv.org/abs/2510.04871](https://arxiv.org/abs/2510.04871)

  * **Probabilistic Propagation (Discrete Schrödinger Bridges):**
      * *Entering the Era of Discrete Diffusion Models: A Benchmark for Schrödinger Bridges and Entropic Optimal Transport.*
      * [https://arxiv.org/abs/2509.23348](https://arxiv.org/abs/2509.23348)

  * **Cognitive Plausibility (Fast, Flat Simulation):**
      * *People use fast, flat goal-directed simulation to reason about novel problems.*
      * [https://arxiv.org/abs/2510.11503](https://arxiv.org/abs/2510.11503)

  * **Hardware Realization (Spintronics):**
      * *Field Free Spin-Orbit Torque Controlled Synapse and Stochastic Neuron Devices for Spintronic Boltzmann Neural Networks.*
      * [https://arxiv.org/abs/2510.05616](https://arxiv.org/abs/2510.05616)

  * **Probabilistic Propagation (Continuous Schrödinger Bridges):**
      * *Probabilistic Super-Resolution for Urban Micrometeorology via a Schrödinger Bridge.*
      * [https://arxiv.org/abs/2510.12148](https://arxiv.org/abs/2510.12148)

## Status

This work is in the initial research and development phase.  
The immediate goal is to build and validate the **Version 1.0** HMR architecture on established reasoning benchmarks.  

## Contributing

Contributions are welcome. Please open an issue to discuss potential changes or new features before submitting a pull request.
