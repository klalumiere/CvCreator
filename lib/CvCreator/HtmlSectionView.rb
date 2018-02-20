require_relative "SectionView"

module CvCreator
    class HtmlSectionView < SectionView
        def sectionHeader(title)
            "<br><strong style=\"font-size: 125%;\">#{title}</strong>
            <hr class=\"section\">"
        end
        def itemHeader(subsectionName)
            result=""
            result+="\n<strong style=\"font-size: 112%;\">#{subsectionName}</strong><br>\n" if subsectionName != ""
            result+="<ul>\n"
        end
        def itemFooter
            "</ul><br>\n"
        end
        def subitemHeader
            "<ul>\n"
        end
        def subitemFooter
            "</ul>\n"
        end

        def removeUnwantedChars(tex)
            tex
        end
    end

    class SkillSummaryHtml < HtmlSectionView
        def itemsName
            ["item"]
        end
        def itemBody(itemTag)
            "<li> #{CvCreator::findTagContentByName(itemTag.subtags,"what"+@language)}</li>\n"
        end
        def subitemName
            "subitem"
        end
        def subitemBody(subitemTag)
            "<li> #{CvCreator::findTagContentByName(subitemTag.subtags,"what"+@language)}</li>\n"
        end
    end

    class EducationHtml < HtmlSectionView
        def itemsName
            ["education"]
        end
        def itemHeader(subsectionName)
            ""
        end
        def itemBody(itemTag)
            "<table>
            <tr>
            <td align=\"left\"><strong>#{CvCreator::findTagContentByName(itemTag.subtags,"what"+@language)}</strong>
            </td>
            <td align=\"right\">#{CvCreator::findTagContentByName(itemTag.subtags,"when"+@language)}</td>
            </tr>
            <tr>
            <td colspan=\"2\" align=\"left\"> #{CvCreator::findTagContentByName(itemTag.subtags,"where")}</td>
            </tr>
            </table>
            "
        end
        def itemFooter
            ""
        end
        def subitemName
            "thesis"
        end
        def subitemBody(subitemTag)
            result="<li> <strong>#{CvCreator::findTagContentByName(subitemTag.subtags,"titleName"+@language)}</strong> "
            result+="#{CvCreator::findTagContentByName(subitemTag.subtags,"name")}</li>\n"              
            result+="<li> <strong>#{CvCreator::findTagContentByName(subitemTag.subtags,"titleAdvisor"+@language)}"
            result+="</strong>#{CvCreator::findTagContentByName(subitemTag.subtags,"advisor")}</li>\n"   
        end
        def subitemFooter
            "</ul><br>\n"
        end
        def subitemEmptyFooter
            "<br>\n"
        end
    end

    class ExperienceHtml < HtmlSectionView
        def itemsName
            ["experience"]
        end
        def itemHeader(subsectionName)
            ""
        end
        def itemBody(itemTag)
            who=CvCreator::findTagContentByName(itemTag.subtags,"who")
            who+=", " if !who.empty?

            "<table>
            <tr>
            <td align=\"left\"><strong>#{CvCreator::findTagContentByName(itemTag.subtags,"what"+@language)}</strong>
            </td>
            <td align=\"right\">#{CvCreator::findTagContentByName(itemTag.subtags,"when"+@language)}</td>
            </tr>
            <tr>
            <td colspan=\"2\" align=\"left\">#{who}#{CvCreator::findTagContentByName(itemTag.subtags,"where")}</td>
            </tr>
            </table>
            <hr>
            "
        end
        def itemFooter
            "<br>"
        end
        def subitemName
            "skill"
        end
        def subitemEssentialTag
            @language
        end
        def subitemBody(subitemTag)
            "<li> #{CvCreator::findTagContentByName(subitemTag.subtags,@language)}</li>\n"
        end
        def subitemFooter   
            "</ul><br>\n"
        end
        def subitemDefaultFooter
            ""
        end
    end

    class AutodidactTrainingHtml < HtmlSectionView
        def itemsName
            ["book","course"]
        end
        def itemBody(itemTag)
            result="<li>"
            result+="#{CvCreator::findTagContentByName(itemTag.subtags,"who")}, " if itemTag.name=="book"
            result+="<strong>#{CvCreator::findTagContentByName(itemTag.subtags,"what")}</strong>" 
            result+=", #{CvCreator::findTagContentByName(itemTag.subtags,"where")}" if itemTag.name=="course"
            result+="</li>\n"
        end
    end

    class HonorHtml < HtmlSectionView
        def itemsName
            ["honors"+@language]
        end
        def itemBody(itemTag)
            "<li> #{itemTag.content}</li>\n"
        end
    end

    class SocialImplicationHtml < HtmlSectionView
        def itemsName
            ["social"]
        end
        def itemBody(itemTag)
            result="<li> #{CvCreator::findTagContentByName(itemTag.subtags,"what"+@language)}"
            result+=", #{CvCreator::findTagContentByName(itemTag.subtags,"when")}</li>\n"
        end
    end

    class PublicationHtml < HtmlSectionView
        def itemsName
            ["publication"]
        end
        def itemBody(itemTag)
            "<li> #{itemTag.content}</li>\n"
        end
    end

    class TalkHtml < HtmlSectionView
        def itemsName
            ["talk"]
        end
        def itemBody(itemTag)
            "<li> #{itemTag.content}</li>\n"
        end
    end
end
