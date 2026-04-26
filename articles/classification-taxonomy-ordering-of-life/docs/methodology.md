# Methodology Notes

## Pairwise p-distance

p_ij = n_ij / L

where n_ij is the number of differing aligned sites and L is alignment length.

## Jukes-Cantor Correction

d_ij = -3/4 log(1 - 4p_ij/3)

The correction is undefined when p >= 0.75.

## Shannon Diversity

H = -sum p_k log(p_k)

where p_k is relative abundance of taxon k.

## Bray-Curtis Dissimilarity

BC_ij = 1 - 2 sum min(x_ik, x_jk) / (sum x_ik + sum x_jk)

## Taxonomic Confidence Score

Q = w_s S + w_m M + w_g G + w_p P - w_u U

where S is sequence similarity, M is morphological support, G is geographic plausibility, P is phylogenetic support, and U is uncertainty penalty.

## Interpretation

The workflows formalize taxonomic comparison and assignment confidence. They do not replace taxonomic expertise, nomenclatural rules, voucher specimens, peer review, or authoritative classification.
