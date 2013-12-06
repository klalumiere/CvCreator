require_relative "sectionView"

module CvMaker
	class TexSectionView < SectionView
		def sectionHeader(title)
			"\\section{#{title}}\n"
		end
		def itemHeader(subsectionName)
			result=""
			result+="\\subsection{#{subsectionName}}\n" if subsectionName != ""
			result+="\\begin{itemize}\n"
		end
		def itemFooter
			"\\end{itemize}\n"
		end
		def subitemHeader
			"\\begin{itemize}\n"
		end
		def subitemFooter
			"\\end{itemize}\n"
		end

		def removeUnwantedChars(tex)
			result=tex
			result=tex[0..tex.rindex(/}/)] if !tex.rindex(/}/).nil?
			result
		end
	end

	class SkillSummaryTex < TexSectionView
		def itemsName
			["item"]
		end
		def itemBody(itemTag)
			"\\item #{CvMaker::contentByName(itemTag.subTags,"what"+@language)}\n"
		end
		def subitemName
			"subitem"
		end
		def subitemBody(subitemTag)
			"\\item #{CvMaker::contentByName(subitemTag.subTags,"what"+@language)}\n"
		end
	end

	class EducationTex < TexSectionView
		def itemsName
			["education"]
		end
		def itemHeader(subsectionName)
			""
		end
		def itemBody(itemTag)
			result="\\diploma{#{CvMaker::contentByName(itemTag.subTags,"what"+@language)}}"
			result+="{#{CvMaker::contentByName(itemTag.subTags,"where")}}"
			result+="{#{CvMaker::contentByName(itemTag.subTags,"when"+@language)}}\n"
		end
		def itemFooter
			""
		end
		def subitemName
			"thesis"
		end
		def subitemBody(subitemTag)
			result="\\item \\textbf{#{CvMaker::contentByName(subitemTag.subTags,"titleName"+@language)}} "
			result+="#{CvMaker::contentByName(subitemTag.subTags,"name")}\n"				
			result+="\\item \\textbf{#{CvMaker::contentByName(subitemTag.subTags,"titleAdvisor"+@language)}} "
			result+="#{CvMaker::contentByName(subitemTag.subTags,"advisor")}\n"	
		end
		def subitemFooter
			"\\end{itemize}\n~\\\\\n"
		end
		def subitemEmptyFooter
			"~\\\\~\\\\\n"
		end
	end

	class ExperienceTex < TexSectionView
		def sectionHeader(title)
			"~\\\\ \\section{#{title}}\n"
		end
		def itemsName
			["experience"]
		end
		def itemHeader(subsectionName)
			""
		end
		def itemBody(itemTag)
			result="\\begin{job}{#{CvMaker::contentByName(itemTag.subTags,"what"+@language)}}{"
			who=CvMaker::contentByName(itemTag.subTags,"who")
			result+="#{who}, " if !who.empty?
			result+="#{CvMaker::contentByName(itemTag.subTags,"where")}}"
			result+="{#{CvMaker::contentByName(itemTag.subTags,"when"+@language)}}\n"
		end
		def itemFooter
			""
		end
		def subitemName
			"skill"
		end
		def subitemEssentialTag
			@language
		end
		def subitemBody(subitemTag)
			"\\item #{CvMaker::contentByName(subitemTag.subTags,@language)}\n"
		end
		def subitemFooter	
			"\\end{itemize}\n"
		end
		def subitemDefaultFooter
			"\\end{job}\n\n"
		end
	end

	class AutodidactTrainingTex < TexSectionView
		def itemsName
			["book","course"]
		end
		def itemBody(itemTag)
			result="\\item "
			result+="#{CvMaker::contentByName(itemTag.subTags,"who")}, " if itemTag.name=="book"
			result+="\\textbf{#{CvMaker::contentByName(itemTag.subTags,"what")}}" 
			result+=", #{CvMaker::contentByName(itemTag.subTags,"where")}" if itemTag.name=="course"
			result+="\n"
		end
	end

	class HonorTex < TexSectionView
		def itemsName
			["honors"+@language]
		end
		def itemBody(itemTag)
			"\\item #{itemTag.content}\n"
		end
	end

	class SocialImplicationTex < TexSectionView
		def itemsName
			["social"]
		end
		def itemBody(itemTag)
			result="\\item #{CvMaker::contentByName(itemTag.subTags,"what"+@language)}"
			result+=", #{CvMaker::contentByName(itemTag.subTags,"when")}\n"
		end
	end

	class PublicationTex < TexSectionView
		def itemsName
			["publication"]
		end
		def itemBody(itemTag)
			"\\item #{itemTag.content}\n"
		end
	end

	class TalkTex < TexSectionView
		def itemsName
			["talk"]
		end
		def itemBody(itemTag)
			"\\item #{itemTag.content}\n"
		end
	end
end
