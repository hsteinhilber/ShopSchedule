
using Caliburn.Micro;
using ShopSchedule.Infrastructure;
namespace ShopSchedule.Employees {
    public class EmployeeViewModel : Screen, IWorkspace {

        public EmployeeViewModel() {
            DisplayName = "Employees";
        }

        public string Icon { get { return @"/Resources/Images/employees.png"; } }

        public void Show() {
            IConductor conductor = this.Parent as IConductor;
            if (conductor == null) return;

            conductor.ActivateItem(this);
        }
    }
}
