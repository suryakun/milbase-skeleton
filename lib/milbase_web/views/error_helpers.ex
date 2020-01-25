defmodule MilbaseWeb.ErrorHelpers do
  alias AbsintheErrorPayload.ValidationMessage
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate "is invalid" in the "errors" domain
    #     dgettext("errors", "is invalid")
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    # This requires us to call the Gettext module passing our gettext
    # backend as first argument.
    #
    # Note we use the "errors" domain, which means translations
    # should be written to the errors.po file. The :count option is
    # set by Ecto and indicates we should also apply plural rules.
    if count = opts[:count] do
      Gettext.dngettext(MilbaseWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(MilbaseWeb.Gettext, "errors", msg, opts)
    end
  end

  @spec validate_translate([%ValidationMessage{}]) :: [%ValidationMessage{}]
  def validate_translate(messages) do
    Enum.map(messages, &translate_validation/1)
  end

  defp translate_validation(%ValidationMessage{options: [count: count] = options, message: message} = err) do
      %ValidationMessage{err | message: Gettext.dngettext(MilbaseWeb.Gettext, "errors", message, message, count, options)}
  end

  defp translate_validation(%ValidationMessage{options: options, message: message} = err) do
      %ValidationMessage{err | message: Gettext.dgettext(MilbaseWeb.Gettext, "errors", message, options)}
  end
end
