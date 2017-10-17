require_relative "Tag"

module CvCreator

    class Section
        def initialize(data, options, view)
            @tagList = CvCreator::Tag.parse(data)
            @classes = options[:classes]
            @language = options[:language]
            @view = view
        end
        def content
            return "" if itemsCount() == 0 or !dataInClasses?()
            titleTag = CvCreator::findTagContentByName(@tagList, "title" + @language)
            result = @view.itemsName.reduce(@view.sectionHeader(titleTag), &method(:addItemsWithName))
            @view.removeUnwantedChars(result) # NOT tested
        end

    private
        def addItemsWithName(partialResult, name)
            items = CvCreator::findTagsByName(@tagList, name).select { |item|
                itemInClass?(item, @classes) and containsTag(item, @view.itemEssentialTag)
            }
            return partialResult if items.empty? # tested
            titleTag = CvCreator::findTagContentByName(@tagList, name+"Title"+@language)
            items.reduce(partialResult + @view.itemHeader(titleTag),  &method(:addItem)) + @view.itemFooter()
        end
        def dataInClasses?()
            globalClasses = CvCreator::findTagsContentByName(@tagList, "class")
            !(globalClasses & @classes).empty? or globalClasses.empty?
        end
        def itemsCount()
            @view.itemsName.reduce(0) { |result, name|
               result + CvCreator::findTagsByName(@tagList, name).size()
            }
        end

        def addItem(partialResult, itemTag)
            partialResult += @view.itemBody(itemTag)
            subitems = CvCreator::findTagsByName(itemTag.subtags, @view.subitemName).select { |subitem|
                itemInClass?(subitem, @classes) and containsTag(subitem, @view.subitemEssentialTag)
            }
            partialResult += @view.subitemHeader if !subitems.empty?
            subitems.each { |subitemTag| partialResult += @view.subitemBody(subitemTag) }
            partialResult + subitemFooter(subitems.length)
        end
        def containsTag(item, tagName)
            return true if tagName == ""
            !CvCreator::findTagsByName(item.subtags, tagName).empty?
        end
        def itemInClass?(item, classes)
            itemClasses = CvCreator::findTagsContentByName(item.subtags, "class")
            itemClassesAndSubclasses = item.subtags.reduce(itemClasses) { |result, subtag|
                result + CvCreator::findTagsContentByName(subtag.subtags, "class")
            }
            !(itemClassesAndSubclasses & classes).empty? or itemClassesAndSubclasses.empty?
        end
        def subitemFooter(subitemsNumber)
            result=@view.subitemFooter if subitemsNumber > 0
            result=@view.subitemEmptyFooter if subitemsNumber == 0
            result += @view.subitemDefaultFooter
        end
    end

end # CvCreator
