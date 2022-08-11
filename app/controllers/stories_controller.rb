class StoriesController < ApplicationController
  before_action :set_story, only: %i[show destroy]

  def new
    @story = Story.new
  end

  def index
    @stories = Story.all
  end

  def show; end

  def create
    @story = Story.new(story_params)
    if @story.save
      redirect_to users, notice: 'story is successfuly created'
    else
      render :new, notice: @story.errors.full_messages.to_sentence.to_s
    end
  end

  def destroy
    if @story.destroy
      redirect_to users_url, notice: 'Story was successfully deleted.'
    else
      redirect_to users_url, notice: "Something went wrong. #{@story.errors.full_messages.to_sentence}"
    end
  end

  private

  def story_params
    params.require(:story).permit(:user_id, images: [])
  end

  def set_story
    @story = Story.find(params[:id])
  end
end
