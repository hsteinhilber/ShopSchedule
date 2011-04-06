using System;
using System.Collections.Generic;
using System.Linq;
using Caliburn.Micro;
using NUnit.Framework;
using ShopSchedule.Infrastructure;
using System.Reflection;
using System.Windows.Controls;

namespace ShopSchedule.Conventions.Tests {

    [TestFixture]
    public class ViewAndViewModels {

        public IEnumerable<Type> GetViewModelTypes() {
            return from type in typeof(NinjectBootstrapper).Assembly.GetTypes()
                   where type.FullName.EndsWith("ViewModel")
                   && !type.IsAbstract && !type.IsInterface
                   && typeof(IScreen).IsAssignableFrom(type)
                   select type;
        }

        [Test]
        public void ViewModel_ThereIsAtLeastOneViewModel() {
            Assert.That(GetViewModelTypes(), Is.Not.Empty);
        }

        [TestCaseSource("GetViewModelTypes")]
        public void ViewModel_HasCorrespondingView(Type viewModel) {
            string viewName = viewModel.FullName.Replace("Model", String.Empty);
            Assert.That(viewModel.Assembly.GetType(viewName), Is.Not.Null, "Expected view model {0} to have a corresponding view {1}, but it did not.", viewModel.FullName, viewName);
        }
    }
}
