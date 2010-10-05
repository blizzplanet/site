# encoding: utf-8
require "spec_helper"

describe String do
  describe "#transliterated" do
    it "should transliterate cyrillics" do
      "вова".transliterated.should == "vova"
    end

    it "should respect case" do
      "ВовАн".transliterated.should == "VovAn"
    end
    it "should not modify numbers" do
      "123".transliterated.should == "123"
    end

    it "should not modify symbols" do
      "#!@#   ^&".transliterated.should == "#!@#   ^&"
    end

    it "should respect special letters" do
      "Жвачка".transliterated.should == "Zhvachka"
    end

    it "should accept mixed strings" do
      "ВоВа 4YMA 666#".transliterated.should == "VoVa 4YMA 666#"
    end
  end
end