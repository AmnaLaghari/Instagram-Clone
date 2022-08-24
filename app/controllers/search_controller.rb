# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @users = @query.result(distinct: true)
  end
end
