# Options

```bash
-?, -h, --help          Shows this help message.
-a, --no-rebuild        Do not rebuild project dependencies.
-b, --build-file        Specifies the build file.
-c, --settings-file     Specifies the settings file.
--cancel                Cancels the build in Gradle daemon if it is running. [incubating]
--configure-on-demand   Only relevant projects are configured in this build run. This means faster build for large multi-project builds. [incubating]
--continue              Continues task execution after a task failure.
-D, --system-prop       Set system property of the JVM (e.g. -Dmyprop=myvalue).
-d, --debug             Log in debug mode (includes normal stacktrace).
--daemon                Uses the Gradle daemon to run the build. Starts the daemon if not running.
--foreground            Starts the Gradle daemon in the foreground. [incubating]
-g, --gradle-user-home  Specifies the gradle user home directory.
--gui                   Launches the Gradle GUI.
-I, --init-script       Specifies an initialization script.
-i, --info              Set log level to info.
-m, --dry-run           Runs the builds with all task actions disabled.
--no-color              Do not use color in the console output.
--no-daemon             Do not use the Gradle daemon to run the build.
--offline               The build should operate without accessing network resources.
-P, --project-prop      Set project property for the build script (e.g. -Pmyprop=myvalue).
-p, --project-dir       Specifies the start directory for Gradle. Defaults to current directory.
--parallel              Build projects in parallel. Gradle will attempt to determine the optimal number of executor threads to use. [incubating]
--parallel-threads      Build projects in parallel, using the specified number of executor threads. [incubating]
--profile               Profiles build execution time and generates a report in the <build_dir>/reports/profile directory.
--project-cache-dir     Specifies the project-specific cache directory. Defaults to .gradle in the root project directory.
-q, --quiet             Log errors only.
--recompile-scripts     Force build script recompiling.
--refresh-dependencies  Refresh the state of dependencies.
--rerun-tasks           Ignore previously cached task results.
-S, --full-stacktrace   Print out the full (very verbose) stacktrace for all exceptions.
-s, --stacktrace        Print out the stacktrace for all exceptions.
--stop                  Stops the Gradle daemon if it is running.
-u, --no-search-upward  Don't search in parent folders for a settings.gradle file.
-v, --version           Print version info.
-x, --exclude-task      Specify a task to be excluded from execution.

```