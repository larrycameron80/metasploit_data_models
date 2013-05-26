require 'spec_helper'

describe Mdm::Session do

  context 'asscoiations' do
    it { should belong_to(:host).class_name('Mdm::Host') }
    it { should have_many(:events).class_name('Mdm::SessionEvent').dependent(:delete_all) }
    it { should have_many(:routes).class_name('Mdm::Route').dependent(:delete_all) }
    it { should have_one(:workspace).class_name('Mdm::Workspace').through(:host) }
  end

  context 'scopes' do
    context 'alive' do
      it 'should return sessions that have not been closed' do
        alive_session = FactoryGirl.create(:mdm_session)
        dead_session = FactoryGirl.create(:mdm_session, :closed_at => Time.now)
        alive_set = Mdm::Session.alive
        alive_set.should include(alive_session)
        alive_set.should_not include(dead_session)
      end
    end

    context 'dead'  do
      it 'should return sessions that have been closed' do
        alive_session = FactoryGirl.create(:mdm_session)
        dead_session = FactoryGirl.create(:mdm_session, :closed_at => Time.now)
        dead_set = Mdm::Session.dead
        dead_set.should_not include(alive_session)
        dead_set.should include(dead_session)
      end
    end

    context 'upgradeable' do
      it 'should return sessions that can be upgraded to meterpreter' do
        win_shell = FactoryGirl.create(:mdm_session, :stype => 'shell', :platform => 'Windows')
        linux_shell = FactoryGirl.create(:mdm_session, :stype => 'shell', :platform => 'Linux')
        win_meterp = FactoryGirl.create(:mdm_session, :stype => 'meterpreter', :platform => 'Windows')
        upgrade_set = Mdm::Session.upgradeable
        upgrade_set.should include(win_shell)
        upgrade_set.should_not include(linux_shell)
        upgrade_set.should_not include(win_meterp)
      end
    end
  end

  context 'callbacks' do
    context 'before_destroy' do
      it 'should call #stop' do
        mysession = FactoryGirl.create(:mdm_session)
        mysession.should_receive(:stop)
        mysession.destroy
      end
    end
  end

  context 'methods' do
    context '#upgradeable?' do
      it 'should return true for windows shells' do
        win_shell = FactoryGirl.create(:mdm_session, :stype => 'shell', :platform => 'Windows')
        win_shell.upgradeable?.should == true
      end

      it 'should return false for non-windows shells' do
        linux_shell = FactoryGirl.create(:mdm_session, :stype => 'shell', :platform => 'Linux')
        linux_shell.upgradeable?.should == false
      end

      it 'should return false for Windows Meterpreter Sessions' do
        win_meterp = FactoryGirl.create(:mdm_session, :stype => 'meterpreter', :platform => 'Windows')
        win_meterp.upgradeable?.should == false
      end
    end
  end
end