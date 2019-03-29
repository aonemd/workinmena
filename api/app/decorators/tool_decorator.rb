class ToolDecorator < Geckorate::Decorator
  def decorate
    {
      name: name
    }.as_json
  end
end
