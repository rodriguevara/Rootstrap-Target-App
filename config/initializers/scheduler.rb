require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

scheduler.every '7d' do
  @expired_targets = Target.where("created_at < ?", 7.day.ago)
  @expired_targets.each do |target|
    target.destroy!
  end
end
