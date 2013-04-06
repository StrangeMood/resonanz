json.(conversation, :id, :slug)

if conversation.messages.present?
  json.lastMessage do
    json.cache! conversation.messages.last do
      json.partial! conversation.messages.last
    end
  end
end