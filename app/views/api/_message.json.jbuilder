json.(message, :id, :text, :created_at)

if message.author
  json.author do
    json.cache! message.author do
      json.partial! message.author
    end
  end
end
