# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story, only: %i[show destroy]
  before_action :set_user, only: %i[new show destroy]

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @stories = Story.all
    @stories = policy_scope(Story).reverse
  end

  def new
    @story = Story.new
    authorize @story
  end

  def show; end

  def create
    @user = User.find(params[:user_id])
    @story = @user.stories.create(story_params)
    authorize @story
    if @story.save
      DeleteStoriesJob.set(wait: 1.day).perform_later(@story.id)
      redirect_to users_url, notice: 'story is successfuly created'
    else
      redirect_to new_user_story_url, notice: @story.errors.full_messages.to_sentence.to_s
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
    authorize @story
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end