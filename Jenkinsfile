pipeline {
  agent any

  environment {
    PATH="/var/jenkins_home/.asdf/shims:/var/jenkins_home/.asdf/bin:/usr/local/openjdk-8/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  }

  stages {
    stage("Build") {
      steps {
        sh ". ./var/jenkins_home/.bashrc"
        sh "mix do deps.get, deps.compile"
      }
    }

    stage("Test") {
      steps {
        sh "mix test --cover"
      }
    }

  }

  post{
    always{
      cobertura coberturaReportFile: "coverage.xml"
    }
  }
}
