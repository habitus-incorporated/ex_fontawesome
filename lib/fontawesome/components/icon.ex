if Code.ensure_loaded?(Surface) do
  defmodule FontAwesome.Components.Icon do
    @moduledoc """
    A Surface component for rendering Font Awesome icons.

    ## Examples

        <FontAwesome.Components.Icon name="address-book" type="regular" class="h-4 w-4" />
    """

    use Surface.Component

    @doc "The name of the icon"
    prop name, :string, required: true

    @doc """
    The type of the icon

    Required if default type is not configured.
    """
    prop type, :string

    @doc "The class of the icon"
    prop class, :css_class

    @doc "All options are forwarded to the underlying SVG tag as HTML attributes"
    prop opts, :keyword, default: []

    def render(assigns) do
      ~F"""
      { FontAwesome.icon(@name, type_to_opts(@type) ++ class_to_opts(@class) ++ @opts) }
      """
    end

    defp type_to_opts(type) do
      type = type || FontAwesome.default_type()

      unless type do
        raise ArgumentError,
              "type prop is required if default type is not configured."
      end

      [type: type]
    end

    defp class_to_opts(class) do
      if class do
        [class: Surface.css_class(class)]
      else
        []
      end
    end
  end
end
