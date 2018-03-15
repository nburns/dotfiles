# vi: ft=ruby

Pry.config.exception_handler = proc do |output, exception, _pry_|
  choices = ['full', 'summary', 'none']

  choice = choices.find { |c| c == (ENV['PRY_EXCEPTION'] || '').downcase } || 'summary'

  if choice == 'summary'
    output.puts "#{exception}"

    remove = [
      /pry/,
      /spring/,
      /activesupport/,
      /\/usr\/local\//,
    ]

    backtrace = exception.backtrace.reject do |line|
      remove.any? { |regex| regex.match(line) }
    end

    output.puts %Q<#{backtrace.join("\n")}>

  elsif choice == 'full'
    output.puts "#{exception}"
    output.puts "#{exception.backtrace.join('\n')}"

  elsif choice == 'none'
    output.puts "#{exception}"
  end

end
