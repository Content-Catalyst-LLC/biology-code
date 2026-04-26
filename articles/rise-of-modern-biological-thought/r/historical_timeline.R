# Historical timeline summary in R.

timeline_path <- file.path("data", "historical_milestones.csv")
if (!file.exists(timeline_path)) {
  timeline_path <- file.path("..", "data", "historical_milestones.csv")
}

timeline <- read.csv(timeline_path)

timeline$century <- floor((timeline$year - 1) / 100) + 1

domain_summary <- aggregate(
  year ~ domain,
  data = timeline,
  FUN = function(x) c(first_year = min(x), last_year = max(x), n = length(x))
)

print(timeline[order(timeline$year), ])
print(domain_summary)
