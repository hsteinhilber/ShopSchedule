﻿using Caliburn.Micro;
using ShopSchedule.Infrastructure;

namespace ShopSchedule.Home {
    public class HomeViewModel : Screen, IWorkspace {

        public HomeViewModel() {
            DisplayName = "Home Page";
        }

        public string Icon { get { return @"/Resources/Images/home.png"; } }

        public void Show() {
        }
    }
}