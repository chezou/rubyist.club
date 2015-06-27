require "rubygems"
require "dotenv"
Dotenv.load

ssh_user	= ENV['SSH_USER']
ssh_port	= ENV['SSH_PORT']
ssh_host	= ENV['SSH_HOST']

# Usage: rake preveiw
desc "Launch preview environment"
task :preview do
    sh "jekyll serve --watch"
end

task :deploy do
    sh "jekyll build"
    sh "rsync -e 'ssh -p #{ssh_port}' -avz --delete _site/ #{ssh_user}@#{ssh_host}:/home/#{ssh_user}/jekyll/_site"
end

# Usage: rake post["new-post-name"]
desc "Given a title as an argument, create a new post file"
task :post, [:title] do |t, args|
    dirname = File.join(".", "_posts")
    if not FileTest.directory?(dirname)
        abort("rake aborted: #{dirname} directory is not found.")
    end
    date = Time.now.strftime('%Y-%m-%d')
    slug = args.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    filename = "#{date}-#{slug}.md"
    fullpath = File.join(dirname, filename)
    if File.exist?(fullpath)
        abort("rake aborted: #{fullpath} already exists.")
    end
    File.open(fullpath, 'w') do |post|
        post.puts "---"
        post.puts "layout: post"
        post.puts "title: #{args.title}"
        post.puts "date: #{date}"
        post.puts "summary: "
        post.puts "audio-src: http://rubyist.club/audio/rubyist_club_ep0#{args.title}.mp3"
        post.puts "audio-length: "
        post.puts "audio-duration: \":\""
        post.puts "author: chezou"
        post.puts "---"
    end
    puts "Open #{fullpath} in an editor."
end
