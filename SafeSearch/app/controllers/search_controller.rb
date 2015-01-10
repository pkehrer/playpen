require 'rubygems'
require 'json'

class SearchController < ApplicationController
  include ApplicationHelper

  def index

  end

  def query
    @page = params[:page].nil? ? 1 : params[:page].to_i
    @query = params[:query]
    json = web_search(params[:query], (@page-1)*10 + 1)
    result_obj = JSON.parse(json)

    if (!result_obj["error"].nil?)
      @error = result_obj["error"]["message"]
    elsif (result_obj["searchInformation"]["totalResults"] == "0")
      @raw = "Sorry, but your search returned Zero results."
      @results = nil
    elsif(result_obj["items"].nil?)
      @raw = json
      @results = nil
    else
      @results = result_obj["items"].collect{|i| {:title => i["htmlTitle"], :link => i["link"], :description => i["htmlSnippet"]}}
    end

    render 'index'
  end
end
