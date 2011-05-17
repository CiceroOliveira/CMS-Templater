CMS Template Engine
===================

Welcome to a CMS template engine.

Templates for this applications might be served from files, like in a regular rails application, or through a database.

CMS functionality
-----------------

As pages can be served from the database, a controller called CMS will simply attempt to render the page which will be retrieved from the database instead of from a file.

Example
-------
When you try to access the address CMS/about. The about page will be retrieved from the database. Try going to SQL Templates and changing the about page. After you save your changes will be reflected immediately when you access the cms/about