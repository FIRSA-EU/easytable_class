# Interaction Effects in Regression

This repository contains the code and teaching materials for a short practical session on interaction terms in regression, prepared as part of the FIRSA in-house training sessions.

The slides introduce the basic logic of interaction effects in ordinary least squares regression. They show how to move from an additive model, where the effect of one predictor is assumed to be constant, to an interaction model, where the relationship between one variable and the outcome depends on another variable.

## Files

- `index.qmd` — source file for the Beamer or RevealJS slides
- `activity_script.R` — code for the student activity using Gapminder data
- `synth_aux.R` — code used to create the synthetic country-level dataset
- `output/synth_df.rds` — synthetic dataset for reproducing the examples
- `firsa.css` — for CSS styles and branding

## What the code does

The code prepares examples for teaching interaction terms in R. It shows how to estimate models of the form:

    lm(y ~ x * z, data = df)

The repository also includes the code for the practical activity and the synthetic data material, so the seminar examples can be fully reproduced. The synthetic dataset uses fictitious countries and includes variables such as GDP growth, aid, state capacity, democracy, and population.

## Activity

Students work in pairs or small groups to identify a plausible interaction, write a simple hypothesis, explain the mechanism, clean the data, estimate a model with an interaction term, and interpret the result in plain English.

More advanced students can use `easytable` for regression tables and `marginaleffects` for predicted-value or marginal-effect plots.

## Requirements

Main R packages:

    gapminder
    tidyverse
    marginaleffects

Optional:

    easytable

If using `easytable`run:

    install.packages(
      "easytable",
      repos = c("https://alfredo-hs.r-universe.dev", "https://cloud.r-project.org")
    )

## Context

These materials are part of the [FIRSA](www.firsa.eu) in-house training activities and are designed as a practical refresher for students and researchers with basic familiarity with linear regression.
