require_relative "Tag"

module CvCreator

	class Section
		def initialize(data,options,view)
			@tagList=CvCreator::Tag.parse(data)
			@options=options
			@view=view
		end
		def content
			return "" if !dataInClass?(@tagList,@options[:classes])
			
			result=@view.sectionHeader(CvCreator::findTagContentByName(@tagList,"title"+@options[:language]))
			itemAdded=0
			@view.itemsName.each { |name|
				items=CvCreator::findTagsByName(@tagList,name)
				items=filterBadClassAndEmpty(items,@options[:classes],@view.itemEssentialTag)
				result+=@view.itemHeader(CvCreator::findTagContentByName(@tagList,name+"Title"+@options[:language])) if !items.empty?
				items.each { |itemTag|
					result+=@view.itemBody(itemTag)
					subitems=CvCreator::findTagsByName(itemTag.subtags,@view.subitemName)
					subitems=filterBadClassAndEmpty(subitems,@options[:classes],@view.subitemEssentialTag)
					result+=@view.subitemHeader if !subitems.empty?
					subitems.each { |subitemTag|
						result+=@view.subitemBody(subitemTag)
					}
					result+=subitemFooter(subitems.length)
					itemAdded+=1
				}
				result+=@view.itemFooter() if !items.empty?
			}
			result="" if itemAdded==0

			result=@view.removeUnwantedChars(result)
		end

	private
		def dataInClass?(tagList, classes)
			globalClasses=CvCreator::findTagsContentByName(tagList,"class")
			!(globalClasses & classes).empty? or globalClasses.empty?
		end
		def filterBadClassAndEmpty(items,classes,essentialTag)
			filteredItems=[]
			items.each { |item|
				filteredItems << item if itemInClass?(item,classes) and !emtpyItem?(item,essentialTag)
			}
			filteredItems
		end
		def subitemFooter(subitemsNumber)
			result=@view.subitemFooter if subitemsNumber>0
			result=@view.subitemEmptyFooter if subitemsNumber==0
			result+=@view.subitemDefaultFooter
		end

		def itemInClass?(item,classes)
			subTags=item.subtags
			itemClasses=CvCreator::findTagsContentByName(subTags,"class")
			subTags.each { |subTag|
				itemClasses+=CvCreator::findTagsContentByName(subTag.subtags,"class")
			}
			!(itemClasses & classes).empty? or itemClasses.empty?
		end
		def emtpyItem?(item,essentialTag)
			result=true if CvCreator::findTagsByName(item.subtags,essentialTag).empty? and essentialTag != ""
			result
		end
	end

end # CvCreator
