require 'spec_helper'

describe Typhoeus::Header do
  let(:options) { {} }
  let(:header) { described_class.new(options) }
  let(:variations) {
    [ 'Content-Type', 'content-type', 'cOnTent-TYPE',
      'Content-Type', 'Content-Type', 'content-type',
      :content_type ]
  }


  it "responds to has_key?" do
    header.should respond_to(:has_key?)
  end

  describe ".new" do
    let(:options) { { 'Content-Type' => 'text/html', :x_http_header => 'foo', 'X-HTTP-USER' => 'bar' } }

    it "normalizes keys" do
      header.keys.should eq(['Content-Type', 'X-Http-Header', 'X-Http-User'])
    end
  end

  describe "#[]=" do
    it "normalizes keys" do
      variations.each do |key|
        header[key] = 'fsda'
        header['Content-Type'].should eq('fsda')
      end
    end
  end

  describe "#merge" do
    before { header.merge!('Content-Type' => 'fdsa') }

    it "normalizes keys" do
      header['content-type'].should == 'fdsa'
    end
  end

end
