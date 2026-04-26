# Species-area modeling, uncertainty, and fragmentation scenario.
#
# This script fits S = cA^z on a log-log scale, bootstraps uncertainty in z,
# and compares baseline richness with a 30 percent habitat-area loss scenario.

set.seed(123)

data_path <- file.path("data", "species_area_patches.csv")

if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "species_area_patches.csv")
}

patches <- read.csv(data_path)

fit <- lm(log(richness) ~ log(area), data = patches)

intercept <- coef(fit)[1]
z_est <- coef(fit)[2]
c_est <- exp(intercept)

cat("Estimated c:", round(c_est, 3), "\n")
cat("Estimated z:", round(z_est, 3), "\n")

patches$predicted <- exp(predict(fit, newdata = patches))
patches$residual <- patches$richness - patches$predicted

n_boot <- 2000
boot_z <- numeric(n_boot)

for (b in seq_len(n_boot)) {
  idx <- sample(seq_len(nrow(patches)), replace = TRUE)
  fit_b <- lm(log(richness) ~ log(area), data = patches[idx, ])
  boot_z[b] <- coef(fit_b)[2]
}

cat("Bootstrap z interval:\n")
print(quantile(boot_z, probs = c(0.025, 0.5, 0.975)))

patches$fragmented_area <- patches$area * 0.70
patches$predicted_fragmented <- c_est * patches$fragmented_area^z_est
patches$expected_loss <- patches$predicted - patches$predicted_fragmented

print(
  round(
    patches[
      ,
      c(
        "patch_id",
        "area",
        "richness",
        "predicted",
        "fragmented_area",
        "predicted_fragmented",
        "expected_loss"
      )
    ],
    2
  )
)
