Given /^the merge article blog is set up$/ do
  Blog.default.update_attributes!({:blog_name => 'Test Blog - Article Merge', 
                                   :base_url => 'http://localhost:3000'});
  Blog.default.save!
  
  admin = User.create!({:login => 'admin',
                :password => 'aaaaaa',
                :email => 'joe@snow.com',
                :profile_id => 1,
                :name => 'admin',
                :state => 'active'})

  user1 = User.create!({:login => 'user1',
                :password => 'bbbbbb',
                :email => 'john@snow.com',
                :profile_id => 2,
                :name => 'User 1',
                :state => 'active'})

  article1 = Article.create!({
                :title => 'title1',
                :author => 'Admin',
                :body => 'Text of 1st article',
                :user_id => admin.id,
                :published => true})

  article2 = Article.create!({
                :title => 'title2',
                :author => 'User 1',
                :body => 'Text of 2nd article',
                :user_id => user1.id,
                :published => true})

  Comment.create!({
                :title => 'Comment on Article 1',
                :author => 'Commenter 1',
                :body => 'Comment of 1st article',
                :article_id => article1.id })
  Comment.create!({
                :title => 'Comment on Article 2',
                :author => 'Commenter 2',
                :body => 'Comment of 2nd article',
                :article_id => article2.id })
end

Given /^I am merging articles "(.*?)" and "(.*?)"$/ do |art1, art2|
        visit "/admin/content/edit/#{art1}"
        fill_in 'merge_with', :with => art2
        click_button 'Merge'
end

Then /^Article with id "(.*?)" then author should be "(.*?)"$/ do |id, author|
        article = Article.find_by_id(id)
        article.author == author
end

Given /I am logged in as "(.*?)" with password "(.*?)"$/ do |user, pw|
  visit '/accounts/login'
  fill_in 'user_login', :with => user
  fill_in 'user_password', :with => pw
  click_button 'Login'
  assert page.has_content? 'Login successful'
end