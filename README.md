## Kenshō
**見性 (Kenshō)** _(n)_: An initial flash of insight, followed by training that deepens into enlightenment.

A prototype implementation of the Hierarchical Recursive Refinement model, initially using Python and Triton.
This is a novel AI model designed for efficient, deep reasoning.  
The project combines high-performance kernels for GPU execution with PyTorch for data pipelines and orchestration.
After the concept is proven, the intent is to port from PyTorch to Rust (perhaps with PyO3 and tch-rs).

## Concept
Modern AI has been dominated by scaling up large, general-purpose models. While powerful, these models can be inefficient and struggle with tasks requiring deep, structured reasoning.  
Kensho explores an alternative path focused on architectural elegance and computational efficiency.

This approach, Hierarchical Recursive Refinement (HRR), is a synthesis of two groundbreaking ideas:
1.  **The Hierarchical Reasoning Model (HRM):** A brain-inspired architecture that uses two modules—a high-level "planner" and a low-level "executor": to solve problems hierarchically. This structure is incredibly data-efficient and excels at tasks requiring symbolic reasoning. [1, 2]

2.  **The Tiny Recursive Model (TRM):** A minimalist architecture that introduced a breakthrough in training. Instead of making assumptions about the model's internal state, TRM uses full backpropagation through its recursive steps. This allows a much smaller model to achieve superior generalization by learning to iteratively refine its own answers. [3]

**Kensho implements HRR by combining these strengths:** It uses the strategic planner/executor structure of HRM but replaces the core execution mechanism with the more powerful and theoretically robust iterative refinement loop from TRM. The result is a model designed to "think" with both strategic depth and iterative precision.

## Inspiration & Further Reading
The HRR architecture is directly inspired by the following research. A full understanding of these papers is highly recommended for contributors.
  * **Hierarchical Reasoning Model (HRM):**
      * *A Neuroscience-Inspired, Parameter-Efficient Artificial Intelligence Architecture for Enhanced Reasoning Performance on Complex Benchmarks with Minimal Training Data.*
      * [https://arxiv.org/abs/2506.21734](https://arxiv.org/abs/2506.21734) [4]

  * **Tiny Recursive Model (TRM):**
      * *Less is More: Recursive Reasoning with Tiny Networks* by Alexia Jolicoeur-Martineau.
      * [https://arxiv.org/abs/2510.04871](https://www.google.com/search?q=https://arxiv.org/abs/2510.04871) [5, 6]

## Project Status
This project is in the initial research and development phase. The immediate goal is to build a working prototype that can validate the HRR architecture on established reasoning benchmarks.

## Getting Started
**TODO**

## Contributing
Contributions are welcome. Let's make it happen.  
Please open an issue to discuss your plans before submitting your first pull request.

### TODO List
- [] Create repo structure
- [] Configure prototype Python env, e.g. `pyproject.toml`
- [] Declare core dependencies
- [] Write kernel tests in `tests/test_kernels.py`
- [] Implement `kernels/refiner_kernel.py` with Triton
- [] Implement `kernels/planner_kernel.py`
- [] Create PyTorch model in `/pykensho`
- [] Create `RefinerModule(nn.Module)` in `model.py` to use `forward` to call the kernel
- [] Create `PlannerModule(nn.Module)` along the same lines
- [] Create `HRRModel(nn.Module)`, one planner step followed by _N_ refiner steps, all within the `forward` pass to enable backprop
- [] Create training rig at `pykensho/data.py`, initially using the sapientinc/HRM Sudoku training set
- [] Create something like `scripts/train.py`, standard PyTorch training loop. Instantiate the HRRModel, the optimizer, and the data loader, and then iterate through epochs
- [] Train the model on a small dataset to ensure the pipeline works and the loss decreases
- [] Goal: Replicate the performance claims of TRM on a benchmark
