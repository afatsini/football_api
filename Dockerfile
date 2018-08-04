FROM elixir:1.7.1-slim

#expose port
EXPOSE 4000

#set working directory
WORKDIR /app

# Install hex locally
RUN mix local.hex --force && mix local.rebar --force

# Copy the contents
COPY . /app/

#set project to run in PROD env
ENV MIX_ENV=prod

#set application port
ENV PORT=4000

# Compile
RUN mix deps.get
RUN mix deps.compile
RUN mix compile

# Run the application
CMD ["mix", "phx.server", "--no-halt", "--no-compile", "--no-deps-check"]
