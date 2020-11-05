namespace :db do
  namespace :views do
    desc 'Refresh materialized views'
    task refresh: :environment do
      PopularTool.refresh
      CompanyPopularTool.refresh

      puts 'Refreshed materialized views'
    end
  end
end
