#!/usr/bin/env bash
# Build, test and launch this assignment with its required macOS Java 8 runtime.
set -euo pipefail
cd "$(dirname "$0")"
assignment_jdk="../runtime/zulu8.98.0.111-ca-jdk8.0.512-macosx_aarch64/Contents/Home"
if [ ! -x "$assignment_jdk/bin/java" ]; then
  printf '%s\n' 'The assignment Java 8 runtime is missing. Select Java 8 in IntelliJ or restore the runtime folder.' >&2
  exit 1
fi
export JAVA_HOME="$(cd "$assignment_jdk" && pwd)"
export PATH="$JAVA_HOME/bin:$PATH"
java -version
mvn -version
mvn clean test | tee ../runtime/mock-internship-maven-tests.log
mvn -DskipTests package | tee ../runtime/mock-internship-maven-package.log
mvn compile exec:java
