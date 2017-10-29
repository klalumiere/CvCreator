module CvCreator
    
    class SectionView
        def initialize(language)
            @language=language
        end
        def sectionHeader(title)
            ""
        end
        
        def itemsName
            [""]
        end
        def itemEssentialTag
            ""
        end
        def itemHeader(subsectionName)
            ""
        end
        def itemBody(itemTag)
            ""
        end
        def itemFooter
            ""
        end
        
        def subitemName
            ""
        end
        def subitemEssentialTag
            ""
        end
        def subitemHeader
            ""
        end
        def subitemBody(subitemTag)
            ""
        end
        def subitemFooter
            ""
        end
        def subitemEmptyFooter
            ""
        end
        def subitemDefaultFooter
            ""
        end

        def removeUnwantedChars(text)
            text
        end
    end

end # CvCreator
