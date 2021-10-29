

dt <- fread("G:/My Drive/sample_data/")
dt <- dt[series_name%in%c("advance retail sales", "gdp constant prices", "initial jobless claims", "t bill spread 10y 3m")]
dt[ , ref_date := as.Date(ref_date)]
dt[ , pub_date := as.Date(pub_date)]
dt <- dt[ref_date >= as.Date("2000-01-01") & pub_date <= as.Date("2021-02-26")]

tail(dt[series_name == "advance retail sales"])
tail(dt[series_name == "gdp constant prices"])
tail(dt[series_name == "initial jobless claims"])
tail(dt[series_name == "t bill spread 10y 3m"])


bob <- dt[series_name == "t bill spread 10y 3m" & ref_date >= as.Date("2021-01-01")]


dtMF <- process_MF(dt[series_name == "gdp constant prices"], dt[series_name != "gdp constant prices"])

dt_wide <- dcast(dtMF, ref_date ~ series_name)



fredlib$series_name

fredlib[series_name == "initial jobless claims", detrend := 0]
fredlib[ , detrend := 1]

fred <- dt
save(fred, file = "~/dateutils/data/fred.RData")




dt <- process_MF(fred[series_name == "gdp constant prices"], fred[series_name != "gdp constant prices"])


X <- dcast(dt, ref_date ~ series_name)

dt <- process(fred, fredlib)

bob <- try_trend(fred[series_name == "initial jobless claims"]$value)

ts.plot(log(fred[series_name == "initial jobless claims"]$value))

ts.plot(dt[series_name == "initial jobless claims"]$value)


dtQ <- process_MF(fred[series_name == "gdp constant prices"], fred[series_name != "gdp constant prices"]) #quarterly mixed frequency
dtQ <- process(dtQ, fredlib)

ts.plot(dtQ[series_name == "initial jobless claims 0"]$value)

dtQ <- process_MF(fred[series_name == "gdp constant prices"], fred[series_name != "gdp constant prices"]) #quarterly mixed frequency
dtW <- dcast(dtQ, ref_date ~ series_name, value.var = "value")
dtQ <- process(dtW, fredlib)

fredlib

# ---- error cases --------

lib <- fredlib
lib[series_name == "advance retail sales" , needs_SA := 1]
lib
bob <- process(fred, lib)


library(devtools)
load_all("~/dateutils")




