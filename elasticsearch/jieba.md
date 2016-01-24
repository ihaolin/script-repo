# install jieba
* build jieba to jars

[https://github.com/huaban/elasticsearch-analysis-jieba]()

* config elasticsearch.yml

```yml
index:
  analysis:
    analyzer:
      jieba:
        alias: jieba_analyzer
        type: org.elasticsearch.index.analysis.JiebaAnalyzerProvider
      jieba_search:
        type: jieba
        seg_mode: search
        stop: true
      jieba_other:
        type: jieba
        seg_mode: other
        stop: true
      jieba_index:
        type: jieba
        seg_mod: index
        stop: true
index.analysis.analyzer.default.type : "jieba"
```
* don't place jieba jars under es's plugins/
