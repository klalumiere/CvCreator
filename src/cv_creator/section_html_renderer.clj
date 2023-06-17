(ns cv-creator.section-html-renderer
  (:require
   [cv-creator.section]
   [cv-creator.html-renderer]
   [clojure.string :as string]
   [selmer.parser :as selmer])
  (:import [cv_creator.section HeadSection PhoneItem]))

(extend-type PhoneItem cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (if (string/blank? (:item this))
                                   ""
                                   (selmer/render "<td style=\"text-align: right\">{{label}}: {{item}}</td>"
                                                  this))))

(extend-type HeadSection cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (selmer/render "<div class=\"cvStyle\">
<table align=\"center\">
<tr> <td colspan=\"2\"> <p style=\"text-align: center\">
<strong style=\"font-size: 150%; text-align: center\">{{name}}</strong>
<br>{{e-mail}}
</p> </td> </tr>
<tr>
<td style=\"text-align: left\">{{address-door}}</td>
{{rendered-phone|safe}}
</tr>
<tr>
<td style=\"text-align: left\">{{address-town}}</td>
<td style=\"text-align: right\"></td>
</tr>
<tr>
<td colspan=\"2\">#{View::WebPage[language]}:  
<a href=\"{{web-page}}\">{{web-page}}</a> </td>
</tr> </table>
" (assoc this
         :rendered-phone (cv-creator.html-renderer/render-html (:phone this))
         :rendered-webpage "web"))))











            ;; phoneLabel = ""
            ;; if not (data["phone"].nil? or data["phone"].empty?)
            ;;     phoneLabel = "#{View::Phone[language]}: "
            ;; end

