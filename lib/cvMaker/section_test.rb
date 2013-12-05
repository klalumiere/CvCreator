require "test/unit"
require_relative "section"
require_relative "sectionView"

class MockSectionView < CvMaker::SectionView
	def initialize(language)
		@language=language
	end
	def sectionHeader(title)
		title
	end
	
	def itemsName
		["itemsNameOne","itemsNameTwo"]
	end
	def itemEssentialTag
		"itemEssentialTag"
	end
	def itemHeader(subsectionName)
		subsectionName
	end
	def itemBody(itemTag)
		CvMaker::contentByName(itemTag.subTags,itemEssentialTag)
	end
	def itemFooter
		"itemFooter "
	end
	
	def subitemName
		"subitemName"
	end
	def subitemEssentialTag
		"subitemEssentialTag"
	end
	def subitemDefaultHeader
		"subitemDefaultHeader "
	end
	def subitemHeader
		"subitemHeader "
	end
	def subitemBody(subitemTag)
		CvMaker::contentByName(subitemTag.subTags,subitemEssentialTag)
	end
	def subitemFooter
		"subitemFooter "
	end
	def subitemEmptyFooter
		"subitemEmptyFooter "
	end
	def subitemDefaultFooter
		"subitemDefaultFooter "
	end

	def removeUnwantedChars(text)
		text
	end
end

class SectionTest < Test::Unit::TestCase
	def setup
		@data=%q[\titleFr{sectionEnTete }\titleEn{sectionHeader }\class{fun}
			\itemsNameOneTitleFr{itemHeader }\itemsNameOneTitleEn{itemHeaderEn }\itemsNameOne{\itemEssentialTag{itemBody }}
			\itemsNameTwoTitleFr{itemHeader }\itemsNameTwoTitleEn{itemHeaderEn }]
		@options={language: "Fr", classes: ["fun"]}
		@view=MockSectionView.new(@options[:language])
		@itemExpectedResult="itemHeader itemBody subitemEmptyFooter subitemDefaultFooter itemFooter "
	end
	def testGlobalClass
		result=CvMaker::Section.new("",@options,@view).content
		assert_equal("",result)
	end
	def testGlobalClassEmpty
		@options[:classes]=[""]
		result=CvMaker::Section.new(@data,@options,@view).content
		assert_equal("",result)
	end
	def testGlobalClass
		result=CvMaker::Section.new(@data,@options,@view).content
		assert_equal("sectionEnTete "+@itemExpectedResult,result)
	end
	def testTwoItems
		@data+=%q[\itemsNameOne{\itemEssentialTag{itemBody2 }}]
		@itemExpectedResult="itemHeader itemBody subitemEmptyFooter subitemDefaultFooter itemBody2 subitemEmptyFooter subitemDefaultFooter itemFooter "
		result=CvMaker::Section.new(@data,@options,@view).content
		assert_equal("sectionEnTete "+@itemExpectedResult,result)
	end
	def testEnglish
		@options[:language]="En"
		result=CvMaker::Section.new(@data,@options,@view).content
		itemExpectedResultEn="itemHeaderEn itemBody subitemEmptyFooter subitemDefaultFooter itemFooter "
		assert_equal("sectionHeader "+itemExpectedResultEn,result)
	end
	def testTwoItemType
		@data+=%q[\itemsNameTwo{\itemEssentialTag{itemBody }}]
		result=CvMaker::Section.new(@data,@options,@view).content
		expectedResult="sectionEnTete "
		expectedResult+=@itemExpectedResult+@itemExpectedResult
		assert_equal(expectedResult,result)
	end
	def testSkipBadClassItem
		@data+=%q[\itemsNameTwo{\class{bad}\itemEssentialTag{itemBody }}]
		result=CvMaker::Section.new(@data,@options,@view).content
		assert_equal("sectionEnTete "+@itemExpectedResult,result)
	end
	def testIncludeGoodClassItem
		@data+=%q[\itemsNameTwo{\class{fun}\itemEssentialTag{itemBody }}]
		result=CvMaker::Section.new(@data,@options,@view).content
		expectedResult="sectionEnTete "
		expectedResult+=@itemExpectedResult+@itemExpectedResult
		assert_equal(expectedResult,result)
	end
	def testNoEssentialTag
		@data+=%q[\itemsNameTwo{\class{fun}}]
		result=CvMaker::Section.new(@data,@options,@view).content
		assert_equal("sectionEnTete "+@itemExpectedResult,result)
	end
	def testSubitem
		@data+=%q[\itemsNameTwo{
			\itemEssentialTag{itemBody }  
			\subitemName{\subitemEssentialTag{yo }}
			}]
		result=CvMaker::Section.new(@data,@options,@view).content
		subitemExpectedResult="itemHeader itemBody subitemHeader yo subitemFooter subitemDefaultFooter itemFooter "
		assert_equal("sectionEnTete "+@itemExpectedResult+subitemExpectedResult,result)
	end
	def testTwoSubitems
		@data+=%q[\itemsNameTwo{
			\itemEssentialTag{itemBody }  
			\subitemName{\subitemEssentialTag{yo1 }}
			\subitemName{\subitemEssentialTag{yo2 }}
			}]
		result=CvMaker::Section.new(@data,@options,@view).content
		subitemExpectedResult="itemHeader itemBody subitemHeader yo1 yo2 subitemFooter subitemDefaultFooter itemFooter "
		assert_equal("sectionEnTete "+@itemExpectedResult+subitemExpectedResult,result)
	end
	def testBadClassSubitems
		@data+=%q[\itemsNameTwo{
			\itemEssentialTag{itemBody }  
			\subitemName{\class{bad}\subitemEssentialTag{yo }}
			}]
		result=CvMaker::Section.new(@data,@options,@view).content
		assert_equal("sectionEnTete "+@itemExpectedResult,result)
	end
	def testGoodClassSubitems
		@data+=%q[\itemsNameTwo{
			\itemEssentialTag{itemBody }  
			\subitemName{\class{fun}\subitemEssentialTag{yo }}
			}]
		result=CvMaker::Section.new(@data,@options,@view).content
		subitemExpectedResult="itemHeader itemBody subitemHeader yo subitemFooter subitemDefaultFooter itemFooter "
		assert_equal("sectionEnTete "+@itemExpectedResult+subitemExpectedResult,result)
	end
	def testBadAndGoodClassSubitems
		@data+=%q[\itemsNameTwo{
			\itemEssentialTag{itemBody }  
			\subitemName{\class{fun}\subitemEssentialTag{yo1 }}
			\subitemName{\class{bad}\subitemEssentialTag{yo2 }}
			}]
		result=CvMaker::Section.new(@data,@options,@view).content
		subitemExpectedResult="itemHeader itemBody subitemHeader yo1 subitemFooter subitemDefaultFooter itemFooter "
		assert_equal("sectionEnTete "+@itemExpectedResult+subitemExpectedResult,result)
	end
	def testNoEssentialTagSubitems
		@data+=%q[\itemsNameTwo{
			\itemEssentialTag{itemBody }  
			\subitemName{\class{fun}}
			\subitemName{\class{bad}}
			}]
		result=CvMaker::Section.new(@data,@options,@view).content
		assert_equal("sectionEnTete "+@itemExpectedResult+@itemExpectedResult,result)
	end
	def testSommeEssentialTagSubitems
		@data+=%q[\itemsNameTwo{
			\itemEssentialTag{itemBody }  
			\subitemName{\class{fun}\subitemEssentialTag{yo1 }}
			\subitemName{\class{fun}}
			}]
		result=CvMaker::Section.new(@data,@options,@view).content
		subitemExpectedResult="itemHeader itemBody subitemHeader yo1 subitemFooter subitemDefaultFooter itemFooter "
		assert_equal("sectionEnTete "+@itemExpectedResult+subitemExpectedResult,result)
	end
	def testNoItemAdded
		@data=%q[\titleFr{sectionEnTete }\titleEn{sectionHeader }]
		result=CvMaker::Section.new(@data,@options,@view).content
		assert_equal("",result)
	end
end

class ClearedMockSectionView < MockSectionView
	def removeUnwantedChars(text)
		""
	end
end

class ClearedSectionTest < Test::Unit::TestCase
	def setup
		@data=%q[\titleFr{sectionEnTete }\titleEn{sectionHeader }\class{fun}
			\itemsNameOneTitleFr{itemHeader }\itemsNameOneTitleEn{itemHeaderEn }\itemsNameOne{\itemEssentialTag{itemBody }}
			\itemsNameTwoTitleFr{itemHeader }\itemsNameTwoTitleEn{itemHeaderEn }]
		@options={language: "Fr", classes: ["fun"]}
		@view=ClearedMockSectionView.new(@options[:language])
	end
	def testGlobalClassEmptyCleared
		@options[:classes]=[""]
		result=CvMaker::Section.new(@data,@options,@view).content
		assert_equal("",result)
	end
	def testGlobalClassCleared
		result=CvMaker::Section.new(@data,@options,@view).content
		assert_equal("",result)
	end
end
