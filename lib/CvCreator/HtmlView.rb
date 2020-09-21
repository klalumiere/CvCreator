require_relative "HtmlSectionView"
require_relative "Section"
require_relative "View"

module CvCreator
    class HtmlView < View
        def self.sectionToClass()
            {
                "skillSummary" => CvCreator::SkillSummaryHtml,
                "experience" => CvCreator::ExperienceHtml,
                "education" => CvCreator::EducationHtml,
                "autodidactTraining" => CvCreator::AutodidactTrainingHtml,
                "honor" => CvCreator::HonorHtml,
                "socialImplication" => CvCreator::SocialImplicationHtml,
                "publication" => CvCreator::PublicationHtml,
                "talk" => CvCreator::TalkHtml
            }
        end

    private
        def convertSpecialChar(data)
            data = data.gsub(/\\'(\w)/,"&\\1acute;")
            data = data.gsub(/\\`(\w)/,"&\\1grave;")
            data = data.gsub(/\\\^(\w)/,"&\\1circ;")
            data = data.gsub(/``/,"&ldquo;")
            data = data.gsub(/''/,"&rdquo;")
            data = data.gsub(/\\c (\w)/,"&\\1cedil;")
        end
        def footer
            "</div>"
        end
        def header(data,language)
            phoneLabel = ""
            if not (data["phone"].nil? or data["phone"].empty?)
                phoneLabel = "#{View::Phone[language]}: "
            end
            result = %Q[<div class="cvStyle">\n]
            result += %Q[<table align="center">\n]
            result += %Q[<tr> <td colspan="2"> <p style="text-align: center">]
            result += %Q[<strong style="font-size: 150%; text-align: center">#{data["name"]}</strong>\n]
            result += %Q[<br>#{data["email"]}\n]
            result += %Q[</p> </td> </tr>\n]
            result += %Q[<tr>\n]
            result += %Q[<td style="text-align: left">#{data["address"]}</td>\n]
            result += %Q[<td style="text-align: right">#{phoneLabel}#{data["phone"]}</td>\n]
            result += %Q[</tr>\n]
            result += %Q[<tr>\n]
            result += %Q[<td style="text-align: left">#{data["town"]}</td>\n]
            result += %Q[<td style="text-align: right"></td>\n]
            result += %Q[</tr>\n]
            result += %Q[<tr>\n]
            result += %Q[<td colspan="2">#{View::WebPage[language]}:  \n]
            result += %Q[<a href="#{data["webPage"]}">#{data["webPage"]}</a> </td>\n]
            result += %Q[</tr> </table>\n]
        end
        def sectionFooter
            ""
        end
    end # HtmlView
end # CvCreator
