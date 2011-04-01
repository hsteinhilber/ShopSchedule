using Caliburn.Micro;
using System;

namespace ShopSchedule.Shell {
    
    public class ShellViewModel : Conductor<object>.Collection.OneActive {

        public ShellViewModel() {
            DisplayName = String.Format("Shop Schedule Maker {0}", DateTime.Today.Year);
        }
    }
}
