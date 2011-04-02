using System;
using NUnit.Framework;
using TechTalk.SpecFlow;
using White.Core;
using White.Core.UIItems;
using White.Core.UIItems.Finders;
using White.Core.UIItems.WindowItems;
using White.Core.UIItems.WPFUIItems;

namespace ShopSchedule.Specs {

    [Binding]
    public class ShellActions {

        Application application;
        Window mainWindow;

        [Given(@"I have not run the application")]
        public void GivenIHaveNotRunTheApplication() {
            // Do nothing, application isn't started yet
            Assume.That(application, Is.Null);
            Assume.That(mainWindow, Is.Null);
        }

        [When("I open the application")]
        public void WhenIOpenTheApplication() {
            application = Application.Launch("ShopSchedule.exe");
            Assume.That(application, Is.Not.Null, "Application failed to start!");
            mainWindow = application.GetWindows()[0];
            Assume.That(mainWindow, Is.Not.Null, "Could not find the primary window!");
        }

        [Then("I should see the home screen")]
        public void ThenIShouldDefaultToTheStatisticsScreen() {            
            WPFLabel titleLabel = mainWindow.Get<WPFLabel>(SearchCriteria.ByAutomationId("DisplayName").AndIndex(1));
            Assert.That(titleLabel, Is.Not.Null, "Could not find the title label for the active content item.");

            Assert.That(titleLabel.Text, Is.StringMatching("home").IgnoreCase);
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
