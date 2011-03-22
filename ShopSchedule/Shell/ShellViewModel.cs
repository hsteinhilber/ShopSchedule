using Caliburn.Micro;

namespace ShopSchedule.Shell {
    
    public class ShellViewModel : Conductor<object>.Collection.OneActive {

        public ShellViewModel() {
            DisplayName = "Shop Scheduler";
        }
    }
}
