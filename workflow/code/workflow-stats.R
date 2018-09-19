# ----------------------------------------------------
#   WORKFLOW SCRIPT
#   This script produces tables and figures 
#     to demonstrate an integrated TeX workflow
#     
#   1. Read in data
#   2. Produce a table of summary statistics
#   3. Estimate a regression & generate output table
#   4. Save a graphic
#   
#   note: this script uses 'tidyverse' syntax (pipes, dplyr, tidyr, and so on)
#   to learn more visit https://rpubs.com/bradleyboehmke/data_wrangling
#   or check out 'R for data science' (http://r4ds.had.co.nz/)
#   
# ----------------------------------------------------




# --- prep -----------------------

# packages

# if you open R in the latex-workshop-2018/workflow directory, 'here' finds .here file
# read more: https://github.com/jennybc/here_here
library("here")

# data manipulation and graphics
library("magrittr")
library("tidyverse")
library("ggplot2")
theme_set(theme_minimal())

# models
library("broom")

# export tables
library("xtable")
library("texreg")

# create table and figs directory
dir.create("workflow/tables")
dir.create("workflow/graphics")
dir.create("workflow/refs")



list.files("data")

pm <- read_csv(here("data/pokemon.csv")) %>%
  print()



# --- summary stats table (xtable) -----------------------

# create a table of stats
# select variables
# for each generation, find the mean of every stat variable
# round numeric variables off to zero decimals
mean_stats_tab <- pm %>%
  select(Generation, HP:Speed) %>%
  group_by(Generation) %>%
  summarize_all(mean) %>%
  mutate_if(is.numeric, round) %>%
  print()

# convert table to tex code 
#   using xtable() function and print.xtable() method
#   create a caption and label
#   use 0 decimal places for numeric data
#   use 'booktabs' and 'dcolumn' package syntax
#   don't print a column of row numbers
# write to a tex file (using the here() function to control directory)
mean_stats_tab %>%
  xtable(caption = "Mean Pok\\'emon Statistics",
         label = "tab:pm", digits = 0) %>% 
  print(booktabs = TRUE, dcolumn = TRUE, 
        include.rownames = FALSE,
        latex.environments = "center") %>%
  write(here("workflow/tables/pokemon-stats.tex"))

# for more, uncomment
# help(xtable)
# help(print.xtable)


# --- table of text -----------------------

# create a data frame of pokemon info
starters <- 
  data_frame(Pokemon = c("Bulbasaur", "Squirtle", "Charmander"), 
             Type = c("Grass", "Water", "Fire"), 
             Weakness = c("Fire", "Grass", "Water"), 
             `Gary Picks` = c("Charmander", "Bulbasaur", "Squirtle")) %>%
  print()


# convert to latex
# we include the 'sanitize' argument to prevent the print.xtable() function
#   from converting the backslashes to \textbackslash in latex
#   (we want actual backslashes in the code, not in the output)
starters %>%
  rename(`Pok\\'emon` = Pokemon) %>%
  xtable(caption = "Choices for your first Pok\\'emon",
         label = "tab:first-pm") %>%
  print(booktabs = TRUE, include.rownames = FALSE, 
        sanitize.colnames.function = identity) %>%
  write(here("workflow/tables/first-pokemon.tex"))


# --- regression table -----------------------

pm

# health as a function of attack and defense points
# is it the case that weak pokemon are given stronger defenses?
def_model <- lm(HP ~ Defense, data = pm)
atk_def_model <- lm(HP ~ Defense + Attack, data = pm)

summary(def_model)
summary(atk_def_model)
# doesn't seem that way


# create texreg table
#   save to file in workflow/tables/
texreg(list(def_model, atk_def_model),
       custom.model.names = c("Restricted Model", "Full Model"),
       caption.above = TRUE,
       caption = "Regressions predicting Pok\\'emon HP",
       label = "tab:pm-regs",
       dcolumn = TRUE, booktabs = TRUE, use.packages = FALSE,
       float.pos = "ht",
       file = here("workflow/tables/hp-regs.tex"))



# --- A figure from R to tex -----------------------

type_mod <- lm(Defense ~ `Type 1`, data = pm)
summary(type_mod)

broom::tidy(type_mod, conf.int = TRUE) %>%
  filter(term != "(Intercept)") %>%
  arrange(desc(estimate)) %>%
  mutate(term = str_replace(term, "`Type 1`", ""),
         term = fct_reorder(term, estimate)) %>%
  ggplot(aes(x = term, y = estimate)) +
    geom_hline(yintercept = 0, color = "gray", size = 0.5) +
    geom_pointrange(aes(ymin = conf.low, ymax = conf.high)) +
    coord_flip() +
    labs(y = "Type Effect on Defense (vs. \"Bug\" Type)", x = "Primary Type")

ggsave(here("workflow/graphics/type-intercepts.pdf"), 
       height = 4, width = 7, device = cairo_pdf)




# --- Exported quantities -----------------------

diff_from_bug <- broom::tidy(type_mod) %>%
  filter(p.value < .05) %>%
  filter(term != "(Intercept)") %>%
  print()

# what is the coef on steel?
filter(diff_from_bug, estimate == max(estimate)) %$%
  write(round(estimate, 1), here("workflow/refs/steel-coef.tex"))


# what's lower than bug?
filter(diff_from_bug, estimate < 0)

filter(diff_from_bug, estimate < 0) %$% {
 write(round(estimate, 1), here("workflow/refs/normal-coef.tex"))
 write(round(p.value, 3), here("workflow/refs/normal-p.tex"))
}

