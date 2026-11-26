# Power System Analysis — MATLAB Experiments

A student engineering repository containing MATLAB programs and experiment material for Power Systems I and II. The repository includes network-matrix exercises, load-flow programs and a separate collection of numbered Power Systems II experiments.

**Author:** Hari Prasad L S  
**Department:** Electrical and Electronics Engineering  
**Institution:** Saveetha School of Engineering, SIMATS

> This repository is an educational work in progress. The scripts have not all been independently executed or benchmarked as part of this documentation update. Numerical outputs should be treated as unverified until reproduced in MATLAB.

## Repository map

### Root MATLAB programs

| File | What the current source does |
|---|---|
| `expno1.m` | Builds and displays a bus-admittance matrix (Ybus) from interactive line inputs |
| `expno2.m` | Builds Ybus from interactive line inputs and calculates Zbus using matrix inversion |
| `expno3a.m` | Collects element/node incidence choices and displays a reduced bus-incidence matrix |
| `expno3b.m` | Collects element/loop incidence choices and displays a loop-incidence matrix |
| `expno4a.m` | Collects node/branch incidence and direction choices and displays the resulting matrix |
| `expno4b.m` | Collects branch/cutset incidence and direction choices and displays the cutset matrix |
| `expno5.m` | Contains a fixed three-bus Gauss–Seidel load-flow function |
| `expno6.m` | Contains a fixed three-bus Newton–Raphson load-flow implementation |

### Power Systems II material

The `POWERSYSTEM 2/` directory contains numbered experiment folders (for example, `EXP1`, `EXP 2`, `EX 4` and subsequent `EX` folders), with code, calculation material, and selected README or Simulink-related files. Two PDF documents are also stored at the repository root.

Folder names and contents are retained as they currently exist. The experiment collection has not yet been normalised into a single numbered index; check each folder before assuming an experiment is present or complete.

## Requirements

- MATLAB (a recent release is recommended).
- Simulink only for experiments that specifically use Simulink models.
- Some programs use interactive Command Window input; follow each prompt in sequence.

No third-party MATLAB toolbox dependency has been established for the root scripts from this source review.

## Getting started

Clone the repository:

```bash
git clone https://github.com/lshariprasad/PowerSystem---1-and-2-Matlab-.git
cd PowerSystem---1-and-2-Matlab-
```

Open MATLAB, set the Current Folder to the cloned repository, and run one root script at a time:

```matlab
expno1
expno2
expno3a
expno3b
expno4a
expno4b
```

The load-flow source files contain function definitions. Open `expno5.m` and `expno6.m` to inspect their function/code entry points and follow the MATLAB function/file naming requirements before execution.

## Technical notes and validation status

This section records limitations found during a source inspection; it is not a claim that the programs have passed MATLAB testing.

- `expno1.m` and `expno2.m` accept line data interactively. Check bus numbering, nonzero line impedance, input units and line-charging conventions when entering a case.
- `expno2.m` calculates `inv(Ybus)`. Matrix inversion requires a nonsingular Ybus; a disconnected or otherwise singular network will fail.
- `expno3a.m`, `expno3b.m`, `expno4a.m` and `expno4b.m` are separate interactive incidence-matrix exercises. Their matrix orientation and sign convention should be checked against the relevant experiment statement before comparing results.
- `expno5.m` uses a hard-coded three-bus network and load data. It prints bus voltages, but the source does not report a final non-convergence warning if the iteration limit is reached.
- `expno6.m` uses a hard-coded three-bus case. Its bus data, Jacobian construction, PV-bus treatment and convergence output should be independently checked before relying on its numerical results.
- The README previously contained five-bus convergence tables and advanced-module descriptions that were not traceable to the eight root MATLAB files inspected. Those numerical tables and unsupported completion claims are intentionally not reproduced here.

## Suggested verification checklist

Before presenting a numerical result in a report or portfolio:

1. Record the exact MATLAB release and the input case.
2. Run the script from a clean MATLAB session.
3. Check matrix dimensions, bus numbering and sign conventions.
4. For Ybus, verify symmetry where the network is reciprocal and inspect row sums against the adopted shunt model.
5. For Zbus, verify that the matrix is nonsingular and check `Ybus * Zbus` is approximately the identity matrix.
6. For load flow, verify the final power mismatches, bus constraints and convergence status.
7. Save the input data, command-window output and plots alongside the experiment.

## Development priorities

- Add a verified experiment index for the existing `POWERSYSTEM 2/` folders.
- Standardise filenames and add concise READMEs for each experiment.
- Add reproducible input cases and expected outputs only after MATLAB execution.
- Review and test the Gauss–Seidel and Newton–Raphson implementations.
- Add automated checks for matrix dimensions, symmetry and numerical residuals where practical.

## References

Use the textbooks, lecture notes and experiment sheets prescribed by the course. Cite the exact source and edition used when documenting equations or numerical test cases.

## License and reuse

No explicit open-source license file was identified during this source review. Until a license is added by the repository owner, do not assume that the code is licensed for unrestricted reuse or redistribution.

---

[GitHub profile](https://github.com/lshariprasad)
