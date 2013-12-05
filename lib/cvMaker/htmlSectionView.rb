require_relative "sectionView"

module CvMaker
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
			"<li> #{CvMaker::contentByName(itemTag.subTags,"what"+@language)}</li>\n"
		end
		def subitemName
			"subitem"
		end
		def subitemBody(subitemTag)
			"<li> #{CvMaker::contentByName(subitemTag.subTags,"what"+@language)}</li>\n"
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
			<td align=\"left\"><strong>#{CvMaker::contentByName(itemTag.subTags,"what"+@language)}</strong></td>
			<td align=\"right\">#{CvMaker::contentByName(itemTag.subTags,"when"+@language)}</td>
			</tr>
			<tr>
			<td colspan=\"2\" align=\"left\"> #{CvMaker::contentByName(itemTag.subTags,"where")}</td>
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
			result="<li> <strong>#{CvMaker::contentByName(subitemTag.subTags,"titleName"+@language)}</strong> "
			result+="#{CvMaker::contentByName(subitemTag.subTags,"name")}</li>\n"				
			result+="<li> <strong>#{CvMaker::contentByName(subitemTag.subTags,"titleAdvisor"+@language)}</strong>"
			result+="#{CvMaker::contentByName(subitemTag.subTags,"advisor")}</li>\n"	
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
			who=CvMaker::contentByName(itemTag.subTags,"who")
			who+=", " if !who.empty?

			"<table>
			<tr>
			<td align=\"left\"><strong>#{CvMaker::contentByName(itemTag.subTags,"what"+@language)}</strong></td>
			<td align=\"right\">#{CvMaker::contentByName(itemTag.subTags,"when"+@language)}</td>
			</tr>
			<tr>
			<td colspan=\"2\" align=\"left\">#{who}#{CvMaker::contentByName(itemTag.subTags,"where")}</td>
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
			"<li> #{CvMaker::contentByName(subitemTag.subTags,@language)}</li>\n"
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
			result+="#{CvMaker::contentByName(itemTag.subTags,"who")}, " if itemTag.name=="book"
			result+="<strong>#{CvMaker::contentByName(itemTag.subTags,"what")}</strong>" 
			result+=", #{CvMaker::contentByName(itemTag.subTags,"where")}" if itemTag.name=="course"
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
			result="<li> #{CvMaker::contentByName(itemTag.subTags,"what"+@language)}"
			result+=", #{CvMaker::contentByName(itemTag.subTags,"when")}</li>\n"
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
