# frozen_string_literal: true

json.extract! note, :id, :title, :description, :user_id, :created_at, :updated_at
json.url note_url(note, format: :json)
