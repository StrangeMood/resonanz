messages = messages.includes(:author) if messages.is_a?(ActiveRecord::Relation)

json.array! messages do |message|
  json.(message, :id, :text, :created_at)

  if message.author
    json.author do
      json.(message.author, :id, :name)
    end
  end
end