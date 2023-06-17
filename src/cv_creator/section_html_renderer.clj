(ns cv-creator.section-html-renderer
  (:require
   [cv-creator.section]
   [cv-creator.html-renderer]
   [selmer.parser :as selmer])
  (:import [cv_creator.section HeadSection]))

(extend-type HeadSection cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (selmer/render "<div class=\"cvStyle\">
<table align=\"center\">
<tr> <td colspan=\"2\"> <p style=\"text-align: center\">
<strong style=\"font-size: 150%; text-align: center\">{{name}}</strong>
<br>{{e-mail}}
</p> </td> </tr>
<tr>
<td style=\"text-align: left\">{{address-door}}</td>
<td style=\"text-align: right\">#{phoneLabel}{{phone}}</td>
</tr>
<tr>
<td style=\"text-align: left\">{{address-town}}</td>
<td style=\"text-align: right\"></td>
</tr>
<tr>
<td colspan=\"2\">#{View::WebPage[language]}:  
<a href=\"{{web-page}}\">{{web-page}}</a> </td>
</tr> </table>
" this)))











            ;; phoneLabel = ""
            ;; if not (data["phone"].nil? or data["phone"].empty?)
            ;;     phoneLabel = "#{View::Phone[language]}: "
            ;; end

