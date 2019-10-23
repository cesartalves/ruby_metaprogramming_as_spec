docker run --rm -ti  -v $(pwd):/usr/src --link sonarqube newtmitch/sonar-scanner \
  -Dsonar.projectKey=ruby-test \

