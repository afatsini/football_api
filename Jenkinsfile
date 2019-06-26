pipeline {
  agent any

  environment {
    SOME_VAR = "/home/deployer"
  }

  stages {
    stage("Build") {
      steps {
        bash "mix local.hex --force"
        bash "mix local.rebar"
        bash "mix do deps.get, deps.compile"
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
