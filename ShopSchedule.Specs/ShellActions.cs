using NUnit.Framework;
using TechTalk.SpecFlow;
using White.Core;
using White.Core.UIItems;
using White.Core.UIItems.WindowItems;

namespace ShopSchedule.Specs {

    [Binding]
    public class ShellActions {

        Application application;
        Window mainWindow;

        [Given(@"I have not opened the application")]
        public void DoNothing() {
            // Do nothing, application isn't started yet
            Assume.That(application, Is.Null);
            Assume.That(mainWindow, Is.Null);
        }

        [Given("I have opened the application")]
        [When("I open the application")]
        public void RunTheApplication() {
            application = Application.Launch("ShopSchedule.exe");
            Assume.That(application, Is.Not.Null, "Application failed to start!");
            mainWindow = application.GetWindows()[0];
            Assume.That(mainWindow, Is.Not.Null, "Could not find the primary window!");
        }

        [When("I click on the employees button")]
        public void ClickOnWorkspaceButton() {
            Button button = mainWindow.Get<Button>("Employees");
            Assume.That(button, Is.Not.Null, "Button '{0}' was expected to be clicked, but could not be found.", "Employees");

            button.Click();
        }

        [Then(@"I should see the (\w+) workspace")]
        public void ShouldDisplayWorkspace(string workspace) {
            WPFLabel titleLabel = mainWindow.Get<WPFLabel>("WorkspaceTitle");
            Assert.That(titleLabel, Is.Not.Null, "Could not find the title label for the active content item.");

            Assert.That(titleLabel.Text, Is.StringMatching(workspace).IgnoreCase);
        }

        [AfterScenario]
        public void CleanupApplication() {
            if (mainWindow != null) {
                mainWindow.Close();
                mainWindow = null;
            }
            if (application != null && application.HasExited) {
                application.Kill();
                application = null;
            }
        }
    }
}
