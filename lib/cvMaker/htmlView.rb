require_relative "section"
require_relative "htmlSectionView"

module CvMaker
	class HtmlView
		def initialize(dataHash,options)
			@sectionClasses={
				skillSummary: CvMaker::SkillSummaryHtml,
				education: CvMaker::EducationHtml,
				experience: CvMaker::ExperienceHtml,
				autodidactTraining: CvMaker::AutodidactTrainingHtml,
				honor: CvMaker::HonorHtml,
				socialImplication: CvMaker::SocialImplicationHtml,
				publication: CvMaker::PublicationHtml,
				talk: CvMaker::TalkHtml
			}

			@dataHash=dataHash
			@options=options
		end
		def content
			result=header
			@sectionClasses.each { |key,sectionViewClass|
				convertSpecialChar(@dataHash[key])
				view=sectionViewClass.new(@options[:language])
				newTex=Section.new(@dataHash[key],@options,view).content
				result+=newTex+sectionFooter if newTex != ""
			}
			result+=footer
		end
	private
		def header
			phone={"Fr"=>"Cellulaire","En"=>"Mobile"}
			phoneHome={"Fr"=>"Domicile","En"=>"Phone"}
			webPage={"Fr"=>"Page web","En"=>"Web page"}
			result="
	 		<div class=\"cvStyle\">
	 		<table align=\"center\">
	 		<tr>
	 		<td colspan=\"2\">
	 			<p style=\"text-align: center\">
	 				<strong style=\"font-size: 150%; text-align: center\">Kevin Lalumi&egrave;re</strong>
	 				<br>kevin.lalumiere@gmail.com
	 				</p>
	 		</td>
	 		</tr>
	 		<tr>
	 		<td style=\"text-align: left\">534 Short</td>
	 		<td style=\"text-align: right\">#{phone[@options[:language]]}: (819) 437-7749</td>
	 		</tr>
	 		<tr>
	 		<td style=\"text-align: left\">Sherbrooke(Qc), Canada, J1H 2E4</td>
	 		<td style=\"text-align: right\">#{phoneHome[@options[:language]]}: (819) 347-3388</td>
	 		</tr>
	 		<tr>
	 		<td colspan=\"2\">#{webPage[@options[:language]]}:  
	 			<a href=\"http://fierce-hamlet-5053.herokuapp.com\">http://fierce-hamlet-5053.herokuapp.com</a></td>
	 		</tr>
	 		</table>
			"
			result.gsub!("\t", "")
			result
		end
		def convertSpecialChar(data)
			data.gsub!(/\\'(\w)/,"&\\1acute;")
			data.gsub!(/\\`(\w)/,"&\\1grave;")
			data.gsub!(/\\\^(\w)/,"&\\1circ;")
			data.gsub!(/``/,"&ldquo;")
			data.gsub!(/''/,"&rdquo;")
			data.gsub!(/\\c (\w)/,"&\\1cedil;")
		end
		def sectionFooter
			""
		end
		def footer
			"</div>"
		end 
	end
end
