# frozen_string_literal: true

class DeleteStoriesJob < ApplicationJob
  queue_as :default

  def perform(story_id)
    story = Story.find(story_id)
    story.destroy!
  end
end
