module CvMaker
	def CvMaker.header
		result=%q[\documentclass[letterpaper,11pt]{resume2}

			\newcommand{\tab}[1]{\hspace{.2\textwidth}\rlap{#1}}

			\setcounter{errorcontextlines}{100}

			\usepackage{paralist}

			\definecolor{rulestartcolor}{rgb}{0,0,1}
			\definecolor{ruleendcolor}{rgb}{0.9,0.9,1}

			\begin{document}
			\renewcommand{\headrulewidth}{0pt}
			\rfoot{\thepage\ de\ \pageref{LastPage}}
			\cfoot{Kevin Lalumi\`ere}

			\author{Kevin Lalumi\`ere}
			\email{kevin.lalumiere@gmail.com}
			\phone{(819)~347-3388}
			\phonework{(819)~437-7749}
			%\webpage{http://}
			\streetaddress{534 Short}
			\citystatezip{Sherbrooke(Qc), Canada, J1H 2E4}
			\maketitle


		]
		result.gsub!("\t", "")
		result
	end

	def CvMaker.footer
		"\\end{document}"
	end
end
