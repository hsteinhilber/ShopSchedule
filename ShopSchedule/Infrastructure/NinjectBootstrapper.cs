using System;
using Caliburn.Micro;
using Ninject;
using Ninject.Extensions.Conventions;
using System.Collections.Generic;
using ShopSchedule.Shell;

namespace ShopSchedule.Infrastructure {

    public class NinjectBootstrapper : Bootstrapper<ShellViewModel> {
        IKernel kernel;

        protected override void Configure() {
            kernel = new StandardKernel();
            kernel.Scan(scanner => {
                scanner.From(AssemblySource.Instance);
                scanner.BindWithDefaultConventions();
                scanner.InTransientScope();
            });
            kernel.Bind<IWindowManager>().ToMethod(ctx => new WindowManager()).InSingletonScope();
            kernel.Bind<IEventAggregator>().ToMethod(ctx => new EventAggregator()).InSingletonScope();
            kernel.Bind<IKernel>().ToMethod(ctx => kernel);
        }

        protected override object GetInstance(Type service, string key) {
            return kernel.Get(service, key);
        }

        protected override IEnumerable<object> GetAllInstances(Type service) {
            service.ThrowIfNull("service");

            return kernel.GetAll(service);
        }

        protected override void BuildUp(object instance) {
            kernel.Inject(instance);
        }
    }
}
