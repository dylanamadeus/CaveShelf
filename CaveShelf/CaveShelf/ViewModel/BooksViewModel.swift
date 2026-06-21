//
//  BooksViewModel.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 10/06/26.
//

import Foundation
import Observation

@Observable
final class BooksViewModel {
    var books: [BooksModel]
    
    init() {
        books = []
        loadBooks()
    }
    
    func saveBooks() {
        do {
            let encoded = try JSONEncoder().encode(books)
            UserDefaults.standard.set(encoded, forKey: "books")
            print("Books Saved")
        } catch {
            print("Failed to save books: \(error)")
        }
    }
    
    func loadBooks() {
        if let data = UserDefaults.standard.data(forKey: "books") {
            do {
                let decoded = try JSONDecoder().decode([BooksModel].self, from: data)
                books = decoded
            } catch {
                print("Failed to load books: \(error)")
            }
        } else {
            books = [
                BooksModel(
                    title: "War and Peace and War",
                    author: "Peter Turchin",
                    coverImage: "warAndPeaceAndWar",
                    pages: 416,
                    year: 2006,
                    about: "War and Peace and War applies a scientific approach to history, explaining how societies rise and fall through cooperation and conflict. Peter Turchin introduces the concept of cliodynamics, exploring how social cohesion and imperial expansion are driven by collective solidarity, which eventually decays over time.",
                    status: true
                ),
                BooksModel(
                    title: "War: How Conflict Shaped Us",
                    author: "Margaret MacMillan",
                    coverImage: "warHowConflictShapedUs",
                    pages: 320,
                    year: 2020,
                    about: "War: How Conflict Shaped Us examines the profound and paradoxical impact of warfare on human history. Margaret MacMillan argues that conflict is deeply intertwined with human civilization, influencing language, technology, social structures, and political institutions, making it essential to understand rather than ignore.",
                    status: true
                ),
                BooksModel(
                    title: "Woman Life Freedom",
                    author: "Marjane Satrapi",
                    coverImage: "womanLifeFreedom",
                    pages: 272,
                    year: 2024,
                    about: "Woman Life Freedom is a graphic novel anthology that documents the historic, women-led uprising in Iran following the death of Mahsa Amini. Activists and artists collaborate under Marjane Satrapi's guidance to depict the struggle against oppression, celebrating the resilience, courage, and cultural history of the Iranian people.",
                    status: true
                ),
                BooksModel(
                    title: "Feminist Propaganda",
                    author: "Ladies Who Create",
                    coverImage: "feministPropaganda",
                    pages: 150,
                    year: 2020,
                    about: "Feminist by Ladies Who Create is a creative compilation celebrating women designers, artists, and innovators. The book highlights diverse perspectives on feminism within the creative industry, providing inspiration, advice, and visual stories aimed at empowering the next generation of female creators.",
                    status: true
                ),
                BooksModel(
                    title: "Catatan Pinggir 2",
                    author: "Goenawan Mohamad",
                    coverImage: "catatanPinggir2",
                    pages: 450,
                    year: 1989,
                    about: "Catatan Pinggir is a renowned collection of weekly essays written by Goenawan Mohamad for Tempo magazine. Spanning various topics from politics and philosophy to literature and humanity, these short reflections offer deep, poetic insights into the complex socio-political landscape of Indonesia and the world.",
                    status: true
                ),
                BooksModel(
                    title: "The Matter of Critique",
                    author: "Andrea Righi & Rachel Jackson",
                    coverImage: "theMatterOfCritique",
                    pages: 240,
                    year: 2022,
                    about: "The Matter of Critique explores modern critical theory and its relationship with materialism and societal change. Andrea Righi and Rachel Jackson delve into how philosophical critique can address current socio-economic crises, offering readers a deep, challenging look into the mechanics of ideology and intellectual resistance.",
                    status: true
                ),
                BooksModel(
                    title: "Kamisan",
                    author: "Tim Aksi Kamisan",
                    coverImage: "kamisan",
                    pages: 180,
                    year: 2019,
                    about: "Kamisan tells the powerful story of the weekly silent protest held in front of the Presidential Palace in Jakarta by victims of human rights violations and their families. The book documents their decades-long endurance, demanding accountability, justice, and truth from the state for past tragedies.",
                    status: true
                ),
                BooksModel(
                    title: "Irama Orang-Orang (Menolak) Kalah",
                    author: "Irfan R. Darajat",
                    coverImage: "iramaOrangOrangMenolakKalah",
                    pages: 220,
                    year: 2021,
                    about: "Irama Orang-Orang (Menolak) Kalah examines the intersection of popular music, subculture, and social resistance in Indonesia. Irfan R. Darajat explores how independent musicians and local communities use melodies and lyrics as a powerful medium to voice criticism, preserve identity, and resist structural injustices.",
                    status: true
                ),
                BooksModel(
                    title: "Trocoh",
                    author: "Budi Warsito",
                    coverImage: "trocoh",
                    pages: 160,
                    year: 2018,
                    about: "Trocoh is an Indonesian literary work that captures daily life narratives with a sharp, satirical, and deeply reflective tone. Budi Warsito presents stories of ordinary individuals navigating modern absurdities, cultural transitions, and internal conflicts, blending local wisdom with contemporary social commentary.",
                    status: true
                ),
                BooksModel(
                    title: "Metode Jakarta",
                    author: "Vincent Bevins",
                    coverImage: "metodeJakarta",
                    pages: 320,
                    year: 2020,
                    about: "Metode Jakarta explores the violent covert operations orchestrated by the US during the Cold War, focusing on the 1965 mass killings in Indonesia. Vincent Bevins investigates how this brutal strategy became a global blueprint used to dismantle leftist movements and shape the modern capitalist world.",
                    status: true
                ),
                BooksModel(
                    title: "Confessions",
                    author: "Saint Augustine",
                    coverImage: "confessions",
                    pages: 350,
                    year: 397,
                    about: "Confessions is a deeply personal and philosophical autobiographical work written by Saint Augustine of Hippo. The text outlines his sinful youth, his passionate intellectual search for truth, and his eventual conversion to Christianity, establishing a foundational framework for Western spiritual and philosophical thought.",
                    status: true
                ),
                BooksModel(
                    title: "Republic",
                    author: "Plato",
                    coverImage: "republic",
                    pages: 416,
                    year: 375, // SM / BCE
                    about: "Republic is Plato's classic Socratic dialogue concerning justice, the order and character of the just city-state, and the just man. Through famous allegories like the Cave, Plato examines the nature of reality, the concept of philosopher-kings, and the ideal political system for human flourishing.",
                    status: true
                ),
                BooksModel(
                    title: "Jogja Bawah Tanah",
                    author: "Agung Purwandono",
                    coverImage: "jogjaBawahTanah",
                    pages: 200,
                    year: 2016,
                    about: "Jogja Bawah Tanah uncovers the hidden, alternative, and subcultural layers of Yogyakarta that lie beneath its traditional tourist image. Agung Purwandono takes readers on an investigative journey through independent art communities, underground movements, and marginalized voices that shape the city's unique identity.",
                    status: true
                ),
                BooksModel(
                    title: "Hijrah jangan jauh jauh nanti nyasar!",
                    author: "Kalis Mardiasih",
                    coverImage: "hijrahJanganJauhJauhNantiNyasar",
                    pages: 212,
                    year: 2019,
                    about: "Hijrah jangan jauh jauh nanti nyasar! offers a refreshing, empathetic, and critical look at the contemporary phenomenon of religious migration (hijrah) among Indonesian youths. Kalis Mardiasih advocates for a moderate, compassionate approach to Islam that values humanity, critical thinking, and inclusivity over rigid formalism.",
                    status: true
                ),
                BooksModel(
                    title: "Terra incognita",
                    author: "Ian Goldin",
                    coverImage: "terraIncognita",
                    pages: 320,
                    year: 2020,
                    about: "Terra Incognita uses state-of-the-art maps and data visualization to analyze the massive forces reshaping our planet, from climate change to globalization and inequality. Ian Goldin explores the profound transformations of the 21st century, offering an urgent guide to navigating humanity's uncertain future.",
                    status: true
                ),
                BooksModel(
                    title: "User Friendly",
                    author: "Cliff Kuang & Robert Fabricant",
                    coverImage: "userFriendly",
                    pages: 416,
                    year: 2019,
                    about: "User Friendly uncovers the hidden history and principles of user experience design, showing how it subtly shapes modern daily life. Cliff Kuang and Robert Fabricant trace the evolution of machines becoming intuitive, explaining how design changed from a technical discipline into a powerful tool that controls human behavior.",
                    status: true
                ),
                BooksModel(
                    title: "The Interpretation of Dreams",
                    author: "Sigmund Freud",
                    coverImage: "theInterpretationOfDreams",
                    pages: 480,
                    year: 1899,
                    about: "The Interpretation of Dreams introduces Sigmund Freud's groundbreaking psychoanalytic theory that dreams are forms of wish-fulfillment. Freud analyzes the mechanisms of dream-work, unconscious desires, and the human psyche, shifting how modern psychology understands the unconscious mind and inner conflicts.",
                    status: true
                ),
                BooksModel(
                    title: "Why has nobody told me this before",
                    author: "Dr. Julie Smith",
                    coverImage: "whyHasNobodyToldMeThisBefore",
                    pages: 368,
                    year: 2022,
                    about: "Why Has Nobody Told Me This Before? is a practical handbook providing essential mental health skills for navigating life's challenges. Dr. Julie Smith offers accessible insights into managing anxiety, dealing with criticism, boosting self-confidence, and fostering resilience, delivering proven therapeutic techniques straight to everyday readers.",
                    status: true
                ),
                BooksModel(
                    title: "An Illustrated History of Ghost",
                    author: "Adam Allsuch Boardman",
                    coverImage: "anIllustratedHistoryOfGhost",
                    pages: 120,
                    year: 2018,
                    about: "An Illustrated History of Ghosts offers a visually captivating exploration of spectral phenomena across different cultures and eras. Adam Allsuch Boardman traces folklore, spiritualism, and cinematic ghosts with detailed, stylized illustrations, providing a charming yet historical look at humanity's long-standing obsession with the paranormal.",
                    status: true
                ),
                BooksModel(
                    title: "Kings & Queens",
                    author: "David Soud",
                    coverImage: "kingsQueens",
                    pages: 256,
                    year: 2014,
                    about: "Kings & Queens is a comprehensive historical guide detailing the monarchies that have shaped global dynasties throughout history. David Soud examines the lives, triumphs, scandals, and political impacts of history's most notable rulers, offering an engaging overview of imperial power and legacy across various civilizations.",
                    status: true
                ),
                BooksModel(
                    title: "Saya Ingin Lihat Semua Ini Berakhir",
                    author: "M. Aan Mansyur",
                    coverImage: "sayaInginLihatSemuaIniBerakhir",
                    pages: 112,
                    year: 2020,
                    about: "Saya Ingin Lihat Semua Ini Berakhir is a poignant collection of contemporary Indonesian poetry that explores themes of loss, isolation, and existential weariness. M. Aan Mansyur uses deeply evocative, minimalist language to capture the emotional weight of living through uncertain times and the quiet longing for closure.",
                    status: true
                ),
                BooksModel(
                    title: "The Social Constract and Discoureses",
                    author: "Jean-Jacques Rousseau",
                    coverImage: "theSocialConstractAndDiscoureses",
                    pages: 304,
                    year: 1762,
                    about: "The Social Contract and Discourses is a foundational work of modern political philosophy regarding the legitimacy of political authority. Jean-Jacques Rousseau argues that true freedom is found in a society ruled by the general will of its citizens, laying down principles that inspired democratic revolutions worldwide.",
                    status: true
                ),
                BooksModel(
                    title: "The Body keeps the score",
                    author: "Bessel van der Kolk",
                    coverImage: "theBodyKeepsTheScore",
                    pages: 464,
                    year: 2014,
                    about: "The Body Keeps the Score explores how trauma re-wires the human brain and physically manifests within the body. Dr. Bessel van der Kolk shares scientific breakthroughs and case studies to explain how survivors can heal through innovative therapies like yoga, mindfulness, neurofeedback, and theater.",
                    status: true
                ),
                BooksModel(
                    title: "Southeast Asia",
                    author: "Milton Osborne",
                    coverImage: "southeastAsia",
                    pages: 320,
                    year: 2016,
                    about: "Southeast Asia provides a comprehensive, highly accessible introductory history of the region's complex cultural, colonial, and political evolution. Milton Osborne tracks the rise of early kingdoms, the impact of European colonization, and the turbulent transitions to independence that shaped modern Southeast Asian nations.",
                    status: true
                ),
                BooksModel(
                    title: "Grit",
                    author: "Angela Duckworth",
                    coverImage: "grit",
                    pages: 352,
                    year: 2016,
                    about: "Grit demonstrates that the secret to outstanding achievement is not naturally inherited talent, but a special blend of passion and long-term perseverance. Angela Duckworth draws on psychology and real-world examples to show how individuals can cultivate grit within themselves and foster it in others.",
                    status: true
                ),
                BooksModel(
                    title: "Feminist designer",
                    author: "Alison Place",
                    coverImage: "feministDesigner",
                    pages: 320,
                    year: 2023,
                    about: "Feminist Designer brings together essays and case studies exploring how design can dismantle patriarchal structures and promote social equity. Alison Place challenges traditional design methodologies, offering inclusive, justice-centered frameworks that elevate marginalized voices and rethink the future of visual communication.",
                    status: true
                ),
                BooksModel(
                    title: "This day in Rap and Hip-Hop History",
                    author: "Chuck D",
                    coverImage: "thisDayInRapAndHipHopHistory",
                    pages: 352,
                    year: 2017,
                    about: "This Day in Rap and Hip-Hop History is an exhaustive, chronological compilation detailing the monumental events that defined hip-hop culture over four decades. Legendary artist Chuck D provides expert commentary on pivotal album releases, battles, and historic breakthroughs, celebrating the genre's enduring global legacy.",
                    status: true
                ),
                BooksModel(
                    title: "Sapiens",
                    author: "Yuval Noah Harari",
                    coverImage: "Sapiens",
                    pages: 443,
                    year: 2011,
                    about: "Sapiens explores the history of humankind, tracing the journey from early hunter-gatherers to modern civilizations. Yuval Noah Harari examines how biology, culture, and shared beliefs shaped societies, economies, and technologies. The book offers a thought-provoking perspective on humanity's past and future.",
                    status: true
                ),
                BooksModel(
                    title: "Atomic Habits",
                    author: "James Clear",
                    coverImage: "AtomicHabits",
                    pages: 320,
                    year: 2018,
                    about: "Atomic Habits explains how small, consistent actions can lead to remarkable personal growth over time. James Clear introduces practical strategies for building positive habits, breaking negative ones, and designing environments that support success. The book focuses on sustainable improvement rather than dramatic change.",
                    status: false
                ),
                BooksModel(
                    title: "The Alchemist",
                    author: "Paulo Coelho",
                    coverImage: "TheAlchemist",
                    pages: 208,
                    year: 1988,
                    about: "The Alchemist follows Santiago, a young shepherd who embarks on a journey in search of treasure. Along the way, he encounters challenges, mentors, and valuable life lessons that help him discover his personal legend. The novel explores themes of destiny, courage, and self-discovery.",
                    status: false
                ),
                BooksModel(
                    title: "Rich Dad Poor Dad",
                    author: "Robert T. Kiyosaki",
                    coverImage: "RichDadPoorDad",
                    pages: 336,
                    year: 1997,
                    about: "Rich Dad Poor Dad contrasts two approaches to money and financial education through the author's experiences growing up. The book highlights the importance of financial literacy, investing, and building assets instead of relying solely on traditional employment. It challenges common beliefs about wealth and success.",
                    status: true
                ),
                BooksModel(
                    title: "Deep Work",
                    author: "Cal Newport",
                    coverImage: "DeepWork",
                    pages: 304,
                    year: 2016,
                    about: "Deep Work argues that the ability to focus without distraction is becoming increasingly valuable in today's world. Cal Newport presents strategies for cultivating concentration, reducing interruptions, and producing high-quality work. The book emphasizes deliberate practice and meaningful productivity.",
                    status: true
                )
            ]
            saveBooks()
        }
    }
}
