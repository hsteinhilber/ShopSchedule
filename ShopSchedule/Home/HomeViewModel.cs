using Caliburn.Micro;
using ShopSchedule.Infrastructure;

namespace ShopSchedule.Home {
    public class HomeViewModel : Screen, IWorkspace {

        public HomeViewModel() {
            DisplayName = "Home";
        }

        public string Icon { get { return @"/Resources/Images/home.png"; } }

        public void Show() {
            IConductor conductor = this.Parent as IConductor;
            if (conductor == null) return;

            conductor.ActivateItem(this);
        }
    }
}
