# INFO 624 Assignment 3

## 1. Student(s)

+ Manisha Nandawadekar, mun24@drexel.edu

## 2. Tasks and Steps
We used all data collection of 20 research articles (abstracts) which was used for assignment #2, which includes the following fields:

• author: the list of author names (type "text" and analyzer "standard");

• title: the title of the article (type "text" and analyzer "english");

• abstract: the abstract of the article (type "text" and analyzer "english");

• citations: the number of times the article has been cited (type "integer").

Before moving forward to further process, We made sure all 20 documents are there in the index created for assignment #2.

## 2.2. Identification of Use Cases (2 points)
Identified three use cases given the following information needs:

**1. Query with narrow keywords:** We choose 4 specific keywords that best describe one of our articles, i.e. unique rare keywords that appears in a very few documents;

**"fluid-attenuated inversion recovery"**

**2. Query with broad keywords:** Later we choose 3 general keywords that can describe most of the our papers in the data collection, i.e. keywords that appear in many documents;

**"Machine Learning Algorithms"**

**3. Author plus broad keywords:** In this step we choose the name of an author (first name and last name) plus 3 general keywords from previous steps. (from above).

**"Saba Saboor Machine Learning Algorithms"**

### 2.2.1 Use Case 1: Narrow Keywords

Keywords:
We have chosen the "fluid-attenuated inversion recovery" query as the narrow keywords because this keywords are unique and rare words to our index, This query has four keywords in it.

            "fluid", "attenuated", "inversion", "recovery"

Brief description of information need: "fluid-attenuated inversion recovery" is an MRI technique. Here we are using this query to retrieve all the relevant articles from the ms4976_info624_201904_articles index which have used this FLAIR MRI technique. We are expecting to return only one document which is written by Elizabeth M. Sweeney author where this author used Multimodal Structural MRI technique in there article to provide Comparison of Supervised Machine Learning Algorithms.

### 2.2.2 Use Case 2: Broad Keywords

Keywords: We have chosen the "Machine Learning Algorithms" query as the broad keywords because this keywords are more often repeated words in our index, This query has three keywords in it.

             "Machine", "Learning", "Algorithms"

Brief description of information need: We are using this query to retrieve all the relevant documents/articles from the ms4976_info624_201904_articles index which have used/applied/described machine learning algorithms. In this case which should return all documents/articles from the index except few articles as mostly our data in the index are related to  Machine learning algorithms and very few belongs to deep learning and others.


### 2.2.3 Use Case 3: Author + Broad Keywords

Keywords: We have chosen the "Saba Saboor Machine Learning Algorithms" query as the Author + Broad keywords as this words contains an author name and board keywords(most often repeated words in our index), This query has five keywords in it.

            "Saba", "Saboor", "Machine", "Learning", "Algorithms"

Brief description of information need: "Saba Saboor Machine Learning Algorithms" keyword is an author plus keywords, Here we are using this query to retrieve all the relevant documents from the ms4976_info624_201904_articles index which are written by Saba Saboor and used/applied machine learning algorithms in them. In this case the number of document relevant are more than 16 in my index as many documents contains this board keywords and few books were written by author Saba Saboor.

## 2.3. Basic Search and Scoring

### 2.3.1 Use Case 1: Basic Search (1 points)
Here we are searching our Elastic Search index with the narrow query (use case 1) on all the text fields. Also we used parameters "from":0 and "size":3 which limits search results to top 3 hits as shown below:

**Request:**
```json
GET ms4976_info624_201904_articles/_search
{
  "from" : 0, "size" : 3,
  "query": {
    "multi_match" : {
      "query": "fluid-attenuated inversion recovery",
      "fields": [ "author", "title", "abstract" ]
    }
  }
}
```

Results (top 3) in table:

For this narrow query we are getting only two results retrieved as the keywords are soo rare in our index

| Doc ID | Author             | Title                                 | Score |
|--------|--------------------|---------------------------------------|-------|
|    7   |  "Elizabeth M. Sweeney ,Joshua T. Vogelstein ,Jennifer L. Cuzzocreo ,Peter A. Calabresi ,Daniel S. Reich ,Ciprian M. Crainiceanu and Russell T. Shinohara"|"A Comparison of Supervised Machine Learning Algorithms and Feature Vectors for MS Lesion Segmentation Using Multimodal Structural MRI" |  9.350587  |
|    20  |"Anca Ciurte ,Xavier Bresson,Olivier Cuisenaire,Nawal Houhou,Sergiu Nedevschi,Jean-Philippe Thiran and Meritxell Bach Cuadra" | "Semi-Supervised Segmentation of Ultrasound Images Based on Patch Representation and Continuous Min Cut" |   2.0065608 |

### 2.3.2 Use Case 2: Basic Search (1 points)

**Request:**
```json
GET ms4976_info624_201904_articles/_search
{
  "from" : 0, "size" : 3,
  "query": {
    "multi_match" : {
      "query": "Machine Learning Algorithms",
      "fields": [ "author", "title", "abstract" ]
    }
  }
}
```

Results in table:

| Doc ID | Author             | Title                                 | Score |
|--------|--------------------|---------------------------------------|-------|
|    15  |"Hjalmar K. Turesson ,Sidarta Ribeiro,Danillo R. Pereira,João P. Papa and Victor Hugo C. de Albuquerque"|"Machine Learning Algorithms for Automatic Classification of Marmoset Vocalizations"|4.156092|
|   17 |"Andrius Vabalas ,Emma Gowen,Ellen Poliakoff and Alexander J. Casson"|"Machine learning algorithm validation with a limited sample size"|4.156092|
|  7   |"Elizabeth M. Sweeney ,Joshua T. Vogelstein ,Jennifer L. Cuzzocreo ,Peter A. Calabresi ,Daniel S. Reich ,Ciprian M. Crainiceanu and Russell T. Shinohara"|"A Comparison of Supervised Machine Learning Algorithms and Feature Vectors for MS Lesion Segmentation Using Multimodal Structural MRI"|3.0915308 |

### 2.3.3 Use Case 3: Basic Search (1 points)

**Request:**
```json
GET ms4976_info624_201904_articles/_search
{
  "from" : 0, "size" : 3,
  "query": {
    "multi_match" : {
      "query": "Saba Saboor Machine Learning Algorithms",
      "fields": [ "author", "title", "abstract" ]
    }
  }
}
```

Results in table:

| Doc ID | Author             | Title                                 | Score |
|--------|--------------------|---------------------------------------|-------|
|   6    |"Amir H. Beiki ,Saba Saboor and Mansour Ebrahimi"|"A New Avenue for Classification and Prediction of Olive Cultivars Using Supervised and Unsupervised Algorithms"|6.276081|
|    15    |"Hjalmar K. Turesson ,Sidarta Ribeiro,Danillo R. Pereira,João P. Papa and Victor Hugo C. de Albuquerque"|"Machine Learning Algorithms for Automatic Classification of Marmoset Vocalizations"|4.156092|
|   17     |"Andrius Vabalas ,Emma Gowen,Ellen Poliakoff and Alexander J. Casson"|"Machine learning algorithm validation with a limited sample size"|4.156092|

### 2.3.4 Use Case 3: Boosted Search (1 points)
In this step we Searched the index again for use case 3 i.e. author plus broad query with a boosted author field. Here the  authorˆ4 boosts the author field and multiples its contribution to scoring by 4 as shown below:

**Request:**
```json
GET ms4976_info624_201904_articles/_search
{
  "from" : 0, "size" : 3,
  "query": {
    "multi_match" : {
      "query": "Saba Saboor Machine Learning Algorithms",
      "fields": [ "author^4", "title", "abstract" ]
    }
  }
}
```

Results in table:

| Doc ID | Author             | Title                                 | Score |
|--------|--------------------|---------------------------------------|-------|
|   6   | "Amir H. Beiki ,Saba Saboor and Mansour Ebrahimi"|"A New Avenue for Classification and Prediction of Olive Cultivars Using Supervised and Unsupervised Algorithms" |25.104324  |
|  15 | "Hjalmar K. Turesson ,Sidarta Ribeiro,Danillo R. Pereira,João P. Papa and Victor Hugo C. de Albuquerque"|"Machine Learning Algorithms for Automatic Classification of Marmoset Vocalizations" |4.156092       |
|  17 |"Andrius Vabalas ,Emma Gowen,Ellen Poliakoff and Alexander J. Casson" | "Machine learning algorithm validation with a limited sample size"|4.156092  |

**Discussion / Comparison:**

We can observe from above binary and boosted search results on use case 3,the order of the documents did not changed the only difference that occurred is the score value for doc 6 increased this is because only one document belongs to the Saba Saboor author present in our index which is doc 6. We are applying boosting on author field so whenever any search query keyword present in that author field it will boost the score of the doc by that many times. Here we have boosted the author field by 4 so the boosted search score result would be 4 times the binary search score result for that document.


## 2.6. Setup for Custom Scoring and Similarity
Here we have used the default scoring functions in Elastic Search to rank the documents.
In this step, we customized related functions for similarity and scoring, and tested the search queries again. For this part, we have created a new index with new mappings (settings) and re-indexed  the entire document collection.
First we Identified a name for our new index, for example, ms4976_info624_201904_papers. And we will configure the index with a custom similarity and rank features.

### 2.6.1 Custom Similarity (0.5 point)
In this step we create a new custom similarity functions to the index as shown below:
```json
PUT /ms4976_info624_201904_papers
{
  "settings":
  {
    "index":
    {
      "similarity":
      {
        "my_bm25":
        {
          "type": "BM25",
          "k1": 2.0,
          "b":1.0
        },
        "my_dfr":
        {
          "type": "DFR",
          "basic_model": "g",
          "after_effect": "l",
          "normalization": "h2",
          "normalization.h2.c": "3.0"
        }
      }
    }
  }
}
```
response
```json
{

  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ms4976_info624_201904_papers"

}
```

**Impact:**

It will create a customization similarity functions for the index is my_bm25 and my_dfr with the help of built-in similarity functions of BM25 and DFR by tuning the parameters values from the default values respectively. Further it can be used with any fields in the docs to use this customized similarity functions.

The main difference between BM25 and customized my_bm25 is that pivot function parameter "K1" is increased to 2.0 from 1.2 default value(BM25) due to this pivot value increases the term saturation rate will be get reduced and also the document length parameter "b" which values range from (0-1) where b=0 represents the no length normalization and where b=1 represents the completely normalize/scale the term weight by document length. This document length("b") parameter value has increased to 1 from 0.75 default value(BM25) due to this increase in b value to max value we are making the full length normalization.

The my_dfr is the customized built-in DFR(Divergence from Randomness) similarity function with basic_model parameter  value set to "g" which represents for Geometric approximation of Bose-Einstein for information content, after_effect parameter value set to "l" which represents the laplace normalization for the information gain, normalization parameter value set to "h2" which will make the term frequency density inversely proportional to the length and normalization.h2.c parameter value set to 3.0

### 2.6.2 Abstract Field with the Custom BM25 Similarity (0.5 point)
Then we added mappings for the abstract field to use the custom my_bm25 similarity:

```json
PUT /ms4976_info624_201904_papers/_mapping
{
  "properties" :
  {
    "abstract" :
    {
      "type" : "text",
      "analyzer": "english",
      "similarity" : "my_bm25"
    }
  }
}
```
response
```json
{
  "acknowledged" : true
}
```

**Impact:**

• By default any field will uses BM25 similarity with TF normalization value set to 1.2 and document length normalization value set to 0.75 but here the abstract Field is configured to use my_bm25 customized similarity which has TF normalization value set to 2.0 and document length normalization value set to 1.0 which reduces the term saturation rate and making the full length normalization will increases the term scores values with there term frequency. Further English analyzer is used on this abstract field so stemming will be performed on this field data.

### 2.6.3 Title Field with the Custom DFR Similarity (0.5 point)
Here we added mappings for the title field to use the custom my_dfr similarity as shown below:
```json
PUT /ms4976_info624_201904_papers/_mapping
{
  "properties" :
  {
    "title" :
    {
      "type" : "text",
      "analyzer": "english",
      "similarity" : "my_dfr"
    }
  }
}
```
response
```json
{
  "acknowledged" : true
}
```

**Impact:**

• By default any field will uses BM25 similarity but here we can configure the title field to use my_dfr which is the customized similarity function of DFR(Divergence from Randomness) with basic_model parameter  value set to "g" which represents for Geometric approximation of Bose-Einstein for information content, after_effect parameter value set to "l" which represents the laplace normalization for the information gain, normalization parameter value set to "h2" which will make the term frequency density inversely proportional to the length and normalization.h2.c parameter value set to 3.0. Further English analyzer is used on this title field so stemming will be performed on this field data.

### 2.6.4 Author Field with Boolean Similarity (0.5 point)
Here we added mappings for the author field to use the boolean similarity as shown below:
```json
PUT /ms4976_info624_201904_papers/_mapping
{
  "properties" :
  {
    "author" :
    {
      "type" : "text",
      "analyzer": "standard",
      "similarity" : "boolean"
    }
  }
}
```
response
```json
{
  "acknowledged" : true
}
```
**Impact:**

By default, any field will use BM25 similarity but this author field is configured to use the boolean similarity which is used when ranking is not required for entire text and the score depends only based on whether the query terms are present or not in this field. Further a standard analyzer is used to it as no stemming is required on names of the author field.

### 2.6.5 Citations Field as a Rank Feature (0.5 point)
Here we added mappings for the citations field and make it a rank feature:
```json
PUT /ms4976_info624_201904_papers/_mapping
{
  "properties" :
  {
    "citations" :
    {
      "type" : "rank_feature",
      "positive_score_impact" : true
    }
  }
}
```
response
```json
{
  "acknowledged" : true
}
```
**Impact:**

The type of the citations field type is set to rank_feature based on which the query will skip the documents that are not ambitious so it will retrieve the top score results quite faster. As the positive_score_impact is true for citations there would be positive impact on the relevance w.r.t number of citations. So the documents with low citations will be skipped.


## 2.7. Index Documents in the New Index (0.5 point)
After the mappings comlpeted, In this step, we have kept our all 20 documents to the new index.

**Code to reindex:**

```json
POST _reindex
{
  "source": {
    "index": "ms4976_info624_201904_articles"
  },
  "dest": {
    "index": "ms4976_info624_201904_papers"
  }
}

```

{

  "took" : 562,
  "timed_out" : false,
  "total" : 20,
  "updated" : 0,
  "created" : 20,
  "deleted" : 0,
  "batches" : 1,
  "version_conflicts" : 0,
  "noops" : 0,
  "retries" : {
    "bulk" : 0,
    "search" : 0
  },

  "throttled_millis" : 0,
  "requests_per_second" : -1.0,
  "throttled_until_millis" : 0,
  "failures" : [ ]

}


## 2.8. Search with Custom Scoring and Boosting
After indexing, Now we conducted the searches again based on the first two use cases.

### 2.8.1 Use Case 1: Search with Custom Scoring (1 points)
In this step we, conducted the same query search for use case 1 and compile the result in a table (top three hits). Here index should be using different similarity functions for author, title, and abstract fields.

Request:
```json
GET ms4976_info624_201904_papers/_search
{
  "from" : 0, "size" : 3,
  "query": {
    "multi_match" : {
      "query": "fluid-attenuated inversion recovery",
      "fields": [ "author", "title", "abstract" ]
    }
  }
}
```

Results in table:

| Doc ID | Author             | Title                                 | Score |
|--------|--------------------|---------------------------------------|-------|
|  7      |"Elizabeth M. Sweeney ,Joshua T. Vogelstein ,Jennifer L. Cuzzocreo ,Peter A. Calabresi ,Daniel S. Reich ,Ciprian M. Crainiceanu and Russell T. Shinohara"| "A Comparison of Supervised Machine Learning Algorithms and Feature Vectors for MS Lesion Segmentation Using Multimodal Structural MRI" |8.965885|
|  20      |"Anca Ciurte ,Xavier Bresson,Olivier Cuisenaire,Nawal Houhou,Sergiu Nedevschi,Jean-Philippe Thiran and Meritxell Bach Cuadra" | "Semi-Supervised Segmentation of Ultrasound Images Based on Patch Representation and Continuous Min Cut"|2.376516 |

**Comparison / Discussion:**

|Doc ID for Basic search | Score|Doc ID for Custom Scoring|Score|
|-------------------|-----|---------------------|-----|
|7|9.350587|7|8.965885|
|20|2.0065608|20|2.376516 |


We can observe that there is no difference in order of documents returned by basic search and Custom Scoring search but there is a slight difference in scoring values that occurred due to tuning of parameters pivot function "K1" and length normalization "b"  in the customized similarity function.

### 2.8.2 Use Case 2: Search with Custom Scoring (1 points)
Again we Searched the index for use case 2 (broad query) and include citations as a rank feature for the scoring:

**Request:**
```json
GET /ms4976_info624_201904_papers/_search
{
  "query":
  {
    "bool":
    {
      "must":
      [{
        "match":
        {
          "abstract": "Machine Learning Algorithms"
        }
      }],
      "should":
      {
        "rank_feature":
        {
          "field": "citations",
          "sigmoid":
          {
            "pivot": 5,
            "exponent":0.6
          }
        }
      }
    }
  }
}
```

Results in table:

| Doc ID | Author             | Title                                 | Score |
|--------|--------------------|---------------------------------------|-------|
| 14 |"Zhuoran Wang,Anoop D. Shah ,A. Rosemary Tate,Spiros Denaxas,John Shawe-Taylor and Harry Hemingway" |"Extracting Diagnoses and Investigation Results from Unstructured Text in Electronic Health Records by Semi-Supervised Machine Learning" |4.3596253 |
|7 |"Elizabeth M. Sweeney ,Joshua T. Vogelstein ,Jennifer L. Cuzzocreo ,Peter A. Calabresi ,Daniel S. Reich ,Ciprian M. Crainiceanu and Russell T. Shinohara"| "A Comparison of Supervised Machine Learning Algorithms and Feature Vectors for MS Lesion Segmentation Using Multimodal Structural MRI"  |3.7931325 |
|  9|"Shusen Zhou ,Qingcai Chen and Xiaolong Wang" |"Active Semi-Supervised Learning Method with Hybrid Deep Belief Networks"|3.7142663 |


**Comparison / Discussion:**

|Doc ID for Basic search | Score|Doc ID for Custom Scoring|Score|
|-------------------|-----|---------------------|-----|
|15|4.156092|14|4.3596253|
|17|4.156092|7|3.7931325|
|7|3.0915308|9|3.7142663|


We can see that both the returned results are different this is because in basic search we are considering the author, title and abstract fields which has BM25 as default similarity functions. whereas in this custom scoring search it is only considering abstract field which is configured with customized scoring function of BM25(my_bm25) and citations field is a rank_feature for this search as all the assigned score by the abstract field will be positively scaled with citations as this field have a positive score impact on relevance.


# 3. Questions (3 points)

## 3.1 Question 1
1.) Review all the searches and results in this assignment, which query (use case and
scoring/boosting) perform the best or worst according to your assessment? Why? You
may compare the search results (ranking) to what you had expected from the data
collection

After reviewing all the searches and their results we can conclude that the best performance we got for boosted search on use case 3 query, since in our case we are trying to find the articles which belongs to machine learning algorithms that were written by Saba Saboor. But in our collection only one article was written by this author when we performed basic search on this query(use case 3) and by looking into the top 3 results we can observe that the article that was written by Saba Saboor and other two retrieved articles has very less score value difference which means that there is chance of misclassification may occur with other articles. But when we used boosted search on this query the score valve difference is very high between the relevant article that we are expecting to retrieve and other articles. For us, we are getting bad performance for custom scoring on use case 2 query as we got 2 not relevant documents out of top 3 retrieved results.


## 3.2 Question 2
2.) One may analyze a citation network (graph) to compute PageRank scores for articles
referencing one another. How is a PageRank score similar to and/or different from a
citation score (how many times one article is cited)?

To represent the citation network in terms PageRank lets assume that count of citations is equal to number of incoming links to the page but here in PageRank the weights of the incoming links are not treated same as like to citations count it depends on the pages where this in-links are coming from. If the in-link to page that is coming from a page that having high popularity/importance/significance has more weight as it would have low out degree and/or high in degree(popular page). Whereas if the in-link that is coming from a page that having low popularity/importance/significance has assigned with less weight as it has low in degree and/or high out degree. PageRank should be used to overcome the drawback of citations where it treats all weights as equal which is not ideal case.


## 3.3 Question 3
3.) Do you think it will make a difference if we replace the citations field with a PageRank field in the rank feature?

Yes, there would be a difference in the retrieved results if citations field is replaced with PageRank field in the rank feature, as the results would expected to be better and more effective because it considers all visited pages importance also. As by seeing the concept wise how citations and PageRank works where citation weights are equal for all in-links but for as PageRank it will assigns different weights to the in-coming links based on the page popularity. Which is the main drawback we are facing in citation score as we are assigning equal score. But practically by many research's has done and found that there is no much difference in PageRank and Citation results. PageRank recounts the citations for entire web which is creating an drawback of complexity of running for total web and also web has full of dead ends which may stuck there.
