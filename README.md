# ⚡ Power System Analysis — MATLAB Implementation Suite

<div align="center">

![MATLAB](https://img.shields.io/badge/MATLAB-R2018b%2B-orange?style=for-the-badge&logo=mathworks&logoColor=white)
![Domain](https://img.shields.io/badge/Domain-Power%20Systems-blueviolet?style=for-the-badge&logo=lightning&logoColor=white)
![Status](https://img.shields.io/badge/Status-Active%20Development-success?style=for-the-badge)
![License](https://img.shields.io/badge/License-Educational-blue?style=for-the-badge)
![Contributions](https://img.shields.io/badge/Contributions-Welcome-brightgreen?style=for-the-badge)
![Stars](https://img.shields.io/github/stars/lshariprasad/PowerSystem---1-and-2-Matlab-Public?style=for-the-badge&color=yellow)
![Last Commit](https://img.shields.io/github/last-commit/lshariprasad/PowerSystem---1-and-2-Matlab-Public?style=for-the-badge)
![Repo Size](https://img.shields.io/github/repo-size/lshariprasad/PowerSystem---1-and-2-Matlab-Public?style=for-the-badge)

<br/>

> **A rigorous, lab-grade MATLAB codebase implementing foundational and advanced Power System Analysis algorithms — from network matrix formation to load flow convergence, fault computation, and optimal economic dispatch.**

<br/>

[📖 Overview](#-overview) • [🧠 Theory](#-theoretical-background) • [🧪 Experiments](#-experiments) • [▶️ Getting Started](#️-getting-started) • [📊 Results](#-sample-results) • [🚀 Roadmap](#-roadmap) • [🤝 Contributing](#-contributing) • [📜 License](#-license)

</div>

---

## 📖 Overview

This repository is a comprehensive MATLAB implementation suite for **Power System Analysis**, structured to mirror the canonical curriculum of B.E./B.Tech Electrical Engineering programs while targeting industry-relevant depth. Each experiment is independently executable, numerically verified, and documented with inline comments.

The suite spans:

- **Network Modeling** — Formation of system matrices from primitive network data
- **Load Flow Analysis** — Iterative solvers for steady-state voltage/angle profiles
- **Fault Analysis** — Symmetrical and unsymmetrical fault current computation
- **Stability Studies** — Transient stability using swing equation integration
- **Optimization** — Economic dispatch with λ-iteration and merit order loading
- **Control** — Load Frequency Control (LFC) for single and multi-area systems
- **Estimation** — Weighted Least Squares (WLS) State Estimation

This project is suited for university lab coursework, interview preparation for core power sector roles, and as a reference baseline for research.

---

## 🧠 Theoretical Background

A brief mathematical grounding for each major module:

### 🔷 Ybus Formation — Nodal Admittance Matrix

The bus admittance matrix **Y_bus** is the fundamental network model used in all load flow and fault studies.

```
Y_bus = A · y · Aᵀ
```

Where:
- `A` — Element-node incidence matrix (n_elements × n_buses)
- `y` — Primitive admittance matrix (diagonal, in per-unit)

For an n-bus system:
- **Diagonal elements:** `Y_ii = Σ y_ij` (sum of all admittances connected to bus i, including shunt)
- **Off-diagonal elements:** `Y_ij = -y_ij` (negative admittance of branch between buses i and j)

### 🔷 Zbus Formation — Bus Impedance Matrix

```
Z_bus = Y_bus⁻¹
```

Built incrementally using the **Kron reduction** algorithm:
1. Add branch from new bus to reference → extend matrix
2. Add branch between existing buses → rank-1 update + Kron reduction
3. Add link (loop-closing branch) → use partial Z_bus column

Critical for symmetrical fault analysis: `I_fault = V_prefault / Z_bus(k,k)`

### 🔷 Gauss-Seidel Load Flow

Iterative voltage update for PQ buses:

```
V_i^(k+1) = (1/Y_ii) · [ (P_i - jQ_i) / conj(V_i^(k)) - Σ(j≠i) Y_ij · V_j ]
```

For PV buses — Q is computed from the scheduled voltage magnitude and angle is updated.

**Convergence criterion:** `max|ΔV| < ε` (typically ε = 1e-6 p.u.)

Acceleration factor `α` (default: 1.6) applied to speed convergence:
```
V_i^(k+1) = V_i^(k) + α · (V_i^(k+1) - V_i^(k))
```

### 🔷 Newton-Raphson Load Flow

Solves the nonlinear power balance equations using Jacobian-based linearization:

```
[ ΔP ]   [ H  N ] [ Δδ        ]
[ ΔQ ] = [ J  L ] [ ΔV/V      ]
```

Where H, N, J, L are 4 sub-matrices of the full Jacobian. Updated each iteration:

```
[Δδ, ΔV/V]ᵀ = J⁻¹ · [ΔP, ΔQ]ᵀ
```

**Quadratic convergence** achieved — doubles correct digits per iteration near solution.

### 🔷 Symmetrical Fault Analysis

Three-phase balanced fault at bus k:

```
I_fault(k) = V_k(prefault) / Z_kk
ΔV_i = -Z_ik · I_fault(k)
V_i(postfault) = V_i(prefault) + ΔV_i
```

### 🔷 Economic Dispatch

Lambda-iteration for equal incremental cost:

```
dC_i/dP_i = λ  (for all online generators)
```

Each generator's incremental cost `IC_i = a_i + 2·b_i·P_i` is set equal to the system lambda.
Solved iteratively while enforcing generator MW limits and total load + loss constraints.

---

## 📁 Repository Structure

```
PowerSystem---1-and-2-Matlab-Public/
│
├── 📂 Matrix_Formation/
│   ├── expno1.m            # Ybus — Bus Admittance Matrix
│   └── expno2.m            # Zbus — Bus Impedance Matrix (Kron reduction)
│
├── 📂 Network_Topology/
│   ├── expno3a.m           # Loop Incidence Matrix (Bf)
│   ├── expno3b.m           # Bus Incidence Matrix (A)
│   ├── expno4a.m           # Branch Path Matrix (K)
│   └── expno4b.m           # Cutset Matrix (C)
│
├── 📂 Load_Flow/
│   ├── expno5.m            # Gauss-Seidel Method
│   ├── expno6.m            # Newton-Raphson Method
│   └── [fast_decoupled.m]  # Fast Decoupled Method (Planned)
│
├── 📂 Fault_Analysis/
│   ├── sym_fault.m         # Symmetrical (3-phase) Fault
│   └── [unsym_fault.m]     # LLG, LL, LG Faults (Upcoming)
│
├── 📂 Advanced/
│   ├── economic_dispatch.m # Lambda-Iteration Economic Dispatch
│   ├── transient_stab.m    # Swing Equation — RK4 Integration
│   ├── lfc_single.m        # Single-Area LFC
│   ├── lfc_two_area.m      # Two-Area LFC with Tie-Line
│   └── state_estimation.m  # WLS State Estimation
│
└── README.md
```

---

## 🧪 Experiments

### 🔹 Module 1 — Matrix Formation

#### `expno1.m` — Bus Admittance Matrix (Ybus)

| Parameter | Description |
|---|---|
| Input | Line data: [From, To, R, X, B/2] in per-unit |
| Output | Complex n×n Y_bus matrix |
| Method | Primitive admittance + incidence-based assembly |
| Validation | Row-sum ≈ shunt admittances for lossless lines |

#### `expno2.m` — Bus Impedance Matrix (Zbus)

| Parameter | Description |
|---|---|
| Input | Network data or pre-formed Ybus |
| Output | Complex n×n Z_bus matrix |
| Method | Direct inversion + Kron reduction |
| Application | Fault level computation, bus coupling analysis |

---

### 🔹 Module 2 — Network Topology

Implements the full graph-theoretic representation of a power network.

| File | Matrix | Dimension | Use Case |
|---|---|---|---|
| `expno3a.m` | Loop Incidence (Bf) | l×n | Mesh analysis |
| `expno3b.m` | Bus Incidence (A) | n×e | Branch-node relationships |
| `expno4a.m` | Branch Path (K) | b×n | Tree identification |
| `expno4b.m` | Cutset (C) | b×e | Network partitioning |

**Key identity verified:** `C · Bfᵀ = 0` (cutset and loop matrices are orthogonal)

---

### 🔹 Module 3 — Load Flow Analysis

#### `expno5.m` — Gauss-Seidel

```
Convergence: O(1) per iteration
Best for: Small systems (<10 buses), educational purposes
Drawback: Slow convergence, sensitive to starting point
```

#### `expno6.m` — Newton-Raphson

```
Convergence: Quadratic (doubles accuracy each iteration)
Best for: Medium to large systems (10–500+ buses)
Typical iterations: 3–6 for convergence to 1e-6 p.u.
```

**Bus type classification used:**

| Bus Type | Known | Unknown |
|---|---|---|
| Slack (Reference) | V, δ | P, Q |
| PV (Generator) | P, V | Q, δ |
| PQ (Load) | P, Q | V, δ |

---

### 🔹 Module 4 — Fault Analysis

#### Symmetrical Fault (`sym_fault.m`)

- Computes prefault Ybus and Zbus from network data
- Applies three-phase balanced fault at specified bus
- Calculates: fault current, bus voltage profile post-fault, fault MVA

#### Unsymmetrical Fault *(Upcoming)*

- **Single Line-to-Ground (SLG):** Uses sequence network coupling — Z1, Z2, Z0 in series
- **Line-to-Line (LL):** Z1 + Z2 in series with phase shift
- **Double Line-to-Ground (DLG):** Z2 ∥ Z0 in series with Z1

---

### 🔹 Module 5 — Advanced Studies

#### Economic Dispatch (`economic_dispatch.m`)

- Cost function: `C_i(P_i) = a_i + b_i·P_i + c_i·P_i²` (₹/hr or $/hr)
- Lambda iteration with generator limit enforcement
- Outputs: optimal dispatch schedule, system lambda, total cost

#### Transient Stability (`transient_stab.m`)

- Solves the swing equation using **4th-order Runge-Kutta**:
  ```
  M·d²δ/dt² = Pm - Pe·sin(δ)
  ```
- Plots δ-t curve and determines Critical Clearing Time (CCT)
- Supports multi-machine systems via SMIB equivalent

#### Load Frequency Control

| Module | Area Config | Features |
|---|---|---|
| `lfc_single.m` | Single area | Governor, turbine, area control |
| `lfc_two_area.m` | Two area | Tie-line, ACE, PI controller |

#### State Estimation (`state_estimation.m`)

- Weighted Least Squares formulation: `x̂ = (HᵀWH)⁻¹Hᵀ Wz`
- Processes: real/reactive power injections and line flows as measurements
- Outputs: best estimate of bus voltages and angles
- Includes bad data detection via chi-squared test

---

## ▶️ Getting Started

### ✅ Prerequisites

| Requirement | Details |
|---|---|
| MATLAB Version | R2018b or later (R2022a+ recommended) |
| Toolboxes | None required (core MATLAB only) |
| Knowledge Base | Power Systems I & II, Linear Algebra, Numerical Methods |
| Optional | Simulink (for LFC simulation diagrams) |

### ⚡ Quick Start

```matlab
% Step 1: Clone the repository
% git clone https://github.com/lshariprasad/PowerSystem---1-and-2-Matlab-Public

% Step 2: Navigate to the directory
cd('PowerSystem---1-and-2-Matlab-Public')

% Step 3: Add all subfolders to MATLAB path
addpath(genpath(pwd))

% Step 4: Run any experiment
clc; clear; close all;
expno1    % → Ybus Formation
expno5    % → Gauss-Seidel Load Flow
expno6    % → Newton-Raphson Load Flow
```

### 🔧 Modifying Input Data

Each script has a clearly marked **DATA INPUT SECTION** at the top. Example for `expno5.m`:

```matlab
%% ===================== DATA INPUT =====================
% Line Data: [From  To  R(pu)  X(pu)  B/2(pu)]
linedata = [
    1  2  0.02  0.06  0.030;
    1  3  0.08  0.24  0.025;
    2  3  0.06  0.18  0.020;
    2  4  0.06  0.18  0.020;
    2  5  0.04  0.12  0.015;
    3  4  0.01  0.03  0.010;
    4  5  0.08  0.24  0.025;
];

% Bus Data: [Bus  Type  Vsp  delta  Pgen  Qgen  Pload  Qload]
% Type: 1=Slack, 2=PV, 3=PQ
busdata = [
    1  1  1.06  0  0     0     0    0;
    2  2  1.045 0  0.4   0     0.2  0.1;
    3  3  1.0   0  0     0     0.45 0.15;
    4  3  1.0   0  0     0     0.40 0.05;
    5  3  1.0   0  0     0     0.60 0.10;
];
%% =====================================================
```

---

## 📊 Sample Results

### Gauss-Seidel Convergence (5-Bus IEEE)

```
Iteration    Max |ΔV| (p.u.)    Converged?
---------    ---------------    ----------
    1            0.048201          No
    2            0.011734          No
    3            0.003142          No
   ...              ...           ...
   28            0.0000009         YES ✅
```

### Newton-Raphson Convergence (Same System)

```
Iteration    Max Mismatch (p.u.)    Converged?
---------    -------------------    ----------
    1              0.048201            No
    2              0.000521            No
    3              0.000000062         YES ✅
```

> **Newton-Raphson converges in ~3 iterations vs ~28 for Gauss-Seidel** on the same system.

### Load Flow Results (Bus Voltages)

| Bus | Type | V (p.u.) | δ (°) | P_gen (MW) | Q_gen (MVAR) |
|-----|------|----------|-------|------------|--------------|
| 1 | Slack | 1.0600 | 0.000 | 130.78 | −6.93 |
| 2 | PV | 1.0450 | −2.06 | 40.00 | 30.94 |
| 3 | PQ | 1.0100 | −4.64 | — | — |
| 4 | PQ | 1.0175 | −3.80 | — | — |
| 5 | PQ | 1.0200 | −3.42 | — | — |

---

## 🚀 Roadmap

| Milestone | Status | Target |
|---|---|---|
| Ybus / Zbus Formation | ✅ Complete | — |
| Network Topology Matrices | ✅ Complete | — |
| Gauss-Seidel Load Flow | ✅ Complete | — |
| Newton-Raphson Load Flow | ✅ Complete | — |
| Symmetrical Fault Analysis | ✅ Complete | — |
| Economic Dispatch (λ-iteration) | ✅ Complete | — |
| LFC — Single Area | ✅ Complete | — |
| LFC — Two Area | ✅ Complete | — |
| WLS State Estimation | ✅ Complete | — |
| Fast Decoupled Load Flow | 🔄 In Progress | Q3 2025 |
| Unsymmetrical Fault (SLG, LL, DLG) | 🔄 In Progress | Q3 2025 |
| IEEE 14/30/57 Bus Integration | 📅 Planned | Q4 2025 |
| MATLAB App Designer GUI | 📅 Planned | Q4 2025 |
| Python-MATLAB Hybrid Interface | 📅 Planned | 2026 |
| Optimal Power Flow (OPF) | 💡 Conceptual | 2026 |

---

## 🤝 Contributing

Contributions are actively welcomed from students, researchers, and power systems engineers.

### How to Contribute

```bash
# 1. Fork the repository on GitHub

# 2. Clone your fork
git clone https://github.com/<your-username>/PowerSystem---1-and-2-Matlab-Public.git

# 3. Create a feature branch
git checkout -b feature/fast-decoupled-load-flow

# 4. Commit with a descriptive message
git commit -m "feat: add Fast Decoupled Load Flow with B' B'' matrices"

# 5. Push and open a Pull Request
git push origin feature/fast-decoupled-load-flow
```

### Contribution Guidelines

- Follow the existing script structure — **DATA INPUT → COMPUTATION → OUTPUT** sections clearly separated
- Add inline comments for every non-trivial equation referencing the source (textbook/standard)
- Test your implementation against at least one published reference case (e.g., IEEE 5-bus, 14-bus)
- Do not hardcode system-specific data — make inputs configurable at the top of the script
- Open an issue before starting large features to avoid duplication

### Good First Issues

- Add per-unit conversion utility functions
- Add Q-limit checking for PV buses in Gauss-Seidel
- Implement contingency analysis (N-1 security)
- Add IEEE standard bus data files as `.m` input scripts

---

## 📚 References

| # | Reference |
|---|---|
| 1 | Stevenson, W.D. — *Elements of Power System Analysis*, 4th Ed., McGraw-Hill |
| 2 | Glover, Sarma & Overbye — *Power System Analysis and Design*, 6th Ed., Cengage |
| 3 | Bergen & Vittal — *Power Systems Analysis*, 2nd Ed., Prentice Hall |
| 4 | Grainger & Stevenson — *Power Systems Analysis*, McGraw-Hill |
| 5 | Wood, Wollenberg & Sheblé — *Power Generation, Operation and Control*, 3rd Ed., Wiley |
| 6 | IEEE Std 399-1997 — IEEE Recommended Practice for Industrial and Commercial Power Systems Analysis |

---

## 🧑‍💻 Author

<div align="center">

**Hari Prasad L S**
B.E. Electrical & Electronics Engineering
SIMATS Saveetha School of Engineering, Chennai

[![GitHub](https://img.shields.io/badge/GitHub-lshariprasad-181717?style=for-the-badge&logo=github)](https://github.com/lshariprasad)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?style=for-the-badge&logo=linkedin)](https://linkedin.com/in/lshariprasad)

</div>

---

## 📜 License

This project is licensed for **Educational and Non-Commercial Use Only**.

You are free to:
- ✅ Use for university coursework and self-study
- ✅ Fork and extend for academic research
- ✅ Reference in reports with proper attribution

You may not:
- ❌ Use in commercial products or paid consulting without permission
- ❌ Redistribute without attribution

---

## ⭐ Support the Project

If this repository helped you understand Power Systems better:

- ⭐ **Star** the repository
- 🍴 **Fork** and build on top of it
- 🐛 **Open an issue** if you find a bug or have a suggestion
- 📢 **Share** with your classmates and colleagues

---

<div align="center">

*Built with ⚡ for Electrical Engineers who believe in learning by building.*

</div>
