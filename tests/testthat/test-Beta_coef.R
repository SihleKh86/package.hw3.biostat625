test_that("Beta_coef works", {
  mod5<-Beta_coef(swiss,1,0)
  coef1<-mod5[2]
  coef2<-as.data.frame(coef1)
  coef3<-coef2[1]
  coef4<-as.numeric(as.vector(unlist(coef3)))

  mod6<-lm(Fertility~.,swiss)
  coef_mod6<-coef(mod6)[1:6]
  coef2_mod6<-as.vector(coef_mod6)
  expect_equal(coef4,coef2_mod6)
})
