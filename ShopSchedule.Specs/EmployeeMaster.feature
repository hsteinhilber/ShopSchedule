Feature: Employees Master List
	In order to track employees
	As a shop manager
	I want to be able to see a list of my active employees

Scenario: No employees defined
	Given I have no employees
	When I visit the employee master screen
	Then I should see a message saying there are no employees defined

Scenario: One employee defined
	Given I have an employee named Alice
	When I visit the employee master screen
	Then I should see Alice in the employee list

Scenario: Multiple employees defined
	Given I have an employee named Alice
	And I have an employee named Bob
	When I visit the employee master screen
	Then I should see Alice in the employee list
	And I should see Bob in the employee list

Scenario: Multiple employees defined with one inactive
	Given I have an employee named Alice
	And I have an employee named Bob
	And I have an employee named Charlie
	And Eve is marked as inactive
	When I visit the employee master screen
	Then I should see Alice in the employee list
	And I should see Bob in the employee list
	And I should not see Charlie in the employee list
