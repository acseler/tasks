guard :rspec, cmd: 'bundle exec rspec' do
  # watch /lib/ files
  watch(%r{^lib/(.+).rb$}) do |m|
    "spec/#{m[1]}_spec.rb"
  end

# watch /spec/ files
  watch(%r{^spec/(.+).rb$}) do |m|
    "spec/#{m[1]}.rb"
  end

  watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
  watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)(?:\.\w+)*$}) do |m|
    "spec/javascripts/#{ m[1] }_spec.#{ m[2] }"
  end
end