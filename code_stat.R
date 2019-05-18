library(tidyverse)

#----------------------------------------------------
# 독립적으로 데이터를 통계내서 시각화 해주는 함수
#----------------------------------------------------
# 기본적인 statistics를 알아보자
a <- ggplot(mpg, aes(hwy))
f <- ggplot(mpg, aes(cty, hwy))
g <- ggplot(mpg, aes(class, hwy))

# stat_bin = geom_histogram (1차원 변수)
a + stat_bin()

# stat_bin2d (2차원 변수)
f + geom_bar(stat = "identity")
f + stat_bin2d(bins = 30, drop = TRUE)
f + stat_density2d(contour = TRUE, n = 100)

# 비교 목적
g + stat_boxplot()
g + stat_ydensity(adjust = 1, kernel = "gaussian", scale = "area")

#-----------------------------------------------------------
# 모든 레이어에 color aesthethics가 상속 
#-----------------------------------------------------------
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  theme(legend.position = "none")

# point layer에만 color aesthetics 적용
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(method = "lm", se = FALSE) +
  theme(legend.position = "none")

# 간혹 레이어를 구별하고 싶다면 aes에 예외적으로 이름을 줄 수 있음  
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(method = "loess", se = FALSE, aes(color = "loess")) +
  geom_smooth(method = "lm", se = FALSE, aes(color = "lm")) +
  labs("method")
