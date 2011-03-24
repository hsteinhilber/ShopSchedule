Feature: Employee Details
	In order to track employee availability and status
	As a shop manager
	I want to be able to see an individual employees details

Scenario: Selecting employee from master list
	Given I have an employee named Alice
	And I visit the employee master screen
	When I click on Alice
	Then I should be on the employee detail screen for Alice
	And I should see Alice's name

Scenario: Viewing a shop manager
	Given I have an employee named Alice
	And Alice is manager
	When I visit the employee detail screen for Alice
	Then I should see Alice's name
	And I should see Alice can work a minimum of 45 hours
	And I should see Alice can work a maximum of 80 hours
	And I should see Alice is Salaried
	And I should see Alice is available from 12:00 AM to 11:59 PM on Sunday
	And I should see Alice is available from 12:00 AM to 11:59 PM on Monday
	And I should see Alice is available from 12:00 AM to 11:59 PM on Tuesday
	And I should see Alice is available from 12:00 AM to 11:59 PM on Wednesday
	And I should see Alice is available from 12:00 AM to 11:59 PM on Thursday
	And I should see Alice is available from 12:00 AM to 11:59 PM on Friday
	And I should see Alice is available from 12:00 AM to 11:59 PM on Saturday

Scenario: Viewing a full time employee
	Given I have an employee named Alice
	And Alice is full time
	And Alice can only work 04:00 AM to 02:00 PM on Monday
	And Alice cannot work on Thursday
	When I visit the employee detail screen for Alice
	Then I should see Alice's name
	And I should see Alice can work a minimum of 35 hours
	And I should see Alice can work a maximum of 40 hours
	And I should see Alice is Hourly
	And I should see Alice is available from 12:00 AM to 11:59 PM on Sunday
	And I should see Alice is available from 04:00 AM to 02:00 PM on Monday
	And I should see Alice is available from 12:00 AM to 11:59 PM on Tuesday
	And I should see Alice is available from 12:00 AM to 11:59 PM on Wednesday
	And I should see Alice is available from 12:00 AM to 12:00 AM on Thursday
	And I should see Alice is available from 12:00 AM to 11:59 PM on Friday
	And I should see Alice is available from 12:00 AM to 11:59 PM on Saturday

Scenario: Viewing a part time employee
	Given I have an employee named Alice
	And Alice is part time
	And Alice cannot work on Tuesday
	And Alice cannot work on Wednesday
	And Alice can only work 02:00 PM to 11:59 PM on Saturday
	When I visit the employee details screen for Alice
	Then I should see Alice's name
	And I should see Alice can work a minimum of 0 hours
	And I should see Alice can work a maximum of 40 hours
	And I should see Alice is Hourly
	And I should see Alice is available from 12:00 AM to 11:59 PM on Sunday
	And I should see Alice is available from 12:00 AM to 11:59 PM on Monday
	And I should see Alice is available from 12:00 AM to 12:00 AM on Tuesday
	And I should see Alice is available from 12:00 AM to 12:00 AM on Wednesday
	And I should see Alice is available from 12:00 AM to 11:59 PM on Thursday
	And I should see Alice is available from 12:00 AM to 11:59 PM on Friday
	And I should see Alice is available from 02:00 PM to 11:59 PM on Saturday