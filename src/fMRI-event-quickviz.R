library('ggplot2')
library('gridExtra')

eventFilePath <- '/Users/barilari/data/V5_high-res_pilot-1_raw/sub-pilot001/ses-001/func/sub-pilot001_ses-001_task-visualLocalizer_run-001_events.tsv'

plotPosterName = 'sub-pilot001_ses-001_task-visualLocalizer_run-001_events.pdf'

eventFile <- read.table(file = eventFilePath, 
                        header = T)

summary(eventFile)

# Assign a value per trial_type level that will be used in the y axis 

eventFile$trial_type <- as.character(eventFile$trial_type)

# WIP
# expCondition <- c('static', 'motion') 

eventFile$y_axis <- ifelse(eventFile$trial_type == 'response',2,
                           ifelse(eventFile$trial_type == 'static',1,
                                  ifelse(eventFile$trial_type == 'motion',1,
                                                1.5)))

# divide in blocks

eventFile$block <- as.character(eventFile$block)

eventFile$block[eventFile$block == 'n/a'] <- '0'

eventFile$block <- as.integer(eventFile$block)

for (iBlock in 1:max(eventFile$block)){
  
  print(iBlock)
  
  if (iBlock != max(eventFile$block)) {
    
    print(c(min(which(eventFile$block %in% iBlock)), min(which(eventFile$block %in% (iBlock+1)))-1))
    
    eventFile$block[min(which(eventFile$block %in% iBlock)):min(which(eventFile$block %in% (iBlock+1)))-1] <- iBlock
    
  } else {
    
    eventFile$block[min(which(eventFile$block %in% iBlock)):nrow(eventFile)] <- iBlock
    
    print(c(min(which(eventFile$block %in% iBlock)), nrow(eventFile)))
    
  }
  
}

# calculate end  of an event

eventFile$end <-eventFile$onset + eventFile$duration 

#### LOOP ACROSS BLOCKS

plotBlock <- list()

for (iBlock in 1:max(eventFile$block)){
  
  tempBlock <- subset(eventFile, block == iBlock & onset >= 0)
  
  tempTitle <- paste('block n. ', iBlock)
  
  plotBlock[[iBlock]] <- ggplot(data = tempBlock) +
    geom_segment(data = subset(tempBlock, y_axis == 1 ), 
                 aes(x = onset, xend = end, y = y_axis, yend = y_axis), 
                 size = 10) +
    geom_segment(data = subset(tempBlock, y_axis == 1.5 ), 
                 aes(x = onset, xend = end, y = y_axis, yend = 0.8), 
                 size = 1) +
    geom_point(data = subset(tempBlock, y_axis > 1), 
               aes(x = onset, y = y_axis), 
               size = 3) +
    geom_text(data = subset(tempBlock, y_axis == 1 ),
              aes(x=onset,
                  y=1.2,
                  label=trial_type,
                  angle=25,
                  hjust=0)) + 
    geom_text(data = subset(tempBlock, y_axis == 1.5 ),
              aes(x=onset,
                  y=1.6,
                  label=trial_type,
                  angle=25,
                  hjust=0)) +
    {if(nrow(subset(tempBlock, y_axis == 2 ))) 
    geom_text(data = subset(tempBlock, y_axis == 2 ),
              aes(x=onset,
                  y=2.1,
                  label=keyName,
                  angle=0,
                  hjust=0))} +
    theme_classic() +
    scale_y_continuous( limits = c( 0.8, 2.2),
                        breaks = c (1, 1.5, 2)) +
    scale_x_continuous( limits = c(min(tempBlock$onset) - 1, max(tempBlock$onset) + 2),
                        breaks = round(seq(round(min(tempBlock$onset)), round(max(tempBlock$onset), 2) + 1, length = 15),2)) +
    xlab('Time')+
    ylab('Events') +
    ggtitle(tempTitle) +
    theme(
      text=element_text(size=16),
      legend.position = 'right',
      legend.text=element_text(size=14),
      axis.line = element_line(size = 0.6),
      axis.text.x = element_text(size=14,colour="black"),
      axis.text.y = element_text(size=14, colour='black', hjust=10, vjust = 0))
  
  print(plotBlock[[iBlock]])
  
}

plotPoster <- do.call(grid.arrange,  c(plotBlock, nrow=max(eventFile$block)))

ggsave(plotPosterName, plot = plotPoster, device="pdf", path = '~/Desktop/', units="in", width=20, height=80, dpi='retina', limitsize = F)


