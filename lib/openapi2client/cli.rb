require 'thor'

module Openapi2client
  class CLI < Thor
    include Thor::Actions
    desc 'generate FILE_PATH', 'Generate API client code from OpenAPI YAML file'

    def generate(file_path)
      yaml = YAML.load_file(file_path)
      # OpenAPI YAMLを読み込んでAPIクライアントのコードを生成する処理
      puts 'Generated API client code'
    end
  end
end

