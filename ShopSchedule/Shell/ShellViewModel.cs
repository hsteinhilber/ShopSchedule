using Caliburn.Micro;
using System;
using ShopSchedule.Infrastructure;

namespace ShopSchedule.Shell {
    
    public class ShellViewModel : Conductor<IWorkspace>.Collection.OneActive {

        public ShellViewModel() {
            DisplayName = String.Format("Shop Schedule Maker {0}", DateTime.Today.Year);
            Items.Add(new Home.HomeViewModel());
            Items.Add(new Employees.EmployeeViewModel());
            ActivateItem(Items[0]);
        }
    }
}
