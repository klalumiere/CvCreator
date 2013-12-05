require_relative "tag"

module CvMaker
	class Section
		def initialize(data,options,view)
			@tagList=Tag.parseTag(data)
			@options=options
			@view=view
		end
		def content
			return "" if !dataInClass?(@tagList,@options[:classes])
			
			result=@view.sectionHeader(CvMaker::contentByName(@tagList,"title"+@options[:language]))
			itemAdded=0
			@view.itemsName.each { |name|
				items=CvMaker::findTagsByName(@tagList,name)
				items=filterBadClassAndEmpty(items,@options[:classes],@view.itemEssentialTag)
				result+=@view.itemHeader(CvMaker::contentByName(@tagList,name+"Title"+@options[:language])) if !items.empty?
				items.each { |itemTag|
					result+=@view.itemBody(itemTag)
					subitems=CvMaker::findTagsByName(itemTag.subTags,@view.subitemName)
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
			globalClasses=CvMaker::contentsByName(tagList,"class")
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
			subTags=item.subTags
			itemClasses=CvMaker::contentsByName(subTags,"class")
			subTags.each { |subTag|
				itemClasses+=CvMaker::contentsByName(subTag.subTags,"class")
			}
			!(itemClasses & classes).empty? or itemClasses.empty?
		end
		def emtpyItem?(item,essentialTag)
			result=true if CvMaker::findTagsByName(item.subTags,essentialTag).empty? and essentialTag != ""
			result
		end
	end
end