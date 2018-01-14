require_relative "Section"
require_relative "Tag"

module CvCreator
    # TODO This class should be tested
    class View
        HeaderDataKeys = ["name" , "email" , "address" , "phone" , "town" , "webPage"]
        
        Phone = { "Fr" => "Cellulaire", "En" => "Mobile" }
        WebPage = { "Fr" => "Page web", "En" => "Web page" }
        
        def initialize(headerTags,dataHash,options)

            @headerTags = headerTags
            @dataHash = dataHash
            @options = options
        end
        def content
            headerContent = header(createHeaderDataFromTags(HeaderDataKeys,@headerTags), @options[:language])
            result = self.class.sectionToClass
                .map{ |key,viewClass| sectionContent(convertSpecialChar(@dataHash[key]), createView(viewClass)) }
                .map{ |content| addSectionFooterIfNotEmpty(content) }
                .reduce(headerContent, :+)
            result + footer()
        end

        def addSectionFooterIfNotEmpty(data)
            data == "" ? data : data + sectionFooter()
        end
        def createHeaderDataFromTags(headerDataKeys,headerTags)
            headerDataRaw = headerDataKeys.reduce({}) { |result,key|
                result.merge({key => CvCreator::findTagContentByName(headerTags,key)})
            }
            Hash[ headerDataRaw.map { |key,value| [key,convertSpecialChar(value)] } ]
        end
        def createView(viewClass)
            viewClass.new(@options[:language])
        end
        def sectionContent(data,view)
            Section.new(data, @options, view).content()
        end
    end # View
end # CvCreator
