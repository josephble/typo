Feature: Merge Articles
  As a blog administrator
  In order to limit the number of duplicate topics
  I want to be able to merge articles on my blog

  Background: Users and Articles exist within a blog
    Given the merge article blog is set up

    Scenario: Non-admin attempts to merge articles, and fails
      Given I am logged in as "user1" with password "bbbbbb"
      And I am on the admin content page
      When I follow "title1"
      Then I should not see "Merge Articles"

    Scenario: Admin attempts to merge articles, and succeeds
      Given I am logged into the admin panel 
      And I am on the admin content page
      When I follow "title1"
      Then I should see "Merge Articles"
    
    Scenario: Merged article should contain text of both previous articles
      Given I am logged into the admin panel 
      And I am on the admin content page
      Given I follow "title1"
      And I fill in "merge_with" with "4"
      And I press "Merge"
      Then I should be on the admin content page
      When I go to the home page
      Then I should see "title1"
      When I follow "title1"
      Then I should see "Text of 1st article"
      And I should see "Text of 2nd article"

    Scenario: Merged article should only list one of the orignal authors
      Given I am logged into the admin panel
      And I am merging articles "3" and "4"
      Then Article with id "3" then author should be "User 1"

    Scenario: Merged article should contain the comments of both articles
      Given I am logged into the admin panel
      And I am merging articles "3" and "4"
      Then I should be on the admin content page
      When I go to the home page
      Then I should see "title1"
      When I follow "title1"
      Then I should see "Comment of 1st article"
      And I should see "Comment of 2nd article" 

    Scenario: Merged article's title should be from either one of the merged articles
      Given I am logged into the admin panel
      And I am merging articles "3" and "4"
      Then I should be on the admin content page
      And I should see "title1"
      And I should not see "title2"