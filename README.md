# Telecom Data Analysis with an RShiny Dashboard
Created by Margaret Sant, Data Engineering student at Jacobs University
[**Click Here to use Application**](https://margisant.shinyapps.io/app2/)

## Summary
### Task and Goal
The goal of this project is to create a dashboard application for the use of the marketing / product development and sales teams of a telecommunication company. This application uses customer churn data and returns graphs and figures with insights that can lead to developments of products and a marketing plan aimed towards customers that are likely to stay with the company for longer. It can also be used to develop a sales strategy that helps customers choose products appropriate for them, so they do not become unhappy with their service and leave.  
### Data Background
This project uses an [**IBM sample set called Telecom Customer Churn**](https://www.kaggle.com/blastchar/telco-customer-churn) available for the purpose of practicing data analysis on a ‘real-world’ type of business problem. The dataset is meant to simulate a typical dataset of a Telecommunications company. This application can be applied to real datasets.  
	
The dataset contains 7043 observations (rows) and 22 variables (columns) that contain information about customer demographics (gender, senior citizenship status, children, and marital status), services they signed up for (phone line, multiple lines, online security, online backup, device protection, tech support, streaming TV and Movies), account information (type of contract, payment type, paperless billing, monthly and total charges), and churn (which customers left within the past month when the data was collected). 

### Approach / Methods Used (Libraries)
The raw dataset is imported and cleaned in an R file in the "data" folder. The dashboard application is created using the **R Shiny app package** and makes use of the **shinydashboard** library for the sidebar layout. The **ggplot2** library is used for creating graphs, while gridExtra is used to layout graphs side-by-side in some cases. The **dplyr** library filter function is used to filter the data. 

### Results
The objective was to create a dashboard application that could present customer churn data in a way that would help marketing and sales teams understand their client distribution and compare churn rates of target demographics. The result was positive. App users filter customers by any one or more of the following categories: gender, relationship status, whether they have dependents and whether they are senior citizens. The dashboard then returns the churn rates of the target demographic chosen by the user. This way, businesses can clearly see which demographic groups have higher churn rates. Additionally, it gives information about how much they are spending and what kinds of services they prefer. The application shows this information with a side-by-side comparison of churn clients and clients that stayed.

## 1. Introduction
This report is focused on creating a dashboard application in R Shiny for a Telecommunications company that takes user input to define a target client demographic and outputs graphs and figures that will give business and sales insights. One important metric in the Telecommunications customer data is the churn rate. So throughout the dashboard, the data is presented side-by-side in terms of churn clients and clients that stayed.

### 1.1 What is Customer Churn?
Customer churn is the rate at which customers decide to stop doing business with a company. For a telecommunications company, churn would be the rate at which subscribers drop their services and leave for a competitor. It is an important metric in business, especially in the telecommunications industry, since it is more expensive to sign on new customers rather than retaining current ones given marketing budgets aimed towards non-customers. An analysis and continuous monitoring of customer churn can help companies pinpoint weaknesses and strengths in the customer attrition strategy. An analysis of who is more likely to leave can also help generate creative solutions for customized services and service packages.

### 1.2 How R. Shiny App works?
The R Shiny app is a directory that consists of an R script called app.R, which is made up of a user interface object and a server function—the folder also contains an additional script called clean_data.R where the original customer churn dataset is imported and preprocessed.  The UI creates the sidebar and main panel layout, and also includes the code for tab menus, icons, box layouts, etc. The server outputs the graphs and figures, which load each time the filters on the sidebar menu change.  When the app starts, all of the script including the ui object and server runs. The ui and additional script outside of the application (used to load libraries and source files such as clean_data.R) only runs once. When the user chooses a filter, just the server runs again and the graphs and figures change. 

## 2.Background of Data
The dataset is a simulated dataset comprised of mostly categorical data which describes customer traits, such as relationship status and types of services. Numerical discrete data includes tenure (number of months with the company). While numerical continuous data includes billing info for monthly and total charges. For the main purpose of this project, the independent variables are the demographic datatypes or their combinations. The dependent variables are the churn rates and tenure for broad insights regarding attrition, and the account type and services datatypes for deeper insights into billing and customer habits. 

## 3.Data Preprocessing
### 3.1 Data Cleaning
The data is imported and cleaned in a file called clean_data.R, which is then sourced in the app.R script before the UI object is defined. 

In clean_data.R, the ‘Yes’ and ‘No’ values for the demographic datatypes were changed to be more descriptive. For example, values for the ‘Senior Citizen’ column changed from ‘Yes’ and ‘No’ to ‘is a Senior’ and ‘is not a Senior’. This helped the design of the UI to be clear and descriptive for the target demographic. It also made coding the input and output values in R Shiny simpler. This was done for the columns ‘Dependents’, ‘Partner’ and ‘Senior Citizen’.

The ‘Yes’ and ‘No’ values for the ‘Churn’ column were changed to ‘Churn’ and ‘Stayed’. This made it less confusing for those new to the terminology and to read the code.

Values in the dataset ‘No internet service’ and ‘No phone service’ were changed to ‘No’. These values appeared in columns regarding specific phone or internet services such as ‘Multiple Lines’ or ‘Online Backup’. They are redundant for this project, so they are changed to be a straightforward ‘No’ to the service.

Finally, the ‘Gender’, ‘Partner’, ‘Dependents’, ‘Senior Citizen’ and ‘Churn’ columns were changed to character datatypes to be read by the UI.

### 3.2 User Interface Design
The design of the application makes use of the shinydashboard library. The dashboard has a sidebar with drop-down menus to select demographic filters, which can be toggled to expose only the main panel. The sidebar panel code is included in the Appendix. The main panel consists of five sections: Demographic Size, Demographic Spending, Demographic Tenure, and Entertainment Services. Each section is outlined with a box. 

The color theme is consistent throughout the entire dashboard, with blue representing all customers in the target demographic, green for customers that stayed and orange for customers that left. The colors are based on Bootstrap button colors “primary” (blue), “success” (green), and “warning” (orange).  These colors are also used in the graphs to show the distribution of the of customers that stayed and left together.  Each section shows a side-by-side comparison of all target customers, the customers that stayed, and the customers that left. 

The dashboard also uses tab menus to include different types of graphs relevant in each section. 

### 3.3 Server Function
#### 3.3.1 Filtering the Data 
The **most important feature** of the application is to filter the dataset by demographic features. The filters are introduced in the UI section of the R Shiny app as dropdown menus with the data values such as ‘Male’ and ‘Female’, each with a ‘No Filter’ option. The actual filtering of the dataset is done in the Server side of the application in the *observe({}) function*, and uses the filter() function from the dplyr R library. 

Here is the code for the filters:
```
rv$dataset = dataset %>% filter(if(input$gender == 'No Filter'){gender %in% gender_options} else {gender == input$gender}) %>%
  filter(if(input$senior == 'No Filter'){SeniorCitizen %in% senior_options} else {SeniorCitizen == input$senior}) %>%
  filter(if(input$relationship == 'No Filter'){Partner %in% relationship_options} else {Partner == input$relationship}) %>%
  filter(if(input$dependents == 'No Filter'){Dependents %in% dep_options} else {Dependents == input$dependents}) %>%
```

#### 3.3.2 Making a Reactive Dataset
The rv$dataset is a reactive value, which means that it is updated every time the server runs. The dataset is imported (called ‘dataset’) and cleaned in an R file, and then in the Shiny app it is set as a reactive value in the first lines of the server side of the Shiny App with the following code:
```
rv = reactiveValues()
rv$dataset = dataset
```

The reactive dataset is filtered by churn for graphs and values that pertain to one group. The dim() function gets a count of reactive dataset, which gives us the customer counts and percentages in the first section. 
```
rv$churn = filter(rv$dataset, Churn == 'Churn')
rv$stayed = filter(rv$dataset, Churn == 'Stayed')

rv$dim = dim(rv$dataset)
rv$dimStayed = dim(rv$stayed)
rv$dimChurn = dim(rv$churn)
```

#### 3.3.3 Info Boxes
Info boxes give figures such as averages and percent of total for the given datatypes. The code for the info box ui object and server fuction come from the shinydashboard library. These info boxes are located side-by-side in the outline boxes set in the UI application code. The actual info boxes are created in the server side of the application. Here is an example of the following UI and Server code for an info box:
```
column(width=4,
  box(title = "Customers Left", width = NULL, solidHeader = TRUE, status = "warning",
    box(title = "Total Monthly Charges", width = NULL, status = 'warning', infoBoxOutput("totalMonthlyChargesChurn")),
    box(title = "Average Monthly Charges", width = NULL, status = 'warning', infoBoxOutput("avgMonthlyChargesChurn"))
  )
)
```
And the Corresponding Server Code:
```
output$totalMonthlyChargesChurn <- renderInfoBox({
  x = format(round(sum(rv$churn$MonthlyCharges),2), big.mark = ",")
  infoBox("Total Monthly", paste("$",x),
          color = "orange",
          icon = icon("dollar-sign"),
    )
  })
```

The info boxes give the following information on all clients, stayed clients, and churn clients according to each section:
* Demographic Size --> Customer count, Percent of total clients
* Demographic Spending --> Total monthly charges, Average Monthly Charges
* Demographic Tenure --> Average number of months with the company.

#### 3.3.4 Graphs
The graphs are all created using the ggplot() function from the ggplot2 library. The main objective of the dashboard app is to compare the distributions of different types of customers. Therefore, the app uses various bar graphs to communicate this information. Staying consistent to the color theme, the bar graphs such as the Billing graph shown above are created using the grid.arrange() function from the GridExtra library. This way, the distribution is shown for the different reactive datasets (rv$dataset, rv$stayed, rv$churn), and shown together in one frame. 

## 4. Data Exploration
Here are some of the insights that the application presents about the IBM Telecom dataset, with notable figures given a star or double star for most importance:

### 4.1 Churn Rates
*	The Overall churn rate is 26.54%.
*	Gender does not make a difference in churn rate, with females leaving 26.92% of the time, and males 26.16%.
*	Seniors have a much higher churn rate at 41.68% than non-Seniors at 23.61%. *
*	Relationship status also makes a difference in churn rates. Customers with a partner have a churn rate of 19.66%, while single customers churn at a rate of 32.96%. **
*	Customers with dependents also churn at a much lower rate of 15.45% than customers without dependents at 31.28%. **
*	Single clients without dependents (perhaps recent college grads), have a churn rate of 34.24%. **

### 4.2 Demographic Size
*	The total number of customers is 7,043 (100%). 
*	Genders are even, with females making up 49.52% and males 50.48%.
*	Seniors make up 16.21% of the company with 1,142 senior clients. From this group, 476 customers churn which accounts for 6.76% of the total clientele.
*	Clients with a partner make 48.3% of the total clientele. From this group, the churn clients make 9.5% of the total clientele.
*	Single clients make 51.70% of the total clientele. From this group, the churn clients make 17.04% of the total clientele. **
*	Customers with dependents make 29.96% of the total clientele. From this group the churn clients make 4.63% of the total clientele. 
*	Single clients without dependents make up 46.57% of the total clientele of the company. From this group, the churn customers make up 15.94% of the total clientele. **

### 4.3 Contract Type
*	A majority of customers have a month-to-month contract. Month-to-month contracts account for 55.02% of all contracts. The next most popular is the two-year contract at 24.07% and the one-year contract at 20.91%. *
*	Among all of the churn clients, 88.55% had month-to-month contracts. 8.88% had one-year contracts and 2.57% had two-year contracts. It is important to note that the data was collected according to one month of churn rates, so it should be taken into consideration that clients with longer contracts that want to leave might not have had the possibility. 
*	Genders are once again proportionate in their contract preference.
*	Seniors sign up for monthly contracts at a higher rate of 70.67%, with non-seniors choosing monthly contracts 51.99% of the time. *
*	Customers with a partner prefer monthly contracts, but also sign up for two-year contracts at a high rate of 35.04% of the time. Among the non-churn customers from this group, the two-year contract is the most popular at 42.48%. **
*	By contrast, single clients prefer shorter contracts, with only 13.81% of single clients choosing a two-year contract, 17.66% going for one-year and 68.53% choosing monthly contracts. **
*	Clients with dependents prefer long contracts, and their most preferred contract is the two-year contract at 37.44%. This only slightly edges out the monthly contract which 37.39% from this group choose. Yearly contracts come in at 25.17%.  Among the non-churn customers, two-year contracts are the highest at 43.17%. **
*	Single clients with no dependents prefer monthly contracts at a rate of 69.78%.**

### 4.4 Payment Methods
*	Most customers pay with electronic checks (38.23%). Other methods of payment are proportionate to each other: mailed check at 21.26%, credit card (automatic) at 19.99%, and bank transfer (automatic) at 20.51%. All of the payment methods become very  proportional among the non-churn customers (within 1% of each other). Among the churn customers, a electronic check is a clear winner with 59.43% of churn clients paying this way. The automatic methods of payment for non-churn clients are around double the rates at which churn-clients use automatic methods. **
*	Gender again makes no difference here. 
*	Seniors pay via electronic check at a higher rate (52.9%). Meanwhile, non-seniors have a slightly more proportionate preference of payment methods than the overall. *
*	Customers with Partners prefer electronic checks, however among those that stayed automatic methods and electronic check are closely tied. Mailed check is the clear loser for this group. **
*	Single clients still prefer payment via electronic check; however, in contrast to clients with partners the mailed check comes in second. Among the non-churn single clients, mailed check is most popular. *
*	Clients with dependents least prefer electronic check, which comes in last overall and for churn clients. However, electronic check was the most popular for clients that left. Mailed check slightly out-performs automatic methods. On the other hand, clients without dependents prefer electronic check at a clear winner in overall, churn and non-churn categories. **

### 4.5 Paperless Billing
*	Most clients prefer paperless billing at 59.22%, with churn clients (74.91%) choosing it at a higher rate than non-churn clients (53.56%).
*	Surprisingly, seniors choose paperless billing at higher rates than the overall at 76.71%. Non-seniors are more proportional overall with 55.84% paperless, with non-churn clients close to half choosing paperless and churn clients with paperless at 71.93%.
*	Relationship status makes little difference from the overall in preference for paperless billing.
*	Clients with dependents prefer paperless overall but have a higher proportion of paper billing than other demographics, with 49.15% choosing paper billing. Among the non-churn clients, paper billing is actually slightly higher here at 52.07%. No dependents prefer paperless only at a slightly higher rate than the overall clientele. **
*	Single Clients *without* dependents prefer paperless around the same rate as the overall clientele. Single clients *with* dependents are nearly 50/50 in their preference to paperless, and paper billing is higher at 54.23% among the non-churn clients of this demographic.

### 4.6 Charges
*	The average monthly charges overall are $64.76. Totaling $456,116.60. 
*	The average monthly charges for churn clients ($74.44) are higher than loyal clients ($61.27).*
*	Senior citizens have much higher monthly charges at $79.82 overall ($79.18 for non-churn and $80.71 for churn clients). Non-seniors by contrast have $61.85 for monthly charges on average (non-churn at $58.62 and churn at $72.30). **
*	Clients with a partner have slightly higher charges, while single clients have only slightly lower charges. *
*	Clients with dependents have the low monthly charges, averaging $59.52 (non-churn at $57.08 and churn at $72.87).
*	Single clients with dependents have even lower monthly charges, averaging $52.51 (non-churn at $49.01 and churn at $65.40). 

### 4.7 Tenure
*	Most clients leave in the first months, with churn rates decreasing and then evening out around 30 months. 
*	The average number of months overall with the company is 32.37 months, with non-churn at 37.57 months and churn leaving after 17.98 months.*
*	Although seniors churn at a high rate given the month when the data was collected, they are loyal customers who churn on average after 21 months, and those that have stayed average 42 months with the company.*
*	Clients with Partners are loyal customers who average 42 months with the company (non-churn 45 and churn 26.59). Single customers by contrast average just 23.36 months overall (13 months for churn clients).
*	Clients with dependents are slightly more loyal than those without dependents, too.

### 4.8 Types of Internet Services
*	Fiber Optic is most popular overall. DSL is more popular than Fiber Optic among non-churn clients. Fiber Optic is a very clear winner for churn clients. 
*	Senior Citizens choose fiber optic at a much higher rate across the board. Non-seniors choose DSL.
*	Relationship status makes little different in internet preference than the overall. 
*	DSL is a clear winner for clients with dependents. Clients without dependents go for Fiber Optic more often. 
*	21% of clients overall don’t get internet service. 

### 4.9 Types of Phone Services
*	More customers have phone service than internet. Only 9.68% opt out. One line is most popular, followed closely by multiple lines. Multiple lines is higher for churn clients, who chose one-line and multiple-lines at the same rate (45%). 
*	Seniors choose multiple lines at a much higher rate than average. Multiple lines are a clear winner for this demographic. **
*	Customers with partners choose multiple lines at a higher rate as well. 
*	Customers with dependents choose one-line phone contracts at a slightly higher rate. 

### 4.10 Types of Streaming Services
*	Only about around 50% of clients signed up for streaming services. Churn clients signed up for streaming services at a slightly higher rate overall. 
*	Senior citizens are streaming TV and Movies at a very high rate well with only around 35% opting out of streaming services. **
*	Customers with partners choose streaming services at a higher rate than average, while single clients opt out.
*	Clients with dependents also opt out of streaming services at a slightly higher rate.

## 5. Results and Conclusions
### 5.1 The Dataset
Conclusions based on the dataset and presented by the application are vast and provide many opportunities to lower customer churn rates. The observations mentioned above in section 4 can mean any of the following or more:

*	Female and Male clients have almost zero difference in their preferences, so marketing should be gender neutral 
*	Month-to-month contracts are very popular, but allow more opportunity for customers to leave. Perhaps a contract option between one month and one year would be worth exploring (a 6 months contract, for example). 
*	Senior clients are signing up for many services and paying way more on average. Given the novelty of some of these services, they might not fully understand why they are paying so much. Sales teams should be weary of this, since seniors also have a very high churn rate. 
*	Single clients make up around 50% of the clientele but have much higher churn rates than client with partners. Single clients might be frustrated with costs, considering they are taking on more payments alone and using the services less. The telecom company could consider a package for single customers, like recent college grads.
*	Clients seem happier with DSL, especially those with partners or kids. This indicates that DSL performs better in larger households. Sales professionals should ask how many people will use the internet to help clients choose a plan. 
*	Incentives to stay with the company for at least 3 months at sign-up might be worth trying out, since churn rates dramatically decrease after the first couple of months. 
 
### 5.2 The Application
The application result was positive, meaning that the application provides thorough business insight given the relatively basic information contained in the dataset. The app helps users explore the data quickly without having to use code. From top to bottom, the application allows the user to explore the following information and more about their clients: 

Customer Demographic Size: 		
*	How many customers are in the selected customer demographic?	
*	What is the percentage of the total company clients?
*	What is the Churn Rate of the selected demographic?
*	How many customers from the selected demographic left and how many stayed?
*	What is the percentage of the total company clients for customers that left or stayed?

	Demographic Spending:
*	What Percentage of clients from the selected demographic have paperless billing?
*	What are their payment methods?
*	What are their contract types?
*	What differences in billing are there between the churn customers  and those that stayed?
*	How much are their monthly charges combined?
*	How much money did the company lose according to the combined monthly charges of customers that left from the chosen demographic?
*	How much did they get from the clients that stayed?
*	Is the chosen demographic spending more or less than others?
*	Are churn clients spending more money on average? 

	Tenure:
*	When do customers leave the company?
*	How loyal are the customers?
*	How long do they stay on average?

	Types of Service: 
*	What are the preferred types of services that the target demographic chooses?
*	What kind of internet service are customers happy with?
*	How many customers have this particular service?
*	Are customers happy with these services?

### 5.3 Overall Conclusions
The Telecom Customer Churn dataset is relatively simple. Any small or medium-sized company can track their data this way. It leaves out complicated details such as prices per service and break-downs of what services make up most of the customers’ bills. However, even with a simple dataset one can find very important insights to guide company decisions. Plus, simple datasets are easy to handle with less employees. And finale, an easy-to-use dashboard for customer analysis can be very valuable, since all of the information and conclusions described in sections 4 and 5 were clear and easy to find. 
