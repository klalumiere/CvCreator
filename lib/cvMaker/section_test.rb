require "test/unit"
require_relative "section"

class SkillSummaryTest < Test::Unit::TestCase
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

	def testSkillSummaryNoClass
		@expectedResult=%q[\section{Sommaire de comp\'etences}
			\begin{itemize}
			\item Plus de cinq (5) ann\'ees d'exp\'erience en recherche
			\begin{itemize}
			\item Mod\'elisation math\'ematique et informatique de probl\`emes
			\end{itemize}
			\end{itemize}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: []}
		@result=CvMaker::SkillSummary.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end

	def testSkillSummaryWithClass
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
		@result=CvMaker::SkillSummary.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end

	def testSkillSummaryWithClassEn
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
		@result=CvMaker::SkillSummary.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end
end

class EducationTest < Test::Unit::TestCase
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

	def testEducation
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
		@result=CvMaker::Education.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end
end

class ExperienceTest < Test::Unit::TestCase
	def setup
		@data=%q[
			\titleFr{Exp\'eriences de travail}
			\titleEn{Experience}

			\experience{
				\whatEn{Graduate student researcher in physics}
				\whatFr{\'Etudiant chercheur en physique}
				\who{Alexandre Blais}
				\where{Universit\'e de Sherbrooke, Sherbrooke(Qc), Canada}
				\whenFr{2008-}
				\whenEn{2008-}
				\skill{
					\class{research}
					\En{International collaboration with experimentalists, Paper writing, Keynote presentation, Analytic study of circuit quantum electrodynamic}
					\Fr{Collaboration internationale avec des exp\'erimentateurs, \'Ecritures d'articles, Pr\'esentation Keynote, \'Etude analytique de l'\'electrodynamique quantique en circuit}
				}
				\skill{
					\class{computerScience}
					\En{Development of software to simulate quantum electrical circuits using C++}
					\Fr{D\'eveloppement d'un logiciel pour simuler des circuits \'electriques quantiques en C++}
				}
				\skill{
					\class{computerScience}
					\En{Contribution in development of a high performance scientific library using C++}
					\Fr{Participation au d\'eveloppement d'une librairie scientifique haute performance en C++}
				}
			}

			\experience{
				\whatEn{Teaching assistant}
				\whatFr{Auxiliaire d'enseignement}
				\who{}
				\where{Universit\'e de Sherbrooke, Sherbrooke(Qc), Canada}
				\whenFr{2008-2012}
				\whenEn{2008-2012}
				\skill{
					\class{teaching}
					\Fr{M\'ecanique quantique II (2008), M\'ecanique quantique I (2009), Physique M\'esoscopique (2010), Physique Statistique I (2011)}
					\En{M\'ecanique quantique II (2008), M\'ecanique quantique I (2009), Physique M\'esoscopique (2010), Physique Statistique I (2011)}
				}
			}

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

	def testExperiencesAllClasses
		@expectedResult=%q[\section{Exp\'eriences de travail}
			\begin{job}{\'Etudiant chercheur en physique}{Alexandre Blais, Universit\'e de Sherbrooke, Sherbrooke(Qc), Canada}{2008-}
			\begin{itemize}
			\item Collaboration internationale avec des exp\'erimentateurs, \'Ecritures d'articles, Pr\'esentation Keynote, \'Etude analytique de l'\'electrodynamique quantique en circuit
			\item D\'eveloppement d'un logiciel pour simuler des circuits \'electriques quantiques en C++
			\item Participation au d\'eveloppement d'une librairie scientifique haute performance en C++
			\end{itemize}
			\end{job}

			\begin{job}{Auxiliaire d'enseignement}{Universit\'e de Sherbrooke, Sherbrooke(Qc), Canada}{2008-2012}
			\begin{itemize}
			\item M\'ecanique quantique II (2008), M\'ecanique quantique I (2009), Physique M\'esoscopique (2010), Physique Statistique I (2011)
			\end{itemize}
			\end{job}

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
		@result=CvMaker::Experience.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end

	def testExperiencesNoOther
		@expectedResult=%q[\section{Exp\'eriences de travail}
			\begin{job}{\'Etudiant chercheur en physique}{Alexandre Blais, Universit\'e de Sherbrooke, Sherbrooke(Qc), Canada}{2008-}
			\begin{itemize}
			\item Collaboration internationale avec des exp\'erimentateurs, \'Ecritures d'articles, Pr\'esentation Keynote, \'Etude analytique de l'\'electrodynamique quantique en circuit
			\item D\'eveloppement d'un logiciel pour simuler des circuits \'electriques quantiques en C++
			\item Participation au d\'eveloppement d'une librairie scientifique haute performance en C++
			\end{itemize}
			\end{job}

			\begin{job}{Auxiliaire d'enseignement}{Universit\'e de Sherbrooke, Sherbrooke(Qc), Canada}{2008-2012}
			\begin{itemize}
			\item M\'ecanique quantique II (2008), M\'ecanique quantique I (2009), Physique M\'esoscopique (2010), Physique Statistique I (2011)
			\end{itemize}
			\end{job}

			\begin{job}{Stagiaire}{St\'ephane P\'eloquin, Infotierra, Sherbrooke(Qc), Canada}{\'Et\'e 2005}
			\begin{itemize}
			\item Conception d'un algorithme utilis\'e pour identifier les roches d'apr\`es les propri\'et\'es spectrales des pixels
			\end{itemize}
			\end{job}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: ["research","teaching","computerScience"]}
		@result=CvMaker::Experience.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end

	def testExperiencesNoOtherNoResearch
		@expectedResult=%q[\section{Exp\'eriences de travail}
			\begin{job}{\'Etudiant chercheur en physique}{Alexandre Blais, Universit\'e de Sherbrooke, Sherbrooke(Qc), Canada}{2008-}
			\begin{itemize}
			\item D\'eveloppement d'un logiciel pour simuler des circuits \'electriques quantiques en C++
			\item Participation au d\'eveloppement d'une librairie scientifique haute performance en C++
			\end{itemize}
			\end{job}

			\begin{job}{Auxiliaire d'enseignement}{Universit\'e de Sherbrooke, Sherbrooke(Qc), Canada}{2008-2012}
			\begin{itemize}
			\item M\'ecanique quantique II (2008), M\'ecanique quantique I (2009), Physique M\'esoscopique (2010), Physique Statistique I (2011)
			\end{itemize}
			\end{job}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: ["teaching","computerScience"]}
		@result=CvMaker::Experience.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end

	def testExperiencesNoOtherNoResearchNoTeaching
		@expectedResult=%q[\section{Exp\'eriences de travail}
			\begin{job}{\'Etudiant chercheur en physique}{Alexandre Blais, Universit\'e de Sherbrooke, Sherbrooke(Qc), Canada}{2008-}
			\begin{itemize}
			\item D\'eveloppement d'un logiciel pour simuler des circuits \'electriques quantiques en C++
			\item Participation au d\'eveloppement d'une librairie scientifique haute performance en C++
			\end{itemize}
			\end{job}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: ["computerScience"]}
		@result=CvMaker::Experience.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end

	def testExperiencesNoSkills
		@expectedResult=""
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: []}
		@result=CvMaker::Experience.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end
end

class AutodidactTrainingTest < Test::Unit::TestCase
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

	def testAutodidactTraining
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
		@result=CvMaker::AutodidactTraining.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end

	def testAutodidactTrainingEmpty
		@expectedResult=""
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: []}
		@result=CvMaker::AutodidactTraining.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end
end

class HonorTest < Test::Unit::TestCase
	def setup
		@data=%q[
			\titleFr{Mentions sp\'eciales}
			\titleEn{Honors and Awards}

			\honorsFr{Bourse de Doctorat ES D3 du CRSNG, 2010}
			\honorsEn{NSERC Phd Student Scholarship ES D3, 2010}]
	end

	def testHonors
		@expectedResult=%q[\section{Mentions sp\'eciales}
			\begin{itemize}
			\item Bourse de Doctorat ES D3 du CRSNG, 2010
			\end{itemize}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: []}
		@result=CvMaker::Honor.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end
end

class SocialImplicationTest < Test::Unit::TestCase
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

	def testSocialImplication
		@expectedResult=%q[\section{Implications sociales}
			\begin{itemize}
			\item Pr\'esentation ``Tests unitaires dans la programmation scientifique'' \`a l'Universit\'e de Sherbrooke, 2013
			\end{itemize}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: []}
		@result=CvMaker::SocialImplication.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end
end

class PublicationTest < Test::Unit::TestCase
	def setup
		@data=%q[
			\titleFr{Publications}
			\titleEn{Publications}
			\class{research}

			#BAC
			\publication{P. Xue, B. C. Sanders, A. Blais, and K. Lalumi\`ere, Quantum walks on circles in phase space via superconducting circuit quantum electrodynamics, Phys. Rev. A 78, 042334 (2008).}]
	end

	def testPublication
		@expectedResult=%q[\section{Publications}
			\begin{itemize}
			\item P. Xue, B. C. Sanders, A. Blais, and K. Lalumi\`ere, Quantum walks on circles in phase space via superconducting circuit quantum electrodynamics, Phys. Rev. A 78, 042334 (2008).
			\end{itemize}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: ["research"]}
		@result=CvMaker::Publication.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end
	def testPublicationEmpty
		@expectedResult=""
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: []}
		@result=CvMaker::Publication.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end
end

class TalkTest < Test::Unit::TestCase
	def setup
		@data=%q[
			\titleFr{Pr\'esentations orales}
			\titleEn{Contributed Talks}

			#Doctorat
			\talk{Interactions between superconducting qubits mediated by travelling photons, INTRIQ Meeting, Bromont(Qc), Canada, 2013.}]
	end

	def testTalk
		@expectedResult=%q[\section{Pr\'esentations orales}
			\begin{itemize}
			\item Interactions between superconducting qubits mediated by travelling photons, INTRIQ Meeting, Bromont(Qc), Canada, 2013.
			\end{itemize}]
		@expectedResult.gsub!("\t", "")
		@options = { language: "Fr",
					 classes: []}
		@result=CvMaker::Talk.new(@data,@options).tex
		assert_equal(@expectedResult,@result)
	end
end

class NoDataTest < Test::Unit::TestCase
	def testNoData
		@data=""
		@options = { language: "Fr",
					 classes: []}

		assert_equal("",CvMaker::SkillSummary.new(@data,@options).tex)
		assert_equal("",CvMaker::Education.new(@data,@options).tex)
		assert_equal("",CvMaker::Experience.new(@data,@options).tex)
		assert_equal("",CvMaker::AutodidactTraining.new(@data,@options).tex)
		assert_equal("",CvMaker::Honor.new(@data,@options).tex)
		assert_equal("",CvMaker::SocialImplication.new(@data,@options).tex)
		assert_equal("",CvMaker::Publication.new(@data,@options).tex)
		assert_equal("",CvMaker::Talk.new(@data,@options).tex)
	end
end
