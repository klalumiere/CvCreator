require_relative "tag"

module CvMaker

	class Section
		attr_reader :tex
		def initialize(data,options)
			@language=options[:language]
			tagList=Tag.parseTag(data)
			globalClasses=CvMaker::contentsByName(tagList,"class")
			if (globalClasses & options[:classes]).empty? and !globalClasses.empty?
				@tex=""
				return
			end
			@tex="\\section{#{CvMaker::contentByName(tagList,"title"+@language)}}\n"
			
			itemAdded=0
			self.itemsName.each { |name|
				items=CvMaker::findTagsByName(tagList,name)
				items=filterBadClassAndEmpty(items,options[:classes],self.itemEssentialTag)
				self.addHeader(CvMaker::contentByName(tagList,name+"Title"+@language))
				items.each { |itemTag|
					self.addItem(itemTag)
					subitems=CvMaker::findTagsByName(itemTag.subTags,self.subitemName)
					subitems=filterBadClassAndEmpty(subitems,options[:classes],self.subitemEssentialTag)
					self.addSubitemHeader(subitems.length)
					subitems.each { |subitemTag|
						self.addSubitem(subitemTag)
					}
					self.addSubitemFooter(subitems.length)
					itemAdded+=1
				}
				self.addFooter()
			}

			@tex=@tex[0..tex.rindex(/}/)]
			@tex="" if itemAdded==0
		end
	protected
		def itemEssentialTag
			""
		end
		def addHeader(subsectionName)
			@tex+="\\subsection{#{subsectionName}}\n" if subsectionName != ""
			@tex+="\\begin{itemize}\n"
		end
		def subitemName
			""
		end
		def subitemEssentialTag
			""
		end
		def addSubitemHeader(subitemAdded)
			@tex+="\\begin{itemize}\n" if subitemAdded>0
		end
		def addSubitem(subitemTag)
		end
		def addSubitemFooter(subitemAdded)
			@tex+="\\end{itemize}\n" if subitemAdded>0
		end
		def addFooter
			@tex+="\\end{itemize}\n"
		end

	private
		def filterBadClassAndEmpty(items,classes,essentialTag)
			filteredItems=[]
			items.each { |item|
				filteredItems << item if itemInClass?(item,classes) and !emtpyItem?(item,essentialTag)
			}
			filteredItems
		end
		def itemInClass?(item,classes)
			subTags=item.subTags
			itemClasses=CvMaker::contentsByName(subTags,"class")
			subTags.each { |subTag|
				itemClasses+=CvMaker::contentsByName(subTag.subTags,"class")
			}
			!( (itemClasses & classes).empty? and !itemClasses.empty?)
		end
		def emtpyItem?(item,essentialTag)
			result=true if CvMaker::findTagsByName(item.subTags,essentialTag).empty? and essentialTag != ""
			result
		end
	end


	class SkillSummary < Section
	protected
		def itemsName
			["item"]
		end
		def addItem(itemTag)
			@tex+="\\item #{CvMaker::contentByName(itemTag.subTags,"what"+@language)}\n"
		end
		def subitemName
			"subitem"
		end
		def addSubitem(subitemTag)
			@tex+="\\item #{CvMaker::contentByName(subitemTag.subTags,"what"+@language)}\n"				
		end
	end

	class Education < Section
	protected
		def itemsName
			["education"]
		end
		def addHeader(subsectionName)
		end
		def addItem(itemTag)
			@tex+="\\diploma{#{CvMaker::contentByName(itemTag.subTags,"what"+@language)}}"
			@tex+="{#{CvMaker::contentByName(itemTag.subTags,"where")}}"
			@tex+="{#{CvMaker::contentByName(itemTag.subTags,"when"+@language)}}\n"
		end
		def subitemName
			"thesis"
		end
		def addSubitem(subitemTag)
			@tex+="\\item \\textbf{#{CvMaker::contentByName(subitemTag.subTags,"titleName"+@language)}} "
			@tex+="#{CvMaker::contentByName(subitemTag.subTags,"name")}\n"				
			@tex+="\\item \\textbf{#{CvMaker::contentByName(subitemTag.subTags,"titleAdvisor"+@language)}} "
			@tex+="#{CvMaker::contentByName(subitemTag.subTags,"advisor")}\n"	
		end
		def addSubitemFooter(subitemAdded)
			@tex+="\\end{itemize}\n~\\\\\n" if subitemAdded > 0
			@tex+="~\\\\~\\\\\n" if subitemAdded == 0
		end
		def addFooter
		end
	end

	class Experience < Section
	protected
		def itemsName
			["experience"]
		end
		def addHeader(subsectionName)
		end
		def addItem(itemTag)
			@tex+="\\begin{job}{#{CvMaker::contentByName(itemTag.subTags,"what"+@language)}}{"
			who=CvMaker::contentByName(itemTag.subTags,"who")
			@tex+="#{who}, " if !who.empty?
			@tex+="#{CvMaker::contentByName(itemTag.subTags,"where")}}"
			@tex+="{#{CvMaker::contentByName(itemTag.subTags,"when"+@language)}}\n"
		end
		def subitemName
			"skill"
		end
		def subitemEssentialTag
			@language
		end
		def addSubitem(subitemTag)
			@tex+="\\item #{CvMaker::contentByName(subitemTag.subTags,@language)}\n"
		end
		def addSubitemFooter(subitemAdded)		
			@tex+="\\end{itemize}\n" if subitemAdded>0
			@tex+="\\end{job}\n\n"
		end
		def addFooter
		end
	end

	class AutodidactTraining < Section
	protected
		def itemsName
			["book","course"]
		end
		def addItem(itemTag)
			@tex+="\\item "
			@tex+="#{CvMaker::contentByName(itemTag.subTags,"who")}, " if itemTag.name=="book"
			@tex+="\\textbf{#{CvMaker::contentByName(itemTag.subTags,"what")}}" 
			@tex+=", #{CvMaker::contentByName(itemTag.subTags,"where")}" if itemTag.name=="course"
			@tex+="\n"
		end
	end

	class Honor < Section
	protected
		def itemsName
			["honors"+@language]
		end
		def addItem(itemTag)
			@tex+="\\item #{itemTag.content}\n"
		end
	end

	class SocialImplication < Section
	protected
		def itemsName
			["social"]
		end
		def addItem(itemTag)
			@tex+="\\item #{CvMaker::contentByName(itemTag.subTags,"what"+@language)}"
			@tex+=", #{CvMaker::contentByName(itemTag.subTags,"when")}\n"
		end
	end

	class Publication < Section
	protected
		def itemsName
			["publication"]
		end
		def addItem(itemTag)
			@tex+="\\item #{itemTag.content}\n"
		end
	end

	class Talk < Section
	protected
		def itemsName
			["talk"]
		end
		def addItem(itemTag)
			@tex+="\\item #{itemTag.content}\n"
		end
	end
end