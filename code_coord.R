library(tidyverse)
library(ggthemes)
library(gcookbook)

#--------------------------------------------------------------
# coordinates : coord_cartesian
#--------------------------------------------------------------
p <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(alpha = 0.6) +
  geom_smooth()

p + scale_x_continuous(limits = c(4.5, 5.5)) # scale_x_continuous
p + xlim(c(4.5, 5.5)) # xlim
p + coord_cartesian(xlim = c(4.5, 5.5)) # coord_cartesian

#--------------------------------------------------------------
# coordinates : coord_flip
#--------------------------------------------------------------
jeonpo <- read_csv("data/cafe_jeonpo.csv")

# 데이터저널리즘 기사는 데스크탑에만 보는게 아니죠. 그럴때 coord_flip!
ggplot(jeonpo, aes(x = reorder(name, -`2017`), y = `2017`)) +
  geom_bar(stat = "identity") +
  theme_fivethirtyeight(base_family = "NanumGothic") +
  scale_y_continuous(labels = scales::comma)

# coord_flip은 모바일에서 보여줄 때 효과적이다
jeonpo %>% 
  filter(category == "카페" | category == "디저트" | category == "가게") %>% 
ggplot(aes(x = reorder(name, `2017`), y = `2017`, fill = category)) +
  geom_bar(stat = "identity") +
  theme_fivethirtyeight(base_family = "NanumGothic") +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "부산 전포동 공시지가 비교", 
       subtitile = "카페, 디저트, 가게 중심으로", 
       caption = "출처 : 정보공개청구") +
  coord_flip()

#--------------------------------------------------------------
# coord_fixed()
#--------------------------------------------------------------

fixed <- ggplot(marathon, aes(x=Half, y=Full)) + geom_point()
fixed2 <- fixed + coord_fixed()

gridExtra::grid.arrange(fixed, fixed2)

#--------------------------------------------------------------
# tips : label 수정
#--------------------------------------------------------------
hwp <- ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point()
hwp

hwp + scale_y_continuous(breaks = c(50, 56, 60, 66, 72), 
                         labels = c("Seoul", "Busan", "Gwang-ju", "Ulsan", "Daejeon"))

# custom을 위해서는 함수를 만들어야 가능 or scales패키지 기능 사용
# 1 inch = 2.54cm

formatter <- function(x) {
  cm <- x * 2.54
  return(paste(cm, "cm", sep=""))
}
formatter(70)

hwp + scale_y_continuous(labels = formatter)

#--------------------------------------------------------------
# facet : facet_grid  & facet_wrap
#--------------------------------------------------------------
t <- ggplot(mpg, aes(x = cty, y = hwy)) + 
  geom_point()

t + facet_grid(. ~ fl) # 열을 기준으로 grid 구분
t + facet_grid(fl ~ .) # 행을 기준으로 grid 구분
t + facet_grid(year ~ fl) # 행은 연도 열은 fl을 기준으로 grid 구분
t + facet_wrap(~fl) # 열을 기준으로 multi charts
t + facet_wrap(~fl) # 열을 기준으로 multi charts

#--------------------------------------------------------------
# facet실습
#--------------------------------------------------------------
cafe <- read_csv("data/cafe.csv")
head(cafe)

# dates를 열을 기준으로 나눠보자
ggplot(cafe %>% gather("dates", "value", 2:7), 
       aes(x=행정구역, y=value, fill=dates)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_fivethirtyeight(base_family = "NanumGothic") +
  facet_grid(.~dates)

# dates를 열을 기준으로 나눠보자
ggplot(cafe %>% gather("dates", "value", 2:7), 
       aes(x=행정구역, y=value, fill=dates)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_fivethirtyeight(base_family = "NanumGothic") +
  facet_wrap(~dates, scales = "free")

# dates를 열을 기준으로 나눠보자
ggplot(cafe %>% gather("dates", "value", 2:7), 
       aes(x=행정구역, y=value, fill=dates)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_fivethirtyeight(base_family = "NanumGothic") +
  facet_wrap(~행정구역, scales = "free", ncol = 5, labeller = label_both)

# 스스로 만들어봅시다
df_bus <- read_csv("data/bus.csv")

  

