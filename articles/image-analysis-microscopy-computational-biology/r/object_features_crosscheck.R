# Object feature extraction cross-check in R.

pixels <- data.frame(
  object_id = c(rep("cell_01", 5), rep("cell_02", 5)),
  x = c(10, 11, 10, 11, 12, 30, 31, 30, 31, 32),
  y = c(10, 10, 11, 11, 11, 20, 20, 21, 21, 21),
  intensity = c(120, 132, 128, 140, 125, 180, 190, 176, 188, 181)
)

features <- aggregate(
  intensity ~ object_id,
  data = pixels,
  FUN = function(values) c(area = length(values), mean = mean(values), integrated = sum(values))
)

print(features)
