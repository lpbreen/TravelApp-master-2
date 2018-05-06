App Name: Trip Planner

Tagline: From weekend getaways to business trips to family vacations, this is the one app you need to stay organized with whatever trip you take.

Repo Link: https://github.com/jamesylgan/hack_challenge_backend

Screenshots:


Short Description: Our app allows you to plan as many trips as you’d like. A trip includes a start location, an end location, a start date, an end date, a hotel, and a trip type (plane vs car). Once you’ve created a trip, you can edit your start and end dates, see a timeline of which days you’re away, and see a map of your destination city. Additionally, the app can recommend restaurants in your destination city. 

How app addresses requirements:
iOS
Autolayout: Uses SnapKit for layouts
CollectionView or TableView: Home page is a CollectionView, many TableViews used throughout
Navigation: Lots of ViewControllers connected with NavigationController
API: API’s used for map and restaurant suggestion functionanility

Backend
We used postgres because of MySQL on Windows not working.

We really struggled to deploy on time because of Windows issues. Because of that, we were unable to properly test (although we believe that our code is correct but slightly unfinished) and could not deploy in time (DEPLOY ON GOOGLE CLOUD)

Hotels queries use Google Places API with the help of the Google Geocode API to list hotels within 10km for the app to use. The same function can be used for queries of nearby attractions with addresses. (DESIGN AN API)

We (wanted) to store hotel queries in our DB to lower the costs of using Google API, and speed up queries, but could not get around to testing that. (DATABASE MODELING, CHANGE EXISTING API TO MODEL DATA APPROPRIATELY)

We store user data in a DB with a full rest API for user data and users. (DATABASE MODELING)

We used a flask boilerplate for all of the above. (IMPLEMENT USING FLASK BOILERPLATE WE PROVIDE)
