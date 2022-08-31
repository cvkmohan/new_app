defmodule NewAppWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use NewAppWeb, :controller
      use NewAppWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)

  def controller do
    quote do
      use Phoenix.Controller, namespace: NewAppWeb

      import Plug.Conn
      import NewAppWeb.Gettext

      unquote(verified_routes())
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/new_app_web/templates",
        namespace: NewAppWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_csrf_token: 0, get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {NewAppWeb.LayoutView, "live.html"}

      unquote(view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
    end
  end

  def component do
    quote do
      use Phoenix.Component

      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router, helpers: false

      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: NewAppWeb.Endpoint,
        router: NewAppWeb.Router,
        statics: NewAppWeb.static_paths()
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import NewAppWeb.Gettext
    end
  end

  defp view_helpers do
    quote do
      # Import basic HTML rendering capabilities (tags, forms, etc)
      use Phoenix.HTML

      # Import .heex helpers (<.link>, <.form>, etc) and alias JS module
      import Phoenix.LiveView.Helpers
      alias Phoenix.LiveView.JS

      # Include the router functionality defined above
      unquote(verified_routes())

      # All imports from the current project should be defined from here under
      import NewAppWeb.ErrorHelpers
      import NewAppWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
