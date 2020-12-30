x
# Assignment 1

## Student(s)

+ Manisha Nandawadekar, mun24@drexel.edu


## 1. Academic Honesty Statement

I certify that:
+ My work will be entirely my own work.
+ I will not quote the words of any other person from a printed source or a website without indicating what has been quoted and providing an appropriate citation.
+ I will not submit my work in this course to satisfy the requirements of any other course.

Student Names: __Manisha Nandawadekar__

Date: __July 1, 2020__

---------*-------------*---------------*----------------*-----------------*---------*--------------------

## 2. Assignment Data:

Consider a small collection of 4 text documents (titles only):
1. breakthrough drug for schizophrenia
2. new schizophrenia drug
3. new approach for treatment of schizophrenia
4. new hopes for schizophrenia patients

## 3. Assignment Tasks
### 3.1. Term-Document Matrix Representation (1 point):

Please check the term-document incidence matrix (with binary representation) for this document collection is drawn below. Where only if the file contained the term it returns 1, otherwise 0. Documents are distributed row wise and words are distributed column wise.

| Term | breakthrough drug for schizophrenia |  new schizophrenia drug | new approach for treatment of schizophrenia | new hopes for schizophrenia patients
|--|--|--|--|--|
| breakthrough | 1 | 0 | 0 | 0 |
| drug | 1 | 1 | 0 | 0 |
| for | 1 | 0 | 1 | 1 |
| schizophrenia | 1 | 1 | 1 | 1 |
| new | 0 | 1 | 1 | 1 |
| approach | 0 | 0 | 1 | 0 |
| treatment | 0 | 0 | 1 | 0 |
| of | 0 | 0 | 1 | 0 |
| hopes | 0 | 0 | 0 | 1 |
| patients | 0 | 0 | 0 | 1 |


### 3.2. Inverted Index Representation (1 point):

Please check the following inverted index representation for the document collection which is drawn below. Where the inverted index representation is the occurrence of a particular word in the document and its exact place in the incidence matrix for the Word document.

 Dictionary and their Postings :

| approach ---> | 3 |
|--|--|

| breakthrough ---> | 1 |
|--|--|

| drug ---> | 1 | 2 |
|--|--|--|

| for ---> | 1 | 3 | 4 |
|--|--|--|--|

| hopes ---> | 4 |
|--|--|

| new ---> | 2 | 3 | 4
|--|--|--|--|

| of ---> | 3 |
|--|--|

| patients ---> | 4 |
|--|--|

| schizophrenia ---> | 1 | 2 | 3 | 4 |
|--|--|--|--|--|

| treatment ---> | 3 |
|--|--|




### 3.3. Indexing with ElasticSearch (1 point):
Using Kibana Dev Tools Console, I put the above Schizophrenia documents into an index called mun24_info624_201904_schizophrenia on the ElasticSearch cluster. Once indexing successfully processed, the following are the request commands I used.

```json
POST mun24_info624_201904_schizophrenia/_doc/1
{
"content": "breakthrough drug for schizophrenia"
}

POST mun24_info624_201904_schizophrenia/_doc/2
{
"content": "new schizophrenia drug"
}

POST mun24_info624_201904_schizophrenia/_doc/3
{
"content": "new approach for treatment of schizophrenia"
}

POST mun24_info624_201904_schizophrenia/_doc/4
{
"content": "new hopes for schizophrenia patients"
}
```

### 3.4. Retrieval with ElasticSearch (0.5 points):

After running search command to retrieve all documents, I am getting the following result which is pasted in response and I checked for all four documents which have been posted to the above Schizophrenia index.

1.**Request**:
```json
GET mun24_info624_201904_schizophrenia/_search
{
  "query": {
    "match_all": {}
  }
}
```
**Response**:
```json
{
  "took" : 4,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0  
  },

  "hits" : {
    "total" : {
      "value" : 4,
      "relation" : "eq"
    },
    "max_score" : 1.0,
    "hits" : [

      {
        "_index" : "mun24_info624_201904_schizophrenia",
        "_type" : "_doc",
        "_id" : "1",
        "_score" : 1.0,
        "_source" : {
          "content" : "breakthrough drug for schizophrenia"
        }
      },

      {
        "_index" : "mun24_info624_201904_schizophrenia",
        "_type" : "_doc",
        "_id" : "2",
        "_score" : 1.0,
        "_source" : {
          "content" : "new schizophrenia drug"
        }
      },

      {
        "_index" : "mun24_info624_201904_schizophrenia",
        "_type" : "_doc",
        "_id" : "3",
        "_score" : 1.0,
        "_source" : {
          "content" : "new approach for treatment of schizophrenia"
        }
      },

      {
        "_index" : "mun24_info624_201904_schizophrenia",
        "_type" : "_doc",
        "_id" : "4",
        "_score" : 1.0,
        "_source" : {
          "content" : "new hopes for schizophrenia patients"
        }
      }
    ]
  }  
}
```

### 3.5. Boolean Query:
It is a query that matches different documents matching combination of boolean with other queries.

```sql
"schizophrenia" AND "drug"
```

#### 3.5.1. Manual Analysis (0.75 point):

The query is for finding the documents which contains both "schizophrenia" and "drug" words. Following documents contains the words (highlighted)

1. breakthrough **drug** for **schizophrenia** -> found both
2.  new **schizophrenia** **drug** -> found both
3. new approach for treatment of schizophrenia -> found schizophrenia, but drug is absent
4. new hopes for schizophrenia patients -> found schizophrenia, but drug is absent.


1. Documents containing ```schizophrenia```:
        All the four documents contains the term schizophrenia in them(i.e., _id=1, _id=2, _id=3 and _id=4).

2. Documents containing ```drug```:
        Only first and second documents (i.e., _id=1 and _id=2) contains the term drug in them.

3. Merging results of 1 and 2 with ```AND```:
        AND is an boolean operator which will gives results true if only both values are true otherwise it will give result as false. So in this case the merging results of terms 1 and 2 with AND operator will gives documents that contains both schizophrenia and drug.


As highlighted above, document 1 and 2 (i.e., _id=1 and _id=2) has the both words while document 3 and 4 are missing word "drug". Thus, result should be document 1 and 2.

#### 3.5.2. ElasticSearch Query (1 point):

As discussed above, our manual analysis holds true in Kibana elastic search and it returned document 1 and 2 with its content. On kibana elastic search I wrote Boolean queries in two different ways which gives me the same result. I copy pasted both the queries here with result, check the following request(queries) and thier response.

**1.Request:**
```json
GET mun24_info624_201904_schizophrenia/_search
{
  "query":
  {
    "bool":
    {
      "must":
      [{"term":{"content":"schizophrenia"}},
      {"term":{"content":"drug"}}]
    }
  }
}
```
**or**
**2. Request:**
```json
GET mun24_info624_201904_schizophrenia/_search
{
  "query": {

        "query_string" : {
            "query" : "(schizophrenia) AND (drug)",
            "default_field" : "content"
        }
    }
}
```
**Response:**
```json
{
  "took" : 3,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 2,
      "relation" : "eq"
    },
    "max_score" : 0.9245879,
    "hits" : [
      {
        "_index" : "mun24_info624_201904_schizophrenia",
        "_type" : "_doc",
        "_id" : "2",
        "_score" : 0.9245879,
        "_source" : {
          "content" : "new schizophrenia drug"
        }
      },
      {
        "_index" : "mun24_info624_201904_schizophrenia",
        "_type" : "_doc",
        "_id" : "1",
        "_score" : 0.8365319,
        "_source" : {
          "content" : "breakthrough drug for schizophrenia"
        }
      }
    ]
  }
}
```

### 3.6. Compound Query:

```sql
"for" AND ("drug" OR "approach")
```
#### 3.6.1. Manual Analysis (1.25 point):

The query is for finding the documents which contains word "for" and at-least one word from "drug" or "approach". That means we have to find all documents with word "for" first, then filter documents which contains either "drug" or "approach" or both. Following documents satisfies the query (where must word is highlighted by bold and least words are highlighted by bold+italics)
1. breakthrough ***drug*** **for** schizophrenia -> found match
2.  new schizophrenia ***drug*** -> "for" is missing
3. new ***approach*** **for** treatment of schizophrenia -> found match
4. new hopes **for** schizophrenia patients -> both "approach" and "drug" missing


1. Documents containing ```for```:
        first, third and fourth documents (i.e., _id=1,_id=3 and _id=4) contains the term for in them.

2. Documents containing ```drug```:
        Only first and second documents (i.e., _id=1 and _id=2) contains the term drug in them.

3. Documents containing ```approach```:
        Only thrid documents (i.e., _id=3) contains the term approach.

4. Merging results of 2 and 3 with ```OR```:
          OR is an boolean operator which will gives results as true if any of the values are true otherwise it results as false. So using this case the combining results of terms 2 and 3 with OR operator will returns the documents that contains atleast one term.

          Therefore first, second and third documents (i.e., _id=1,_id=2 and _id=3) contains the terms drug or approach in them.

5. Merging results of 1 and 4 with ```AND```:
        we must select the documents which wil have for term and also that document should contains atleast one term in drug or approach.


As highlighted above, document 1 and 3 (i.e., _id=1 and _id=3) has "for" word with "drug" in document 1 and "approach" in document 3. Thus, document 1 and 3 should be the result.

#### 3.6.2. ElasticSearch Query (1.5 points):

As discussed above, our manual analysis holds true and search query returns document 1 and 3 with its content.

**1. Request:**
```json
GET mun24_info624_201904_schizophrenia/_search

{
  "query":{
    "bool":{
      "must":[
        {"term":{"content":"for"}},
        {
          "bool":{
            "should":[
              {"term":{"content":"drug"}},
              {"term":{"content":"approach"}}
            ]
          }
        }
      ]
    }
  }
}
```
**or 2. Request:**
```json
GET mun24_info624_201904_schizophrenia/_search

{
  "query": {

        "query_string" : {
            "query" : "(for) AND ((drug) OR (approach))",
            "default_field" : "content"
        }
    }
}
```
**Response:**
```json
{
  "took" : 3,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 2,
      "relation" : "eq"
    },
    "max_score" : 1.3733702,
    "hits" : [
      {
        "_index" : "mun24_info624_201904_schizophrenia",
        "_type" : "_doc",
        "_id" : "3",
        "_score" : 1.3733702,
        "_source" : {
          "content" : "new approach for treatment of schizophrenia"
        }
      },
      {
        "_index" : "mun24_info624_201904_schizophrenia",
        "_type" : "_doc",
        "_id" : "1",
        "_score" : 1.0998137,
        "_source" : {
          "content" : "breakthrough drug for schizophrenia"
        }
      }
    ]
  }
}
```
