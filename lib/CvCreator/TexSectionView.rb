require_relative "SectionView"

module CvCreator
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
			result=tex[0..tex.rindex("}")] if !tex.rindex("}").nil?
			result
		end
	end

	class SkillSummaryTex < TexSectionView
		def itemsName
			["item"]
		end
		def itemBody(itemTag)
			"\\item #{CvCreator::findTagContentByName(itemTag.subtags,"what"+@language)}\n"
		end
		def subitemName
			"subitem"
		end
		def subitemBody(subitemTag)
			"\\item #{CvCreator::findTagContentByName(subitemTag.subtags,"what"+@language)}\n"
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
			result="\\diploma{#{CvCreator::findTagContentByName(itemTag.subtags,"what"+@language)}}"
			result+="{#{CvCreator::findTagContentByName(itemTag.subtags,"where")}}"
			result+="{#{CvCreator::findTagContentByName(itemTag.subtags,"when"+@language)}}\n"
		end
		def itemFooter
			""
		end
		def subitemName
			"thesis"
		end
		def subitemBody(subitemTag)
			result="\\item \\textbf{#{CvCreator::findTagContentByName(subitemTag.subtags,"titleName"+@language)}} "
			result+="#{CvCreator::findTagContentByName(subitemTag.subtags,"name")}\n"				
			result+="\\item \\textbf{#{CvCreator::findTagContentByName(subitemTag.subtags,"titleAdvisor"+@language)}} "
			result+="#{CvCreator::findTagContentByName(subitemTag.subtags,"advisor")}\n"	
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
			result="\\begin{job}{#{CvCreator::findTagContentByName(itemTag.subtags,"what"+@language)}}{"
			who=CvCreator::findTagContentByName(itemTag.subtags,"who")
			result+="#{who}, " if !who.empty?
			result+="#{CvCreator::findTagContentByName(itemTag.subtags,"where")}}"
			result+="{#{CvCreator::findTagContentByName(itemTag.subtags,"when"+@language)}}\n"
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
			"\\item #{CvCreator::findTagContentByName(subitemTag.subtags,@language)}\n"
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
			result+="#{CvCreator::findTagContentByName(itemTag.subtags,"who")}, " if itemTag.name=="book"
			result+="\\textbf{#{CvCreator::findTagContentByName(itemTag.subtags,"what")}}" 
			result+=", #{CvCreator::findTagContentByName(itemTag.subtags,"where")}" if itemTag.name=="course"
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
			result="\\item #{CvCreator::findTagContentByName(itemTag.subtags,"what"+@language)}"
			result+=", #{CvCreator::findTagContentByName(itemTag.subtags,"when")}\n"
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
