class Tool::CategoryDecorator < Geckorate::Decorator
  def decorate(options = {})
    {
      name: name
    }
  end

  def name
    __getobj__.name
  end
end
