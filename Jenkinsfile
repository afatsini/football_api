pipeline {
  agent {
      docker { image 'FROM elixir:1.7.1-slim' }
  }

  environment {
    SOME_VAR = "/home/deployer"
  }

  stages {
    stage("Build") {
      steps {
        sh "curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
            && tar xzvf docker-17.04.0-ce.tgz \
            && mv docker/docker /usr/local/bin \
            && rm -r docker docker-17.04.0-ce.tg"
        sh "MIX_ENV=test mix local.hex --force && mix local.rebar --force"
        sh "MIX_ENV=test mix local.hex --force && mix local.rebar --forcemix do deps.get, deps.compile"
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
