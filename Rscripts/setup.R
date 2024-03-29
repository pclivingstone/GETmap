# setup.R

# clean up ----------------------------------------------------------------
rm(list = ls())
# graphics.off()
cat('\014')

# libraries ---------------------------------------------------------------
library(data.table)
library(leaflet)
library(leaflet.extras)
library(shiny)
library(ggplot2)
library(googleVis)

# functions ---------------------------------------------------------------
source('Rfunctions/stripComma.R')
