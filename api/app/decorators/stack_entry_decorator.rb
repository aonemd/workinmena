class StackEntryDecorator < Geckorate::Decorator
  def decorate(options = {})
    {
      id: id,
      community: community,
      endorsements: community_endorsements,
      tool: ToolDecorator.new(tool).decorate
    }
  end
end
