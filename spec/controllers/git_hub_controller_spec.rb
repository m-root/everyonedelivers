require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GitHubController do

  before(:each) do
    controller.stub!(:set_timezone)
  end

  describe "GET 'commit'" do
    it "should be successful" do
      controller.should_receive(:shell)
      get 'commit', :payload => '{}'
      response.should be_success
    end
  end
end
