require "spec_helper"

describe TimesheetMailer do

  context 'invalid_timesheet' do
    before do
      @user      = mock('user', :email      => 'egems-user1@example.com',
                                :login      => 'user1')
      @timesheet = mock('timesheet', :time_in => 1.day.ago,
                                     :time_out => nil)
      @type = "time out"
    end

    it 'should send email to user' do
      mail = TimesheetMailer.invalid_timesheet(@user, @timesheet, @type).deliver
      mail.to.should == [@user.email]
    end

    it 'should contain user first name on the salutation' do
      mail = TimesheetMailer.invalid_timesheet(@user, @timesheet, @type).deliver
      mail.body.should =~ /#{@user.login}/
    end

    it 'should use the default layout' do
      mail = TimesheetMailer.invalid_timesheet(@user, @timesheet, @type).deliver
      mail.body.should =~ /logo\.png/
    end
  end

end
