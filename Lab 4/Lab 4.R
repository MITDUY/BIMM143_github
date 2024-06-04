#' ---
#' title: "BIMM 143 Lab 4"
#' author: "Yi-Hung Lee (PID: A16587141)"
#' date: "April 11rd, 2014"
#' ---
#' 
x <- seq(1, 20, by = 0.01)
y = sin(x)
y2 = cos(x)
plot(x, y, type = "h", col = "green", lwd = 3, main = "Sin + Cos wave", xlab = "x val
     ue", ylab = "sin(x) value")
lines(x, y2, type = "h", col = "pink", lwd = 3)

lines(x, y, type = "l", col = "blue", lwd = 3)
lines(x, y2, type = "l", col = "red", lwd = 3)