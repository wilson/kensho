## Kenshō
**見性 (Kenshō)** _(n)_: An initial flash of insight, followed by training that deepens into enlightenment.  

An implementation of the **Hierarchical Morphic Refinement (HMR)** architecture, a novel framework for building structured, efficient, and topologically-aware reasoning systems.  

This project synthesizes breakthroughs in efficient AI with cutting-edge techniques from topological and geometric deep learning.  
The implementation pairs high-performance Triton kernels for GPU execution with a memory-safe Rust core for data pipelines and orchestration.  

## The Vision: Beyond Pattern Matching to Structured Reasoning

Modern AI has been defined by scaling large, general-purpose models. While powerful, this paradigm struggles with tasks requiring deep, algorithmic reasoning and often fails to leverage the inherent structure of a problem.

Project Kensho explores an alternative path. The next frontier of AI lies not in greater scale, but in superior architectural principles. This approach is grounded in the language of **category theory**, modeling the process of reasoning as the **composition of learned morphisms**: structure-preserving functions that operate on topologically rich data representations.

This is the core of the **Hierarchical Morphic Refinement (HMR)** architecture: a system that learns not just to transform data, but to do so in a way that respects and leverages the underlying geometry and relational structure of the problem itself.

## The HMR Architecture: A Categorical Approach to Cognition

The HMR architecture is a principled synthesis of several powerful ideas:

1.  **A Hierarchical Framework:** Inspired by the Hierarchical Reasoning Model (HRM), the system uses a dual-module design: a high-level **Planner** morphism sets abstract goals, while a low-level **Refiner** morphism executes detailed, iterative computations.
2.  **Iterative Refinement:** Based on the breakthrough of the Tiny Recursive Model (TRM), the model learns a refinement operator that is applied repeatedly. This process is trained with full backpropagation, enabling superior generalization without making restrictive assumptions about the model's dynamics.
3.  **Geometric and Topological Awareness:** This is Kensho's core innovation. The Refiner is not a simple neural network block; it is a learned morphism that operates on structured spaces. This allows the model to reason about not just vectors, but the relationships, connections, and global shape of the problem domain.

## Architectural Roadmap

Kensho is designed as a multi-phase research program to progressively build and validate the HMR architecture.

### Version 1.0: The Foundation — Algorithmic Refinement

The initial implementation establishes the core HMR framework. The Refiner module will be a standard recurrent Transformer block, trained with full backpropagation as pioneered by TRM. This version will serve as a baseline to validate the model's ability to perform iterative, algorithmic reasoning on sequential and grid-based tasks.

### Version 1.5: Geometric Refinement — Sheaf Neural Networks

This version upgrades the Refiner to a **Sheaf Neural Network (SNN)**. This transforms Kensho from a sequence processor into a true graph-native reasoning engine. The iterative refinement process becomes a form of **Neural Sheaf Diffusion**, a principled method for propagating information across a graph that respects its underlying geometric structure. This allows the model to:
*   Handle heterophilic data (where connected nodes are dissimilar).
*   Avoid common GNN problems like over-smoothing.
*   Learn complex, context-dependent relationships between entities in the problem space.

### Version 2.0: Higher-Order Dynamics — Simplicial Message Passing

The final stage of the vision extends the Refiner to operate on **simplicial complexes**. While graphs model pairwise relationships, simplicial complexes can represent higher-order interactions (triangles, tetrahedra, etc.). By using **Simplicial Message Passing**, Kensho will be able to reason about systems with complex, multi-way constraints, such as those found in molecular dynamics, social systems, and advanced logic.

## A Principled Approach to Training and Analysis

The Kensho project integrates modern techniques to guide the learning process and understand the resulting models.

*   **Topological Regularization:** We will employ loss functions derived from Topological Data Analysis (TDA). By adding terms that penalize or encourage specific topological features (e.g., the number of loops or connected components) in the model's output, we can directly teach the model to produce solutions with the correct global structure.
*   **Dynamical Systems Analysis:** We treat the iterative refinement process as a discrete dynamical system. After training, we will use TDA and persistent homology to analyze the trajectories of the model's latent state. This serves as a "microscope" to visualize the model's "thought process," identify attractors, and understand how it navigates the solution space.

## High-Performance Implementation

This ambitious research agenda is made computationally feasible by a modern, performance-first tech stack:

*   **Performance on the GPU:** Custom compute kernels for the core morphic refiners are written in **Triton**, a Python-based language that compiles to highly efficient GPU code.
*   **Safety and Speed on the CPU:** Data loading pipelines and the main training loop are driven by **Rust**, providing memory safety and C-like performance for data orchestration.
*   **Seamless Integration:** The system is built on **PyTorch**, with **PyO3** and **Maturin** creating a single, easy-to-install Python package that seamlessly bridges the gap between the Python ML ecosystem and the high-performance Rust core.

## Foundational Inspiration

The HMR architecture stands on the shoulders of giants. A full understanding of these papers is highly recommended for contributors.

*   **Hierarchical Reasoning Model (HRM):**
    *   *A Neuroscience-Inspired, Parameter-Efficient Artificial Intelligence Architecture for Enhanced Reasoning Performance on Complex Benchmarks with Minimal Training Data.*
    *   [https://arxiv.org/abs/2506.21734](https://arxiv.org/abs/2506.21734)

*   **Tiny Recursive Model (TRM):**
    *   *Less is More: Recursive Reasoning with Tiny Networks* by Alexia Jolicoeur-Martineau.
    *   [https://arxiv.org/abs/2510.04871](https://www.google.com/search?q=https://arxiv.org/abs/2510.04871)

## Project Status

This project is in the initial research and development phase. The immediate goal is to build and validate the **Version 1.0** HMR architecture on established reasoning benchmarks.

## Contributing

Contributions are welcome. Please open an issue to discuss potential changes or new features before submitting a pull request.
