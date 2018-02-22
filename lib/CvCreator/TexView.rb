require_relative "Section"
require_relative "TexSectionView"
require_relative "View"

module CvCreator
    class TexView < View
        def self.sectionToClass()
            @sectionClasses = {
                "skillSummary" => CvCreator::SkillSummaryTex,
                "education" => CvCreator::EducationTex,
                "experience" => CvCreator::ExperienceTex,
                "autodidactTraining" => CvCreator::AutodidactTrainingTex,
                "honor" => CvCreator::HonorTex,
                "socialImplication" => CvCreator::SocialImplicationTex,
                "publication" => CvCreator::PublicationTex,
                "talk" => CvCreator::TalkTex
            }
        end

    private
        def convertSpecialChar(data)
            data
        end
        def footer
            "\\end{document}"
        end 
        def header(data,language)
            result = %q[%The file 'resume2.cls' is required to compile this LaTeX source
            %Le fichier 'resume2.cls' est requis pour compiler cette source LaTeX
            \documentclass[letterpaper,11pt]{resume2}

            \newcommand{\tab}[1]{\hspace{.2\textwidth}\rlap{#1}}

            \setcounter{errorcontextlines}{100}

            \usepackage{paralist}

            \definecolor{rulestartcolor}{rgb}{0,0,1}
            \definecolor{ruleendcolor}{rgb}{0.9,0.9,1}

            \begin{document}
            \renewcommand{\headrulewidth}{0pt}
            \rfoot{\thepage\ ]

            result += View::Of[@options[:language]]
            result += %q[\ \pageref{LastPage}} \cfoot{]
            result += "#{data["name"]}"
            result += %q[} \begin{center}
            \begin{tabular}{c}
            \Large{\textbf{]

            result += "#{data["name"]}"
            result += %q[}}\\\\]
            result += "#{data["email"]}"
            result += %q[\end{tabular} ]
            result += "\\begin{tabular}{lr}
            #{data["address"]} & #{View::Phone[@options[:language]]}: #{data["phone"]}\\\\
            #{data["town"]} & ~ \\\\
            #{View::WebPage[@options[:language]]}: {\\color{rulestartcolor}{\\shorthandoff{:} #{data["webPage"]}}} & 
            \\end{tabular}
            \\end{center}\n\n"

            result.gsub!("\t", "")
            result
        end
        def sectionFooter
            "\n\n\n"
        end
    end # TexView
end # CvCreator