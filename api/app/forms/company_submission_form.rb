class CompanySubmissionForm
  def initialize(args)
    @params = args
    separate_tools
  end

  def call
    company_submission = Company::Submission.new(create_params)
  end

  private

  def create_params
    {
      name: @params.fetch(:name, ''),
      website: @params.fetch(:website, ''),
      tool_ids: @tool_ids,
      unknown_tools: @unknown_tools
    }
  end

  def separate_tools
    known_tools   = @params.fetch(:tools, []).filter { |item| !item[:id].nil? }
    unknown_tools = @params.fetch(:tools, []).filter { |item| item[:id].nil? }

    @tool_ids      = known_tools.map { |item| item[:id] }
    @unknown_tools = unknown_tools.map { |item| item[:name] }
  end
end
