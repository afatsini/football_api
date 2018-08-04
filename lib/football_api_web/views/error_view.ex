defmodule FootballApiWeb.ErrorView do
  use FootballApiWeb, :view

  def render("404.html", _assigns) do
    "Not found"
  end

  def render("400.html", _assigns) do
    "Bad Request"
  end

  def render(<<_status::binary-size(3)>> <> ".html", _assigns) do
    "Internal Server Error"
  end

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
