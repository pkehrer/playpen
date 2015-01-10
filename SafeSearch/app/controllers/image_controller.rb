class ImageController < ApplicationController
  include ApplicationHelper

  def index
  end

  def query
    @page = params[:page].nil? ? 1 : params[:page].to_i
    @query = params[:query]

    json1 = image_search(params[:query], (@page-1)*20+1)
    json2 = image_search(params[:query], (@page-1)*20+11)
    result_obj1 = JSON.parse(json1)
    result_obj2 = JSON.parse(json2)

    if (!result_obj1["error"].nil?)
      @error = result_obj1["error"]["message"]
    elsif (result_obj1["searchInformation"]["totalResults"] == "0")
      @raw = "Sorry, but your search returned Zero results."
      @results = nil
    elsif(result_obj1["items"].nil?)
      @raw = json
      @results = nil
    else
      @results = result_obj1["items"].collect{|i| {:title => i["htmlTitle"],
                                                  :link => i["link"],
                                                  :description => i["htmlSnippet"],
                                                  :thumb => i["image"]["thumbnailLink"]}}
      if (!result_obj2["items"].nil?)
        result_obj2["items"].collect{|i| {:title => i["htmlTitle"],
                                                      :link => i["link"],
                                                      :description => i["htmlSnippet"],
                                                      :thumb => i["image"]["thumbnailLink"]}}.each {|r| @results.append(r)}
      end
    end

    render 'index'
  end
end
