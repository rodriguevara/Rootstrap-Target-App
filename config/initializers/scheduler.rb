require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

scheduler.every '1d' do
  expired_targets = Target.where('created_at < ?', 7.days.ago)
  expired_targets.each(&:destroy!)
end
