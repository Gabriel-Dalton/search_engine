# app/controllers/search_controller.rb
class SearchController < ApplicationController
  def index
    if params[:query].present?
      bing_service = BingSearchService.new
      @results = bing_service.search(
        query: params[:query],
        count: params[:count],
        mkt: params[:mkt],
        safesearch: params[:safesearch],
        freshness: params[:freshness],
        sortby: params[:sortby]
      )

      Rails.logger.debug "Bing API Response: #{@results.inspect}"
      current_user.search_histories.create(query: params[:query]) if user_signed_in?
    end
  end
end