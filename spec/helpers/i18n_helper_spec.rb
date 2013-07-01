require 'spec_helper'

require 'sxle/helpers/i18n_helper'

class I18nHelperTest
  include Sxle::Helpers::I18nHelper
end

describe "I18n" do
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper

  subject { I18nHelperTest.new }
  describe "safe_t" do
    it "escapes unsafe text" do
      subject.stub(:t).with('my_key').and_return('this is <strong>unsafe</strong>')
      subject.safe_t('my_key').should == 'this is &lt;strong&gt;unsafe&lt;/strong&gt;'
    end

    it "escapes unsafe variables" do
      subject.stub(:t).with('my_key').and_return('I am %{username}')
      value = '<b>Bob</b>'
      value.stub(:html_safe?).and_return(false)
      subject.safe_t('my_key', username: value).should == 'I am &lt;b&gt;Bob&lt;/b&gt;'
    end

    it "doesn't escape safe variables" do
      subject.stub(:t).with('my_key').and_return('I am %{username}')
      value = content_tag 'b', 'Bob'
      subject.safe_t('my_key', username: value).should == 'I am <b>Bob</b>'
    end

    it "doesn't escape safe variables (anchors)" do
      subject.stub(:t).with('my_key').and_return('Go to %{link}')
      value = link_to 'Google', 'http://www.google.com'
      subject.safe_t('my_key', link: value).should ==
        'Go to <a href="http://www.google.com">Google</a>'
    end

    it "returns html_safe result" do
      subject.stub(:t).with('my_key').and_return('abc')
      subject.safe_t('my_key').should be_html_safe
    end

  end
end
