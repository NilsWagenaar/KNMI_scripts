require("ggplot2")
require("gridExtra")

require(grid)


#generate plots

#data1 = read.csv("/usr/people/wagenaa/CRPSS_tables/DFZ_Years_Tides/06511_Tide_Period.csv")
#print(data1)
#p1 = ggplot() + geom_line(aes(y = CRPSS, x = leadtime, colour = Tide_Period),
 #                          data = data1, stat="identity") + xlab("Leadtime [h]") + ggtitle("Delfzijl") + scale_x_continuous(breaks=seq(0,240,48))

data2 = read.csv("/usr/people/wagenaa/CRPSS_tables/HVH_Surge_Tides/06514_Surge_Tides.csv")
#print(data2)
p2 = ggplot() + geom_line(aes(y = CRPSS, x = leadtime, colour = Tide_Surge),
                           data = data2, stat="identity") + xlab("Leadtime [h]")  + ggtitle("Hoek van Holland") + scale_x_continuous(breaks=seq(0,240,48))

#data3 = read.csv("/usr/people/wagenaa/CRPSS_tables/DH_Season_Tides/06512_Tide_Season.csv")
#print(data3)
#p3 = ggplot() + geom_line(aes(y = CRPSS, x = leadtime, colour = Tides_Season),
 #                          data = data3, stat="identity") + xlab("Leadtime [h]")  + ggtitle("Den Helder")+ scale_x_continuous(breaks=seq(0,240,48))


#function to generate shared legend
grid_arrange_shared_legend <- function(...) {
    plots <- list(...)
    g <- ggplotGrob(plots[[1]] + theme(legend.position="bottom"))$grobs
    legend <- g[[which(sapply(g, function(x) x$name) == "guide-box")]]
    lheight <- sum(legend$height)
    grid.arrange(
        do.call(arrangeGrob, lapply(plots, function(x)
            x + theme(legend.position="none"))),
        legend,
        ncol = 1,
        heights = unit.c(unit(1, "npc") - lheight, lheight))
}






pdf("/usr/people/wagenaa/CRPSS_tables/CRPSS_HVH/CRPSS_plot_HVH_Tide_Surge.pdf", onefile = FALSE)

grid_arrange_shared_legend(p2)




dev.off()

#data2 = read.csv("/usr/people/wagenaa/CRPSS_tables/06515_Season.csv")
#print(data2)
#pdf("/usr/people/wagenaa/CRPSS_tables/CRPSS_plots_Huibert.pdf", onefile = FALSE)


#p4 = ggplot() + geom_line(aes(y = CRPSS, x = leadtime, colour = Season),
 #                          data = data2, stat="identity") + xlab("Leadtime [hr]") + ggtitle("Huibertgat") + scale_x_continuous(breaks=seq(0,240,48))


#data3 = read.csv("/usr/people/wagenaa/CRPSS_tables/06520_Season.csv")
#print(data3)
#pdf("/usr/people/wagenaa/CRPSS_tables/CRPSS_plots_Vlissingen.pdf", onefile = FALSE)

#p5 = ggplot() + geom_line(aes(y = CRPSS, x = leadtime, colour = Season),
                           #data = data3, stat="identity") + xlab("Leadtime [hr]") + ggtitle("Vlissingen") + scale_x_continuous(breaks=seq(0,240,48))

#pdf("/usr/people/wagenaa/CRPSS_tables/CRPSS_plots_Huibert_season.pdf", onefile = FALSE)

#grid_arrange_shared_legend(p4)

#dev.off()
