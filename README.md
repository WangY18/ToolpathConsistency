# ToolpathConsistency

[![License](https://img.shields.io/github/license/WangY18/ToolpathConsistency)](https://mit-license.org/)

## Introduction

This repository contains the open-source <u>numerical benchmarks for testing the <mark>**consistency**</mark> of your given path smoothing or trajectory planning methods</u>. The consistency is a <mark>**surface-centric**</mark> evaluation that considers toolpaths and trajectories as a whole surface in CNC machining (specifically, single-point milling).

For the example shown in the following figure, we can see that some *single tool marks* (inconsistencies in surface quality of the machined surface) exist due inconsistencies in toolpaths' position (see c2) and trajectories' feedrate (see d2).

![BenzMold_consistency](https://github.com/user-attachments/assets/2983a784-f576-4fd1-a471-94a8f9fdf8bd)

<center>Fig. The consistency can lead to single tool marks.</center>

[Our paper](https://doi.org/10.1016/j.rcim.2024.102873) reasoned that the main causes of inconsistencies is the sensitivity of path smoothing or trajectory planning to the cutter pose points. In the following figure, two adjacent input fold-paths (G01 block) are smoothed into totally different toolpaths through most existing methods.

![Inconsistency_toolpaths](https://github.com/user-attachments/assets/f563b1e0-f359-4905-9342-31a040116d7b)

<center>Fig. Most existing methods are sensitivity to cutter pose points. Hence, they are inconsistent.</center>

## Citation

Please cite the following reference:

```
Wang Y, Hu C, Li Z, et al. On the consistency of path smoothing and trajectory planning in CNC machining: a surface-centric evaluation[J]. Robotics and Computer-Integrated Manufacturing, 2024. (Accepted)
```

or in BiBTeX:

```tex
@article{wang2024consistency,
  title={On the consistency of path smoothing and trajectory planning in CNC machining: a surface-centric evaluation},
  author={Wang, Yunan and Hu, Chuxiong and and Li, Zeyang and He, Zhirui and Lin, Shiwen and Wang, Yushuo and Lin, Shize and Yu, Jichuan and Jin, Zhao and Zhu, Yu},
  journal={Robotics and Computer-Integrated Manufacturing},
  volume={},
  pages={},
  year={2024},
  publisher={Elsevier}
}
```

## How to Use `ToolpathConsistency`

Five benchmarks are provided in this repository:

+ Segment with Strong Noise (SwSN)
+ Segment with Weak Noise (SwWN)
+ Corner Splitting (CS)
+ Segment to Sine Curve (S2SC)
+ Mercedes-Benz Mold (MBM)

<img src="https://github.com/user-attachments/assets/b2b68e3a-8c59-4b64-ac73-3eb06c8a0109" alt="benchmarks_demo" style="zoom: 33%;" />

<center>Fig. Benchmarks. (a) SwSN and SwWN. (b) CS. (c) S2SC.</center>

<img src="https://github.com/user-attachments/assets/904e62ae-c86c-4b5c-a4ed-017127e24ab0" alt="BenzPattern" style="zoom:50%;" />

<center>Fig. Benchmark MBM.</center>

See `demo_*.m` and [our paper](https://doi.org/10.1016/j.rcim.2024.102873) for details.

## Results in Demos

![BencmarksSimulation_Curvature](https://github.com/user-attachments/assets/3c8f57a6-be86-4bfe-9b1b-0ee7080fcf69)

<center>Fig. Results in demos.</center>