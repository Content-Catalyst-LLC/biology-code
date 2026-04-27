program biotechnology_risk_kernel
  implicit none

  real :: benefit, harm, uncertainty, reversibility, access_equity, governance
  real :: responsibility
  real :: exposure, magnitude, monitoring, risk, buffer, concern

  benefit = 0.85
  harm = 0.20
  uncertainty = 0.30
  reversibility = 0.60
  access_equity = 0.35
  governance = 0.70

  responsibility = benefit * 0.30 + access_equity * 0.20 + reversibility * 0.20 + governance * 0.15 - harm * 0.10 - uncertainty * 0.05

  exposure = 0.85
  magnitude = 0.75
  uncertainty = 0.80
  monitoring = 0.40
  reversibility = 0.15

  risk = exposure * magnitude * uncertainty
  buffer = monitoring * reversibility
  concern = risk * (1.0 - buffer)

  print *, "responsibility_score=", responsibility
  print *, "ecological_risk=", risk
  print *, "governance_buffer=", buffer
  print *, "net_concern=", concern

end program biotechnology_risk_kernel
