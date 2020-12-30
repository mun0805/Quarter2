# INFO 624 Assignment 2

## 1. Student(s)

+ Manisha Nandawadekar, mun24@drexel.edu

## 2. Tasks and Steps

## 2.1 Text Collection (2 points)
I have identified 20 research articles which includes author, title, abstract and citations for each articles. All data is stored in file name A2_mun24_data.json,  Here is the one example of data collection as shown in below. We are using this collection of data to Indexing document with proper analyzer to perform full text searches. Also we will examine related term statistics to compute TF*IDF weights and cosine similarities.

**Example article:**

```json
{
  "author":"Jianguo Li, Chunyan Hao, Lili Ren, Yan Xiao, Jianwei Wang and Xuemei Qin",
  "title":"Data Mining of Lung Microbiota in Cystic Fibrosis Patients",
  "abstract":"The major therapeutic strategy used to treat exacerbated cystic fibrosis (CF) is antibiotic treatment. As this approach easily generates antibiotic-resistant strains of opportunistic bacteria, optimized antibiotic therapies are required to effectively control chronic and recurrent bacterial infections in CF patients. A promising future for the proper use of antibiotics is the management of lung microbiota. However, the impact of antibiotic treatments on CF microbiota and vice versa is not fully understood. This study analyzed 718 sputum samples from 18 previous studies to identify differences between CF and uninfected lung microbiota and to evaluate the effects of antibiotic treatments on exacerbated CF microbiota. A reference-based OTU (operational taxonomic unit) picking method was used to combine analyses of data generated using different protocols and platforms. Findings show that CF microbiota had greater richness and lower diversity in the community structure than uninfected control (NIC) microbiota. Specifically, CF microbiota showed higher levels of opportunistic bacteria and dramatically lower levels of commensal bacteria. Antibiotic treatment affected exacerbated CF microbiota notably but only transiently during the treatment period. Limited decrease of the dominant opportunistic bacteria and a dramatic decrease of commensal bacteria were observed during the antibiotic treatment for CF exacerbation. Simultaneously, low abundance opportunistic bacteria were thriving after the antibiotic treatment. The inefficiency of the current antibiotic treatment against major opportunistic bacteria and the detrimental effects on commensal bacteria indicate that the current empiric antibiotic treatment on CF exacerbation should be reevaluated and optimized.",
  "citations":14
}
```

## 2.2. Index Mapping (2 points)
Mapping is the process of defining how a document and its fields are stored and indexed. Use mappings, for example, to set:

:-Can string fields are to be viewed as whole text fields.

:-What fields are numbered, dated, or geolocated.

:-The date values format.

:-Custom rules to manage the dynamically added field mapping.

Each field has a data type, and A field can be indexed for different purposes in various ways. for e.g. A string field can be indexed as a both text and keyword.The standard analyzer is the default analyzer used if none is defined. It provides tokenization based on grammar, and works well in most languages. Following is the example of mapping, where we used english analyzer to title and abstract for stemming. On the other hand we used standard analyzer for author because standard analyzer does not use stemming.

### Mapping Request 1

**Request 1:**
```json
PUT mun24_info624_201904_articles
{
  "mappings":
  {
    "properties":
    {
      "author":
      {
        "type": "text",
        "analyzer": "standard"
      } ,
      "title":
      {
        "type": "text" ,
        "analyzer": "english"
      } ,
      "abstract":
      {
        "type": "text" ,
        "analyzer": "english"
      },
      "citations":
      {
        "type": "integer"
      }
    }
  }
}
```

**Response 1:**
```json
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "mun24_info624_201904_articles"
}
```


### Mapping Request 2

**Request:**

```json
PUT /mun24_info624_201904_articles/_mapping
{
 "properties":
  {
    "author":
    {
      "type": "text",
      "analyzer": "standard"
    },
    "title":
    {
      "type": "text",
      "analyzer": "english"
    },
    "abstract":
    {
      "type": "text",
      "analyzer": "english"
    },
    "citations":
    {
      "type": "integer"
    }
  }
}
```

**Response:**

```json
{
  "acknowledged" : true
}
```

## 2.3. Data Indexing (1 point)
After creating proper mapping for our index, we will put all our articles to the index and we will index them with using **PUT** method as shown in below.

**Request:**

```json
PUT /mun24_info624_201904_articles/_doc/1
{
  "author":"Jianguo Li, Chunyan Hao, Lili Ren, Yan Xiao, Jianwei Wang and Xuemei Qin",
  "title":"Data Mining of Lung Microbiota in Cystic Fibrosis Patients",
  "abstract":"The major therapeutic strategy used to treat exacerbated cystic fibrosis (CF) is antibiotic treatment. As this approach easily generates antibiotic-resistant strains of opportunistic bacteria, optimized antibiotic therapies are required to effectively control chronic and recurrent bacterial infections in CF patients. A promising future for the proper use of antibiotics is the management of lung microbiota. However, the impact of antibiotic treatments on CF microbiota and vice versa is not fully understood. This study analyzed 718 sputum samples from 18 previous studies to identify differences between CF and uninfected lung microbiota and to evaluate the effects of antibiotic treatments on exacerbated CF microbiota. A reference-based OTU (operational taxonomic unit) picking method was used to combine analyses of data generated using different protocols and platforms. Findings show that CF microbiota had greater richness and lower diversity in the community structure than uninfected control (NIC) microbiota. Specifically, CF microbiota showed higher levels of opportunistic bacteria and dramatically lower levels of commensal bacteria. Antibiotic treatment affected exacerbated CF microbiota notably but only transiently during the treatment period. Limited decrease of the dominant opportunistic bacteria and a dramatic decrease of commensal bacteria were observed during the antibiotic treatment for CF exacerbation. Simultaneously, low abundance opportunistic bacteria were thriving after the antibiotic treatment. The inefficiency of the current antibiotic treatment against major opportunistic bacteria and the detrimental effects on commensal bacteria indicate that the current empiric antibiotic treatment on CF exacerbation should be reevaluated and optimized.",
  "citations":14
}
```

**Response:**

```json
{
  "_index" : "mun24_info624_201904_articles",
  "_type" : "_doc",
  "_id" : "1",
  "_version" : 1,
  "result" : "created",
  "_shards" : {
    "total" : 2,
    "successful" : 2,
    "failed" : 0
  },
  "_seq_no" : 0,
  "_primary_term" : 1
}
```

## 2.4. Search and Retrieval (1 point)
After data indexing I performed a search query with three keywords relevant to my collection of articles, for example I used "information algorithm analysis" keywords, and searched it into the abstract field on the index. After performing the following query to search these keywords, I got total 15 values but I choose top three articles as shown in response to perform remaining query operations.

**Request:**

```json
GET mun24_info624_201904_articles/_search
{
  "query":
  {
   "match" :
    {
     "abstract" :
      {
       "query" : "information algorithm analysis"
      }
    }
  }
}

```

**Response(**top three** articles):

```json
{
  "took" : 5,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 15,
      "relation" : "eq"
    },
    "max_score" : 5.4870024,
    "hits" : [
      {
        "_index" : "mun24_info624_201904_articles",
        "_type" : "_doc",
        "_id" : "2",
        "_score" : 5.4870024,
        "_source" : {
          "author" : "Qian-Ming Zhang, An Zeng and Ming-Sheng Shang",
          "title" : "Extracting the Information Backbone in Online System",
          "abstract" : "Information overload is a serious problem in modern society and many solutions such as recommender system have been proposed to filter out irrelevant information. In the literature, researchers have been mainly dedicated to improving the recommendation performance (accuracy and diversity) of the algorithms while they have overlooked the influence of topology of the online user-object bipartite networks. In this paper, we find that some information provided by the bipartite networks is not only redundant but also misleading. With such “less can be more” feature, we design some algorithms to improve the recommendation performance by eliminating some links from the original networks. Moreover, we propose a hybrid method combining the time-aware and topology-aware link removal algorithms to extract the backbone which contains the essential information for the recommender systems. From the practical point of view, our method can improve the performance and reduce the computational time of the recommendation system, thus improving both of their effectiveness and efficiency.",
          "citations" : 45
        }
      },
      {
        "_index" : "mun24_info624_201904_articles",
        "_type" : "_doc",
        "_id" : "17",
        "_score" : 3.0455132,
        "_source" : {
          "author" : "Antoni Morro, Vincent Canals, Antoni Oliver, Miquel L. Alomar and Josep L. Rossello",
          "title" : "Ultra-Fast Data-Mining Hardware Architecture Based on Stochastic Computing",
          "abstract" : "Minimal hardware implementations able to cope with the processing of large amounts of data in reasonable times are highly desired in our information-driven society. In this work we review the application of stochastic computing to probabilistic-based pattern-recognition analysis of huge database sets. The proposed technique consists in the hardware implementation of a parallel architecture implementing a similarity search of data with respect to different pre-stored categories. We design pulse-based stochastic-logic blocks to obtain an efficient pattern recognition system. The proposed architecture speeds up the screening process of huge databases by a factor of 7 when compared to a conventional digital implementation using the same hardware area.",
          "citations" : 15
        }
      },
      {
        "_index" : "mun24_info624_201904_articles",
        "_type" : "_doc",
        "_id" : "6",
        "_score" : 2.6249342,
        "_source" : {
          "author" : "Sylvie Droit-Volet and Pierre S. Zélanti",
          "title" : "Development of Time Sensitivity and Information Processing Speed",
          "abstract" : "The aim of this study was to examine whether age-related changes in the speed of information processing are the best predictors of the increase in sensitivity to time throughout childhood. Children aged 5 and 8 years old, as well adults, were given two temporal bisection tasks, one with short (0.5/1-s) and the other with longer (4/8-s) anchor durations. In addition, the participants' scores on different neuropsychological tests assessing both information processing speed and other dimensions of cognitive control (short-term memory, working memory, selective attention) were calculated. The results showed that the best predictor of individual variances in sensitivity to time was information processing speed, although working memory also accounted for some of the individual differences in time sensitivity, albeit to a lesser extent. In sum, the faster the information processing speed of the participants, the higher their sensitivity to time was. These results are discussed in the light of the idea that the development of temporal capacities has its roots in the maturation of the dynamic functioning of the brain.",
          "citations" : 25
        }
      },
```

## 2.5. Manual Examination
In this step, I examined the query keywords, identified related statistics, and computed their TF*IDF weights for the top three articles (from the previous step).

### A. Term stats (2 points)
In this step, For each of the top three articles, used the term vectors API to identify related statistics for keywords in the document.
To quickly identify the DF (document frequency) for each query keyword in the index, I used the query as a pseudo-document and analyzed its term vectors As shown in below request:

**Request for DF Stats:**

```json
GET mun24_info624_201904_articles/_termvectors
{
   "doc":
  {
    "abstract": "information algorithm analysis"
  },
    "term_statistics" : true,
    "field_statistics" : false,
    "positions": false,
    "offsets": false
}

```

**Response:**

```json
{
  "_index" : "mun24_info624_201904_articles",
  "_type" : "_doc",
  "_version" : 0,
  "found" : true,
  "took" : 0,
  "term_vectors" : {
    "abstract" : {
      "terms" : {
        "algorithm" : {
          "doc_freq" : 4,
          "ttf" : 9,
          "term_freq" : 1
        },
        "analysi" : {
          "doc_freq" : 9,
          "ttf" : 15,
          "term_freq" : 1
        },
        "inform" : {
          "doc_freq" : 5,
          "ttf" : 12,
          "term_freq" : 1
        }
      }
    }
  }
}
```

**Request for TF stats in document/hit 1 (doc_2):**

I used the following query to identifiy term frequency of every keyword in top three articles from step **2.4** i.e. (Doc_2, doc_17, doc_6). These are the my top three hits. I performed the same query for these three articles to identify term frequency.
```json
GET mun24_info624_201904_articles/_termvectors/2
{
  "fields" : ["abstract"],
  "term_statistics" : true,
  "field_statistics" : false,
  "positions": false,
  "offsets": false
}
```

**Response:**

```json
{
  "_index" : "mun24_info624_201904_articles",
  "_type" : "_doc",
  "_id" : "2",
  "_version" : 1,
  "found" : true,
  "took" : 2,
  "term_vectors" : {
    "abstract" : {
      "terms" : {
        "accuraci" : {
          "doc_freq" : 4,
          "ttf" : 11,
          "term_freq" : 1
        },
        "algorithm" : {
          "doc_freq" : 4,
          "ttf" : 9,
          "term_freq" : 3
        },
        "also" : {
          "doc_freq" : 5,
          "ttf" : 7,
          "term_freq" : 1
        },
        "awar" : {
          "doc_freq" : 1,
          "ttf" : 2,
          "term_freq" : 2
        },
        "backbon" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "been" : {
          "doc_freq" : 8,
          "ttf" : 10,
          "term_freq" : 2
        },
        "bipartit" : {
          "doc_freq" : 1,
          "ttf" : 2,
          "term_freq" : 2
        },
        "both" : {
          "doc_freq" : 7,
          "ttf" : 9,
          "term_freq" : 1
        },
        "can" : {
          "doc_freq" : 13,
          "ttf" : 19,
          "term_freq" : 2
        },
        "combin" : {
          "doc_freq" : 8,
          "ttf" : 10,
          "term_freq" : 1
        },
        "comput" : {
          "doc_freq" : 9,
          "ttf" : 12,
          "term_freq" : 1
        },
        "contain" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "dedic" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "design" : {
          "doc_freq" : 7,
          "ttf" : 11,
          "term_freq" : 1
        },
        "divers" : {
          "doc_freq" : 3,
          "ttf" : 3,
          "term_freq" : 1
        },
        "effect" : {
          "doc_freq" : 11,
          "ttf" : 16,
          "term_freq" : 1
        },
        "effici" : {
          "doc_freq" : 5,
          "ttf" : 9,
          "term_freq" : 1
        },
        "elimin" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "essenti" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "extract" : {
          "doc_freq" : 5,
          "ttf" : 6,
          "term_freq" : 1
        },
        "featur" : {
          "doc_freq" : 3,
          "ttf" : 7,
          "term_freq" : 1
        },
        "filter" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "find" : {
          "doc_freq" : 6,
          "ttf" : 6,
          "term_freq" : 1
        },
        "from" : {
          "doc_freq" : 11,
          "ttf" : 19,
          "term_freq" : 2
        },
        "have" : {
          "doc_freq" : 8,
          "ttf" : 10,
          "term_freq" : 3
        },
        "hybrid" : {
          "doc_freq" : 3,
          "ttf" : 3,
          "term_freq" : 1
        },
        "improv" : {
          "doc_freq" : 7,
          "ttf" : 11,
          "term_freq" : 4
        },
        "influenc" : {
          "doc_freq" : 3,
          "ttf" : 3,
          "term_freq" : 1
        },
        "inform" : {
          "doc_freq" : 5,
          "ttf" : 12,
          "term_freq" : 4
        },
        "irrelev" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "less" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "link" : {
          "doc_freq" : 2,
          "ttf" : 3,
          "term_freq" : 2
        },
        "literatur" : {
          "doc_freq" : 4,
          "ttf" : 7,
          "term_freq" : 1
        },
        "mainli" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "mani" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "method" : {
          "doc_freq" : 6,
          "ttf" : 10,
          "term_freq" : 2
        },
        "mislead" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "modern" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "more" : {
          "doc_freq" : 6,
          "ttf" : 7,
          "term_freq" : 1
        },
        "moreov" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "network" : {
          "doc_freq" : 9,
          "ttf" : 19,
          "term_freq" : 3
        },
        "object" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "onli" : {
          "doc_freq" : 4,
          "ttf" : 5,
          "term_freq" : 1
        },
        "onlin" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "origin" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "our" : {
          "doc_freq" : 11,
          "ttf" : 26,
          "term_freq" : 1
        },
        "out" : {
          "doc_freq" : 3,
          "ttf" : 3,
          "term_freq" : 1
        },
        "overload" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "overlook" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "paper" : {
          "doc_freq" : 8,
          "ttf" : 10,
          "term_freq" : 1
        },
        "perform" : {
          "doc_freq" : 8,
          "ttf" : 15,
          "term_freq" : 3
        },
        "point" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "practic" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "problem" : {
          "doc_freq" : 5,
          "ttf" : 5,
          "term_freq" : 1
        },
        "propos" : {
          "doc_freq" : 6,
          "ttf" : 11,
          "term_freq" : 2
        },
        "provid" : {
          "doc_freq" : 11,
          "ttf" : 15,
          "term_freq" : 1
        },
        "recommend" : {
          "doc_freq" : 2,
          "ttf" : 6,
          "term_freq" : 5
        },
        "reduc" : {
          "doc_freq" : 4,
          "ttf" : 4,
          "term_freq" : 1
        },
        "redund" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "remov" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "research" : {
          "doc_freq" : 6,
          "ttf" : 10,
          "term_freq" : 1
        },
        "seriou" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "societi" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "solut" : {
          "doc_freq" : 4,
          "ttf" : 4,
          "term_freq" : 1
        },
        "some" : {
          "doc_freq" : 5,
          "ttf" : 7,
          "term_freq" : 3
        },
        "system" : {
          "doc_freq" : 15,
          "ttf" : 37,
          "term_freq" : 3
        },
        "thu" : {
          "doc_freq" : 6,
          "ttf" : 8,
          "term_freq" : 1
        },
        "time" : {
          "doc_freq" : 7,
          "ttf" : 12,
          "term_freq" : 2
        },
        "topolog" : {
          "doc_freq" : 3,
          "ttf" : 5,
          "term_freq" : 2
        },
        "user" : {
          "doc_freq" : 6,
          "ttf" : 8,
          "term_freq" : 1
        },
        "view" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "we" : {
          "doc_freq" : 13,
          "ttf" : 32,
          "term_freq" : 3
        },
        "which" : {
          "doc_freq" : 13,
          "ttf" : 21,
          "term_freq" : 1
        },
        "while" : {
          "doc_freq" : 5,
          "ttf" : 5,
          "term_freq" : 1
        }
      }
    }
  }
}
```

**Request for TF stats in document/hit 2 (doc_17):**

```json
GET mun24_info624_201904_articles/_termvectors/17
{
  "fields" : ["abstract"],
  "term_statistics" : true,
  "field_statistics" : false,
  "positions": false,
  "offsets": false
}
```

**Response:**

```json
{
  "_index" : "mun24_info624_201904_articles",
  "_type" : "_doc",
  "_id" : "17",
  "_version" : 1,
  "found" : true,
  "took" : 0,
  "term_vectors" : {
    "abstract" : {
      "terms" : {
        "7" : {
          "doc_freq" : 4,
          "ttf" : 5,
          "term_freq" : 1
        },
        "abl" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "amount" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "analysi" : {
          "doc_freq" : 9,
          "ttf" : 15,
          "term_freq" : 1
        },
        "applic" : {
          "doc_freq" : 5,
          "ttf" : 10,
          "term_freq" : 1
        },
        "architectur" : {
          "doc_freq" : 3,
          "ttf" : 4,
          "term_freq" : 2
        },
        "area" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "base" : {
          "doc_freq" : 10,
          "ttf" : 16,
          "term_freq" : 2
        },
        "block" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "categori" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "compar" : {
          "doc_freq" : 9,
          "ttf" : 9,
          "term_freq" : 1
        },
        "comput" : {
          "doc_freq" : 9,
          "ttf" : 12,
          "term_freq" : 1
        },
        "consist" : {
          "doc_freq" : 3,
          "ttf" : 3,
          "term_freq" : 1
        },
        "convent" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "cope" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "data" : {
          "doc_freq" : 7,
          "ttf" : 26,
          "term_freq" : 2
        },
        "databas" : {
          "doc_freq" : 3,
          "ttf" : 4,
          "term_freq" : 2
        },
        "design" : {
          "doc_freq" : 7,
          "ttf" : 11,
          "term_freq" : 1
        },
        "desir" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "differ" : {
          "doc_freq" : 14,
          "ttf" : 23,
          "term_freq" : 1
        },
        "digit" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "driven" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "effici" : {
          "doc_freq" : 5,
          "ttf" : 9,
          "term_freq" : 1
        },
        "factor" : {
          "doc_freq" : 6,
          "ttf" : 13,
          "term_freq" : 1
        },
        "hardwar" : {
          "doc_freq" : 1,
          "ttf" : 3,
          "term_freq" : 3
        },
        "highli" : {
          "doc_freq" : 4,
          "ttf" : 4,
          "term_freq" : 1
        },
        "huge" : {
          "doc_freq" : 1,
          "ttf" : 2,
          "term_freq" : 2
        },
        "implement" : {
          "doc_freq" : 6,
          "ttf" : 13,
          "term_freq" : 4
        },
        "inform" : {
          "doc_freq" : 5,
          "ttf" : 12,
          "term_freq" : 1
        },
        "larg" : {
          "doc_freq" : 7,
          "ttf" : 9,
          "term_freq" : 1
        },
        "logic" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "minim" : {
          "doc_freq" : 3,
          "ttf" : 3,
          "term_freq" : 1
        },
        "obtain" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "our" : {
          "doc_freq" : 11,
          "ttf" : 26,
          "term_freq" : 1
        },
        "parallel" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "pattern" : {
          "doc_freq" : 3,
          "ttf" : 9,
          "term_freq" : 2
        },
        "pre" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "probabilist" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "process" : {
          "doc_freq" : 6,
          "ttf" : 12,
          "term_freq" : 2
        },
        "propos" : {
          "doc_freq" : 6,
          "ttf" : 11,
          "term_freq" : 2
        },
        "puls" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "reason" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "recognit" : {
          "doc_freq" : 2,
          "ttf" : 7,
          "term_freq" : 2
        },
        "respect" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "review" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "same" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "screen" : {
          "doc_freq" : 3,
          "ttf" : 3,
          "term_freq" : 1
        },
        "search" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "set" : {
          "doc_freq" : 9,
          "ttf" : 14,
          "term_freq" : 1
        },
        "similar" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "societi" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "speed" : {
          "doc_freq" : 2,
          "ttf" : 5,
          "term_freq" : 1
        },
        "stochast" : {
          "doc_freq" : 1,
          "ttf" : 2,
          "term_freq" : 2
        },
        "store" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "system" : {
          "doc_freq" : 15,
          "ttf" : 37,
          "term_freq" : 1
        },
        "techniqu" : {
          "doc_freq" : 7,
          "ttf" : 9,
          "term_freq" : 1
        },
        "time" : {
          "doc_freq" : 7,
          "ttf" : 12,
          "term_freq" : 1
        },
        "up" : {
          "doc_freq" : 3,
          "ttf" : 3,
          "term_freq" : 1
        },
        "us" : {
          "doc_freq" : 16,
          "ttf" : 33,
          "term_freq" : 1
        },
        "we" : {
          "doc_freq" : 13,
          "ttf" : 32,
          "term_freq" : 2
        },
        "when" : {
          "doc_freq" : 5,
          "ttf" : 5,
          "term_freq" : 1
        },
        "work" : {
          "doc_freq" : 6,
          "ttf" : 10,
          "term_freq" : 1
        }
      }
    }
  }
}

```

**Request for TF stats in document/hit 3 (doc_6):**

```json
GET mun24_info624_201904_articles/_termvectors/6
{
  "fields" : ["abstract"],
  "term_statistics" : true,
  "field_statistics" : false,
  "positions": false,
  "offsets": false
}
```

**Response:**

```json
{
  "_index" : "mun24_info624_201904_articles",
  "_type" : "_doc",
  "_id" : "6",
  "_version" : 1,
  "found" : true,
  "took" : 1,
  "term_vectors" : {
    "abstract" : {
      "terms" : {
        "0.5" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "1" : {
          "doc_freq" : 5,
          "ttf" : 5,
          "term_freq" : 1
        },
        "4" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "5" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "8" : {
          "doc_freq" : 2,
          "ttf" : 3,
          "term_freq" : 2
        },
        "account" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "addit" : {
          "doc_freq" : 5,
          "ttf" : 5,
          "term_freq" : 1
        },
        "adult" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "ag" : {
          "doc_freq" : 1,
          "ttf" : 2,
          "term_freq" : 2
        },
        "aim" : {
          "doc_freq" : 6,
          "ttf" : 6,
          "term_freq" : 1
        },
        "albeit" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "also" : {
          "doc_freq" : 5,
          "ttf" : 7,
          "term_freq" : 1
        },
        "although" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "anchor" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "assess" : {
          "doc_freq" : 3,
          "ttf" : 3,
          "term_freq" : 1
        },
        "attent" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "best" : {
          "doc_freq" : 3,
          "ttf" : 5,
          "term_freq" : 2
        },
        "bisect" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "both" : {
          "doc_freq" : 7,
          "ttf" : 9,
          "term_freq" : 1
        },
        "brain" : {
          "doc_freq" : 2,
          "ttf" : 7,
          "term_freq" : 1
        },
        "calcul" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "capac" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "chang" : {
          "doc_freq" : 3,
          "ttf" : 4,
          "term_freq" : 1
        },
        "childhood" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "children" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "cognit" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "control" : {
          "doc_freq" : 4,
          "ttf" : 5,
          "term_freq" : 1
        },
        "develop" : {
          "doc_freq" : 8,
          "ttf" : 17,
          "term_freq" : 1
        },
        "differ" : {
          "doc_freq" : 14,
          "ttf" : 23,
          "term_freq" : 2
        },
        "dimens" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "discuss" : {
          "doc_freq" : 3,
          "ttf" : 3,
          "term_freq" : 1
        },
        "durat" : {
          "doc_freq" : 2,
          "ttf" : 3,
          "term_freq" : 1
        },
        "dynam" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "examin" : {
          "doc_freq" : 2,
          "ttf" : 3,
          "term_freq" : 1
        },
        "extent" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "faster" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "function" : {
          "doc_freq" : 6,
          "ttf" : 7,
          "term_freq" : 1
        },
        "given" : {
          "doc_freq" : 2,
          "ttf" : 3,
          "term_freq" : 1
        },
        "ha" : {
          "doc_freq" : 6,
          "ttf" : 7,
          "term_freq" : 1
        },
        "higher" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "idea" : {
          "doc_freq" : 4,
          "ttf" : 4,
          "term_freq" : 1
        },
        "increas" : {
          "doc_freq" : 4,
          "ttf" : 5,
          "term_freq" : 1
        },
        "individu" : {
          "doc_freq" : 5,
          "ttf" : 13,
          "term_freq" : 2
        },
        "inform" : {
          "doc_freq" : 5,
          "ttf" : 12,
          "term_freq" : 4
        },
        "it" : {
          "doc_freq" : 7,
          "ttf" : 7,
          "term_freq" : 1
        },
        "lesser" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "light" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "longer" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "matur" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "memori" : {
          "doc_freq" : 2,
          "ttf" : 4,
          "term_freq" : 3
        },
        "neuropsycholog" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "old" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "on" : {
          "doc_freq" : 9,
          "ttf" : 12,
          "term_freq" : 1
        },
        "other" : {
          "doc_freq" : 3,
          "ttf" : 4,
          "term_freq" : 2
        },
        "particip" : {
          "doc_freq" : 3,
          "ttf" : 6,
          "term_freq" : 2
        },
        "predictor" : {
          "doc_freq" : 1,
          "ttf" : 2,
          "term_freq" : 2
        },
        "process" : {
          "doc_freq" : 6,
          "ttf" : 12,
          "term_freq" : 4
        },
        "relat" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "result" : {
          "doc_freq" : 5,
          "ttf" : 9,
          "term_freq" : 2
        },
        "root" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "s" : {
          "doc_freq" : 1,
          "ttf" : 2,
          "term_freq" : 2
        },
        "score" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "select" : {
          "doc_freq" : 5,
          "ttf" : 19,
          "term_freq" : 1
        },
        "sensit" : {
          "doc_freq" : 3,
          "ttf" : 6,
          "term_freq" : 4
        },
        "short" : {
          "doc_freq" : 1,
          "ttf" : 2,
          "term_freq" : 2
        },
        "show" : {
          "doc_freq" : 10,
          "ttf" : 12,
          "term_freq" : 1
        },
        "some" : {
          "doc_freq" : 5,
          "ttf" : 7,
          "term_freq" : 1
        },
        "speed" : {
          "doc_freq" : 2,
          "ttf" : 5,
          "term_freq" : 4
        },
        "studi" : {
          "doc_freq" : 13,
          "ttf" : 22,
          "term_freq" : 1
        },
        "sum" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "task" : {
          "doc_freq" : 3,
          "ttf" : 3,
          "term_freq" : 1
        },
        "tempor" : {
          "doc_freq" : 2,
          "ttf" : 3,
          "term_freq" : 2
        },
        "term" : {
          "doc_freq" : 4,
          "ttf" : 4,
          "term_freq" : 1
        },
        "test" : {
          "doc_freq" : 5,
          "ttf" : 6,
          "term_freq" : 1
        },
        "throughout" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "time" : {
          "doc_freq" : 7,
          "ttf" : 12,
          "term_freq" : 4
        },
        "two" : {
          "doc_freq" : 5,
          "ttf" : 6,
          "term_freq" : 1
        },
        "varianc" : {
          "doc_freq" : 1,
          "ttf" : 1,
          "term_freq" : 1
        },
        "well" : {
          "doc_freq" : 4,
          "ttf" : 5,
          "term_freq" : 1
        },
        "were" : {
          "doc_freq" : 7,
          "ttf" : 10,
          "term_freq" : 2
        },
        "whether" : {
          "doc_freq" : 2,
          "ttf" : 2,
          "term_freq" : 1
        },
        "work" : {
          "doc_freq" : 6,
          "ttf" : 10,
          "term_freq" : 2
        },
        "year" : {
          "doc_freq" : 3,
          "ttf" : 3,
          "term_freq" : 1
        }
      }
    }
  }
}

```


**Query keyword TFs and DFs in the top three hits:**

From the above requests, I collected DF and TF statistics as shown in below table for the top three hits represented by query keywords:

| Doc ID | information  TF |information DF | algorithm TF | algorithm  DF | analysis  TF | analysis  DF |
|--------|-----------|-----------|-----------|-----------|-----------|-----------|
|    2    |      4    |     5     |        3  |      4     |    0      |     9      |
|     17  |    1       |     5      |      0   |    4      |  1       |      9     |
|     6   |   4        |    5       |       0    |   4 |     0    |     9     |


### B. TF*IDF (1 point)
Based on the above table I calculated TF * IDF weights for each documents.

**TF*IDF weights:**

| Doc ID | information    | algorithm   | analysis     |     SUM   |
|--------|-----------|-----------|-----------|-----------|
|     2   |       2.40    |    2.09       |       0    |       4.49    |
|     17  |        0.60   |      0     |       0.34    |       0.94    |
|      6  |         2.40  |      0     |        0   |         2.40  |


Rank the documents using SUM of TF * IDF: Here is the order of my document after ranking  **(#doc_2, #doc_6, #doc_17)**.

Are they ranked in the same order as in ElasticSearch results? **No**, The order is diffent in ElasticSearch which is(#doc_2, #doc_17, #doc_6).

### C. Cosine Similarity (1 point)

**Query IDF ($1\times IDF$) weights:**

|Query  | information     |algorithm   |analysis |
|--------|-----------|-----------|--------|
|     Q  |    0.60   |  0.69     |   0.34|

**Cosine similarities:**

1. Cosine(Q, doc_2) = (0.6 * 2.4+0.69 * 2.09+0.34 * 0) /(sqrt(0.6 * 0.6+0.69 * 0.69+0.34 * 0.34) * sqrt(2.4 * 2.4+2.09 * 2.09))
                    = 2.8821 / sqrt(0.9517) * sqrt(10.1281)

                ​    = 2.8821 / (0.9755 * 3.1824)

                    = 2.8821 / 3.1044

                ​    = 0.9283

2. Cosine(Q, doc_17) = (0.6 * 0.6+0.69 * 0+0.34 * 0.34) /(sqrt(0.6 * 0.6+0.69 * 0.69+0.34 * 0.34) * sqrt(0.6 * 0.6+0.34 * 0.34))
                    = 0.4756 / sqrt(0.9517) * sqrt(0.4756)

              ​      = 0.4756 / ( 0.9755 * 0.6896)

                    = 0.4756 / 0.6727

              ​      = 0.7070


3. Cosine(Q, doc_6) = (0.6 * 2.4+0.69 * 0+0.34 * 0)/(sqrt(0.6 * 0.6+0.69 * 0.69+0.34 * 0.34) * sqrt(2.4 * 2.4))
                    = 1.44 / sqrt(0.9517) * sqrt(5.76)

                ​    = 1.44 / (0.9755 * 2.4)

                    = 1.44 / 2.3412

                ​    = 0.6150

Rank the documents using Cosine scores: After ranking the document here is the order of my document **(#doc_2, #doc_17, #doc_6)**.

Are they ranked in the same order as in TF * IDF SUM or ElasticSearch results? **Yes**, my Cosine scores ranked same as the ElasticSearch results ranking and not same as TF*IDF sum ranking.


**References:**

https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping.html

https://www.elastic.co/guide/en/elasticsearch/reference/7.5/analysis.html

https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-termvectors.html
