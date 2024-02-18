class ApplicationController < ActionController::API
  rescue_from StandardError do |e|
    Rails.logger.error "#{e.class}: #{e}"
    e.backtrace.take(15).each { |b| Rails.logger.error "  #{b}" }

    case e
    when ActiveRecord::RecordInvalid
      render status: :bad_request, json: { errors: e.record.errors.full_messages }
    else
      render status: :bad_request, json: { errors: [e.message] }
    end
  end
end
