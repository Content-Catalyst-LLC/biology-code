# Stage-structured reproductive projection in R.
#
# This script projects juveniles, subadults, and adults through time,
# estimates dominant eigenvalue growth, calculates stable stage distribution,
# and perturbs adult survival.

projection_matrix <- matrix(c(
  0.0, 0.0, 1.8,
  0.45, 0.0, 0.0,
  0.0, 0.70, 0.82
), nrow = 3, byrow = TRUE)

colnames(projection_matrix) <- c("juvenile", "subadult", "adult")
rownames(projection_matrix) <- c("juvenile", "subadult", "adult")

initial_stage_vector <- c(
  juvenile = 50,
  subadult = 20,
  adult = 15
)

time_steps <- 20

trajectory <- matrix(
  NA_real_,
  nrow = time_steps + 1,
  ncol = length(initial_stage_vector)
)

trajectory[1, ] <- initial_stage_vector

for (time_step in seq_len(time_steps)) {
  trajectory[time_step + 1, ] <- projection_matrix %*% trajectory[time_step, ]
}

trajectory_df <- data.frame(
  time = 0:time_steps,
  juvenile = trajectory[, 1],
  subadult = trajectory[, 2],
  adult = trajectory[, 3]
)

trajectory_df$total <- rowSums(trajectory_df[, c("juvenile", "subadult", "adult")])

print(round(trajectory_df, 2))

eigen_result <- eigen(projection_matrix)
dominant_index <- which.max(Re(eigen_result$values))
lambda <- Re(eigen_result$values[dominant_index])

stable_stage <- Re(eigen_result$vectors[, dominant_index])
stable_stage <- stable_stage / sum(stable_stage)

cat("Dominant lambda:", round(lambda, 4), "\n")
cat("Stable stage distribution:\n")
print(round(stable_stage, 4))

projection_matrix_perturbed <- projection_matrix
projection_matrix_perturbed["adult", "adult"] <-
  projection_matrix_perturbed["adult", "adult"] * 0.90

eigen_perturbed <- eigen(projection_matrix_perturbed)
lambda_perturbed <- max(Re(eigen_perturbed$values))

cat("Lambda after adult survival reduction:", round(lambda_perturbed, 4), "\n")
cat("Change in lambda:", round(lambda_perturbed - lambda, 4), "\n")
