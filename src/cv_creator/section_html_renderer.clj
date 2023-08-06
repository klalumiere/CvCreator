(ns cv-creator.section-html-renderer
  (:require
   [clojure.string :as string]

   [selmer.parser :as selmer]

   [cv-creator.html-renderer]
   [cv-creator.section])
  (:import [cv_creator.section
            AutodidactTrainingItem
            EducationItem
            ExperienceItem
            HeadSection
            Item
            PhoneItem
            Section
            EducationSubitem
            OptionalCoursesSubitem
            RelevantReadingsSubitem
            WebPageItem]))


(extend-type AutodidactTrainingItem cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (selmer/render "<strong style=\"font-size: 112%;\">{{label}}</strong><br>
<ul>{{rendered-subitems|safe}}</ul><br>" (assoc this :rendered-subitems
                                                (cv-creator.html-renderer/render-html-all (:subitems this))))))


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
</table><ul>{{rendered-subitems|safe}}</ul><br>" (assoc this :rendered-subitems
                                                        (cv-creator.html-renderer/render-html-all (:subitems this))))))


(extend-type ExperienceItem cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (selmer/render "<table>
<tr>
<td align=\"left\"><strong>{{title}}</strong>
</td>
<td align=\"right\">{{date}}</td>
</tr>
<tr>
<td colspan=\"2\" align=\"left\">{{business}}</td>
</tr>
</table><hr><ul>{{rendered-subitems|safe}}</ul>
<br>" (assoc this :rendered-subitems
             (cv-creator.html-renderer/render-html-all (:subitems this))))))


(extend-type HeadSection cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (selmer/render "<table align=\"center\">
<tr> <td colspan=\"2\"> <p style=\"text-align: center\">
<strong style=\"font-size: 150%; text-align: center\">{{name}}</strong>
<br>{{eMail}}
</p> </td> </tr>
<tr>
<td style=\"text-align: left\">{{addressDoor}}</td>
{{rendered-phone|safe}}
</tr>
<tr>
<td style=\"text-align: left\">{{addressTown}}</td>
<td style=\"text-align: right\"></td>
</tr>
{{rendered-webpage|safe}}
</table>" (assoc this
                 :rendered-phone (cv-creator.html-renderer/render-html (:phone this))
                 :rendered-webpage (cv-creator.html-renderer/render-html (:webPage this))))))


(extend-type Item cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (if (string/blank? (:value this))
                                   ""
                                   (selmer/render "<li>{{value}}</li><ul>{{rendered-subitems|safe}}</ul>
" (assoc this :rendered-subitems (cv-creator.html-renderer/render-html-all (:subitems this)))))))


(extend-type PhoneItem cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (if (string/blank? (:value this))
                                   ""
                                   (selmer/render "<td style=\"text-align: right\">{{label}}: {{value}}</td>" this))))


(extend-type Section cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (if (empty? (:items this))
                                   ""
                                   (selmer/render "<br><strong style=\"font-size: 125%;\">{{label}}</strong>
<hr class=\"section\">
<ul>{{rendered-items|safe}}</ul>
<br>" (assoc this :rendered-items (cv-creator.html-renderer/render-html-all (:items this)))))))


(extend-type EducationSubitem cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (selmer/render "<li><strong>{{label}}: </strong>{{value}}</li>" this)))


(extend-type OptionalCoursesSubitem cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (selmer/render "<li><strong>{{title}}</strong>, {{place}}</li>" this)))


(extend-type RelevantReadingsSubitem cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (selmer/render "<li>{{authors}}, <strong>{{title}}</strong></li>" this)))


(extend-type WebPageItem cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (if (string/blank? (:value this))
                                   ""
                                   (selmer/render "<tr>
<td colspan=\"2\">{{label}}: <a href=\"{{value}}\">{{value}}</a> </td></tr>" this))))
