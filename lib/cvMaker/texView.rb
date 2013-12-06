require_relative "section"
require_relative "texSectionView"

module CvMaker
	class TexView
		def initialize(dataHash,options)
			@sectionClasses={
				skillSummary: CvMaker::SkillSummaryTex,
				education: CvMaker::EducationTex,
				experience: CvMaker::ExperienceTex,
				autodidactTraining: CvMaker::AutodidactTrainingTex,
				honor: CvMaker::HonorTex,
				socialImplication: CvMaker::SocialImplicationTex,
				publication: CvMaker::PublicationTex,
				talk: CvMaker::TalkTex
			}

			@dataHash=dataHash
			@options=options
		end
		def content
			result=header
			@sectionClasses.each { |key,sectionViewClass|
				view=sectionViewClass.new(@options[:language])
				newTex=Section.new(@dataHash[key],@options,view).content
				result+=newTex+sectionFooter if newTex != ""
			}
			result+=footer
		end
	private
		def header
			of={"Fr"=>"de", "En"=>"of" }
			mobile={"Fr"=>"Cellulaire", "En"=>"Mobile" }
			phone={"Fr"=>"Domicile", "En"=>"Phone" }
			webPage={"Fr"=>"Page web", "En"=>"Web page" }
			
			result=%q[\documentclass[letterpaper,11pt]{resume2}

			\newcommand{\tab}[1]{\hspace{.2\textwidth}\rlap{#1}}

			\setcounter{errorcontextlines}{100}

			\usepackage{paralist}

			\definecolor{rulestartcolor}{rgb}{0,0,1}
			\definecolor{ruleendcolor}{rgb}{0.9,0.9,1}

			\begin{document}
			\renewcommand{\headrulewidth}{0pt}
			\rfoot{\thepage\ ]
			result+=of[@options[:language]]
			result+=%q[\ \pageref{LastPage}}
			\cfoot{Kevin Lalumi\`ere}

			\begin{center}
			\begin{tabular}{c}
			\Large{\textbf{Kevin Lalumi\`ere}}\\\\
			kevin.lalumiere@gmail.com
			\end{tabular}
			]

			result+="
			\\begin{tabular}{lr}
			534 Short & #{mobile[@options[:language]]}: (819)~437-7749\\\\
			Sherbrooke(Qc), Canada, J1H 2E4 & #{phone[@options[:language]]}: (819)~347-3388\\\\
			#{webPage[@options[:language]]}: {\\color{rulestartcolor}{\\shorthandoff{:} http://fierce-hamlet-5053.herokuapp.com/cvInteractif}} & 
			\\end{tabular}
			\\end{center}\n\n"

			result.gsub!("\t", "")
			result
		end
		def sectionFooter
			"\n\n\n"
		end
		def footer
			"\\end{document}"
		end 
	end
end