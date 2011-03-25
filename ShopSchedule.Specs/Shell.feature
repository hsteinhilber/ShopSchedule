Feature: Application Shell
	In order to organize workspaces
	As an application user
	I want to have a central location to select which workspace I am currently working on

Scenario: Starting the application
	Given I have not run the application
	When I open the application
	Then I should default to the statistics screen

Scenario: Employees workspace
	Given I have already opened the application
	When I click on the Employees button
	Then I should see the employee master screen

Scenario: Schedules workspace
	Given I have already opened the application
	When I click on the Schedules button
	Then I should see the schedule master screen

Scenario: Statistics workspace
	Given I visit the employee master screen
	When I click on the Statistics button
	Then I should see the statistics screen
	