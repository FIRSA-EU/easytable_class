# Synthetic Data for Lesson on Interactions

library(tidyverse)
library(marginaleffects)
library(easytable)

country_names <- c(
  "Asteria", "Borealia", "Calidora", "Demeria", "Eldoria",
  "Faronia", "Galvaria", "Heliara", "Istravia", "Jorvikia",
  "Kalmora", "Lunaria", "Meridia", "Noveria", "Orsina",
  "Pelagia", "Quintara", "Ravennia", "Selvaria", "Tirona",
  "Ulvaria", "Valdoria", "Westmark", "Xandria", "Ysmara",
  "Zoravia", "Ardenia", "Belvaria", "Caspia", "Dornavia",
  "Estoria", "Felsmere", "Galdovia", "Hespera", "Ivoria",
  "Jasmora", "Kyrania", "Lydora", "Montara", "Norvessa"
)

synth_df <- expand_grid(
  aid_pct = seq(1, 9, length.out = 5),
  state_capacity = c(-1.5, -0.5, 0.5, 1.5),
  democracy = c(0, 1)
) |>
  mutate(
    country = country_names,
    id = row_number(),
    
    population_m = round(
      2 + ((id * 7.1) %% 80) + 8 * abs(sin(id / 3)),
      2
    ),
    noise = 0.35 * (
      0.65 * sin(id * 1.7) +
        0.45 * cos(id * 2.1) +
        0.25 * sin(id * 0.37)
    ),
    gdp_growth = round(
      1.2 +
        0.10 * aid_pct +
        0.50 * state_capacity +
        0.25 * democracy +
        0.20 * aid_pct * state_capacity +
        0.50 * aid_pct * democracy +
        0.005 * log(population_m) +
        noise,
      2
    )
  ) |>
  select(
    country,
    gdp_growth,
    aid_pct,
    state_capacity,
    democracy,
    population_m
  )

saveRDS(synth_df, "synth_df.rds")

m1 <- lm(gdp_growth ~ aid_pct + state_capacity, data = synth_df)
m2 <- lm(gdp_growth ~ aid_pct * state_capacity, data = synth_df)
m3 <- lm(gdp_growth ~ aid_pct * state_capacity + democracy + population_m, data = synth_df)

easytable(m1,m2,m3, highlight = T)

# democracy
model_dem <- lm(gdp_growth ~ aid_pct * 
                  democracy, data = synth_df)
easytable(model_dem)

plot_predictions(
  model_dem,
  condition = c("aid_pct", "democracy")
) +
  labs(
    title = "Interaction between aid and democracy",
    subtitle = "Synthetic data",
    x = "Foreign aid as % of national income",
    y = "Predicted GDP growth"
  ) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "top")

# capacity
model_cap <- lm(gdp_growth ~ aid_pct * 
                  state_capacity, data = synth_df)

plot_predictions(
  model_cap,
  condition = c("aid_pct", "state_capacity")
) +
  labs(
    title = "Interaction between aid and state capacity",
    subtitle = "Synthetic data",
    x = "Foreign aid as % of national income",
    y = "Predicted GDP growth"
  ) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "top")

# Minimal Expected Results of Activity

"H: The association between GDP per capita and life expectancy is weaker in Europe than outside Europe."

"M: European countries already tend to have high life expectancy, stronger health systems, and less variation in basic living conditions, so additional income may be less impactful."

df <- df %>% 
  mutate(
    europe = ifelse(continent == "Europe", 1, 0)
  )

model_interaction <- lm(
  lifeExp ~ log_gdp * europe + pop,
  data = df
)

summary(model_interaction)

"R: Outside Europe, a one-unit increase in logged GDP per capita is associated with about 7.7 additional years of life expectancy. The estimated slope for Europe is 7.7 - 4 = 3.7. Still positively associated with life expectancy, but the relationship is weaker."


# Extra 

library(easytable)

easytable(model_interaction, digits = 1)

library(marginaleffects)

plot_predictions(
  model_interaction,
  condition = c("log_gdp", "europe")
)
