
using Caliburn.Micro;
using ShopSchedule.Infrastructure;
namespace ShopSchedule.Employees {
    public class EmployeeViewModel : Screen, IWorkspace {

        public EmployeeViewModel() {
            DisplayName = "Employees";
        }

        public string Icon { get { return @"/Resources/Images/employees.png"; } }
    }
}
