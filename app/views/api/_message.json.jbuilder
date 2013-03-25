json.(message, :id, :text)

if message.author
  json.author do
    json.partial! message.author
  end
end