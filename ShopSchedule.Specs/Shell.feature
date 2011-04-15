Feature: Application Shell
	In order to organize workspaces
	As an application user
	I want to have a central location to select which workspace I am currently working on

Scenario: Starting the application
	Given I have not opened the application
	When I open the application
	Then I should see the Home workspace

Scenario: Employees workspace
	Given I have opened the application
	When I click on the Employees button
	Then I should see the Employees workspace

Scenario: Schedules workspace
	Given I have opened the application
	When I click on the Schedules button
	Then I should see the Schedules workspace

Scenario: Home workspace
	Given I have opened the application
	And I visit the Employees workspace
	When I click on the Home button
	Then I should see the Home workspace
	
Scenario: Settings workspace
	Given I have opened the application
	When I click on the Settings button
	Then I should see the Settings workspace