


devtools::install_github("imarkonis/scalegram")
library(scalegram)

library(longmemo) # generate fGn time series
library(RColorBrewer)

set.seed(1)
ts_length = 50000
repl_no = 5 

# Common Stochastic models ----------------------------------------------------- 
# white noise
df_wm = matrix(rnorm(n = ts_length), ncol=repl_no)
# autoregressive model
df_ar1 = matrix(arima.sim(model = list(ar = 0.8), n = ts_length), ncol=repl_no)
# fGn model
df_fgn = matrix(simFGN0(n = ts_length, H = 0.9), ncol=repl_no)

cols = brewer.pal(9,"Set1")[c(1:3)]

layout(matrix(c(1, 1, 2,
                3, 3, 4,
                5, 5, 6), nrow=3, byrow=TRUE))
par(oma=c(0,0,2,0))
#layout.show(n=6)
plot.ts(df_wm[,1], ylab = "White noise", col=cols[3])
acf(df_wm[,1], main=NA,  col=cols[3])
plot.ts(df_ar1[,1], ylab = "AR(1)", col=cols[2]) 
acf(df_ar1[,1], main = NA, col=cols[2])
plot.ts(df_fgn[,1], ylab = "fGn", col=cols[1])
acf(df_fgn[,1], main = NA, col=cols[1])
title("Common Stochastic models (Time series and ACFs)", outer=TRUE)


sc_wn_sd = scalegram(df_wm, stat="sd", threshold = 100, plot = F)
sc_wn_sd$Model = "White\nnoise"

sc_ar1_sd = scalegram(df_ar1, stat="sd", threshold = 100, plot = F)
sc_ar1_sd$Model = "AR(1)"

sc_fgn_sd = scalegram(df_fgn, stat="sd", threshold = 100,  plot = F)
sc_fgn_sd$Model = "FGN"

# compare different autocorrelation structures
sc_stoc_df = data.frame(rbind(sc_wn_sd, sc_ar1_sd, sc_fgn_sd))

gg_sc_stoc_comparison = ggplot(data = sc_stoc_df, 
           aes(x = scale, y = sd, group=interaction(Model, variable))) +
      geom_line(aes(colour =Model), alpha = 0.2, show_guide = FALSE) +
      geom_point(aes(colour =Model), alpha = 0.2, show_guide = FALSE) +
      
      geom_smooth(aes(group=Model), se = FALSE, colour="black", size=1.5)+
      geom_smooth(aes(group=Model), se = FALSE, colour="white")+
      
      geom_tile(aes(fill=Model))+
      scale_y_log10("Standard deviation [-]",
                    labels = trans_format("log10", math_format(10 ^ .x))) +
      scale_x_log10("Aggregation scale [-]",
                    labels = trans_format("log10", math_format(10 ^ .x))) +
      scale_fill_manual("", values = cols) +
      scale_colour_manual("", values = cols) +
      annotation_logticks(sides = "b") +
      theme_bw() +
      theme(panel.grid.minor.x = element_blank(),
            panel.grid.minor.y = element_blank(),
            aspect.ratio = 1)

print(gg_sc_stoc_comparison)

# Other common models ---------------------------------------------------------- 
# linear/deterministic trends
# Equation: y=a*x
lm_df = data.frame(lm1 = -10*(1:ts_length), 
                   lm2 = 10*(1:ts_length))
# random walk
# Equation:                 
rw_df = data.frame(rw1 = cumsum(rnorm(n=ts_length)),
                   rw2 = cumsum(rnorm(n=ts_length)))
                                    
# harmonic fluctuation
#Equation: y=a*sin(b*t)
t = seq(0,4*pi,,ts_length)
a = 3
amp <- 2
hf_df = data.frame(y1 = a*sin(1000*t))

layout(matrix(c(1, 1, 2,
                3, 3, 4,
                5, 5, 6), nrow=3, byrow=TRUE))
par(oma=c(0,0,2,0))
#layout.show(n=6)
plot.ts(lm_df[,1], ylab = "Linear trend", col=cols[3])
acf(lm_df[,1], main=NA,  col=cols[3])
plot.ts(rw_df[,1], ylab = "Random walk", col=cols[2]) 
acf(rw_df[,1], main = NA, col=cols[2])
plot.ts(hf_df[1:1000,1], ylab = "Harmonic fluctuation", col=cols[1])
acf(hf_df[,1], main = NA, col=cols[1])
title("Other common models (Time series and ACFs)", outer=TRUE)


sc_lm_sd = scalegram(as.matrix(lm_df), stat="sd", threshold = 100, plot = F)
sc_lm_sd$Model = "Linear trend"

sc_rw_sd = scalegram(as.matrix(rw_df), stat="sd", threshold = 100, plot = F)
sc_rw_sd$Model = "Random walk"

sc_hf_sd = scalegram(as.matrix(hf_df), stat="sd", threshold = 100, plot = F)
sc_hf_sd$Model = "Harmonic fluctuation"

# compare different models
sc_det_df = data.frame(rbind(sc_lm_sd, sc_rw_sd, sc_hf_sd))

    
gg_sc_det_comparison = ggplot(data = sc_det_df, 
           aes(x = scale, y = sd, group=interaction(Model, variable))) +
      geom_line(aes(colour =Model), alpha = 0.2, show_guide = FALSE) +
      geom_point(aes(colour =Model), alpha = 0.2, show_guide = FALSE) +
      
      geom_tile(aes(fill=Model))+
      scale_y_log10("Standard deviation [-]") +
      scale_x_log10("Aggregation scale [-]",
                    labels = trans_format("log10", math_format(10 ^ .x))) +
      scale_fill_manual("", values = cols) +
      scale_colour_manual("", values = cols) +
      annotation_logticks(sides = "b") +
      theme_bw() +
      theme(panel.grid.minor.x = element_blank(),
            panel.grid.minor.y = element_blank(),
            aspect.ratio = 1)          

print(gg_sc_det_comparison)
