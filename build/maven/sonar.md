# Sonar

* Execute **sonar** analysis:

```bash
mvn cobertura:cobertura sonar:sonar -Dmaven.test.failure.ignore=true -Dsonar.skippedModules=snz-parent -e -Ptest
```