# Candidates infos
cadidates_names <- c("Ciro Gomes", "Geraldo Alckmin", "Guilherme Boulos", "Jair Bolsonaro", 
                     "Luiz Inacio Lula da Silva", "Fernando Haddad", "Marina Silva", 
                     "Henrique Meirelles", "Joao Amoedo", "Alvaro Dias", "Jose Maria Eymael",
                     "Cabo Daciolo")

profile <- c("cirogomes","geraldoalckmin", "GuilhermeBoulos","jairbolsonaro", "LulaOficial", "Haddad_Fernando","MarinaSilva", "meirelles", "joaoamoedonovo","alvarodias_", "Eymaeloficial", "CaboDaciolo")

candidates_ids <- c("33374761", "74215006", "762402774260875265", "128372940", "2670726740","354095556","105155795", 
                    "870030409890910210","256730310","73745956", "73889361", "989899804200325121")

df_candidates <- data.frame(cadidates_names,profile, candidates_ids)



# Political Parties infos
political_parties_names <- c("PDT", "PSDB", "PSOL", "PSL", "PT", "REDE", "MDB", "NOVO", "PODEMOS", "PSDC", 
                             "PSTU", "Patriota") 

political_parties_ids <- c("180500907", "39931528","1202130601","1011297899463041028",
                           "39522911","1151011908","86320511","2734700584","868487844595212288",
                           "83835435","26250547","73144615")

df_political_parties <- data.frame(political_parties_names,political_parties_ids)