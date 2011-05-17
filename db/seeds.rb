# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

def add_template(path,body)
  template = SqlTemplate.new
  template.format = "html"
  template.locale = "en"
  template.handler = "erb"
  template.path = path
  template.body = body
  template.save!
end

SqlTemplate.delete_all

add_template "users/index", "<h1>All Users</h1> <h2>List</h2> <table> <tr> <th>Name</th> <th></th> <th></th> <th></th> </tr> <% @users.each do |user| %> <tr> <td><%= user.name %></td> <td><%= link_to 'Show', user %></td> <td><%= link_to 'Edit', edit_user_path(user) %></td> <td><%= link_to 'Destroy', user, :confirm => 'Are you sure?', :method => :delete %></td> </tr> <% end %> </table> <br /> <%= link_to 'New User', new_user_path %>"
add_template "about", "<h1>About</h1> This template engine was written by Cicero Oliveira."

body = <<EOF
<h1>Welcome to a CMS template engine.</h1> Templates for this applications might be served from files, like in a regular rails application, or through a database. <h2>CMS functionality</h2> As pages can be served from the database, a controller called CMS will simply attempt to render the page which will be retrieved from the database instead of from a file. <h3>Example</h3> When you try to access the address CMS/about. The about page will be retrieved from the database. Try going to <%= link_to "SQL Templates", sql_templates_path %> and changing the about page. After you save your changes will be reflected immediately when you access the <%= link_to 'cms/about', \"\#{root_url}cms/about\" %>
EOF
add_template "welcome", body

body = <<EOF
<!DOCTYPE html>
<html>
<head>
	<!--[if lt IE 9]>
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

	<title>Template Generator</title>

  	<%= stylesheet_link_tag "application" %>

  	<%= javascript_include_tag :defaults %>
  	<%= csrf_meta_tag %>
	<%= yield(:head) %>	
</head>
<body>
	<section id="container">
		<header>
			<h1><%= link_to "CMS Template Engine", root_path %></h1>

			<nav>
				<ul>
					<li><%= link_to "Home", root_path %></a></li>
					<li><%= link_to "Templates", sql_templates_path %></a></li>
				</ul>
			</nav>

		</header>

		<section id="main-content">
			<%= yield %>
		</section>

		<section id="subnav">
		</section>
	</section>
</body>
</html>
EOF
add_template "layouts/cms", body

add_template "layouts/sql_template", body