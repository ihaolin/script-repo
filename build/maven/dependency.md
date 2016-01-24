# Dependency 

* analyze the dependencies and determine which of them are used/unused or declared/undeclared.

```bash
mvn dependency:analyze
```

* generate an HTML report, available at the target/dependency-analysis.html

```bash
mvn dependency:analyze-report
```

* display the complete classpath of your project, with the concrete locations, that is, most of the time, the path in the Maven local repository

```bash
mvn dependency:build-classpath
```
* display the same information as dependency:tree, all dependencies

```bash
mvn dependency:list
```
* display the remote repositories used for the current build

```bash
mvn dependency:list-repositories
```

* mvn dependency:copy-dependencies will copy all the dependencies to a folder (by default, target/dependency). A use case is when you need create an archive or a distribution. Plugin assembly can do it, too, and in a better way.

```bash
mvn dependency:copy-dependencies
```
* mvn dependency:sources will download the sources of dependencies when available

```bash
mvn dependency:sources
```

* purge-local-repository will clean the local repository

```bash
mvn dependency:purge-local-repository
```



