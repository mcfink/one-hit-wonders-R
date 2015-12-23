library(shiny)
library(dplyr)
library(lubridate)

a  <- read.csv('tsort-chart-2-4-0003.csv')
b  <- tbl_df(a)
## change year column to number
c <- mutate(b, nyear = as.numeric(levels(year))[year])

eighties <- filter(c, nyear > 1939 & nyear <2016)
eightiesongs <- filter(eighties, as.character(type) == "song")
esbyartists <- group_by(eightiesongs, artist)
artistsums <- summarize(esbyartists, songs = length(score),total = sum(score), biggesthitscore = max(score), biggesthit = name[which.max(score)])
onehitwonderindex <- mutate(artistsums, bighitpct = biggesthitscore/total)
onehitwonderindex <- filter(onehitwonderindex, biggesthitscore > 1)
onehitwonderindex <- mutate(onehitwonderindex, ohwindex = bighitpct * biggesthitscore)
orderedohw <- arrange(onehitwonderindex, desc(ohwindex))


shinyServer(
    function(input, output){
        year_range_grouped <- reactive({
            group_by(filter(filter(c, nyear > input$year_range[1] & nyear < input$year_range[2]), as.character(type) == "song"), artist)
        })
        
        year_range_summarized <- reactive({
            arrange(mutate(summarize(year_range_grouped(), songs = length(score), total = sum(score), biggesthitscore = max(score), biggesthit = name[which.max(score)]), bighitpct = biggesthitscore/total, ohwindex = bighitpct^input$onehit * biggesthitscore^input$whole_catalog), desc(ohwindex))
        })
        
        
        
        output$toponhw <- renderTable(year_range_summarized())       
    }
)