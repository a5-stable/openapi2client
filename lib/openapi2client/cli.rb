require 'thor'
require 'fileutils'
require 'json'

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
        file_name = "outputs/lib/#{tag["name"]}.rb"
        FileUtils.touch(file_name)
        File.open(file_name, "w") do |file|
          file.puts "class #{tag["name"].capitalize}"
        end
      end

      FileUtils.touch("outputs/lib/client.rb")

      template_file_path = "lib/templates/client.rb"
      copied_file_path = "outputs/lib/client.rb"

      # Read the content of the template file
      template_file_content = File.read(template_file_path)

      # Replace the placeholders in the template file content with the passed argument
      replaced_content = template_file_content.gsub('___API_BASE_URL___', "https://" + data["host"] + data["basePath"])

      # Write the replaced content to the copied file
      File.write(copied_file_path, replaced_content)

      data["paths"].each do |pathname, hash|
        method = hash.keys.first
        hash = hash[method]
        target_file = "outputs/lib/#{hash["tags"][0]}.rb"
        method_name = hash["operationId"]

        args = hash["parameters"].map {|param| param["name"]}

        method = <<-"EOS"
  # #{hash["description"].to_s.empty? ? "comment not attached" : hash["description"]}
  def #{method_name}(#{args.join(",")})
    #{method}(#{args.join(",")})
  end

EOS

        File.open(target_file, "a") do |file|
          file.puts(method)
        end
      end

      data["tags"].each do |tag|
        file_name = "outputs/lib/#{tag["name"]}.rb"
        File.open(file_name, "a") do |file|
          file.puts "end"
        end
      end
    end
  end
end

