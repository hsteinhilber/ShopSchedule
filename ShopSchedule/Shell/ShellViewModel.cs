using System;
using System.Windows;
using Caliburn.Micro;

namespace ShopSchedule.Shell {
    
    public class ShellViewModel : Conductor<object> {

        public ShellViewModel() {
            DisplayName = "Shop Scheduler";
        }
    }
}
