require "test/unit"
require_relative "section"
require_relative "texSectionView"

class SkillSummaryTexTest < Test::Unit::TestCase
	def setup
		@data=%q[
			\titleFr{Sommaire de comp\'etences}
			\titleEn{Skill Summary}
			\item{
				\whatFr{Plus de cinq (5) ann\'ees d'exp\'erience en recherche}
				\whatEn{More than five (5) years of research experience}
				\subitem{
					\whatEn{Problem modeling using mathematics and computer science}
					\whatFr{Mod\'elisation math\'ematique et informatique de probl\`emes}
				}
			}
			\item{
				\whatEn{Programming Language: C++, C, LaTeX, PHP, Javascript, HTML,  Ruby, Python, Scheme}
				\whatFr{Langage de programmation: C++, C, LaTeX, PHP, Javascript, HTML,  Ruby, Python, Scheme}
				\class{computerScience}
			}
		]
	end

	def testSkillSummaryTexWithClass
		@expectedResult=%q[\section{Sommaire de comp\'etences}
			\begin{itemize}
			\item Plus de cinq (5) ann\'ees d'exp\'erience en recherche
			\begin{itemize}
			\item Mod\'elisation math\'ematique et informatique de probl\`emes
			\end{itemize}
			\item Langage de programmation: C++, C, LaTeX, PHP, Javascript, HTML,  Ruby, Python, Scheme
			\end{itemize}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: ["computerScience"]}
		view=CvMaker::SkillSummaryTex.new(@options[:language])
		@result=CvMaker::Section.new(@data,@options,view).content
		assert_equal(@expectedResult,@result)
	end

	def testSkillSummaryTexWithClassEn
		@expectedResult=%q[\section{Skill Summary}
			\begin{itemize}
			\item More than five (5) years of research experience
			\begin{itemize}
			\item Problem modeling using mathematics and computer science
			\end{itemize}
			\item Programming Language: C++, C, LaTeX, PHP, Javascript, HTML,  Ruby, Python, Scheme
			\end{itemize}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "En",
					 classes: ["computerScience"]}
		view=CvMaker::SkillSummaryTex.new(@options[:language])
		@result=CvMaker::Section.new(@data,@options,view).content
		assert_equal(@expectedResult,@result)
	end
end

class EducationTexTest < Test::Unit::TestCase
	def setup
		@data=%q[
			\titleFr{Scolarit\'e}
			\titleEn{Education}

			\education{
				\whatEn{Ph.D. in Physics}
				\whatFr{Ph.D. en physique}
				\whenFr{2010-}
				\whenEn{2010-}
				\where{Universit\'e de Sherbrooke, Sherbrooke(Qc), Canada}
				\thesis{
					\titleNameFr{Th\\`ese:}
					\titleNameEn{Thesis}
					\name{}
					\titleAdvisorFr{Superviseur:}
					\titleAdvisorEn{Advisor:}
					\advisor{Alexandre Blais}
				}
			}

			\education{
				\whatEn{Quantum machines Summer school}
				\whatFr{\'Ecole d'\'et\'e Quantum machines}
				\whenFr{Juillet 2011}
				\whenEn{July 2011}
				\where{\'Ecole de physique Les Houches, Les Houches, France}
			}

			\education{
				\whatEn{M. Sc. in Physics}
				\whatFr{M. Sc. en Physique}
				\whenFr{2008-2010}
				\whenEn{2008-2010}
				\where{Universit\'e de Sherbrooke, Sherbrooke(Qc), Canada}
				\thesis{
					\titleNameFr{M\\'emoire:}
					\titleNameEn{Memoir}
					\name{Mesure de parit\'e en \'electrodynamique quantique en circuit}
					\titleAdvisorFr{Superviseur:}
					\titleAdvisorEn{Advisor:}
					\advisor{Alexandre Blais}
				}
			}
		]
	end

	def testEducationTex
		@expectedResult=%q[\section{Scolarit\'e}
			\diploma{Ph.D. en physique}{Universit\'e de Sherbrooke, Sherbrooke(Qc), Canada}{2010-}
			\begin{itemize}
			\item \textbf{Th\`ese:} 
			\item \textbf{Superviseur:} Alexandre Blais
			\end{itemize}
			~\\\\
			\diploma{\'Ecole d'\'et\'e Quantum machines}{\'Ecole de physique Les Houches, Les Houches, France}{Juillet 2011}
			~\\\\~\\\\
			\diploma{M. Sc. en Physique}{Universit\'e de Sherbrooke, Sherbrooke(Qc), Canada}{2008-2010}
			\begin{itemize}
			\item \textbf{M\'emoire:} Mesure de parit\'e en \'electrodynamique quantique en circuit
			\item \textbf{Superviseur:} Alexandre Blais
			\end{itemize}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: []}
		view=CvMaker::EducationTex.new(@options[:language])
		@result=CvMaker::Section.new(@data,@options,view).content
		assert_equal(@expectedResult,@result)
	end
end

class ExperienceTexTest < Test::Unit::TestCase
	def setup
		@data=%q[
			\titleFr{Exp\'eriences de travail}
			\titleEn{Experience}

			\experience{
				\whatEn{Intern}
				\whatFr{Stagiaire}
				\who{St\'ephane P\'eloquin}
				\where{Infotierra, Sherbrooke(Qc), Canada}
				\whenEn{Summer 2005}
				\whenFr{\'Et\'e 2005}
				\skill{
					\class{research}
					\En{Conception of an algorithm used to identify rock type based on pixel's spectral properties}
					\Fr{Conception d'un algorithme utilis\'e pour identifier les roches d'apr\`es les propri\'et\'es spectrales des pixels}
				}
			}

			\experience{
				\whatEn{Clerks}
				\whatFr{Commis}
				\who{Vid\'eoflash}
				\where{Saint-Hyacinthe, Magog, Sherbrooke (Qc), Canada}
				\whenFr{2003-2005}
				\whenEn{2003-2005}
				\skill{\class{other}}
				}]
	end

	def testExperienceTexAllClasses
		@expectedResult=%q[~\\\\ \section{Exp\'eriences de travail}
			\begin{job}{Stagiaire}{St\'ephane P\'eloquin, Infotierra, Sherbrooke(Qc), Canada}{\'Et\'e 2005}
			\begin{itemize}
			\item Conception d'un algorithme utilis\'e pour identifier les roches d'apr\`es les propri\'et\'es spectrales des pixels
			\end{itemize}
			\end{job}

			\begin{job}{Commis}{Vid\'eoflash, Saint-Hyacinthe, Magog, Sherbrooke (Qc), Canada}{2003-2005}
			\end{job}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: ["other","research","teaching","computerScience"]}
		view=CvMaker::ExperienceTex.new(@options[:language])
		@result=CvMaker::Section.new(@data,@options,view).content
		assert_equal(@expectedResult,@result)
	end
end

class AutodidactTrainingTexTest < Test::Unit::TestCase
	def setup
		@data=%q[
			\titleFr{Formations autodidactes}
			\titleEn{Autodidact training}

			\bookTitleFr{Lectures pertinentes}
			\bookTitleEn{Relevant readings}
			\book{
				\what{Operating System Concepts}
				\who{Silberschatz, Galvin et Gagne}
				\class{computerScience}
			}
			\courseTitleFr{Cours optionels}
			\courseTitleEn{Optional courses}
			\course{
				\what{Computer Science 61A: Programming paradigm (Scheme)}
				\where{Online (UC Berkeley via iTunesU)}
				\class{computerScience}
				}]
	end

	def testAutodidactTrainingTex
		@expectedResult=%q[\section{Formations autodidactes}
			\subsection{Lectures pertinentes}
			\begin{itemize}
			\item Silberschatz, Galvin et Gagne, \textbf{Operating System Concepts}
			\end{itemize}
			\subsection{Cours optionels}
			\begin{itemize}
			\item \textbf{Computer Science 61A: Programming paradigm (Scheme)}, Online (UC Berkeley via iTunesU)
			\end{itemize}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: ["computerScience"]}
		view=CvMaker::AutodidactTrainingTex.new(@options[:language])
		@result=CvMaker::Section.new(@data,@options,view).content
		assert_equal(@expectedResult,@result)
	end
end

class HonorTexTest < Test::Unit::TestCase
	def setup
		@data=%q[
			\titleFr{Mentions sp\'eciales}
			\titleEn{Honors and Awards}

			\honorsFr{Bourse de Doctorat ES D3 du CRSNG, 2010}
			\honorsEn{NSERC Phd Student Scholarship ES D3, 2010}]
	end

	def testHonorTex
		@expectedResult=%q[\section{Mentions sp\'eciales}
			\begin{itemize}
			\item Bourse de Doctorat ES D3 du CRSNG, 2010
			\end{itemize}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: []}
		view=CvMaker::HonorTex.new(@options[:language])
		@result=CvMaker::Section.new(@data,@options,view).content
		assert_equal(@expectedResult,@result)
	end
end

class SocialImplicationTexTest < Test::Unit::TestCase
	def setup
		@data=%q[
			\titleFr{Implications sociales}
			\titleEn{Social Implication}

			\social{
				\whatEn{Keynote ``Unit testing in scientific programming'' at Universit\'e de Sherbrooke}
				\whatFr{Pr\'esentation ``Tests unitaires dans la programmation scientifique'' \`a l'Universit\'e de Sherbrooke}
				\when{2013}
				}]
	end

	def testSocialImplicationTex
		@expectedResult=%q[\section{Implications sociales}
			\begin{itemize}
			\item Pr\'esentation ``Tests unitaires dans la programmation scientifique'' \`a l'Universit\'e de Sherbrooke, 2013
			\end{itemize}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: []}
		view=CvMaker::SocialImplicationTex.new(@options[:language])
		@result=CvMaker::Section.new(@data,@options,view).content
		assert_equal(@expectedResult,@result)
	end
end

class PublicationTexTest < Test::Unit::TestCase
	def setup
		@data=%q[
			\titleFr{Publications}
			\titleEn{Publications}
			\class{research}

			#BAC
			\publication{P. Xue, B. C. Sanders, A. Blais, and K. Lalumi\`ere, Quantum walks on circles in phase space via superconducting circuit quantum electrodynamics, Phys. Rev. A 78, 042334 (2008).}]
	end

	def testPublicationTex
		@expectedResult=%q[\section{Publications}
			\begin{itemize}
			\item P. Xue, B. C. Sanders, A. Blais, and K. Lalumi\`ere, Quantum walks on circles in phase space via superconducting circuit quantum electrodynamics, Phys. Rev. A 78, 042334 (2008).
			\end{itemize}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: ["research"]}
		view=CvMaker::PublicationTex.new(@options[:language])
		@result=CvMaker::Section.new(@data,@options,view).content
		assert_equal(@expectedResult,@result)
	end
end

class TalkTexTest < Test::Unit::TestCase
	def setup
		@data=%q[
			\titleFr{Pr\'esentations orales}
			\titleEn{Contributed Talks}

			#Doctorat
			\talk{Interactions between superconducting qubits mediated by travelling photons, INTRIQ Meeting, Bromont(Qc), Canada, 2013.}]
	end

	def testTalkTex
		@expectedResult=%q[\section{Pr\'esentations orales}
			\begin{itemize}
			\item Interactions between superconducting qubits mediated by travelling photons, INTRIQ Meeting, Bromont(Qc), Canada, 2013.
			\end{itemize}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: []}
		view=CvMaker::TalkTex.new(@options[:language])
		@result=CvMaker::Section.new(@data,@options,view).content
		assert_equal(@expectedResult,@result)
	end
end
