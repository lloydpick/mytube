namespace :recurring do
  task init: :environment do
    YoutubedlUpdateJob.schedule!
    CheckChannelsJob.schedule!
  end
end