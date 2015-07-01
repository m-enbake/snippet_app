json.array!(@snippets) do |snippet|
  json.extract! snippet, :id, :snippet_text, :private, :slug
  json.url snippet_url(snippet, format: :json)
end
