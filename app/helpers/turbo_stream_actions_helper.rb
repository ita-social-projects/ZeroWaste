module TurboStreamActionsHelper
  def toast(message, background: "#DC3545")
    turbo_stream_action_tag(:toast, message: message, background: background)
  end
end

Turbo::Streams::TagBuilder.prepend(TurboStreamActionsHelper)
