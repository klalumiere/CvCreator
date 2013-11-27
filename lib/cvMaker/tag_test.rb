require "test/unit"
require_relative "tag"

class BasicTags < Test::Unit::TestCase
	def setup
		@tag1=CvMaker::Tag.new("niceName1",nil)
		@tag2=CvMaker::Tag.new("niceName2","someContent2")
		@tag3=CvMaker::Tag.new(nil,"someContent3")
	end

	def testName
		assert_equal("niceName1",@tag1.name())
		assert_equal("niceName2",@tag2.name())
		assert_equal(nil,@tag3.name())
	end

	def testContent
		assert_equal(nil,@tag1.content())
		assert_equal("someContent2",@tag2.content())
		assert_equal("someContent3",@tag3.content())
	end
end

class ParseTag < Test::Unit::TestCase
	def testNoTag
		text=""
		tagList=CvMaker::Tag.parseTag(text)
		assert_empty(tagList)
	end
	def testSimpleTag
		text="\\simpleTag{simpleContent}"
		tagList=CvMaker::Tag.parseTag(text)
		refute_empty(tagList)
		assert_equal("simpleTag",tagList[0].name)
		assert_equal("simpleContent",tagList[0].content)
	end
	def testLineSkip
		text="\\simpleTag{\nsimpleContent}"
		tagList=CvMaker::Tag.parseTag(text)
		refute_empty(tagList)
		assert_equal("simpleTag",tagList[0].name)
		assert_equal("\nsimpleContent",tagList[0].content)
	end
	def testNestedTag
		text="\\simpleTag{\n\\yobabe{\n \t fefede \t \n}}"
		tagList=CvMaker::Tag.parseTag(text)
		refute_empty(tagList)
		assert_equal("simpleTag",tagList[0].name)
		assert_equal("\n\\yobabe{\n \t fefede \t \n}",tagList[0].content)
	end
	def testJunkAround
		text="ofejj\n \t \\simpleTag{simpleContent} fek \n \t \n"
		tagList=CvMaker::Tag.parseTag(text)
		refute_empty(tagList)
		assert_equal("simpleTag",tagList[0].name)
		assert_equal("simpleContent",tagList[0].content)
	end
	def testThreeTags
		text="\\tag0{conte\nt0} \\tag1{conte\nt1} \\tag2{conte\nt2}"
		tagList=CvMaker::Tag.parseTag(text)
		assert_equal(3,tagList.length)
		tagList.each_with_index { 
			|elem,i| 
			assert_equal("tag"+i.to_s(),elem.name)
			assert_equal("conte\nt"+i.to_s(),elem.content)
		}
	end
	def testThreeTagsWithJunkAround
		text="fejji {} f\nfe\tfe\\tag0{conte\nt0} \\tag1{conte\nt1} \\tag2{conte\nt2}\n e\t"
		tagList=CvMaker::Tag.parseTag(text)
		assert_equal(3,tagList.length)
		tagList.each_with_index { 
			|elem,i| 
			assert_equal("tag"+i.to_s(),elem.name)
			assert_equal("conte\nt"+i.to_s(),elem.content)
		}
	end
end

class SubTags < Test::Unit::TestCase
	def testBasicSubtags
		firstTag=CvMaker::Tag.new("first","\\second{yay}")
		subTagList = firstTag.subTags
		assert_equal("second",subTagList[0].name)
		assert_equal("yay",subTagList[0].content)
	end

	def testThreeSubTags
		firstTag=CvMaker::Tag.new("first","\\tag0{ya\ny0} \\tag1{ya\ny1} \\tag2{ya\ny2}")
		subTagList=firstTag.subTags
		assert_equal(3,subTagList.length)
		subTagList.each_with_index { 
			|elem,i| 
			assert_equal("tag"+i.to_s(),elem.name)
			assert_equal("ya\ny"+i.to_s(),elem.content)
		}
	end

	def testThreeSubTagsWithJunk
		firstTag=CvMaker::Tag.new("first","ggege\t\n \\tag0{ya\ny0}fefe\n\t\\tag1{ya\ny1} feKn\\tag2{ya\ny2}{}ee{}8=}{")
		subTagList=firstTag.subTags
		assert_equal(3,subTagList.length)
		subTagList.each_with_index { 
			|elem,i| 
			assert_equal("tag"+i.to_s(),elem.name)
			assert_equal("ya\ny"+i.to_s(),elem.content)
		}
	end
end

class FindTags < Test::Unit::TestCase
	def testFindTags
		subTagList=[CvMaker::Tag.new("first","bb"),
					CvMaker::Tag.new("second","few"),
					CvMaker::Tag.new("first","few"),
					CvMaker::Tag.new("first",""),
					CvMaker::Tag.new("first",""),
					CvMaker::Tag.new("second",""),
					CvMaker::Tag.new("third","first")]
		foundList=CvMaker::findTagsByName(subTagList,"first")
		assert_equal(4,foundList.length)
		foundList.each { |elem|
			assert_equal(elem.name,"first")
		}
	end
end

class ContentByName < Test::Unit::TestCase
	def testFindTags
		subTagList=[CvMaker::Tag.new("first","bb"),
					CvMaker::Tag.new("third","first")]
		content=CvMaker::contentByName(subTagList,"first")
		assert_equal("bb",content)
	end
	def testTooManyTagsFound
		subTagList=[CvMaker::Tag.new("first","bb"),
					CvMaker::Tag.new("first","cc")]
		assert_raise(CvMaker::TooManyTags) {CvMaker::contentByName(subTagList,"first")}
	end
	def testContentsByName
		subTagList=[CvMaker::Tag.new("first","bb"),
					CvMaker::Tag.new("firsts","cd"),
					CvMaker::Tag.new("first","cc")]
		expectedResult=["bb","cc"]
		assert_equal(CvMaker::contentsByName(subTagList,"first"),expectedResult)
	end
end
