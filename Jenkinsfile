pipeline {
  agent any

  environment {
    SOME_VAR = "/home/deployer"
  }

  stages {
    stage("Build") {
      steps {
        sh "mix local.hex --force"
        sh "mix local.rebar"
        sh "mix do deps.get, deps.compile"
      }
    }

    stage("Test") {
      steps {
        sh "mix test --cover"
      }
    }

    stage("Credo"){
      steps{
        sh "mix credo --strict"
      }
    }
  }

  post{
    always{
      cobertura coberturaReportFile: "coverage.xml"
    }
  }
}
