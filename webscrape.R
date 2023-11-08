# install.packages("rvest")
# install.packages("dplyr")
# install.packages("vscDebugger") # nolint
#  Path: C:\\Users\\drago\\OneDrive\\Documents\\CSE310\\Mod_4\\RWebScraper\\webscrape.R
# source("C:\\Users\\drago\\OneDrive\\Documents\\CSE310\\Mod_4\\RWebScraper\\webscrape.R")
library(rvest) 
library(dplyr)

# link to a search for green cards that tap for mana
link = "https://gatherer.wizards.com/Pages/Search/Default.aspx?action=advanced&text=+[tap]+[add]+[mana]&color=+[G]" # nolint
page = read_html(link)
# print(page)
# use rvest to scrape the page
# using css selectors

cardTitle = page %>% html_nodes(".cardTitle a") %>% html_text()
cardType = page %>% html_nodes(".typeLine") %>% html_text()
cardText = page %>% html_nodes(".rulesText") %>% html_text()
cardMana = page %>% html_nodes(".manaCost") %>% html_text()
cardStats = page %>% html_nodes(".ptRow") %>% html_text()
cardFlavor = page %>% html_nodes(".flavorText") %>% html_text()
cardArtist = page %>% html_nodes(".rightCol .rightCol .rightCol") %>% html_text()

print(cardTitle)
print(cardType)
print(cardText)
print(cardMana)
print(cardStats)
print(cardFlavor)
# print(cardArtist)
# the print statements are for debugging purposes
# Now they are working I need to figure out how to get them into a dataframe
# I think I need to use a list and then convert it to a dataframe, but not sure it will be necessary
# cardflavor does not have full 50 values, since all cards don't have flavor text. exclude it for now

df <- data.frame(cardTitle,
cardType,
cardText,
cardMana)
print(df)
# Install and load the ggplot2 package
# install.packages("ggplot2")
library(ggplot2)

# this should have opened in output, but since it didn't I added the feature to print as a plot and save as a file. 
plot <- ggplot(df, aes(cardType)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for readability
print(plot)
ggsave("plot.png", plot = plot, width = 10, height = 10, units = "in")
creatureList <- list()
# int datatype
count = 0
for (i in 1:50) {
    #use grepl to search for creature in cardType (used like the like operator in sql)
    if (grepl("Creature", cardType[i])) {
        creatureList[i] <- cardTitle[i]
        print(cardTitle[i])
        count = count + 1
    }
}
# string datatype
creatureCount = paste("CreatureCount:", count)
print(creatureCount)

# Create a dataframe
dm <- data.frame(
  cardTitle = cardTitle,
  cardType = cardType,
  cardText = cardText
#   cardMana = cardMana,
#   cardFlavor = cardFlavor,
#   cardArtist = cardArtist
#   cardStats = cardStats,

)

# Write the dataframe to a CSV file
write.csv(dm, "manaTapper.csv", row.names = FALSE)
#List Datatype
ListLegend <- list()
# int datatype
count = 0
for (i in 1:50) {
    #use grepl to search for creature in cardType (used like the like operator in sql)
    if (grepl("Legendary", cardType[i])) {
        ListLegend[i] <- cardTitle[i]
        print(paste("Legendary:",cardTitle[i]))
        count = count + 1
    }
}
# string datatype
LegendaryCount = paste("LegendaryCount:", count)
print(LegendaryCount)

# check for string in cardTitle from legend list
SearchPhrase <- "Orochi"
searchCount = 0
# for (i in ListLegend) {
#     if (grepl(SearchPhrase, i)) {
#         print(paste(SearchPhrase , i))
#         searchCount = searchCount + 1
#     }
# }
isFound <- FALSE #logical datatype
complexNumber <- 3+6i  # complex
for (i in 1:length(ListLegend)) {
    if (!is.null(ListLegend[i]) && grepl("Search Phrase: ",SearchPhrase, ListLegend[i])) {
        print(paste(SearchPhrase , ListLegend[i]))
        searchCount = searchCount + 1
        isFound <- TRUE #update isFound to true if found
    }
}
if (!isFound) {
    print(paste(SearchPhrase, "not found")) #print not found if not
}
print(paste(SearchPhrase,"- SearchCount:", searchCount))
datatypes <- list()

dtypeCardType <- class(cardType)
dtypeCardText <- class(cardText)
dtypeCardMana <- class(cardMana)
dtypeCardStats <- class(cardStats)
dtypeCardFlavor <- class(cardFlavor)
dtypeCardArtist <- class(cardArtist)
dtypeComplexNumber <- class(complexNumber)
dtypeLegendaryCount <- class(LegendaryCount)
dtypeIsFound <- class(isFound)
dtypeListLegend <- class(ListLegend)
datatypes <- c(datatypes,
    dtypeCardType,
    dtypeCardText,
    dtypeCardMana,
    dtypeCardStats,
    dtypeCardFlavor,
    dtypeCardArtist,
    dtypeComplexNumber,
    dtypeLegendaryCount,
    dtypeIsFound,
    dtypeListLegend)
print(datatypes)
# I didn't end up using the below code, but I wanted to keep it for reference
# for (i in 1:50) {
    
#     # check datatypes. Trying a for loop to see how many I used in scraping data 

# }