namespace :recurring do
  task init: :environment do
    YoutubedlUpdateJob.schedule!
  end
end