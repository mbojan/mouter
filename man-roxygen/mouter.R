# As an array
a <- mouter(
  A = c(a=1, b=2) / 3,
  M = matrix(1:4 / 10, 2, 2, dimnames=list(D=letters[5:6], E=letters[7:8])),
  B = c(c=2, d=3) / 5,
  retval="a"
)

str(a)

# Data frame
mouter(
  A = c(a=1, b=2) / 3,
  M = matrix(1:4 / 10, 2, 2, dimnames=list(D=letters[5:6], E=letters[7:8])),
  B = c(c=2, d=3) / 5,
  retval="df"
)
