# Variant summary cross-check in R.

variants <- read.csv(file.path("data", "variants.csv"), stringsAsFactors = FALSE)

valid_bases <- c("A", "C", "G", "T")

variants$valid_ref_alt <- variants$reference %in% valid_bases & variants$alternate %in% valid_bases
variants$positive_position <- variants$position > 0
variants$alternate_depth_valid <- variants$alternate_depth <= variants$read_depth
variants$passes_depth_threshold <- variants$read_depth >= 10
variants$variant_allele_frequency <- variants$alternate_depth / variants$read_depth
variants$passes_basic_validation <- (
  variants$valid_ref_alt &
    variants$positive_position &
    variants$alternate_depth_valid &
    variants$passes_depth_threshold
)

print(round(variants, 5))
