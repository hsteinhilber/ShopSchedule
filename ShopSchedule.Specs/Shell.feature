Feature: Application Shell
	In order to organize workspaces
	As an application user
	I want to have a central location to select which workspace I am currently working on

Scenario: Starting the application
	Given I have not opened the application
	When I open the application
	Then I should see the home workspace

Scenario: Employees workspace
	Given I have opened the application
	When I click on the employees button
	Then I should see the employee master workspace

Scenario: Schedules workspace
	Given I have opened the application
	When I click on the schedules button
	Then I should see the schedule master workspace

Scenario: Home workspace
	Given I visit the employee master workspace
	When I click on the home button
	Then I should see the home workspace
	
Scenario: Settings workspace
	Given I have opened the application
	When I click on the settings button
	Then I should see the settings workspace