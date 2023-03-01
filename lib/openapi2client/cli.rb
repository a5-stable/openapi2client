require 'thor'
require 'fileutils' 

module Openapi2client
  class CLI < Thor
    include Thor::Actions
    desc 'generate FILE_PATH', 'Generate API client code from OpenAPI YAML file'

    def generate(file_path)
      # yaml = YAML.load_file(file_path)
      # # OpenAPI YAMLを読み込んでAPIクライアントのコードを生成する処理
      # puts 'Generated API client code'

      data = File.open("sample.json") do |f|
        JSON.load(f)
      end

      Dir.mkdir("outputs/")
      Dir.mkdir("outputs/lib")
      data["tags"].each do |tag|
        FileUtils.touch("outputs/lib/#{tag["name"]}.rb")
      end

      FileUtils.touch("outputs/lib/client.rb")

      template_file_path = "../templates/client.rb"
      copied_file_path = "outputs/lib/client.rb"

      # Read the content of the template file
      template_file_content = File.read(template_file_path)

      # Replace the placeholders in the template file content with the passed argument
      replaced_content = template_file_content.gsub('___API_BASE_URL___', "https://" + data["host"] + data["basePath"])

      # Write the replaced content to the copied file
      File.write(copied_file_path, replaced_content)

      data["paths"].each do |pathname, hash|
        method = hash.keys.first
        target_file = "lib/#{hash[method]["tags"][0]}"

        method_name = operationId
      end
    end
  end
end

