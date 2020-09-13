class ToolDecorator < Geckorate::Decorator
  def decorate(options = {})
    {
      name: name
    }
  end
end
