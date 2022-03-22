
# Rounding to the nearest base
mround <- function(x,base=0.5){
  base*round(x/base)
}

# Pretty Rounding
rnd <- function(x,digits=3) { format(round(x,digits),nsmall = digits)}

# *** IMPORTANT: These need to match the colours set in style.css ***
# It is a good idea to copy the :root colours from style.css, as below.
# It makes it easier to keep the colours consistent
# Also: Both this file, and style.css are replicated in the css folder where the learnR files are kept
# ****************************************************************************************************

style.env <- new.env(parent = emptyenv())

# These colours are taken https://www.canva.com/learn/100-color-combinations/
#   Current Colour Scheme:Understated and Versatile */

# At the moment, only the first two are used, but it's probably a good idea to have a few
style.env$plot_colour = c('#335252','#AA4B41','#6F4F4A')
style.env$contrast_plot_colour = '#D4DDE1' # this is the same as main_bg_colour

# This controls the size of mtext in the plots
style.env$plot_mtext_cex = 1.25

# This affects how the text Learning Tip looks - I couldn't figure out how to get
# it recognised in the css file in a style tag, so it is here
style.env$learning_tip_title_style='font-size: 120% !important; padding: 2px 2px 2px 2px !important; colour: white !important; border-bottom: 2px solid white;'

# Defining a custom ggplot theme - to mimic base R
style.env$my_theme <- ggplot2::theme_classic() +
  theme(axis.line.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        axis.title = element_blank())

# *** FOR REFERENCE ONLY ***
# These are the colours set by style.css.
# :root {
#   --main-bg-colour: #D4DDE1;
#     --main-text-colour: #2D3033;
#     --input-text-colour: #335252;
#     --highlight-text-colour: #AA4B41;
#     --btn-background-colour: #335252;
#     --btn-text-colour: white;
#   --help-text-colour: #AA4B41;
# }


