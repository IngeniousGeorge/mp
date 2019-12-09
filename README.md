## README

This Ruby on Rails web app is a demo of a market place.   
It's a project I started working on for my former employer but which never completed.  
I took it upon myself to apply all I've learnt in the last few years spent studiyng development as an autodidact and try to make it the most clean code I can produce.  
You can consider it my master thesis, if you will.  

It uses:
· **Rails** 5.2.3 and **Ruby** 2.6.3  
· **Postgres** for the DB  
· **Devise** for authentification  
· **Google Cloud Storage** with **Active Storage** for file storage  
· **Active Admin** for the admin interface  
· **Rspec** & **Capybara** for testing  
· **Capistrano** for deployment  
It is hosted on a droplet on **Digital Ocean** for the [production app](http://ingeniousgeorge.com) and the [repo] is hosted on **Github**.  
I elected not to use an ecommerce gem like Spree for educational purposes and because I felt like most of the issues of a market place could be addressed with core Rails.  

The main requirements at the time of conception, and besides the obvious ones expected from a multi-seller market place, were:  
· Give complete autonomy to a non-technical admin to run the site  
· Translation of all text and user generated input  
· Concentrate all actions and info for clients and sellers in dashboards  
· Meaningful urls to help with SEO, especially urls with proper sellers' names and categories  
· Geolocalisation of all clients and sellers to eventually promote local circuits and handle delivery  
They are all implemented and functional in the current version of the app.  
  
I've followed a mostly BDD style, with most of the testing suite being located in spec/system folder.  
They offer good coverage because any issue at unit level will likely be caught by one or more of those tests.  
But, as useful as they are in the first phases of development, they become cumbersome in a more complete app, as they break when the front end changes.  
Test coverage: 79%  

This app is still being developped with production in mind, yet I admit it is far from ready for it.  

---
##### In the next section I will detail all the noteworthy design decisions I've made
---

NB: 'I' refers to decision I've made for the project when I started it again, 'we' to the decisions that were made by the team at the conception of the project.  


#### Translation

*Concern:*  
By far the most challenging aspect of the project. While I18n can handle the translation of hard coded strings throughout the site, there are no ready made solutions for user generated input.  

*Solution:*  
I decided to scope all the routes with the locale, as it seemed the most DRY. I then created a translation table for each models which required translations. For instance, ProductTranslation will have a lang attribute to note what language it is translating into, and the same fields as the original model which requires translations, description in this case. Then, at the controller level, as the DB is queried for the record, the translation table is queried in turn and substitutes the overlapping attributes. I used convention over configuration in this case, and all models can be translated with the same method [translate_object](config/initializers/extensions/object.rb) which extends the Object class.  

*Pros:*  
I found this solution very satisfying to work with. Once the translating method is in place, and isolated in the config/extensions folder, it's just a matter of creating a dependent model for translations, indenpendent of the language it is. It just needs to be taken into account as nested forms in the new/edit pages. It is also error safe: supposedly, no record without a translation should be asked to be translated, as they are scoped by the first query, but if they do, then the translate_object method will return the original object, with the default language intact. [Testing](spec/system/translations/translate_spec.rb) is also straightforward. Highly reusable.  

*Cons:*  
It is an extra call to the DB. Which isn't an issue for single records, but it is more problematic when the original query returns a set of records, and then there has to be an extra call of each of them. This issue is tackled in the next section.  

*Future Development:*  
It could be better design to treat the default language as a translation and simply call translate_object on all objects, without having to use conditionals to check the locale. If we duplicate the default language field into the original record we keep it error safe and always have text to display, albeit in the default language.  

#### Querying the Catalogue

*Concern:*  
If we let the app query the DB for a set of products, and then all those products need to be translated, it adds one DB query for each product, which is not ideal.  

*Solution:*  
Using pure SQL and a join, I was able to put the translated text directly into the returned object. I decided that once the join was in place and I had this method for querying products at my disposal, I could extend it and use it for all product queries, including the sort, order, offset and limit values. The code is in [lib/product_sql.rb](lib/product_sql.rb) and even if it looks like too long of a method, it is in fact very linear and reads like the SQL statement it is building step by step, based on conditionals on the params.  

*Pros:*  
The result is one SQL statement for every request (Actually two, there's a first to probe the size of the result set, for pagination purposes), no matter how complex the query is. The complexity is all in one place, which is thoroughly [tested](spec/system/catalogue/retrieves_the_right_set_of_products_spec.rb) (17 feature tests). It can't be reused as is, but the structre can be easily adapted to a similar context.  

*Cons:*  
The method isn't very readable and is dependent on the Product class. It does two things, since it is responsible for returning the result set size, but it would have meant a lot of repetition not to get this value through this call.   

*Future Development:*  
Extract the magic number 12 (the number of product per page by default) to an ENV var or the database to give an admin the freedom to change it.  

#### Basket Management

*Concern:*  
In an ideal world every client would first sign up, get a basket record of their own and start shopping. But we wanted them to be able to have a temporary basket as soon as the first connection and deal with potential conflicts at sign up/sign in.  

*Solution:*  
The app controller sets a basket for every visitor. First priority is the basket stored in the DB for signed in clients, then a basket whose ID is stored in a cookie, eventually a new basket if neither is found. This is pretty straightforward and only takes [one method](app/controllers/application_controller.rb) and a few lines in the app controller. Complexity emerges when clients sign up, sign in and sign out, and decisions have to be made between several possible baskets. The solution is to always try to keep items already selected in temporary baskets and merge them with the next basket, which takes just one method in [Basket model](app/models/basket.rb), called from [Devise controllers](app/controllers/client/sessions_controller.rb).  

*Pros:*  
It fits the requirements without using external code. The code itself isn't particularly satisfying, especially since it is not encapsulated and burdens the controllers, but at least it is light and hopefully the extensive [testing](spec/system/basket/basket_management_spec.rb) serves as documentation.  

*Cons:*  
The code is scattered between Devise client session and registration controllers, the application controller and the Basket model. This is not ideal but can hardly be improved, methods can't be extracted to basket class because of heavy use of the cookies method, only available in controllers. It also potentially leads to the creation of a lot of baskets which will be potentially never used again. A task would have to be set to erease those regularly.  

*Future Development:*  
Extract all logic from controllers and encapsulate all of it in the Basket model or in another module.  

#### Admin Control of Categories

*Concern:*  
It would have been logical to hard code the few categories needed for the whole site as a constant hash, but we want the admin to be able to change them, and so we have to move them to the DB. Yet we do not want to query the DB every time a page has to display all or one category, because it's most of them.  

*Solution:*  
In order to have the benefit of a hard coded hash, I hooked a call to a module [Categorize](lib/categorize.rb) at start up and after the categories table is being touched. This module basically uses metaprogramming to enable a call to Category.all_as_hash to return all categoies, their IDs and their translations in one hash of the form: { en: {"c34-e6-fa34" => "books", ... }, fr: { "c34-e6-fa34" => "livres", ...}, that can be used as is in a form for a list of options in a select input for instance, without having to return to the DB.  

*Pros:*  
Once implemented, the call to all_as_hash becomes part of the API of the Category model and there's no need to worry about possible changes. It is also [well tested](spec/unit/categories/category_helper_methods.rb).  

*Cons:*  
It is hard to see how robust the solution is in development, because the app itself is constantly reloaded. I had to add a check in the application controller because the method wasn't always defined, especially in tests. It would probably need to be extensively live tested in production before launch.  

*Future Development:*  
The same system could be used to bypass DB calls for data that doesn't change too often, for "featured sellers", "popular tags" or "new products" for instance.  

---

I could have mentioned polymorphic locations, dashboard controllers, custom image validators, custom pagination, but they are more in line with standard MVC design and didn't really answer a specific, out of the ordinary issue.  

This is my [resume]().   
You can contact me at jcbelouard@gmail.com for more information.  