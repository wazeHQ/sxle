require 'spec_helper'

require 'sxle/helpers/html_helper'

class HtmlHelperTest
  include ActionView::Helpers::TagHelper
  include Sxle::Helpers::HtmlHelper
end

describe "HtmlHelper" do
  subject { HtmlHelperTest.new }

  describe "#lines_to_paragraphs" do
    it "splits the lines to paragraphs" do
      lines = "one\ntwo\nthree"
      subject.lines_to_paragraphs(lines).should == 
        "<p>one</p><p>two</p><p>three</p>"
    end

    it "escapes the lines" do
      lines = "one<b>unsafe</b>\ntwo\nthree"
      subject.lines_to_paragraphs(lines).should == 
        "<p>one&lt;b&gt;unsafe&lt;/b&gt;</p><p>two</p><p>three</p>"
    end

    it "returns safe html" do
      lines = "one<b>unsafe</b>\ntwo\nthree"
      subject.lines_to_paragraphs(lines).should be_html_safe
    end

    it "returns '' if nil" do
      subject.lines_to_paragraphs(nil).should == ''
    end

    it "returns '' if blank string" do
      subject.lines_to_paragraphs('   ').should == ''
    end
  end
end
