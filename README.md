rainfall
========

My small and simple solution to the Palantir programming challenge in Haskell. The algorithm is purely functional,
so Haskell was a natural choice. As a result, the code is extremely short (64 lines, including comments).

The challenge: You are given a matrix of heights, and you assume that water flows over this heightmap in such a way that
water currently in one cell always flows to the neighboring cell of least height. Assume that the provided matrix
is such that there are no ambiguities in this process. Morever, assume each cell has only four neighbors (E,W,N,S).

A sink is a cell with the property that water never flows away from it. The cells which drain water ultimately into a given
sink are said to form a basin. Observe that the map is thereby partitioned into basins. Determine the sizes of all basins.
