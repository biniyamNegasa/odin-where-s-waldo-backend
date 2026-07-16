namespace :timers do
  desc "Delete unfinished timers older than 24 hours (abandoned games)"
  task cleanup: :environment do
    deleted = Timer.abandoned.delete_all
    puts "Deleted #{deleted} abandoned timer(s)."
  end
end
