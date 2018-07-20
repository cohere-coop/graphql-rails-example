# Entrance point into Rails GraphQL
class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token
  def execute
    operation_name = params[:operationName]
    result = AppSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    p result.to_json
    render json: result
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  def context
    {
      current_user: current_user,
    }
  end

  def current_user
    @current_user ||= authenticate_with_http_token do |token|
      AccessTokenIdentity.authenticate(OpenStruct.new(access_token: OpenStruct.new(token: token))).user
    end || Guest.new
  end

  def query
    params[:query]
  end

  def variables
    ensure_hash(params[:variables])
  end
  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(error)
    logger.error error.message
    logger.error error.backtrace.join("\n")

    render json: { error: { message: error.message, backtrace: error.backtrace }, data: {} }, status: 500
  end
end
