using System.Collections.Generic;
using Laborator4.implementation;

namespace Laborator4
{
    class Program
    {
        private static readonly List<string> HOSTS = new List<string> {
            "www.cs.ubbcluj.ro/~rlupsa/edu/pdp",
            "facebook.com",
            "google.com",
        };

        public static void Main(string[] args)
        {
            //DirectCallbacks.run(HOSTS);
            TaskMechanism.run(HOSTS);
            //AsyncTaskMechanism.run(HOSTS);
        }
    }
}
