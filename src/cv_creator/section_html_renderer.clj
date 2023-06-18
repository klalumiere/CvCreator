(ns cv-creator.section-html-renderer
  (:require
   [clojure.string :as string]

   [selmer.parser :as selmer]

   [cv-creator.html-renderer]
   [cv-creator.section])
  (:import [cv_creator.section
            EducationItem
            HeadSection
            Item
            PhoneItem
            Section
            SubitemEducation
            WebPageItem]))

(extend-type EducationItem cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (selmer/render "<table>
<tr>
<td align=\"left\"><strong>{{degree}}</strong>
</td>
<td align=\"right\">{{date}}</td>
</tr>
<tr>
<td colspan=\"2\" align=\"left\">{{school}}</td>
</tr>
</table><ul>{{rendered-subitems|safe}}</ul><br>" (assoc this :rendered-subitems (cv-creator.html-renderer/render-html-all (:subitems this))))))

(extend-type SubitemEducation cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (selmer/render "<li><strong>{{label}}: </strong>{{subitem}}</li>" this)))

(extend-type Section cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (if (empty? (:items this))
                                   ""
                                   (selmer/render "<br><strong style=\"font-size: 125%;\">{{label}}</strong>
<hr class=\"section\">
<ul>{{rendered-items|safe}}</ul><br>" (assoc this :rendered-items (cv-creator.html-renderer/render-html-all (:items this)))))))

(extend-type Item cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (if (string/blank? (:item this))
                                   ""
                                   (selmer/render "<li>{{item}}</li><ul>{{rendered-subitems|safe}}</ul>
" (assoc this :rendered-subitems (cv-creator.html-renderer/render-html-all (:subitems this)))))))

(extend-type PhoneItem cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (if (string/blank? (:item this))
                                   ""
                                   (selmer/render "<td style=\"text-align: right\">{{label}}: {{item}}</td>"
                                                  this))))

(extend-type WebPageItem cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (if (string/blank? (:item this))
                                   ""
                                   (selmer/render "<tr>
<td colspan=\"2\">{{label}}: <a href=\"{{item}}\">{{item}}</a> </td>
</tr>" this))))

(extend-type HeadSection cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (selmer/render "<table align=\"center\">
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
{{rendered-webpage|safe}}
</table>" (assoc this
                 :rendered-phone (cv-creator.html-renderer/render-html (:phone this))
                 :rendered-webpage (cv-creator.html-renderer/render-html (:web-page this))))))
