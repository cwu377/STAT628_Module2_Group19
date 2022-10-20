# Body Fat Prediction

## Description
We try to build a very simple model to predict body fat percentage with a small dataset. (only 250 observations)    
Our final model is: $Body Fat Percentage = -37.54 + 0.61*Abdomen(cm)$    
You could play around with our model: [Body Fat Calculator](https://cwu377.shinyapps.io/body_fat_calculator/)

## Repo Structure

- code 
  - Analysis
    - model_update_final.Rmd: This is our analysis report, which contains detail process of how we obtain our model. Also, this report also produced all results for our 2-page summary and presentation.  
  - Body_Fat_Calculator: the code for our shiny app
    - app.R: code for the app
    - bodyfat_out.csv: for the histogram plot
    - BodyFat_reference.csv: for reference table
  - data_prepocessed: 
    - data_clean.R: produced bodyfat_out.csv
    - generate_reference_table.R: produced BodyFat_reference.csv for our shiny app
- images  
All images were produced by "model_update_final.Rmd". 
So, I would just list the lines corresponding to each image. 
  - image1.png: Histogram of Abdomen (line 34~83)
  - image2.png: Best Subset Method (line 108~123)
  - image3.png: BodyFat% v.s. Abdomen (line 196~217)
  - image4.png: Residuals v.s. Fitted Values (line 220~231)
  - image5.png: QQ plot (line 246~252)
- data
  - BodyFat.csv: Original data
  - bodyfat_out.csv: Removing ADIPOSITY, IDNO and DENSITY. Also, getting rid of ourliers and unreasonable data (e.g. bodyfat% < 4) 
- Two-page Summary
- README: You are reading me now

## Usage
If you would like to use model_update_final.Rmd, make sure you put BodyFat.csv and bodyfat_out.csv to the same layer.

## Credits
- Amy Qin: 
- Chao-Sheng Wu:
- Maxwell Schleck
