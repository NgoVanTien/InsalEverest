class V1 < Grape::API
  VERSION = name.downcase

  version VERSION, using: :path
  mount Users

  add_swagger_documentation hide_documentation_path: true, api_version: VERSION, info: {
    title: "Insal API",
    description: "API for insal"
  }
end
