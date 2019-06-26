pipeline {
  agent any

  environment {
    SOME_VAR = "/home/deployer"
  }

  stages {
    stage("Build") {
      steps {
        sh '''#!/bin/bash
          /var/jenkins_home/.asdf/shims/mix do deps.get, deps.compile
        '''
      }
    }

    stage("Test") {
      steps {
        sh "/var/jenkins_home/.asdf/shims/mix test --cover"
      }
    }
  }

  post{
    always{
      cobertura coberturaReportFile: "coverage.xml"
    }
  }
}
