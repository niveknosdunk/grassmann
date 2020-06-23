This repo contains MATLAB files used to perform persistent homology calculations on samples of points in various Grassmann manifolds.

g24.m: generate random points on the Grassmannian of 2-planes in R^4, embedded in R^16 as the space of symmetric, idempotent 4 x 4 matrices of trace 2.

g24schubert.m: generate random points on the Grassmannian of 2-planes in R^4, but biased to select 5% of points from the 1-cell, 15% of points from each 2-cell, 25% of points from the 3-cell, and 40% of points from the 4-cell (the "cells" are those in the Schubert cell decomposition).

These two files also include code to compute persistence in MATLAB using the Javaplex package. Witness complexes are used in g24schubert.m.

SO3.m: generate random 3 x 3 orthogonal matrices of determinant 1. This space, SO(3), is diffeomorphic to RP^3 = G_1(R^4).

RP2.m: generate random points on the surface RP^2 embedded in R^4.

RP2iso.m: generate random points on the surface RP^2 isometrically embedded in R^5.

The output .txt files of these three .m files can then be passed to Eirene, Ripser, or another software package for computing Vietoris-Rips persistence.

g24_5000schubertcorrect.txt: 5000 points on G_2(R^4) computed using g24schubert.m

g24_landmarks-correct.txt: 100 landmark points such that the resulting witness complex computes the correct homology of G_2(R^4)

