## Kenshō
**見性 (Kenshō)** _(n)_: An initial flash of insight, followed by training that deepens into enlightenment.  

A research implementation of the **Hierarchical Morphic Refinement (HMR)** architecture, a novel framework for building intelligent agents.  
Kenshō is designed to explore a new paradigm of computation that is efficient, structured, and deeply probabilistic.  

This project synthesizes breakthroughs in recursive reasoning with cutting-edge models from computational neuroscience, generative AI, and geometric deep learning.  

## The Vision: A New Foundation for Computation

Modern AI has been defined by scaling large, monolithic models. While powerful, this paradigm is computationally expensive and struggles with tasks requiring deep, structured reasoning or principled uncertainty management.

Project Kensho explores an alternative path. We believe the next frontier of AI lies not in greater scale, but in superior architectural principles grounded in how both natural and artificial systems efficiently process information. This approach is built on three pillars:

1.  **Cognitive Plausibility (The "Why"):** Inspiration is drawn from cognitive science models of human reasoning, which suggest that people approach novel problems using fast, shallow, goal-directed mental simulations, not exhaustive search.[1] The **Planner** module embodies this principle of resource-rationality.
2.  **Probabilistic Propagation (The "How"):** Computation is modeled as a probabilistic process of information propagation. Our **Refiner** module is based on the **Propagator Model**, a class of generative models (like Schrödinger Bridges) that learn to efficiently transform an incomplete or low-resolution state into a refined, high-resolution state through a learned diffusion process.[1]
3.  **Hardware Realization (The "Where"):** This probabilistic, energy-based approach aligns directly with emerging neuromorphic hardware, such as spintronic devices that can perform in-hardware sampling, promising radical gains in energy efficiency over traditional silicon.[1]

## The HMR Architecture: A Propagator-Based Agent

The HMR architecture is a two-level system designed to explicitly model the interaction between goal-directed planning and mechanistic, probabilistic refinement.

1.  **The Planner (Active Inference):** The high-level Planner acts as a probabilistic world model, guided by the Free Energy Principle (FEP). It performs **active inference** to handle uncertainty, seek information, and select policies (sequences of sub-goals) that are expected to minimize future surprise. It embodies the "fast and flat" reasoning of a resource-rational agent.

2.  **The Refiner (Probabilistic Propagator):** The low-level Refiner is the mechanistic substrate that executes the Planner's policies. It is a learned **propagator** that takes the current state of the solution and iteratively refines it by applying a learned diffusion process, efficiently guiding the state toward a stable, low-energy attractor.

## Architectural Roadmap

Kenshō is a multi-phase research program to progressively increase the sophistication of the Refiner's computational substrate.

*   **Version 1.0: Algorithmic Refinement:** The initial implementation establishes the core HMR framework with a Transformer-based Refiner, validating the baseline iterative refinement process.
*   **Version 1.5: Geometric Refinement — Sheaf Neural Networks:** The Refiner is upgraded to a **Sheaf Neural Network (SNN)**, transforming Kensho into a graph-native reasoning engine. The refinement process becomes a form of **Neural Sheaf Diffusion**, allowing the model to reason over complex relational data.
*   **Version 2.0: Higher-Order Dynamics — Simplicial Message Passing:** The Refiner is extended to operate on **simplicial complexes**, enabling Kensho to reason about systems with complex, multi-way constraints.

## Principled Training and Analysis

The Kenshō project integrates modern techniques to guide the learning process and, crucially, to understand the resulting models.

*   **Topological Regularization:** We employ loss functions derived from Topological Data Analysis (TDA). By adding terms that penalize or encourage specific topological features (e.g., the number of loops or connected components) in the model's output, we can directly teach the model to produce solutions with the correct global structure.
*   **Dynamical Systems Analysis:** We treat the iterative refinement process as a discrete dynamical system. After training, we use TDA and persistent homology to analyze the trajectories of the model's internal states. This serves as a "microscope" to visualize the "shape" of the learned dynamics, identify stable attractors, and diagnose the model's reasoning process.

## High-Performance Implementation

This research agenda is made computationally feasible by a modern, performance-first tech stack:

*   **Performance on the GPU:** Custom compute kernels for the core morphic refiners are written in **Triton**, a Python-based language that compiles to highly efficient GPU code.
*   **Safety and Speed on the CPU:** Data loading pipelines and the main training loop are driven by **Rust**, providing memory safety and C-like performance for data orchestration.
*   **Seamless Integration:** The system is built on **PyTorch**, with **PyO3** and **Maturin** creating a single, easy-to-install Python package that bridges the Python ML ecosystem and the high-performance Rust core.

## Foundational Inspiration

The HMR architecture stands on the shoulders of giants. A full understanding of these papers is highly recommended for contributors.

*   **Hierarchical Reasoning Model (HRM):**
    *   *A Neuroscience-Inspired, Parameter-Efficient Artificial Intelligence Architecture for Enhanced Reasoning Performance on Complex Benchmarks with Minimal Training Data*
    *   [https://arxiv.org/abs/2506.21734](https://arxiv.org/abs/2506.21734)

*   **Tiny Recursive Model (TRM):**
    *   *Less is More: Recursive Reasoning with Tiny Networks* by Alexia Jolicoeur-Martineau
    *   [https://arxiv.org/abs/2510.04871](https://arxiv.org/abs/2510.04871)

*   **The Propagator Model:**
    *  *The Art of the Propagator* by Alexey Radul and Gerald Jay Sussman
    *  [https://dspace.mit.edu/handle/1721.1/44215](https://dspace.mit.edu/handle/1721.1/44215)

## Project Status

This project is in the initial research and development phase. The immediate goal is to build and validate the **Version 1.0** HMR architecture on established reasoning benchmarks.

## Contributing

Contributions are welcome. Please open an issue to discuss potential changes or new features before submitting a pull request.
